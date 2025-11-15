from __future__ import annotations

import struct
from dataclasses import dataclass
from typing import Iterable, List, Sequence

from .structs import (
    SENTINEL_BYTES,
    STEP_TICKS,
    find_track_blocks,
    find_track_handles,
    parse_pointer_words,
)

# Structural constants observed after "touching" Track 1 on the hardware.
# These values keep the writer deterministic without copying arbitrary blobs.
_ACTIVATED_POINTER_APPEND = 0xFF00
_POINTER_WORD_DELTA = 0x0200

_ACTIVATED_SLOT_TRAILER = 0x0400
# Event slot descriptor emitted by the firmware once a 0x25 note is present.
EVENT_SLOT_WORDS: Sequence[int] = (
    0x0040,
    0x0100,
    0x0040,
    0x0100,
    0x0040,
    0x0100,
    0x0060,
    0x0400,
)

# Node dwords for the "activated but empty" state.
BLANK_NODE_WORDS: Sequence[int] = (
    0x050000FC,
    0x03010008,
    0x01050000,
    0x10020000,
    0x02060000,
    0x40030000,
    0x0C00001F,
    0x00001F40,
)

# Node dwords used once a single quantised trig exists.
EVENT_NODE_TRAILER: Sequence[int] = (
    0xFC00FF03,
    0x08050000,
    0x00030100,
    0x00010500,
    0x00100200,
)

# Step-state slab (32 words) for the activated blank.
# The firmware rotates the baseline (factory) slab by one word and appends 0x5104.
def _compute_blank_slab(factory_slab: Sequence[int]) -> List[int]:
    rotated = list(factory_slab[1:]) + [0x5104]
    return rotated


# Step-state slab once a 0x25 trig is present (modern firmware captures).
EVENT_SLAB_WORDS: Sequence[int] = (
    0xFF00,
    0x0000,
    0x00FF,
    0xFF00,
    0x0000,
    0x00FF,
    0xFF00,
    0x0000,
    0x40DF,
    0x0000,
    0x4001,
    0x0000,
    0x4001,
    0x0000,
    0x4001,
    0x0000,
    0x4001,
    0x0000,
    0x4001,
    0x0000,
    0x4001,
    0x0000,
    0x4001,
    0x0000,
    0xFF08,
    0x007F,
    0x0000,
    0x03E8,
    0x5555,
    0x1501,
    0x0000,
    0xFF04,
)

# Tail region (0x0750–0x07F4) reference patterns (captured from firmware).
_PREPAYLOAD_BYTES = bytes.fromhex(
    "ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000df4000000140000001400000014000000140000001400000014000000140000008ff7f000000e80355550115000004ff1f000000ac47000000fe550000044d76000000682e000002ffff017f000008554f0000002f1600"
)
PREPAYLOAD_WORDS: Sequence[int] = struct.unpack("<126H", _PREPAYLOAD_BYTES)

_BLANK_TAIL_BYTES = bytes.fromhex(
    "ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff00"
)
BLANK_TAIL_WORDS: Sequence[int] = struct.unpack("<82H", _BLANK_TAIL_BYTES)

_EVENT_TAIL_BYTES = bytes.fromhex(
    "000602000003401f00000c401f0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff0000ff00"
)
EVENT_TAIL_WORDS: Sequence[int] = struct.unpack("<82H", _EVENT_TAIL_BYTES)



@dataclass
class TrigSpec:
    step: int  # zero-based
    note: int  # MIDI note 0-127
    velocity: int = 100
    gate_percent: int = 100
    gate_ticks: int | None = None
    voice: int = 1


def _write_u16(buf: bytearray, offset: int, values: Iterable[int]) -> None:
    pos = offset
    for value in values:
        buf[pos : pos + 2] = int(value).to_bytes(2, "little", signed=False)
        pos += 2


def _write_u32(buf: bytearray, offset: int, values: Iterable[int]) -> None:
    pos = offset
    for value in values:
        buf[pos : pos + 4] = int(value).to_bytes(4, "little", signed=False)
        pos += 4


def _activate_pointer_words(
    factory_words: Sequence[int],
) -> List[int]:
    if not factory_words:
        return []
    transformed = [factory_words[0] + _POINTER_WORD_DELTA]
    transformed.extend(factory_words[2:])
    transformed.append(_ACTIVATED_POINTER_APPEND)
    return transformed


def _activate_slot_words(factory_words: Sequence[int]) -> List[int]:
    if not factory_words:
        return []
    rotated = list(factory_words[1:]) + [factory_words[0]]
    rotated[-1] = _ACTIVATED_SLOT_TRAILER
    return rotated


