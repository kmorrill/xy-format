from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional

from .container import XYContainer, XYHeader, XYProject
from .note_events import Note
from .project_builder import append_notes_to_tracks, build_multi_pattern_project
from .scaffold_writer import apply_notes_to_matching_scaffold


SUPPORTED_SPEC_VERSION = 1
MULTI_PATTERN_MODE = "multi_pattern"
VALID_MODES = {MULTI_PATTERN_MODE}
VALID_DESCRIPTOR_STRATEGIES = {"strict", "heuristic_v1"}


@dataclass(frozen=True)
class HeaderPatch:
    tempo_tenths: Optional[int] = None
    groove_type: Optional[int] = None
    groove_amount: Optional[int] = None
    metronome_level: Optional[int] = None

    def has_changes(self) -> bool:
        return any(
            value is not None
            for value in (
                self.tempo_tenths,
                self.groove_type,
                self.groove_amount,
                self.metronome_level,
            )
        )


@dataclass(frozen=True)
class MultiTrackSpec:
    track: int
    patterns: List[Optional[List[Note]]]


@dataclass(frozen=True)
class BuildSpec:
    version: int
    mode: str
    template: Path
    output: Optional[Path] = None
    descriptor_strategy: str = "strict"
    header: HeaderPatch = field(default_factory=HeaderPatch)
    multi_tracks: List[MultiTrackSpec] = field(default_factory=list)

    @property
    def track_count(self) -> int:
        return len(self.multi_tracks)


def _require_dict(value: object, *, where: str) -> dict:
    if not isinstance(value, dict):
        raise ValueError(f"{where} must be an object")
    return value


def _require_list(value: object, *, where: str) -> list:
    if not isinstance(value, list):
        raise ValueError(f"{where} must be an array")
    return value


def _int_in_range(value: object, *, where: str, low: int, high: int) -> int:
    if not isinstance(value, int) or isinstance(value, bool):
        raise ValueError(f"{where} must be an integer")
    if not (low <= value <= high):
        raise ValueError(f"{where} must be in [{low}, {high}]")
    return value


def _parse_note(note_raw: object, *, where: str) -> Note:
    note_obj = _require_dict(note_raw, where=where)
    step = _int_in_range(note_obj.get("step"), where=f"{where}.step", low=1, high=65535)
    note = _int_in_range(note_obj.get("note"), where=f"{where}.note", low=0, high=127)
    velocity = _int_in_range(note_obj.get("velocity", 100), where=f"{where}.velocity", low=0, high=127)
    tick_offset = _int_in_range(
        note_obj.get("tick_offset", 0),
        where=f"{where}.tick_offset",
        low=0,
        high=65535,
    )
    gate_ticks = _int_in_range(
        note_obj.get("gate_ticks", 0),
        where=f"{where}.gate_ticks",
        low=0,
        high=2**32 - 1,
    )
    return Note(
        step=step,
        note=note,
        velocity=velocity,
        tick_offset=tick_offset,
        gate_ticks=gate_ticks,
    )


def _parse_header_patch(raw: object) -> HeaderPatch:
    if raw is None:
        return HeaderPatch()
    obj = _require_dict(raw, where="header")

    def _get_byte(name: str) -> Optional[int]:
        if name not in obj:
            return None
        return _int_in_range(obj[name], where=f"header.{name}", low=0, high=255)

    tempo = None
    if "tempo_tenths" in obj:
        tempo = _int_in_range(obj["tempo_tenths"], where="header.tempo_tenths", low=0, high=65535)
    return HeaderPatch(
        tempo_tenths=tempo,
        groove_type=_get_byte("groove_type"),
        groove_amount=_get_byte("groove_amount"),
        metronome_level=_get_byte("metronome_level"),
    )


