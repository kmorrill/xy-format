from __future__ import annotations

import re
from collections import Counter
from dataclasses import dataclass
from typing import Literal

from .container import XYProject
from .scaffold_writer import LogicalEntry, extract_logical_entries


PresetKind = Literal["drum", "synth", "multi", "sample", "sampler", "unknown"]
Confidence = Literal["strong", "medium", "weak"]

PRESET_FOLDER_RE = re.compile(rb"/fat32/presets/([a-z0-9 #\-()]+)/[\x20-\x7e]{1,120}", re.I)
PRESET_PATH_MARKER = 0xF7

ENGINE_NAMES = {
    0x02: "Sampler",
    0x03: "Drum",
    0x06: "Organ",
    0x07: "EPiano",
    0x12: "Prism",
    0x13: "Hardsync",
    0x14: "Dissolve",
    0x16: "Axis",
    0x1D: "MIDI",
    0x1E: "Multisampler",
    0x1F: "Wavetable",
    0x20: "Simple",
}

SYNTH_ENGINE_NAMES = {
    "Axis",
    "Dissolve",
    "EPiano",
    "Hardsync",
    "Organ",
    "Prism",
    "Simple",
    "Wavetable",
}


@dataclass(frozen=True)
class PresetReference:
    folder: str
    kind: PresetKind
    hit_count: int
    confidence: Confidence


@dataclass(frozen=True)
class PatternInspection:
    pattern: int
    active: bool
    pattern_count: int
    type_byte: int
    engine_id: int | None
    engine_name: str | None
    body_length: int
    preset_refs: tuple[PresetReference, ...]


@dataclass(frozen=True)
class TrackInspection:
    track: int
    patterns: tuple[PatternInspection, ...]


@dataclass(frozen=True)
class ProjectInspection:
    tracks: tuple[TrackInspection, ...]

    @property
    def active_preset_refs(self) -> tuple[tuple[int, PatternInspection, PresetReference], ...]:
        refs: list[tuple[int, PatternInspection, PresetReference]] = []
        for track in self.tracks:
            for pattern in track.patterns:
                if pattern.active and pattern.preset_refs:
                    refs.append((track.track, pattern, pattern.preset_refs[0]))
        return tuple(refs)


def inspect_project_bytes(data: bytes) -> ProjectInspection:
    return inspect_project(XYProject.from_bytes(data))


def inspect_project(project: XYProject) -> ProjectInspection:
    entries = extract_logical_entries(project)
    tracks: list[TrackInspection] = []

    for track_number in range(1, 17):
        patterns = tuple(
            _inspect_pattern(entry)
            for entry in entries
            if entry.track == track_number
        )
        tracks.append(TrackInspection(track=track_number, patterns=patterns))

    return ProjectInspection(tracks=tuple(tracks))


def _inspect_pattern(entry: LogicalEntry) -> PatternInspection:
    body = entry.body
    type_byte = body[9] if len(body) > 9 else -1
    engine_id = _engine_id(body, type_byte)
    engine_name = ENGINE_NAMES.get(engine_id) if engine_id is not None else None
    active = type_byte == 0x07

    return PatternInspection(
        pattern=entry.pattern,
        active=active,
        pattern_count=entry.pattern_count,
        type_byte=type_byte,
        engine_id=engine_id,
        engine_name=engine_name,
        body_length=len(body),
        preset_refs=tuple(_scan_preset_refs(body, engine_name)) if active else (),
    )


def _engine_id(body: bytes, type_byte: int) -> int | None:
    offset = 0x0D if type_byte == 0x05 else 0x0B
    if len(body) <= offset:
        return None
    return body[offset]


def _scan_preset_refs(body: bytes, engine_name: str | None) -> list[PresetReference]:
    full_path_hits = _scan_full_preset_paths(body, engine_name)
    fragmented_hits = [
        hit
        for hit in _scan_fragmented_preset_names(body, engine_name)
        if not any(_same_or_child_ref(existing.folder, hit.folder) for existing in full_path_hits)
    ]
    return sorted(
        [*full_path_hits, *fragmented_hits],
        key=lambda hit: (-hit.hit_count, hit.folder),
    )


