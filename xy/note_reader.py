"""Read note events from OP-XY track blocks.

Parses both builder-generated and firmware-native note event formats
using a unified continuation-byte state machine.

The per-note byte layout uses a continuation byte between notes to
signal the encoding of the next note's tick field:

  0x00 — separator: 2-byte u16 LE tick + flag + optional pad
  0x01 — escape (tick_lo==0): 1-byte tick_hi + flag + pad
  0x04 — chord continuation: no tick (inherits previous), no flag/pad

The flag byte (0x00 or 0x02) after the tick field determines whether
2 pad bytes follow (0x00 → yes, 0x02 → no).

Gate encoding: first byte 0xF0 → default gate (4 bytes), otherwise
explicit gate as u16 LE + 3 zero bytes (5 bytes total).
"""

from __future__ import annotations

import struct
from typing import List

from .container import TrackBlock
from .note_events import STEP_TICKS, Note, event_type_for_track

KNOWN_EVENT_TYPES = frozenset({0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x25, 0x2D})


def read_event(data: bytes) -> List[Note]:
    """Parse raw event bytes into a list of Note objects.

    Parameters
    ----------
    data : bytes
        Raw bytes starting at the event type byte.  May extend beyond
        the event (trailing data is ignored after ``count`` notes).

    Returns
    -------
    list[Note]
        Parsed notes with 1-based step, MIDI note, velocity, tick
        offset, and gate ticks (0 for default gate).
    """
    if len(data) < 2:
        raise ValueError("event data too short for header")

    event_type = data[0]
    count = data[1]

    if event_type not in KNOWN_EVENT_TYPES:
        raise ValueError(f"unknown event type 0x{event_type:02X}")
    if count < 1 or count > 64:
        raise ValueError(f"invalid note count {count}")

    notes: List[Note] = []
    pos = 2
    prev_tick = 0

    for i in range(count):
        if i == 0:
            # First note: u16 LE tick + flag byte
            tick = struct.unpack_from("<H", data, pos)[0]
            pos += 2
            flag = data[pos]
            pos += 1
            if flag == 0x02:
                pass  # no pad bytes
            elif flag == 0x00:
                pos += 2  # skip 2 pad bytes
            else:
                raise ValueError(
                    f"unexpected first-note flag 0x{flag:02X} at pos {pos - 1}"
                )
        else:
            # Trail (2 bytes) + continuation byte
            pos += 2  # skip trail
            cont = data[pos]
            pos += 1

            if cont == 0x00:
                # Separator: 2-byte u16 LE tick, then flag + optional pad
                tick = struct.unpack_from("<H", data, pos)[0]
                pos += 2
                flag = data[pos]
                pos += 1
                if flag == 0x00:
                    pos += 2  # skip pad
                elif flag == 0x02:
                    pass  # no pad
                else:
                    raise ValueError(
                        f"unexpected flag 0x{flag:02X} after cont 0x00 at pos {pos - 1}"
                    )
            elif cont == 0x01:
                # Escape: 1-byte tick_hi (tick_lo is 0), then flag + pad
                tick_hi = data[pos]
                pos += 1
                tick = tick_hi << 8
                flag = data[pos]
                pos += 1
                if flag == 0x00:
                    pos += 2  # skip pad
                elif flag == 0x02:
                    pass  # no pad (unlikely but handle it)
                else:
                    raise ValueError(
                        f"unexpected flag 0x{flag:02X} after cont 0x01 at pos {pos - 1}"
                    )
            elif cont == 0x04:
                # Chord continuation: inherit previous tick, no flag/pad
                tick = prev_tick
            else:
                raise ValueError(
                    f"unknown continuation byte 0x{cont:02X} at pos {pos - 1}"
                )

        # Gate field
        gate_byte = data[pos]
        if gate_byte == 0xF0:
            # Default gate: F0 00 00 01 (4 bytes)
            pos += 4
            gate_ticks = 0
        else:
            # Explicit gate: u16 LE + 00 00 00 (5 bytes)
            gate_ticks = struct.unpack_from("<H", data, pos)[0]
            pos += 5

        # Note and velocity
        note_byte = data[pos]
        pos += 1
        vel_byte = data[pos]
        pos += 1

        step = tick // STEP_TICKS + 1
        tick_offset = tick % STEP_TICKS

        notes.append(
            Note(
                step=step,
                note=note_byte,
                velocity=vel_byte,
                tick_offset=tick_offset,
                gate_ticks=gate_ticks,
            )
        )
        prev_tick = tick

    # Skip final trail (2 bytes) — not consumed, just informational
    # pos += 2

    return notes


def find_event(body: bytes, track_index: int) -> int | None:
    """Find the byte offset of a note event within a track body.

    Scans for the 5-byte signature ``[event_type] [count:1-64] [00 00 02]``
    which marks the start of a note event (first note at tick 0).

    Falls back to scanning for any of the 9 known event types if the
    expected type for ``track_index`` is not found.

    Parameters
    ----------
    body : bytes
        Raw track body (everything after the 4-byte preamble).
    track_index : int
        1-based track number (used to determine expected event type).

    Returns
    -------
    int or None
        Byte offset of the event type byte within ``body``, or None.
    """
    expected_type = event_type_for_track(track_index)

    # Primary: search for expected event type
    result = _scan_for_event(body, expected_type)
    if result is not None:
        return result

    # Fallback: try all known event types
    for etype in sorted(KNOWN_EVENT_TYPES):
        if etype == expected_type:
            continue
        result = _scan_for_event(body, etype)
        if result is not None:
            return result

    return None


def _scan_for_event(body: bytes, event_type: int) -> int | None:
    """Scan for a note event with the given type byte."""
    target = bytes([event_type])
    start = 0
    while True:
        idx = body.find(target, start)
        if idx == -1 or idx + 5 > len(body):
            return None

        count = body[idx + 1]
        if 1 <= count <= 64:
            # Check tick-0 first-note signature: [00 00 02]
            if body[idx + 2 : idx + 5] == b"\x00\x00\x02":
                return idx
            # Check tick>0 first-note signature: [lo hi 00 00 00]
            # (flag=0x00 + 2 pad bytes after the u16 tick)
            if idx + 7 <= len(body) and body[idx + 4 : idx + 7] == b"\x00\x00\x00":
                return idx

        start = idx + 1


def read_track_notes(track: TrackBlock, track_index: int) -> List[Note]:
    """Read all notes from a track block.

    Parameters
    ----------
    track : TrackBlock
        The track block to read from.
    track_index : int
        1-based track number.

    Returns
    -------
    list[Note]
        Parsed notes, or empty list if the track is inactive or has
        no note events.
    """
    if track.type_byte == 0x05:
        return []  # inactive track

    offset = find_event(track.body, track_index)
    if offset is None:
        return []

    return read_event(track.body[offset:])