def parse_build_spec(data: object, *, base_dir: Path) -> BuildSpec:
    obj = _require_dict(data, where="spec")

    version = _int_in_range(
        obj.get("version", SUPPORTED_SPEC_VERSION),
        where="version",
        low=1,
        high=65535,
    )
    if version != SUPPORTED_SPEC_VERSION:
        raise ValueError(
            f"unsupported spec version {version}; supported version is {SUPPORTED_SPEC_VERSION}"
        )

    mode = obj.get("mode")
    if mode not in VALID_MODES:
        modes = ", ".join(sorted(VALID_MODES))
        raise ValueError(f"mode must be one of: {modes}")

    template_raw = obj.get("template")
    if not isinstance(template_raw, str) or not template_raw:
        raise ValueError("template must be a non-empty string path")
    template = Path(template_raw)
    if not template.is_absolute():
        template = (base_dir / template).resolve()

    output = None
    output_raw = obj.get("output")
    if output_raw is not None:
        if not isinstance(output_raw, str) or not output_raw:
            raise ValueError("output must be a non-empty string path when provided")
        output = Path(output_raw)
        if not output.is_absolute():
            output = (base_dir / output).resolve()

    descriptor_strategy = obj.get("descriptor_strategy", "strict")
    if descriptor_strategy not in VALID_DESCRIPTOR_STRATEGIES:
        valid = ", ".join(sorted(VALID_DESCRIPTOR_STRATEGIES))
        raise ValueError(f"descriptor_strategy must be one of: {valid}")

    tracks_raw = _require_list(obj.get("tracks"), where="tracks")
    if not tracks_raw:
        raise ValueError("tracks must contain at least one track entry")

    seen_tracks: set[int] = set()
    multi_tracks: List[MultiTrackSpec] = []

    for idx, track_raw in enumerate(tracks_raw):
        where = f"tracks[{idx}]"
        track_obj = _require_dict(track_raw, where=where)
        track = _int_in_range(track_obj.get("track"), where=f"{where}.track", low=1, high=16)
        if track in seen_tracks:
            raise ValueError(f"duplicate track {track} in tracks")
        seen_tracks.add(track)

        if "patterns" not in track_obj:
            raise ValueError(f"{where}.patterns is required in {MULTI_PATTERN_MODE} mode")
        patterns_raw = _require_list(track_obj["patterns"], where=f"{where}.patterns")
        if len(patterns_raw) < 1:
            raise ValueError(f"{where}.patterns must contain at least 1 pattern entry")

        parsed_patterns: List[Optional[List[Note]]] = []
        for pidx, pattern_raw in enumerate(patterns_raw):
            pwhere = f"{where}.patterns[{pidx}]"
            if pattern_raw is None:
                parsed_patterns.append(None)
                continue
            notes = _require_list(pattern_raw, where=pwhere)
            if not notes:
                parsed_patterns.append(None)
                continue
            parsed_patterns.append(
                [_parse_note(n, where=f"{pwhere}[{nidx}]") for nidx, n in enumerate(notes)]
            )

        multi_tracks.append(MultiTrackSpec(track=track, patterns=parsed_patterns))

    return BuildSpec(
        version=version,
        mode=mode,
        template=template,
        output=output,
        descriptor_strategy=descriptor_strategy,
        header=_parse_header_patch(obj.get("header")),
        multi_tracks=multi_tracks,
    )


def load_build_spec(path: Path | str) -> BuildSpec:
    spec_path = Path(path).expanduser().resolve()
    payload = json.loads(spec_path.read_text(encoding="utf-8"))
    return parse_build_spec(payload, base_dir=spec_path.parent)


def apply_header_patch(data: bytes, patch: HeaderPatch) -> bytes:
    if not patch.has_changes():
        return data

    container = XYContainer.from_bytes(data)
    old = container.header
    new_header = XYHeader(
        raw=old.raw,
        tempo_tenths=patch.tempo_tenths if patch.tempo_tenths is not None else old.tempo_tenths,
        groove_type=patch.groove_type if patch.groove_type is not None else old.groove_type,
        groove_flags=old.groove_flags,
        groove_amount=patch.groove_amount if patch.groove_amount is not None else old.groove_amount,
        metronome_level=(
            patch.metronome_level
            if patch.metronome_level is not None
            else old.metronome_level
        ),
        field_0x0C=old.field_0x0C,
        field_0x10=old.field_0x10,
        field_0x14=old.field_0x14,
    )
    return XYContainer(raw=container.raw, header=new_header).to_bytes()


def build_xy_bytes(spec: BuildSpec) -> bytes:
    template_bytes = spec.template.read_bytes()
    project = XYProject.from_bytes(template_bytes)

    if spec.mode != MULTI_PATTERN_MODE:
        raise ValueError(f"unsupported mode {spec.mode!r}")
    if not spec.multi_tracks:
        raise ValueError("multi_pattern mode requires at least one track")

    pattern_lengths = {len(entry.patterns) for entry in spec.multi_tracks}
    if pattern_lengths == {1}:
        track_notes: Dict[int, List[Note]] = {}
        for entry in spec.multi_tracks:
            notes = entry.patterns[0]
            if not notes:
                raise ValueError(
                    f"track {entry.track} has empty/null patterns[0]; "
                    "single-pattern form requires note data in patterns[0]"
                )
            track_notes[entry.track] = notes
        project = append_notes_to_tracks(project, track_notes)
    else:
        if 1 in pattern_lengths:
            raise ValueError(
                "mixed pattern counts are not supported: when using multi-pattern "
                "builds all listed tracks must have at least 2 patterns"
            )
        track_patterns: Dict[int, List[Optional[List[Note]]]] = {
            entry.track: entry.patterns for entry in spec.multi_tracks
        }
        scaffold_result = apply_notes_to_matching_scaffold(project, track_patterns)
        if scaffold_result is not None:
            project = scaffold_result
        else:
            project = build_multi_pattern_project(
                project,
                track_patterns,
                descriptor_strategy=spec.descriptor_strategy,
            )

    return apply_header_patch(project.to_bytes(), spec.header)