def _scan_full_preset_paths(body: bytes, engine_name: str | None) -> list[PresetReference]:
    counts: Counter[tuple[str, PresetKind]] = Counter()
    for match in PRESET_FOLDER_RE.finditer(body):
        raw = match.group(0).decode("latin1")
        category = match.group(1).decode("latin1")
        folder = _clean_preset_folder(raw)
        counts[(folder, _normalize_kind(category, engine_name))] += 1

    return [
        PresetReference(
            folder=folder,
            kind=kind,
            hit_count=count,
            confidence="strong" if kind == "drum" and count >= 24 else "medium" if count > 1 else "weak",
        )
        for (folder, kind), count in counts.items()
    ]


def _scan_fragmented_preset_names(body: bytes, engine_name: str | None) -> list[PresetReference]:
    counts: Counter[tuple[str, PresetKind]] = Counter()

    for idx, byte in enumerate(body):
        if byte != PRESET_PATH_MARKER:
            continue
        raw = _read_fragmented_path(body, idx + 1)
        name = _clean_fragmented_preset_path(raw)
        if not name:
            continue
        category = raw.split("/", 1)[0] if "/" in raw else None
        counts[(name, _normalize_kind(category, engine_name))] += 1

    for needle in (b"nt-", b"bandpass"):
        start = 0
        while start < len(body):
            idx = body.find(needle, start)
            if idx < 0:
                break
            raw = _read_fragmented_path(body, idx)
            name = _clean_fragmented_preset_path(raw)
            if name:
                counts[(name, _normalize_kind(None, engine_name))] += 1
            start = idx + len(needle)

    return [
        PresetReference(
            folder=folder,
            kind=kind,
            hit_count=count,
            confidence="medium" if count > 1 else "weak",
        )
        for (folder, kind), count in counts.items()
    ]


def _clean_preset_folder(raw: str) -> str:
    preset_idx = raw.find(".preset")
    if preset_idx >= 0:
        return raw[: preset_idx + len(".preset")]
    return re.sub(r"[/.][A-Za-z0-9 #\-()_]+-(?:[a-g](?:#|b)?\d+)-\d+.*$", "", raw, flags=re.I)


def _read_fragmented_path(buf: bytes, start: int, limit: int = 140) -> str:
    parts: list[str] = []
    current: list[str] = []
    zero_count = 0

    for byte in buf[start : min(len(buf), start + limit)]:
        if 0x20 <= byte <= 0x7E:
            current.append(chr(byte))
            zero_count = 0
            continue
        if byte == 0:
            if current:
                parts.append("".join(current))
                current = []
            zero_count += 1
            if zero_count >= 2:
                break
            continue
        break

    if current:
        parts.append("".join(current))
    return "".join(parts)


def _clean_fragmented_preset_path(raw: str) -> str | None:
    match = re.search(r"(?:^|/)(nt-[a-z0-9 #\-()]+|bandpasser)(?:\.preset)?", raw, re.I)
    if not match:
        return None
    return re.sub(r"\s+", " ", match.group(1).strip())


def _normalize_kind(category: str | None, engine_name: str | None) -> PresetKind:
    clean = category.strip().lower() if category else None
    if clean in {"drum", "synth", "multi", "sample"}:
        return clean  # type: ignore[return-value]
    if clean == "bass" or engine_name == "Sampler":
        return "sampler"
    if engine_name == "Multisampler":
        return "multi"
    if engine_name in SYNTH_ENGINE_NAMES:
        return "synth"
    return "unknown"


def _same_or_child_ref(full_ref: str, short_ref: str) -> bool:
    base = full_ref.removesuffix(".preset")
    return full_ref == short_ref or base.endswith(f"/{short_ref}")