def activate_track(template: bytes, track_index: int = 1) -> bytearray:
    """Return a mutable copy of `template` with Track `track_index` promoted to the blank 'touched' state."""

    buf = bytearray(template)
    blocks = find_track_blocks(template)
    if not blocks or track_index < 1 or track_index > len(blocks):
        raise ValueError(f"invalid track index {track_index}")
    block_offset = blocks[track_index - 1]

    pointer_words = parse_pointer_words(template, block_offset)
    if pointer_words is None:
        raise ValueError("unable to read pointer words from template")
    activated_pointer_words = _activate_pointer_words(pointer_words)
    _write_u16(buf, block_offset + 8, activated_pointer_words)
    # Install the firmware's rotated pre-payload slab (matches unnamed 53.xy).
    _write_u16(buf, block_offset + 0x0024, PREPAYLOAD_WORDS)
    _write_u16(buf, block_offset + 0x0024, PREPAYLOAD_WORDS)

    _write_u16(buf, block_offset + 0x0024, PREPAYLOAD_WORDS)

    handles = find_track_handles(template)
    if track_index - 1 >= len(handles):
        raise ValueError("missing track handle in template")
    handle = handles[track_index - 1]
    try:
        slot_offset = handle.slot_offset()
    except ValueError as exc:  # pragma: no cover - defensive guard
        raise ValueError(
            f"track {track_index} has no slot descriptor in template"
        ) from exc
    factory_slot_words = [
        int.from_bytes(
            template[slot_offset + i : slot_offset + i + 2],
            "little",
            signed=False,
        )
        for i in range(0, 16, 2)
    ]
    activated_slot_words = _activate_slot_words(factory_slot_words)
    _write_u16(buf, slot_offset, activated_slot_words)

    # Sentinel payload
    buf[block_offset + 0x0726 : block_offset + 0x0726 + len(SENTINEL_BYTES)] = (
        SENTINEL_BYTES
    )

    # Node words
    _write_u32(buf, block_offset + 0x0730, BLANK_NODE_WORDS)

    # Tail strip
    _write_u16(buf, block_offset + 0x0750, BLANK_TAIL_WORDS)

    # Step slab
    factory_slab = [
        int.from_bytes(
            template[block_offset + 0x07F4 + i : block_offset + 0x07F4 + i + 2],
            "little",
        )
        for i in range(0, 64, 2)
    ]
    activated_slab = _compute_blank_slab(factory_slab)
    _write_u16(buf, block_offset + 0x07F4, activated_slab)
    return buf


def apply_single_trig(
    buf: bytearray,
    block_offset: int,
    track_index: int,
    trig: TrigSpec,
) -> None:
    """Mutate `buf` in-place, writing a single quantised trig into Track block `block_offset`."""

    if trig.step < 0 or trig.note < 0 or trig.note > 0x7F:
        raise ValueError("invalid trig parameters")
    voice = max(0, min(trig.voice, 0xFFFF))
    velocity = max(0, min(trig.velocity, 0x7F))
    gate_percent = max(0, min(trig.gate_percent, 100))

    fine_ticks = trig.step * STEP_TICKS
    if trig.gate_ticks is not None:
        gate_ticks = max(0, min(trig.gate_ticks, 0xFFFF))
    else:
        gate_ticks = int(round(gate_percent / 100.0 * 1000))

    header = bytearray(10)
    header[0] = 0x25
    header[1] = 0x01
    header[2:4] = fine_ticks.to_bytes(2, "little", signed=False)
    header[4:8] = bytes((0x00, 0x00, 0x00, 0xF0))
    # trailing two bytes left zeroed
    buf[block_offset + 0x0726 : block_offset + 0x0730] = header

    note_word = (velocity << 16) | (trig.note << 8) | (voice & 0xFF)
    pointer_word = (0x1001 << 16) | (velocity << 8)
    coarse_word = ((voice & 0xFF) << 24) | 0x000000F0
    node_values = (
        note_word,
        pointer_word,
        coarse_word,
        *EVENT_NODE_TRAILER,
    )
    _write_u32(buf, block_offset + 0x0730, node_values)

    _write_u16(buf, block_offset + 0x0750, EVENT_TAIL_WORDS)

    event_slab = list(EVENT_SLAB_WORDS)
    event_slab[27] = gate_ticks  # index where 0x03E8 lived
    _write_u16(buf, block_offset + 0x07F4, event_slab)

    # Slot descriptor becomes the event layout.
    handles = find_track_handles(buf)
    if track_index - 1 >= len(handles):
        raise ValueError(f"missing track handle for track {track_index}")
    handle = handles[track_index - 1]
    try:
        slot_offset = handle.slot_offset()
    except ValueError as exc:  # pragma: no cover - defensive guard
        raise ValueError(
            f"track {track_index} has no slot descriptor after activation"
        ) from exc
    _write_u16(buf, slot_offset, EVENT_SLOT_WORDS)


__all__ = [
    "TrigSpec",
    "activate_track",
    "apply_single_trig",
]
