"""Build sequential note events for OP-XY track blocks.

At least 9 event types share identical per-note encoding, differing only
in the type byte.  The correct type is determined by the PRESET loaded on
the track, not the engine or slot.  Different presets within the same
engine can use different event types.

Known event types (discovered via unnamed 93/110/112/113/116/117):
  0x1C — Prism bass presets (moog-funk, moog-bass, moog-dark)
  0x1D — Prism bass preset (bass-ana)
  0x1E — Prism pad/pluck presets; Hardsync default preset
  0x1F — Prism pad preset (pad-vib); EPiano default preset
  0x20 — Axis default preset; Multisampler default preset
  0x21 — Prism bass/shoulder; Dissolve default; Drum "in phase" kit
  0x22 — Drum "chamine" kit
  0x25 — Drum "boop" kit; Drum "kerf" kit
  0x2D — engine-swap fallback (body not rewritten); Drum on T5 (exempt)

Using the wrong event type for a preset crashes the firmware.

Default-preset mapping (for factory-fresh projects):
  T1  0x25  (Drum boop)       T5  0x21  (Dissolve)
  T2  0x21  (Drum phase)      T6  0x1E  (Hardsync)
  T3  0x21  (Prism shoulder)  T7  0x20  (Axis)
  T4  0x1F  (EPiano)          T8  0x20  (Multisampler)
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
MAX_EVENT_NOTES = 120


DEFAULT_GATE = b"\xF0\x00\x00\x01"


@dataclass
class Note:
    """A single note trigger."""

    step: int  # 1-based step index (1 = first 16th)
    note: int  # MIDI note number 0-127
    velocity: int = 100  # 0-127
    tick_offset: int = 0  # sub-step offset in ticks (for micro-timing)
    gate_ticks: int = 0  # 0 = default gate; >0 = explicit gate in ticks (480/step)


def build_event(
    notes: List[Note],
    *,
    event_type: int = 0x21,
    allow_unsafe_2d_multi_note: bool = False,
) -> bytes:
    """Encode a list of notes into a single event blob.

    Parameters
    ----------
    notes : list[Note]
        Notes to encode. Sorted by tick position automatically.
    event_type : int
        Preset-specific. Use event_type_for_track() for default presets.
    allow_unsafe_2d_multi_note : bool
        By default, multi-note 0x2D authoring is blocked because it is a
        known device-crash path in early captures. Set True only for
        controlled experiments.

    Returns the raw bytes ready to be appended to a track body.
    """
    if not notes:
        raise ValueError("need at least one note")
    if event_type not in (0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x25, 0x2d):
        raise ValueError(f"unknown event_type 0x{event_type:02X}")

    # Sort by absolute tick
    sorted_notes = sorted(notes, key=lambda n: (n.step - 1) * STEP_TICKS + n.tick_offset)
    count = len(sorted_notes)
    if count > MAX_EVENT_NOTES:
        raise ValueError(
            f"too many notes in one event: {count} > {MAX_EVENT_NOTES} "
            "(device documented limit)"
        )
    if event_type == 0x2D and count > 1 and not allow_unsafe_2d_multi_note:
        raise ValueError(
            "event_type 0x2D with count > 1 is known crash-prone; "
            "use preset-native event type or pass allow_unsafe_2d_multi_note=True"
        )

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
        # Firmware bug: crashes when note byte == velocity byte.
        # Nudge velocity by +1 to avoid the collision (imperceptible).
        note_byte = note.note & 0x7F
        vel_byte = note.velocity & 0x7F
        if vel_byte == note_byte:
            vel_byte = vel_byte + 1 if vel_byte < 127 else vel_byte - 1
        buf.append(note_byte)
        buf.append(vel_byte)

        # --- trailing padding ---
        if is_last:
            buf.extend(b"\x00\x00")  # 2 bytes on last note
        else:
            buf.extend(b"\x00\x00\x00")  # 3 bytes on non-last notes

    return bytes(buf)


def event_type_for_track(track_index: int) -> int:
    """Return the event type byte for a track's DEFAULT preset.

    IMPORTANT: The event type is a property of the PRESET, not the track
    slot or engine.  This function returns the correct type only for a
    factory-fresh project with default presets.  If the user has changed
    the preset, read the event type from the existing track body instead.

    Evidence: unnamed 117 — Prism on all 8 tracks with different presets
    produced 4 different event types (0x1C, 0x1D, 0x1E, 0x1F).
    unnamed 116 — same Drum kit (boop) on T4/T7/T8 all produced 0x25.

    Default-preset mapping (device-verified where noted):
        T1  0x25 (Drum boop)       T5  0x21 (Dissolve)
        T2  0x21 (Drum phase)      T6  0x1E (Hardsync)
        T3  0x21 (Prism shoulder)  T7  0x20 (Axis)
        T4  0x1F (Pluck/EPiano)    T8  0x20 (Multisampler)
        T9-16: 0x21 (auxiliary, untested)
    """
    if track_index < 1 or track_index > 16:
        raise ValueError(f"track_index must be 1-16, got {track_index}")
    _EVENT_TYPES = {
        1: 0x25,   # Drum boop — device-verified
        2: 0x21,   # Drum phase — device-verified
        3: 0x21,   # Prism shoulder — device-verified
        4: 0x1F,   # Pluck/EPiano — device-verified (0x21 crashes)
        5: 0x21,   # Dissolve — device-verified
        6: 0x1E,   # Hardsync — device-verified via unnamed 93
        7: 0x20,   # Axis — device-verified
        8: 0x20,   # Multisampler — device-verified via unnamed 93
    }
    return _EVENT_TYPES.get(track_index, 0x21)


def build_0x21_event(notes: List[Note]) -> bytes:
    """Backward-compatible wrapper: build a 0x21 event."""
    return build_event(notes, event_type=0x21)
