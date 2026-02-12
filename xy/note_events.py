"""Build sequential note events for OP-XY track blocks.

Six event types share identical per-note encoding, differing only in the
type byte.  The correct type depends on track slot and engine:

  0x25 — Track 1 only (device-verified; 0x21 on T1 crashes)
  0x21 — Drum/Prism/Dissolve engines (device-verified on T2, T3, T5)
  0x1f — Pluck/EPiano engine (device-verified on T4; 0x21 on T4 crashes)
  0x20 — Axis/Multisampler engines (device-verified on T7)
  0x1e — Hardsync engine (T6 native, untested for authoring)
  0x2d — observed on some tracks; crashes on device

Default mapping (device-verified where noted):
  T1  0x25  (Drum boop)       T5  0x21  (Dissolve)
  T2  0x21  (Drum phase)      T6  0x1E  (Hardsync, untested)
  T3  0x21  (Prism)           T7  0x20  (Axis)
  T4  0x1F  (Pluck/EPiano)    T8  0x20  (Multisampler, untested)
  T9-16: 0x21 (auxiliary tracks, untested)

Record layout (per note inside one event, default gate):
  First note  (tick==0) : 12 bytes
  Middle notes (tick>0)  : 14 bytes
  Last note   (tick>0)  : 13 bytes  (1 byte shorter — no separator)

With explicit gate, each note is 1 byte longer (5-byte gate vs 4-byte default).

Gate encoding (device-verified via unnamed 92.xy):
  Default: ``F0 00 00 01`` (4 bytes) — firmware default short gate
  Explicit: ``[gate_ticks u32 LE] 00`` (5 bytes) — absolute tick count
  Parser distinguishes by checking if byte at gate position is 0xF0.

Tick encoding: absolute, 480 ticks per 16th-note step.
"""

from __future__ import annotations

import struct
from dataclasses import dataclass, field
from typing import List

STEP_TICKS = 480


DEFAULT_GATE = b"\xF0\x00\x00\x01"


@dataclass
class Note:
    """A single note trigger."""

    step: int  # 1-based step index (1 = first 16th)
    note: int  # MIDI note number 0-127
    velocity: int = 100  # 0-127
    tick_offset: int = 0  # sub-step offset in ticks (for micro-timing)
    gate_ticks: int = 0  # 0 = default gate; >0 = explicit gate in ticks (480/step)


def build_event(notes: List[Note], *, event_type: int = 0x21) -> bytes:
    """Encode a list of notes into a single event blob.

    Parameters
    ----------
    notes : list[Note]
        Notes to encode. Sorted by tick position automatically.
    event_type : int
        0x25 for Track 1, 0x21 for Tracks 2-16.  Use event_type_for_track().

    Returns the raw bytes ready to be appended to a track body.
    """
    if not notes:
        raise ValueError("need at least one note")
    if event_type not in (0x1e, 0x1f, 0x20, 0x21, 0x25, 0x2d):
        raise ValueError(f"event_type must be 0x1e/0x1f/0x20/0x21/0x25/0x2d, got 0x{event_type:02X}")

    # Sort by absolute tick
    sorted_notes = sorted(notes, key=lambda n: (n.step - 1) * STEP_TICKS + n.tick_offset)
    count = len(sorted_notes)

    buf = bytearray()
    buf.append(event_type)
    buf.append(count)

    for i, note in enumerate(sorted_notes):
        ticks = (note.step - 1) * STEP_TICKS + note.tick_offset
        is_first = i == 0
        is_last = i == count - 1

        # --- tick field ---
        if ticks == 0:
            buf.extend(struct.pack("<H", 0))  # 2 bytes
        else:
            buf.extend(struct.pack("<I", ticks))  # 4 bytes

        # --- flag byte ---
        buf.append(0x02 if ticks == 0 else 0x00)

        # --- gate field ---
        if note.gate_ticks > 0:
            buf.extend(struct.pack("<I", note.gate_ticks))
            buf.append(0x00)
        else:
            buf.extend(DEFAULT_GATE)

        # --- note & velocity ---
        buf.append(note.note & 0x7F)
        buf.append(note.velocity & 0x7F)

        # --- trailing padding ---
        if is_last:
            buf.extend(b"\x00\x00")  # 2 bytes on last note
        else:
            buf.extend(b"\x00\x00\x00")  # 3 bytes on non-last notes

    return bytes(buf)


def event_type_for_track(track_index: int, *, native: bool = False) -> int:
    """Return the correct event type byte for a 1-based track index.

    Track 1 requires 0x25; Tracks 2-16 default to 0x21 (universal fallback).
    Device-verified: 0x21 on T1 crashes, 0x25 on T2 crashes.

    Parameters
    ----------
    track_index : int
        1-based track number (1-16).
    native : bool
        If True, return the firmware-native event type for each track slot
        (from unnamed 93 MIDI harness experiment).  Native types match what
        the device itself writes and may unlock engine-specific features.
        If False (default), return the safe universal fallback (0x21 for T2+).

    Native mapping (unnamed 93, default engines):
        T1  0x25 (Drum boop)      T5  0x21 (Dissolve)
        T2  0x21 (Drum phase)     T6  0x1E (Hardsync)
        T3  0x21 (Prism)          T7  0x20 (Axis)
        T4  0x1F (Pluck/EPiano)   T8  0x20 (Multisampler)
    """
    if track_index < 1 or track_index > 16:
        raise ValueError(f"track_index must be 1-16, got {track_index}")
    if track_index == 1:
        return 0x25
    if not native:
        return 0x21
    # Firmware-native types per default engine assignment (unnamed 93)
    _NATIVE = {
        2: 0x21,   # Drum phase
        3: 0x21,   # Prism
        4: 0x1F,   # Pluck / EPiano
        5: 0x21,   # Dissolve
        6: 0x1E,   # Hardsync
        7: 0x20,   # Axis
        8: 0x20,   # Multisampler
    }
    return _NATIVE.get(track_index, 0x21)


def build_0x21_event(notes: List[Note]) -> bytes:
    """Backward-compatible wrapper: build a 0x21 event."""
    return build_event(notes, event_type=0x21)
