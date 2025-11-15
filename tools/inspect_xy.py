#!/usr/bin/env python3
"""Human-readable OP-XY project inspector.

Parses a single `.xy` file and emits a text report that matches the
current reverse-engineering notebook layout. The goal for v0.1 is to cover:

* Core header fields (tempo / groove / metronome) using the known offsets.
* Pattern directory bookkeeping (max slot index, per-track handles,
  and basic slot descriptor inspection).
* Track blocks: engine ID/label, scale byte, pattern length byte, plus
  a light-weight scan for quantised note event payloads (event type 0x25).
* Master EQ table values at offsets 0x24–0x37.

The script intentionally keeps parsing defensive; when a structure cannot
yet be decoded confidently it reports the raw bytes so future sessions can
extend the decoding without silently emitting incorrect data.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from pathlib import Path
import sys
from typing import Iterable, Iterator, List, Sequence

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))
import re

from xy.structs import (  # noqa: E402
    SENTINEL_BYTES,
    STEP_TICKS,
    SlotDescriptor,
    TrackHandle,
    find_track_blocks,
    find_track_handles,
    find_track_payload_window,
    is_probable_track_start,
    iter_slot_descriptors,
    parse_pointer_words,
    pattern_max_slot,
)


TRACK_SIGNATURE_HEAD = b"\x00\x00\x01"
TRACK_SIGNATURE_TAIL = b"\xff\x00\xfc\x00"


# Known groove presets from change-log captures.
GROOVE_TYPE_NAMES = {
    0x00: "straight",
    0x03: "bombora",
    0x08: "dis-funk",
    0x09: "half-shuffle",
    0x0A: "danish",
    0x0B: "wobbly",
    0x0C: "gaussian",
    0x0D: "prophetic",
}

# Engine enum map gathered from AGENTS.md table.
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


@dataclass
class NoteDetail:
    note: int
    velocity: int
    gate: int | None = None
    step: int | None = None
    beat: int | None = None

    def describe(self, step_hint: int | None = None) -> str:
        step_value = self.step if self.step is not None else step_hint
        parts: list[str] = []
        parts.append(f"step≈{step_value}" if step_value is not None else "step≈?")
        if self.beat is not None:
            parts.append(f"beat≈{self.beat}")
        elif step_value is not None and step_value > 0:
            parts.append(f"beat≈{((step_value - 1) // 4) + 1}")
        parts.extend(
            [f"note={format_midi_note(self.note)} (0x{self.note:02X})"]
        )
        if self.velocity is not None:
            parts.append(f"vel={self.velocity} (0x{self.velocity:02X})")
        else:
            parts.append("vel=?")
        if self.gate is not None:
            parts.append(f"gate={self.gate}% (0x{self.gate:02X})")
        return "  ".join(parts)


@dataclass
class QuantisedEvent:
    offset: int
    event_type: int
    count: int
    fine: int | None
    coarse: int
    coarse_be: int
    step_index: int | None
    grid_step: int | None
    grid_beat: int | None
    notes: List[NoteDetail]
    variant: str
    tail_bytes: bytes
    tail_words: List[int]
    tail_remainder: bytes
    tail_entries: List["TailEntry"]


@dataclass
class MetaEvent21:
    position: int
    variant: int
    start_ticks: int
    gate_ticks: int
    step: int | None
    beat: int | None
    micro_ticks: int
    micro_parts: int
    micro_step_offset: float
    gate_steps: float
    field_a: int
    field_b: int
    note: int | None
    raw: bytes

    @property
    def gate_display(self) -> str:
        if STEP_TICKS:
            return f"{self.gate_ticks} ticks (~{self.gate_steps:.2f} steps)"
        return f"{self.gate_ticks} ticks"


@dataclass
class TrackInfo:
    index: int
    block_offset: int
    engine_id: int
    engine_name: str | None
    scale_byte: int
    pattern_length_byte: int
    handle: TrackHandle | None
    events: List[QuantisedEvent]
    meta_events: List["MetaEvent21"]
    filter_enabled: bool | None
    m4_enabled: bool | None


@dataclass
class TailEntry:
    note: int | None
    velocity: int | None
    flag: int | None
    pointer_words: List[int]
    pointer_infos: List["PointerInfo"]

    def is_pointer_only(self) -> bool:
        note_invalid = (
            self.note is None
            or self.note < MIN_VALID_MIDI_NOTE
            or (self.velocity is not None and self.velocity <= 1)
        )
        return note_invalid

    def describe(self) -> str:
        parts: list[str] = []
        if not self.is_pointer_only() and self.note is not None:
            parts.append(f"note={format_midi_note(self.note)} (0x{self.note:02X})")
            if self.velocity is not None:
                parts.append(f"vel={self.velocity} (0x{self.velocity:02X})")
        else:
            parts.append("pointer-only entry")
        if self.flag not in (None, 0):
            parts.append(f"flag=0x{self.flag:04X}")
        if self.pointer_infos:
            targets: list[str] = []
            for info in self.pointer_infos:
                if info.target_relative is not None:
                    target = f"track+0x{info.target_relative:04X}"
                elif info.target_offset is not None:
                    target = f"0x{info.target_offset:04X}"
                else:
                    target = "?"
                if info.derived_relative is not None and info.derived_relative != info.target_relative:
                    target += f" → track+0x{info.derived_relative:04X}"
                elif info.derived_offset is not None and info.derived_offset != info.target_offset:
                    target += f" → 0x{info.derived_offset:04X}"
                targets.append(target)
            if targets:
                parts.append("targets=" + ", ".join(targets))
        return "  ".join(parts)


def swap_u16(value: int) -> int:
    return ((value & 0xFF) << 8) | (value >> 8)


@dataclass
class PointerInfo:
    lo: int
    hi: int | None
    swap_lo: int
    swap_hi: int | None
    target_offset: int | None
    target_relative: int | None
    derived_offset: int | None
    derived_relative: int | None


def looks_like_note_word(word: int) -> bool:
    note = word & 0xFF
    velocity = (word >> 8) & 0xFF
    return 0 <= note <= 0x7F and 0 < velocity <= 0x7F


MIN_VALID_MIDI_NOTE = 0x00  # allow the full MIDI range (C-1 through G9)


def build_pointer_infos(
    pointer_words: List[int], block_start: int, file_len: int
) -> list[PointerInfo]:
    infos: list[PointerInfo] = []
    k = 0
    while k < len(pointer_words):
        lo = pointer_words[k]
        hi = pointer_words[k + 1] if k + 1 < len(pointer_words) else None
        swap_lo = swap_u16(lo)
        swap_hi = swap_u16(hi) if hi is not None else None
        target: int | None = None
        if hi is not None and swap_hi:
            candidate = block_start + swap_hi
            if 0 <= candidate < file_len:
                target = candidate
        elif swap_lo:
            candidate = block_start + swap_lo
            if 0 <= candidate < file_len:
                target = candidate
        target_relative: int | None = None
        if target is not None:
            target_relative = target - block_start

        derived: int | None = None
        derived_relative: int | None = None
        if hi is not None and swap_hi:
            base = block_start + swap_hi
            delta = swap_lo if hi else 0
            candidate = base + delta
            if 0 <= candidate < file_len:
                derived = candidate
                derived_relative = candidate - block_start
        elif swap_lo:
            candidate = block_start + swap_lo
            if 0 <= candidate < file_len:
                derived = candidate
                derived_relative = candidate - block_start
        infos.append(
            PointerInfo(
                lo=lo,
                hi=hi,
                swap_lo=swap_lo,
                swap_hi=swap_hi,
                target_offset=target,
                target_relative=target_relative,
                derived_offset=derived,
                derived_relative=derived_relative,
            )
        )
        k += 2 if hi is not None else 1
    return infos


def parse_tail_entries(
    tail_words: List[int],
    block_start: int,
    file_len: int,
) -> list[TailEntry]:
    entries: list[TailEntry] = []
    i = 0
    while i < len(tail_words):
        word = tail_words[i]
        note = word & 0xFF
        velocity = (word >> 8) & 0xFF
        if 0 <= note <= 0x7F and 0 < velocity <= 0x7F:
            flag: int | None = None
            pointer_words: list[int] = []
            if i + 1 < len(tail_words):
                flag = tail_words[i + 1]
            j = i + 2
            while j < len(tail_words):
                candidate = tail_words[j]
                next_word = tail_words[j + 1] if j + 1 < len(tail_words) else None
                if looks_like_note_word(candidate):
                    if next_word is None or looks_like_note_word(next_word):
                        break
                    pointer_words.append(candidate)
                    pointer_words.append(next_word)
                    j += 2
                    continue
                if next_word is not None and looks_like_note_word(next_word):
                    break
                pointer_words.append(candidate)
                if next_word is not None:
                    pointer_words.append(next_word)
                    j += 2
                else:
                    j += 1
                    break
            entries.append(
                TailEntry(
                    note=note,
                    velocity=velocity,
                    flag=flag,
                    pointer_words=pointer_words,
                    pointer_infos=build_pointer_infos(
                        pointer_words, block_start, file_len
                    ),
                )
            )
            i = j
        else:
            entries.append(
                TailEntry(
                    note=None,
                    velocity=None,
                    flag=None,
                    pointer_words=[word],
                    pointer_infos=build_pointer_infos(
                        [word], block_start, file_len
                    ),
                )
            )
            i += 1
    return entries


def tail_has_pointer_reference(entries: Sequence[TailEntry]) -> bool:
    for entry in entries:
        for info in entry.pointer_infos:
            if info.target_offset is not None or info.derived_offset is not None:
                return True
    return False


def event_is_plausible(
    event: QuantisedEvent, handle: TrackHandle | None
) -> bool:
    if event.variant == "pointer-21":
        return True
    if event.notes:
        return True
    if tail_has_pointer_reference(event.tail_entries):
        return True
    if handle is None or handle.is_unused():
        return False
    return True


def read_file(path: Path) -> bytes:
    if not path.is_file():
        raise FileNotFoundError(path)
    return path.read_bytes()

CHANGE_LOG_PATH = REPO_ROOT / "src" / "one-off-changes-from-default" / "op-xy_project_change_log.md"
CHANGE_LOG_PATTERN = re.compile(r"\*\*(.+?)\*\*\s+—\s+(.+)")


def load_change_log() -> dict[str, str]:
    try:
        text = CHANGE_LOG_PATH.read_text()
    except FileNotFoundError:
        return {}
    matches = CHANGE_LOG_PATTERN.findall(text)
    return {label.strip(): description.strip() for label, description in matches}


CHANGE_LOG_ENTRIES = load_change_log()


def lookup_change_log_entry(path: Path) -> str | None:
    name = path.stem.replace(" ", "_")
    return CHANGE_LOG_ENTRIES.get(name)


def format_signature(data: bytes) -> str:
    sig = data[:8]
    return " ".join(f"{b:02x}" for b in sig)


def parse_header(data: bytes) -> dict[str, int]:
    if len(data) < 0x18:
        raise ValueError("file too small to contain header fields")
    tempo_word = int.from_bytes(data[8:12], "little")
    tempo_tenths = tempo_word & 0xFFFF
    groove_type = (tempo_word >> 24) & 0xFF
    groove_flags = (tempo_word >> 16) & 0xFF
    groove_amount = data[0x0C]
    metronome_level = data[0x0D]
    return {
        "tempo_tenths": tempo_tenths,
        "groove_type": groove_type,
        "groove_flags": groove_flags,
        "groove_amount": groove_amount,
        "metronome_level": metronome_level,
    }


def format_groove_type(value: int) -> str:
    name = GROOVE_TYPE_NAMES.get(value)
    if name:
        return f"0x{value:02X}  (\"{name}\")"
    return f"0x{value:02X}"


def read_track_scale(data: bytes, block_offset: int) -> int:
    if block_offset + 4 > len(data):
        return 0
    return data[block_offset + 3]


TRACK_SCALE_LABELS = {
    0x00: "Track Scale 1/2",
    0x01: "Track Scale 1",
    0x03: "Track Scale 8",
    0x05: "Track Scale 2",
    0x0E: "Track Scale 16",
}


def format_track_scale(byte_value: int) -> str:
    label = TRACK_SCALE_LABELS.get(byte_value)
    if label:
        return f"{label} (0x{byte_value:02X})"
    return f"0x{byte_value:02X}"


def read_track_engine(data: bytes, block_offset: int) -> int:
    if block_offset + 14 > len(data):
        return 0
    return data[block_offset + 0x0D]


def read_pattern_length_byte(data: bytes, block_offset: int) -> int:
    pos = block_offset - 2
    if pos < 0 or pos >= len(data):
        return 0
    return data[pos]


def format_pattern_length(byte_value: int) -> str:
    if byte_value <= 0:
        return f"unknown (0x{byte_value:02X})"
    if byte_value % 0x10 == 0:
        bars = byte_value // 0x10
        if bars >= 1:
            plural = "s" if bars != 1 else ""
            return f"{bars} bar{plural} (0x{byte_value:02X})"
    steps = byte_value
    return f"{steps} steps (0x{byte_value:02X})"


@dataclass(frozen=True)
class PointerStatePattern:
    values: tuple[int, ...]
    support: int
    captures: tuple[str, ...]
    min_support: int | None = None

    def has_sufficient_support(self, default_min: int) -> bool:
        threshold = self.min_support if self.min_support is not None else default_min
        return self.support >= threshold


@dataclass(frozen=True)
class PointerClassifier:
    name: str
    offsets: tuple[int, ...]
    patterns_by_state: dict[bool, tuple[PointerStatePattern, ...]]
    default_min_support: int = 2

    def __post_init__(self) -> None:
        lookup: dict[tuple[int, ...], tuple[bool, PointerStatePattern]] = {}
        for state, patterns in self.patterns_by_state.items():
            for pattern in patterns:
                existing = lookup.get(pattern.values)
                if existing is not None and existing[0] != state:
                    raise ValueError(
                        f"{self.name}: conflicting state records for signature {pattern.values}"
                    )
                lookup[pattern.values] = (state, pattern)
        object.__setattr__(self, "_lookup", lookup)

    def classify(self, pointer_words: Sequence[int] | None) -> bool | None:
        if pointer_words is None:
            return None
        signature = []
        for offset in self.offsets:
            delta = offset - 0x08
            if delta < 0 or delta % 2 != 0:
                return None
            index = delta // 2
            if index >= len(pointer_words):
                return None
            signature.append(pointer_words[index])
        signature_tuple = tuple(signature)
        entry = self._lookup.get(signature_tuple)
        if entry is None:
            return None
        state, pattern = entry
        if not pattern.has_sufficient_support(self.default_min_support):
            return None
        return state


FILTER_POINTER_CLASSIFIER = PointerClassifier(
    name="filter-enabled",
    offsets=(0x12, 0x16, 0x18, 0x1A),
    patterns_by_state={
        True: (
            PointerStatePattern(
                values=(0, 0, 514, 0),
                support=63,
                captures=(
                    "unnamed 1.xy:track3",
                    "unnamed 10.xy:track3",
                    "unnamed 11.xy:track3",
                    "unnamed 12.xy:track3",
                    "unnamed 13.xy:track3",
                ),
            ),
            PointerStatePattern(
                values=(17, 2, 768, 8000),
                support=87,
                captures=(
                    "unnamed 1.xy:track4",
                    "unnamed 10.xy:track4",
                    "unnamed 11.xy:track4",
                    "unnamed 12.xy:track4",
                    "unnamed 13.xy:track4",
                ),
            ),
            PointerStatePattern(
                values=(0, 10, 1536, 2),
                support=88,
                captures=(
                    "unnamed 1.xy:track5",
                    "unnamed 10.xy:track5",
                    "unnamed 11.xy:track5",
                    "unnamed 12.xy:track5",
                    "unnamed 13.xy:track5",
                ),
            ),
            PointerStatePattern(
                values=(16, 1, 512, 2),
                support=88,
                captures=(
                    "unnamed 1.xy:track6",
                    "unnamed 10.xy:track6",
                    "unnamed 11.xy:track6",
                    "unnamed 12.xy:track6",
                    "unnamed 13.xy:track6",
                ),
            ),
            PointerStatePattern(
                values=(0, 16, 1536, 2),
                support=86,
                captures=(
                    "unnamed 1.xy:track7",
                    "unnamed 10.xy:track7",
                    "unnamed 11.xy:track7",
                    "unnamed 12.xy:track7",
                    "unnamed 13.xy:track7",
                ),
            ),
            PointerStatePattern(
                values=(9, 1, 512, 2),
                support=85,
                captures=(
                    "unnamed 1.xy:track8",
                    "unnamed 10.xy:track8",
                    "unnamed 11.xy:track8",
                    "unnamed 12.xy:track8",
                    "unnamed 13.xy:track8",
                ),
            ),
            PointerStatePattern(
                values=(4098, 518, 0, 16387),
                support=33,
                captures=(
                    "unnamed 17.xy:track1",
                    "unnamed 18.xy:track1",
                    "unnamed 19.xy:track1",
                    "unnamed 2.xy:track1",
                    "unnamed 20.xy:track1",
                ),
            ),
            PointerStatePattern(
                values=(257, 514, 0, 16387),
                support=21,
                captures=(
                    "unnamed 23.xy:track3",
                    "unnamed 24.xy:track3",
                    "unnamed 25.xy:track3",
                    "unnamed 26.xy:track3",
                    "unnamed 27.xy:track3",
                ),
            ),
            PointerStatePattern(
                values=(256, 512, 2, 768),
                support=3,
                captures=(
                    "unnamed 31.xy:track3",
                    "unnamed 33.xy:track3",
                    "unnamed 65.xy:track8",
                ),
                min_support=1,
            ),
            PointerStatePattern(
                values=(257, 256, 1, 512),
                support=1,
                captures=("unnamed 32.xy:track3",),
                min_support=1,
            ),
            PointerStatePattern(
                values=(1536, 768, 8000, 0),
                support=1,
                captures=("unnamed 38.xy:track4",),
                min_support=1,
            ),
            PointerStatePattern(
                values=(257, 1536, 2, 768),
                support=1,
                captures=("unnamed 64.xy:track7",),
                min_support=1,
            ),
        ),
        False: (
            PointerStatePattern(
                values=(0, 0, 518, 0),
                support=146,
                captures=(
                    "unnamed 1.xy:track1",
                    "unnamed 1.xy:track2",
                    "unnamed 10.xy:track1",
                    "unnamed 10.xy:track2",
                    "unnamed 11.xy:track1",
                ),
            ),
            PointerStatePattern(
                values=(518, 16387, 31, 3072),
                support=1,
                captures=("unnamed 29.xy:track3",),
                min_support=1,
            ),
        ),
    },
)


M4_POINTER_CLASSIFIER = PointerClassifier(
    name="m4-enabled",
    offsets=(0x0E, 0x10, 0x12, 0x14, 0x16, 0x18),
    patterns_by_state={
        True: (
            PointerStatePattern(
                values=(265, 10, 256, 1, 512, 2),
                support=2,
                captures=("unnamed 31.xy:track3", "unnamed 33.xy:track3"),
            ),
            PointerStatePattern(
                values=(1541, 0, 257, 10, 256, 1),
                support=1,
                captures=("unnamed 32.xy:track3",),
                min_support=1,
            ),
            PointerStatePattern(
                values=(265, 17, 1536, 2, 768, 8000),
                support=1,
                captures=("unnamed 38.xy:track4",),
                min_support=1,
            ),
            PointerStatePattern(
                values=(265, 9, 256, 1, 512, 2),
                support=1,
                captures=("unnamed 65.xy:track8",),
                min_support=1,
            ),
        ),
        False: (
            PointerStatePattern(
                values=(0, 517, 0, 4098, 0, 518),
                support=58,
                captures=(
                    "unnamed 1.xy:track1",
                    "unnamed 10.xy:track1",
                    "unnamed 11.xy:track1",
                    "unnamed 12.xy:track1",
                    "unnamed 13.xy:track1",
                ),
            ),
            PointerStatePattern(
                values=(0, 261, 0, 4098, 0, 518),
                support=88,
                captures=(
                    "unnamed 1.xy:track2",
                    "unnamed 10.xy:track2",
                    "unnamed 11.xy:track2",
                    "unnamed 12.xy:track2",
                    "unnamed 13.xy:track2",
                ),
            ),
            PointerStatePattern(
                values=(0, 2570, 0, 257, 0, 514),
                support=63,
                captures=(
                    "unnamed 1.xy:track3",
                    "unnamed 10.xy:track3",
                    "unnamed 11.xy:track3",
                    "unnamed 12.xy:track3",
                    "unnamed 13.xy:track3",
                ),
            ),
            PointerStatePattern(
                values=(0, 265, 17, 1536, 2, 768),
                support=87,
                captures=(
                    "unnamed 1.xy:track4",
                    "unnamed 10.xy:track4",
                    "unnamed 11.xy:track4",
                    "unnamed 12.xy:track4",
                    "unnamed 13.xy:track4",
                ),
            ),
            PointerStatePattern(
                values=(0, 773, 0, 257, 10, 1536),
                support=88,
                captures=(
                    "unnamed 1.xy:track5",
                    "unnamed 10.xy:track5",
                    "unnamed 11.xy:track5",
                    "unnamed 12.xy:track5",
                    "unnamed 13.xy:track5",
                ),
            ),
            PointerStatePattern(
                values=(0, 265, 16, 256, 1, 512),
                support=88,
                captures=(
                    "unnamed 1.xy:track6",
                    "unnamed 10.xy:track6",
                    "unnamed 11.xy:track6",
                    "unnamed 12.xy:track6",
                    "unnamed 13.xy:track6",
                ),
            ),
            PointerStatePattern(
                values=(0, 773, 0, 257, 16, 1536),
                support=86,
                captures=(
                    "unnamed 1.xy:track7",
                    "unnamed 10.xy:track7",
                    "unnamed 11.xy:track7",
                    "unnamed 12.xy:track7",
                    "unnamed 13.xy:track7",
                ),
            ),
            PointerStatePattern(
                values=(0, 265, 9, 256, 1, 512),
                support=85,
                captures=(
                    "unnamed 1.xy:track8",
                    "unnamed 10.xy:track8",
                    "unnamed 11.xy:track8",
                    "unnamed 12.xy:track8",
                    "unnamed 13.xy:track8",
                ),
            ),
            PointerStatePattern(
                values=(517, 0, 4098, 0, 518, 0),
                support=33,
                captures=(
                    "unnamed 17.xy:track1",
                    "unnamed 18.xy:track1",
                    "unnamed 19.xy:track1",
                    "unnamed 2.xy:track1",
                    "unnamed 20.xy:track1",
                ),
            ),
            PointerStatePattern(
                values=(2570, 0, 257, 0, 514, 0),
                support=20,
                captures=(
                    "unnamed 23.xy:track3",
                    "unnamed 24.xy:track3",
                    "unnamed 25.xy:track3",
                    "unnamed 26.xy:track3",
                    "unnamed 27.xy:track3",
                ),
            ),
            PointerStatePattern(
                values=(4106, 0, 257, 0, 514, 0),
                support=1,
                captures=("unnamed 28.xy:track3",),
                min_support=1,
            ),
            PointerStatePattern(
                values=(2570, 0, 518, 0, 16387, 31),
                support=1,
                captures=("unnamed 29.xy:track3",),
                min_support=1,
            ),
            PointerStatePattern(
                values=(773, 0, 257, 16, 1536, 2),
                support=1,
                captures=("unnamed 64.xy:track7",),
                min_support=1,
            ),
        ),
    },
)


def detect_filter_enabled(pointer_words: list[int] | None) -> bool | None:
    return FILTER_POINTER_CLASSIFIER.classify(pointer_words)


def detect_m4_enabled(pointer_words: list[int] | None) -> bool | None:
    return M4_POINTER_CLASSIFIER.classify(pointer_words)


def scan_quantised_events(
    data: bytes,
    block_start: int,
    block_end: int,
    pattern_length_byte: int,
    handle: TrackHandle | None,
) -> List[QuantisedEvent]:
    events: List[QuantisedEvent] = []
    search_end = min(block_end, len(data))
    idx = block_start
    max_steps = max(pattern_length_byte, 1)
    while idx < search_end:
        idx = data.find(b"\x25", idx, search_end)
        if idx == -1 or idx + 4 > search_end:
            break
        count = data[idx + 1]
        # Ensure the header looks like an event (avoid false positives inside
        # pointer tables that coincidentally contain 0x25).
        if count == 0:
            idx += 1
            continue
        event, event_end = decode_quantised_event(
            data,
            idx,
            block_start,
            block_end,
            pattern_length=max_steps,
        )
        if event:
            if event_is_plausible(event, handle):
                events.append(event)
            idx = max(idx + 1, event_end)
        else:
            idx += 1
    return events


def decode_quantised_event(
    data: bytes,
    offset: int,
    block_start: int,
    block_end: int,
    pattern_length: int,
) -> tuple[QuantisedEvent | None, int]:
    header = data[offset : offset + 4]
    if len(header) < 4:
        return None, offset + 1

    event_type = header[0]
    count = header[1]
    if event_type != 0x25 or count == 0:
        return None, offset + 1

    records_len = 4 + count * 10
    records_end = min(offset + records_len, len(data))

    # Tail blobs for pointer-heavy events occasionally spill a short distance
    # past the nominal block boundary. Scan a little further so we don't lose
    # those trailing pointer words, but stay defensive and cap the search
    # window.
    search_limit = min(len(data), block_end + 0x200)
    signature_idx = locate_track_signature(
        data, offset + records_len, search_limit
    )
    if signature_idx < records_end:
        signature_idx = records_end

    chunk = data[offset:signature_idx]

    fine: int | None = None
    if offset + 4 <= len(data):
        fine = int.from_bytes(data[offset + 2 : offset + 4], "little")
    coarse_bytes = data[offset + 4 : offset + 8]
    coarse = decode_coarse_ticks(coarse_bytes)
    coarse_be = int.from_bytes(coarse_bytes, "big") if len(coarse_bytes) == 4 else 0

    tail_start = offset + 4 + count * 10
    records_bytes = data[offset + 4 : tail_start]
    tail_data = data[tail_start:signature_idx]
    tail_words: List[int] = []
    if tail_data:
        tail_words = [
            int.from_bytes(tail_data[i : i + 2], "little")
            for i in range(0, len(tail_data) // 2 * 2, 2)
        ]
    tail_remainder = tail_data[len(tail_words) * 2 :]

    use_fine = (
        fine is not None
        and STEP_TICKS
        and fine % STEP_TICKS == 0
        and count == 1
    )

    parsed_tail_entries = parse_tail_entries(
        tail_words, block_start, len(data)
    )

    step_index = derive_step_index(
        coarse_bytes,
        coarse,
        coarse_be,
        pattern_length=pattern_length,
        fine_ticks=fine if use_fine else None,
    )
    grid_step = step_index + 1 if step_index is not None else None
    grid_beat = (
        ((grid_step - 1) // 4) + 1 if grid_step is not None and grid_step > 0 else None
    )

    notes: List[NoteDetail] = []

    last_step_guess: int | None = None
    for i in range(count):
        start = i * 10
        record = records_bytes[start : start + 10]
        if len(record) < 10:
            break

        raw_ticks = int.from_bytes(record[0:4], "little")
        field_a = int.from_bytes(record[4:6], "little")
        field_b = int.from_bytes(record[6:8], "little")
        field_c = int.from_bytes(record[8:10], "little")

        def is_midi_value(value: int) -> bool:
            return 0 < value <= 0x7F

        candidates: List[tuple[int, int, str]] = []
        seen_pairs: set[tuple[int, int, str]] = set()

        def add_candidate(note_value: int, velocity_value: int, source: str) -> None:
            if not is_midi_value(note_value):
                return
            if not (0 <= velocity_value <= 0x7F):
                return
            if note_value < 0x18:
                return
            pair = (note_value, velocity_value, source)
            if pair in seen_pairs:
                return
            seen_pairs.add(pair)
            candidates.append(pair)

        note_a = (field_a >> 8) & 0xFF
        velocity_a = field_b & 0xFF
        add_candidate(note_a, velocity_a, "field_a_high")

        note_low_b = field_b & 0xFF
        velocity_high_b = (field_b >> 8) & 0xFF
        add_candidate(note_low_b, velocity_high_b, "field_b_split")

        voice_id = field_b & 0xFF
        note_high_b = (field_b >> 8) & 0xFF
        velocity_tail = field_c & 0xFF
        if voice_id <= 0x18:
            add_candidate(note_high_b, velocity_tail, "voice_tail")

        note_high_c = (field_c >> 8) & 0xFF
        velocity_low_c = field_c & 0xFF
        add_candidate(note_high_c, velocity_low_c, "field_c_high")

        for idx in range(2, 9):
            if idx + 1 >= len(record):
                break
            a = record[idx]
            b = record[idx + 1]
            add_candidate(a, b, f"bytes[{idx}]")
            add_candidate(b, a, f"bytes_swap[{idx}]")

        note = None
        velocity = None
        if candidates:
            def candidate_score(entry: tuple[int, int, str]) -> tuple[int, int, int]:
                cand_note, cand_velocity, source = entry
                score = 0
                if 0x18 <= cand_note <= 0x70:
                    score += 2
                if source.startswith("bytes"):
                    score += 1
                if source.startswith("bytes_swap"):
                    score -= 1
                if source == "voice_tail":
                    score += 2
                if cand_velocity <= 1:
                    score -= 3
                if cand_note < 0x0C:
                    score -= 3
                return (score, cand_velocity, cand_note)

            note, velocity, _ = max(candidates, key=candidate_score)

        gate_candidate = (field_c >> 8) & 0xFF
        gate = gate_candidate if gate_candidate else None

        step_guess = estimate_step(raw_ticks, pattern_length)
        if note is not None:
            effective_velocity = velocity if velocity is not None and velocity > 1 else None
            if step_guess is not None:
                last_step_guess = step_guess
            note_step = (
                step_guess if step_guess is not None else step_index
            )
            step_display = note_step + 1 if note_step is not None else grid_step
            beat_display = (
                ((step_display - 1) // 4) + 1
                if step_display is not None and step_display > 0
                else grid_beat
            )
            notes.append(
                NoteDetail(
                    note=note,
                    velocity=effective_velocity,
                    gate=gate,
                    step=step_display,
                    beat=beat_display,
                )
            )

    observed_notes = {detail.note for detail in notes if detail.note is not None}
    tail_entries_to_use: Iterable[TailEntry]
    if use_fine:
        tail_entries_to_use = ()
        for entry in parsed_tail_entries:
            entry.note = None
            entry.velocity = None
    else:
        tail_entries_to_use = parsed_tail_entries

    for entry in tail_entries_to_use:
        if entry.note is None or entry.is_pointer_only():
            continue
        if entry.note in observed_notes and len(notes) >= count:
            continue
        velocity_val = entry.velocity if entry.velocity and entry.velocity > 1 else None
        step_val = (
            (last_step_guess + 1)
            if last_step_guess is not None
            else grid_step
        )
        beat_val = (
            ((step_val - 1) // 4) + 1 if step_val is not None and step_val > 0 else grid_beat
        )
        notes.append(
            NoteDetail(
                note=entry.note,
                velocity=velocity_val,
                gate=None,
                step=step_val,
                beat=beat_val,
            )
        )
        observed_notes.add(entry.note)
        if len(notes) >= count:
            break

    if not use_fine and len(notes) < count and tail_words:
        for word in tail_words:
            tail_note = word & 0xFF
            tail_velocity = (word >> 8) & 0xFF
            if tail_velocity <= 1 or tail_velocity > 0x7F:
                continue
            if tail_note < MIN_VALID_MIDI_NOTE or tail_note > 0x7F:
                continue
            if tail_note in observed_notes:
                continue
            step_val = (
                (last_step_guess + 1)
                if last_step_guess is not None
                else grid_step
            )
            beat_val = (
                ((step_val - 1) // 4) + 1
                if step_val is not None and step_val > 0
                else grid_beat
            )
            notes.append(
                NoteDetail(
                    note=tail_note,
                    velocity=tail_velocity,
                    gate=None,
                    step=step_val,
                    beat=beat_val,
                )
            )
            observed_notes.add(tail_note)
            if len(notes) >= count:
                break

    if use_fine:
        variant = "inline-single"
    elif count > 1 and tail_data:
        variant = "hybrid-tail"
    elif tail_data:
        variant = "pointer-tail"
    else:
        variant = "inline"

    event = QuantisedEvent(
        offset=offset,
        event_type=event_type,
        count=count,
        fine=fine if fine else None,
        coarse=coarse,
        coarse_be=coarse_be,
        step_index=step_index,
        grid_step=grid_step,
        grid_beat=grid_beat,
        notes=notes,
        variant=variant,
        tail_bytes=tail_data,
        tail_words=tail_words,
        tail_remainder=tail_remainder,
        tail_entries=parsed_tail_entries,
    )
    if event.step_index is None:
        note_steps = [note.step for note in notes if note.step is not None]
        if note_steps:
            # stored note.step values are 1-based; convert back to 0-based index
            event.step_index = max(min(note_steps) - 1, 0)
            event.grid_step = min(note_steps)
            event.grid_beat = (
                ((event.grid_step - 1) // 4) + 1 if event.grid_step else None
            )
    return event, signature_idx


def decode_pointer21_event(
    data: bytes,
    record_offset: int,
    block_start: int,
    pattern_length: int,
) -> QuantisedEvent | None:
    if record_offset < block_start or record_offset + 18 > len(data):
        return None

    count = int.from_bytes(data[record_offset + 2 : record_offset + 4], "little")
    if count <= 0 or count > 16:
        return None

    best_entries: list[TailEntry] | None = None
    parsed_entries: list[TailEntry] | None = None
    tail_words: List[int] | None = None
    tail_bytes: bytes = b""
    max_back = 0xC0
    span = 0x20
    while span <= max_back and best_entries is None:
        start = max(block_start, record_offset - span)
        if start >= record_offset:
            break
        chunk = data[start:record_offset]
        if len(chunk) < 4:
            span += 0x20
            continue
        words = [
            int.from_bytes(chunk[i : i + 2], "little")
            for i in range(0, len(chunk) // 2 * 2, 2)
        ]
        if not words:
            span += 0x20
            continue
        entries = parse_tail_entries(words, block_start, len(data))
        if entries:
            best_entries = entries
            parsed_entries = entries
            tail_words = words
            tail_bytes = chunk
            break
        span += 0x20

    if best_entries is None or parsed_entries is None or tail_words is None:
        return None

    note_entries: List[NoteDetail] = []
    if parsed_entries:
        for entry in parsed_entries:
            entry.note = None
            entry.velocity = None

    return QuantisedEvent(
        offset=record_offset,
        event_type=0x21,
        count=count,
        fine=None,
        coarse=0,
        coarse_be=0,
        step_index=None,
        grid_step=None,
        grid_beat=None,
        notes=note_entries,
        variant="pointer-21",
        tail_bytes=tail_bytes,
        tail_words=tail_words,
        tail_remainder=b"",
        tail_entries=parsed_entries,
    )


def scan_pointer21_events(
    data: bytes,
    block_start: int,
    block_end: int,
    pattern_length_byte: int,
    handle: TrackHandle | None,
) -> List[QuantisedEvent]:
    events: List[QuantisedEvent] = []
    idx = block_start
    search_end = min(block_end, len(data))
    while idx < search_end:
        idx = data.find(b"\x21", idx, search_end)
        if idx == -1:
            break
        if idx + 18 > search_end:
            idx += 1
            continue
        variant = data[idx + 1]
        if variant not in {0x00, 0x01}:
            idx += 1
            continue
        event = decode_pointer21_event(
            data=data,
            record_offset=idx,
            block_start=block_start,
            pattern_length=pattern_length_byte,
        )
        if event:
            if event_is_plausible(event, handle):
                events.append(event)
            idx = event.offset + 1
        else:
            idx += 1
    return events


def decode_coarse_ticks(coarse_bytes: bytes) -> int:
    if len(coarse_bytes) != 4:
        return 0
    # Hybrid encoding: older captures store the useful coarse tick in the most
    # significant byte (big-end), while quantised step-enter captures only
    # populate the least significant byte. We recover the meaningful portion by
    # checking high bytes first, falling back to little-end interpretation when
    # necessary.
    b0, b1, b2, b3 = coarse_bytes
    if b0 == 0 and b1 == 0:
        # Modern captures: coarse tick in low byte, high-order padding zeroed.
        return (b2 << 8) | b3
    # Otherwise treat as little-end 32-bit (legacy recordings keep micro-timing
    # info in the low byte).
    return int.from_bytes(coarse_bytes, "little")


def locate_track_signature(data: bytes, start: int, block_end: int) -> int:
    """Find the next track signature inside the current block."""

    pos = start
    head = TRACK_SIGNATURE_HEAD

    while pos < block_end:
        idx = data.find(head, pos, block_end)
        if idx == -1:
            break
        if is_probable_track_start(data, idx):
            return idx
        pos = idx + 1
    return block_end


def derive_step_index(
    coarse_bytes: bytes,
    coarse_le: int,
    coarse_be: int,
    pattern_length: int,
    fine_ticks: int | None = None,
) -> int | None:
    max_steps = max(pattern_length, 1)
    if (
        fine_ticks is not None
        and fine_ticks >= 0
        and STEP_TICKS
        and fine_ticks % STEP_TICKS == 0
    ):
        step_candidate = fine_ticks // STEP_TICKS
        if 0 <= step_candidate < max_steps:
            return step_candidate

    if len(coarse_bytes) == 4:
        coarse_mod = coarse_be & 0xFFF
        if coarse_mod % 0x600 == 0:
            if coarse_mod == 0:
                step_candidate = 0
            else:
                step_candidate = max(coarse_mod // 0x600 - 1, 0)
            if step_candidate < max_steps:
                return step_candidate

    candidates: List[int] = []
    if coarse_le:
        candidates.append(coarse_le)
    if len(coarse_bytes) == 4:
        candidates.append(int.from_bytes(coarse_bytes, "little") >> 8)
        candidates.append(coarse_be)

    max_allowed = max_steps * STEP_TICKS
    for coarse in candidates:
        if coarse is None or coarse < 0:
            continue
        if coarse == 0:
            return 0
        if coarse > max_allowed:
            continue
        step = coarse // STEP_TICKS
        if step < max_steps:
            return step
    return None


def estimate_step(raw_ticks: int, pattern_length: int) -> int | None:
    if raw_ticks < 0:
        return None

    total_steps = max(pattern_length, 1)
    max_ticks = total_steps * STEP_TICKS
    if STEP_TICKS == 0 or raw_ticks > max_ticks:
        return None

    step_float = raw_ticks / STEP_TICKS
    approx = round(step_float)
    if approx < 0:
        approx = 0
    if approx >= total_steps:
        return None
    if abs(step_float - approx) > 0.35:
        return None
    return approx


def format_midi_note(note: int) -> str:
    names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    octave = note // 12 - 1
    name = names[note % 12]
    return f"{name}{octave}"


def build_track_infos(
    data: bytes, handles: Sequence[TrackHandle], blocks: Sequence[int]
) -> List[TrackInfo]:
    if len(blocks) < 16:
        raise ValueError(
            f"expected at least 16 track blocks, found {len(blocks)}; file layout changed?"
        )
    if len(blocks) > 16:
        blocks = blocks[:16]

    block_limits = blocks[1:] + [len(data)]
    track_infos: List[TrackInfo] = []
    for idx, (start, end) in enumerate(zip(blocks, block_limits), start=1):
        handle = handles[idx - 1] if idx - 1 < len(handles) else None
        engine_id = read_track_engine(data, start)
        engine_name = ENGINE_NAMES.get(engine_id)
        scale_byte = read_track_scale(data, start)
        pattern_len = read_pattern_length_byte(data, start)
        events = scan_quantised_events(
            data,
            start,
            end,
            pattern_length_byte=pattern_len,
            handle=handle,
        )
        pointer21_events = scan_pointer21_events(
            data,
            start,
            end,
            pattern_length_byte=pattern_len,
            handle=handle,
        )
        if pointer21_events:
            events.extend(pointer21_events)
            events.sort(key=lambda event: event.offset)
        pointer_words = parse_pointer_words(data, start)
        filter_enabled = None
        m4_enabled = None
        if idx <= 8 and pointer_words:
            filter_enabled = detect_filter_enabled(pointer_words)
            m4_enabled = detect_m4_enabled(pointer_words)
        track_infos.append(
            TrackInfo(
                index=idx,
                block_offset=start,
                engine_id=engine_id,
                engine_name=engine_name,
                scale_byte=scale_byte,
                pattern_length_byte=pattern_len,
                handle=handle,
                events=events,
                meta_events=[],
                filter_enabled=filter_enabled,
                m4_enabled=m4_enabled,
            )
        )
    return track_infos


def attach_meta_events(
    data: bytes, track_infos: Sequence[TrackInfo], blocks: Sequence[int]
) -> None:
    if not track_infos or len(blocks) != len(track_infos):
        return

    block_bounds = list(blocks[1:]) + [len(data)]

    pos = 0
    while True:
        pos = data.find(b"\x21", pos)
        if pos == -1:
            break
        if pos + 18 > len(data):
            pos += 1
            continue

        variant = data[pos + 1]
        if variant != 0x01:
            pos += 1
            continue

        track_idx = 0
        for i, start in enumerate(blocks):
            end = block_bounds[i]
            if start <= pos < end:
                track_idx = i
                break
            if pos < start:
                break

        entry = data[pos : pos + 18]
        start_ticks = int.from_bytes(entry[2:6], "little")
        control_raw = int.from_bytes(entry[6:10], "little")
        gate_ticks = (control_raw >> 8) & 0xFFFFFF
        field_a = int.from_bytes(entry[10:14], "little")
        field_b = int.from_bytes(entry[14:18], "little")

        step: int | None = None
        micro_ticks = 0
        micro_parts = 0
        max_steps = max(track_infos[track_idx].pattern_length_byte, 1)
        if STEP_TICKS:
            base_step = round(start_ticks / STEP_TICKS)
            base_step = max(0, min(base_step, max_steps - 1))
            step = base_step + 1
            micro_ticks = start_ticks - base_step * STEP_TICKS
            if STEP_TICKS:
                micro_parts = int(
                    round((micro_ticks / STEP_TICKS) * 64)
                )

        gate_steps = gate_ticks / STEP_TICKS if STEP_TICKS else 0.0
        beat: int | None = None
        if step is not None and step > 0:
            beat = ((step - 1) // 4) + 1

        micro_step_offset = micro_ticks / STEP_TICKS if STEP_TICKS else 0.0

        note_value: int | None = None
        candidate_words = [
            field_b & 0xFFFF,
            (field_b >> 8) & 0xFFFF,
            (field_b >> 16) & 0xFFFF,
        ]
        for candidate in candidate_words:
            if 0x0128 <= candidate <= 0x01FF:
                possible = candidate - 0x0128
                if 0 <= possible <= 0x7F:
                    note_value = possible
                    break

        track_infos[track_idx].meta_events.append(
            MetaEvent21(
                position=pos,
                variant=variant,
                start_ticks=start_ticks,
                gate_ticks=gate_ticks,
                step=step,
                beat=beat,
                micro_ticks=micro_ticks,
                micro_parts=micro_parts,
                micro_step_offset=micro_step_offset,
                gate_steps=gate_steps,
                field_a=field_a,
                field_b=field_b,
                note=note_value,
                raw=entry,
            )
        )

        pos += 18


def parse_eq_entries(data: bytes) -> list[tuple[int, int]]:
    entries: list[tuple[int, int]] = []
    base = 0x24
    for _ in range(3):
        value = int.from_bytes(data[base : base + 2], "little")
        param = int.from_bytes(data[base + 2 : base + 4], "little")
        entries.append((value, param))
        base += 4
    return entries


def fmt_u16(value: int) -> str:
    return f"0x{value:04X}"


def group_unused_handles(handles: Sequence[TrackHandle]) -> tuple[str, list[str]]:
    """Return summary line plus per-track details for non-unused handles."""
    unused_tracks = [
        str(handle.track) for handle in handles if handle.is_unused()
    ]
    summary = ""
    if unused_tracks:
        summary = (
            "T"
            + ",".join(unused_tracks[:-1] + [unused_tracks[-1]])
            + ": unused (00FF/FF00)"
        )
    details: list[str] = []
    for handle in handles:
        if handle.is_unused():
            continue
        details.append(
            f"  T{handle.track}: slot={fmt_u16(handle.slot)}  aux={fmt_u16(handle.aux)}"
        )
    return summary, details


def generate_report(path: Path, data: bytes) -> str:
    lines: List[str] = []
    file_size = len(data)
    header = parse_header(data)
    handles = find_track_handles(data)
    blocks = find_track_blocks(data)
    tracks = build_track_infos(data, handles, blocks)
    attach_meta_events(data, tracks, blocks)
    slot_descriptors = list(
        iter_slot_descriptors(data, (h.slot for h in handles if not h.is_unused()))
    )
    eq_entries = parse_eq_entries(data)

    lines.append("OP-XY Project Inspect (v0.1)")
    lines.append("=" * 28)
    lines.append(
        f"File: {path.name}   Size: {file_size:,} B   Sig: {format_signature(data)}"
    )
    change_log_desc = lookup_change_log_entry(path)
    if change_log_desc:
        lines.append(f"Change Log: {change_log_desc}")
    lines.append("")

    lines.append("[Header]")
    tempo_bpm = header["tempo_tenths"] / 10.0
    lines.append(
        f"  Tempo:            {tempo_bpm:>5.1f} BPM  (raw 0x{header['tempo_tenths']:04X})"
    )
    lines.append(f"  Groove Type:      {format_groove_type(header['groove_type'])}")
    lines.append(f"  Groove Amount:    0x{header['groove_amount']:02X}")
    lines.append(f"  Metronome Level:  0x{header['metronome_level']:02X}")
    lines.append("")

    lines.append("[Pattern Directory]")
    max_slot = pattern_max_slot(data)
    lines.append(
        f"  Max Slot Index @0x56:    0x{max_slot:04X}  (slots 0..{max_slot} potentially used)"
    )
    lines.append("  Track Handles @0x58–0x7F:")
    summary, details = group_unused_handles(handles)
    if details:
        lines.extend(details)
    if summary:
        lines.append(f"    {summary}")

    if slot_descriptors:
        lines.append("")
        lines.append("  Slot Descriptors (16B each, raw view):")
        for slot in slot_descriptors:
            tag = slot.raw[0]
            lines.append(
                f"    Slot 0x{slot.slot:04X} @0x{slot.offset:04X} → tag=0x{tag:02X}  raw={slot.raw.hex()}"
            )
    lines.append("")

    lines.append("[Tracks]")
    for track in tracks:
        engine = (
            f"0x{track.engine_id:02X}"
            + (f" ({track.engine_name})" if track.engine_name else "")
        )
        length_label = format_pattern_length(track.pattern_length_byte)
        lines.append(
            f"  Track {track.index}\n"
            f"    Block @0x{track.block_offset:04X}   Engine ID: {engine}   "
            f"Scale: {format_track_scale(track.scale_byte)}\n"
            f"    Pattern Length @0x{track.block_offset-2:04X}: {length_label}"
        )
        if track.handle and not track.handle.is_unused():
            slot = track.handle.slot
            lines.append(f"    Slot Handle: 0x{slot:04X} / aux 0x{track.handle.aux:04X}")
        module_states: list[str] = []
        if track.filter_enabled is not None:
            module_states.append(
                "M3 Filter=" + ("on" if track.filter_enabled else "off")
            )
        if track.m4_enabled is not None:
            module_states.append("M4 LFO=" + ("on" if track.m4_enabled else "off"))
        if module_states:
            lines.append("    M-pages: " + ", ".join(module_states))

        live_meta = next(
            (meta for meta in track.meta_events if meta.variant == 0x01),
            None,
        )
        if live_meta:
            step_repr = (
                str(live_meta.step) if live_meta.step is not None else "?"
            )
            beat_repr = (
                f" (beat {live_meta.beat})"
                if live_meta.beat is not None
                else ""
            )
            note_parts: list[str] = []
            if live_meta.note is not None:
                note_label = format_midi_note(live_meta.note)
                note_parts.append(f"note={note_label} (0x{live_meta.note:02X})")
            if live_meta.micro_ticks == 0:
                micro_desc = "0 ticks"
            else:
                micro_sign = "+" if live_meta.micro_ticks > 0 else "-"
                micro_abs = abs(live_meta.micro_ticks)
                micro_desc = f"{micro_sign}{micro_abs} ticks"
                if live_meta.micro_parts:
                    micro_desc += f" ({micro_sign}{abs(live_meta.micro_parts)}/64)"
                if live_meta.micro_step_offset:
                    micro_desc += (
                        f" ({micro_sign}"
                        f"{abs(live_meta.micro_step_offset):.2f} step)"
                    )
            note_desc = ""
            if note_parts:
                note_desc = "  " + "  ".join(note_parts)
            lines.append(
                f"    Live trig @0x{live_meta.position:04X}: "
                f"step {step_repr}{beat_repr}  micro={micro_desc}  "
                f"start_ticks={live_meta.start_ticks}  gate={live_meta.gate_display}"
                f"{note_desc}"
            )

        if track.events:
            for event in track.events:
                lines.append(
                    f"    Payload (slot candidate @0x{event.offset:04X}):"
                )
                summary = (
                    f"      EventType 0x{event.event_type:02X}  Count {event.count}"
                )
                lines.append(summary)
                meta_parts = []
                if event.grid_step is not None:
                    meta_parts.append(f"nearest_step={event.grid_step}")
                if event.grid_beat is not None:
                    meta_parts.append(f"nearest_beat={event.grid_beat}")
                meta_parts.append(f"coarse_be=0x{event.coarse_be:08X}")
                if event.coarse:
                    meta_parts.append(f"coarse_le=0x{event.coarse:08X}")
                if event.fine is not None:
                    meta_parts.append(f"fine=0x{event.fine:04X}")
                meta_parts.append(f"form={event.variant}")
                lines.append("        • meta: " + "  ".join(meta_parts))
                if event.tail_bytes:
                    entry_count = len(event.tail_entries)
                    tail_summary = f"{entry_count} tail {'entry' if entry_count == 1 else 'entries'}"
                    tail_summary += f" ({len(event.tail_bytes)} bytes)"
                    pointer_only_count = sum(
                        1 for entry in event.tail_entries if entry.is_pointer_only()
                    )
                    if pointer_only_count == entry_count and entry_count > 0:
                        tail_summary += " pointer metadata"
                    lines.append(f"        • tail: {tail_summary}")
                    for idx, tail_entry in enumerate(event.tail_entries, 1):
                        lines.append(f"          ↳ tail[{idx}]: {tail_entry.describe()}")
                if event.notes:
                    for idx, note_entry in enumerate(event.notes, 1):
                        lines.append(
                            f"        • note[{idx}]: {note_entry.describe(event.grid_step)}"
                        )
                else:
                    lines.append("        • note data unresolved")
        else:
            lines.append("    (no quantised events detected in block window)")

        if track.meta_events:
            lines.append("    Meta Events:")
            for meta in track.meta_events:
                parts = [
                    f"pos=0x{meta.position:04X}",
                    f"variant=0x{meta.variant:02X}",
                    f"start=0x{meta.start_ticks:08X}",
                    f"gate={meta.gate_display}",
                ]
                if meta.step is not None:
                    parts.append(f"step={meta.step}")
                if meta.beat is not None:
                    parts.append(f"beat={meta.beat}")
                if meta.micro_ticks:
                    parts.append(f"micro_ticks={meta.micro_ticks}")
                if meta.micro_parts:
                    parts.append(f"micro_parts={meta.micro_parts}/64")
                if meta.micro_ticks:
                    parts.append(
                        f"micro_step={meta.micro_step_offset:+.3f}"
                    )
                if meta.field_a:
                    parts.append(f"fieldA=0x{meta.field_a:08X}")
                if meta.field_b:
                    parts.append(f"fieldB=0x{meta.field_b:08X}")
                if meta.note is not None:
                    parts.append(
                        f"note={format_midi_note(meta.note)} (0x{meta.note:02X})"
                    )
                raw_repr = " ".join(f"{byte:02X}" for byte in meta.raw)
                lines.append(f"      • 0x21 {'  '.join(parts)}  raw=[{raw_repr}]")

        lines.append("")

    lines.append("[Mix/EQ]")
    labels = ["Low", "Mid", "High"]
    lines.append("  EQ Table @0x24–0x37:")
    for label, (value, param) in zip(labels, eq_entries):
        lines.append(
            f"    {label:<4} value=0x{value:04X}  id=0x{param:04X}"
        )

    return "\n".join(lines).rstrip() + "\n"


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Inspect a single OP-XY project file."
    )
    parser.add_argument("path", type=Path, help="Path to the .xy file to inspect.")
    args = parser.parse_args(argv)

    data = read_file(args.path)
    report = generate_report(args.path, data)
    print(report)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
