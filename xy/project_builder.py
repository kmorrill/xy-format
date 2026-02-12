"""High-level helpers for modifying XYProject track blocks.

Implements the event insertion recipe discovered during reverse engineering:

  Most tracks (pure-append):
    1. Flip type byte from 0x05 -> 0x07
    2. Remove 2-byte padding at body[10:12]
    3. Append event data at end of body

  Pluck/EPiano engine (engine_id 0x07) — insert-before-tail:
    1-2. Same activation as above
    3. Insert event BEFORE the 47-byte parameter tail section
    4. Clear bit 5 of the tail marker byte (0x28 -> 0x08)

  All tracks:
    Set next track's preamble byte 0 to 0x64 (with exceptions).

Preamble rule (verified via unnamed 93, 8 adjacent activated tracks):
  - The first activated track in a contiguous group keeps its original preamble.
  - Every track immediately AFTER an activated track gets 0x64 preamble,
    even if that track is itself activated.
  - The first unactivated track after the group also gets 0x64.
  - Exception: Track 5 (0-based idx 4) keeps its original preamble always.
"""

from __future__ import annotations

from typing import Dict, List

from .container import TrackBlock, XYProject
from .note_events import Note, build_event, event_type_for_track


# Engine IDs with a tail section that events must be inserted before.
# Pluck/EPiano (0x07) has a 47-byte parameter tail starting with 0x28.
# Discovered via unnamed 93: the firmware inserts the event before this
# tail and clears bit 5 of the marker byte (0x28 -> 0x08).
_TAIL_ENGINES = {0x07}
_TAIL_SIZE = 47
_TAIL_MARKER_BIT = 0x20  # bit 5: cleared when event is present


def _activate_body(body: bytes) -> bytearray:
    """Flip type byte 0x05 -> 0x07 and remove 2-byte padding.

    Returns a new mutable body.  If the track is already type 0x07
    (already activated), returns the body unchanged.
    """
    buf = bytearray(body)
    type_byte = buf[9]
    if type_byte == 0x05:
        buf[9] = 0x07
        # Remove the 2-byte padding at positions 10-11 (0x08 0x00)
        del buf[10:12]
    elif type_byte == 0x07:
        pass  # already activated
    else:
        raise ValueError(f"unexpected type byte 0x{type_byte:02X} at body[9]")
    return buf


def _update_preamble(preamble: bytes, new_byte0: int) -> bytes:
    """Return preamble with byte 0 replaced."""
    buf = bytearray(preamble)
    buf[0] = new_byte0 & 0xFF
    return bytes(buf)


def append_notes_to_track(
    project: XYProject,
    track_index: int,
    notes: List[Note],
    *,
    native: bool = False,
) -> XYProject:
    """Return a new XYProject with notes appended to the given track.

    This is the single-track convenience wrapper.  For modifying multiple
    tracks, use :func:`append_notes_to_tracks` instead — it correctly
    handles preamble updates when adjacent tracks are both activated.

    Parameters
    ----------
    project : XYProject
        The source project (not mutated).
    track_index : int
        1-based track number (1-16).
    notes : list[Note]
        Notes to append.
    native : bool
        If True, use firmware-native event types per track slot.
    """
    return append_notes_to_tracks(project, {track_index: notes}, native=native)


def append_notes_to_tracks(
    project: XYProject,
    track_notes: Dict[int, List[Note]],
    *,
    native: bool = False,
) -> XYProject:
    """Return a new XYProject with notes appended to multiple tracks.

    Handles the preamble update rule correctly: the 0x64 sentinel is placed
    on every track immediately following an activated track, even if that
    track is itself activated (verified via unnamed 93).

    Parameters
    ----------
    project : XYProject
        The source project (not mutated).
    track_notes : dict[int, list[Note]]
        Mapping of 1-based track index to list of notes.
    native : bool
        If True, use firmware-native event types per track slot.
        If False (default), use 0x25 for T1 and 0x21 for all others.
    """
    if not track_notes:
        raise ValueError("need at least one track with notes")

    modified_indices = set()  # 0-based indices of tracks we're modifying
    tracks = list(project.tracks)

    # --- Step 1: activate bodies and append events ---
    for track_index, notes in track_notes.items():
        if track_index < 1 or track_index > 16:
            raise ValueError(f"track_index must be 1-16, got {track_index}")
        if not notes:
            raise ValueError(f"need at least one note for track {track_index}")

        idx = track_index - 1
        modified_indices.add(idx)

        target = tracks[idx]
        new_body = _activate_body(target.body)
        etype = event_type_for_track(track_index, native=native)
        event_blob = build_event(notes, event_type=etype)

        if target.engine_id in _TAIL_ENGINES and len(new_body) >= _TAIL_SIZE:
            # Insert-before-tail: event goes before the 47-byte parameter tail.
            # Clear bit 5 of the tail marker to signal "events present".
            insert_pos = len(new_body) - _TAIL_SIZE
            new_body[insert_pos] &= ~_TAIL_MARKER_BIT
            new_body[insert_pos:insert_pos] = event_blob
        else:
            # Pure-append: event goes at end of body.
            new_body.extend(event_blob)

        tracks[idx] = TrackBlock(
            index=target.index,
            preamble=target.preamble,  # keep original preamble
            body=bytes(new_body),
        )

    # --- Step 2: set preamble 0x64 on the track after each activated track ---
    # Corpus evidence (unnamed 93, 8 activated tracks): every track immediately
    # following an activated track gets 0x64, even if itself activated.
    #
    # Exception: Track 5 (0-based index 4) keeps its original preamble even
    # when T4 is activated.  Observed in unnamed 93 where T5 kept 0x2E while
    # all other post-activation tracks got 0x64.  Setting T5 to 0x64 causes
    # a num_patterns crash (serialize_latest.cpp:90).  Reason unknown —
    # possibly a firmware quirk tied to the Dissolve engine or the T5 slot.
    _PREAMBLE_EXEMPT = {4}  # 0-based indices that must NOT get 0x64
    preamble_targets = set()  # 0-based indices that need preamble update
    for idx in modified_indices:
        nxt = idx + 1
        if nxt < 16 and nxt not in _PREAMBLE_EXEMPT:
            preamble_targets.add(nxt)

    for idx in preamble_targets:
        t = tracks[idx]
        tracks[idx] = TrackBlock(
            index=t.index,
            preamble=_update_preamble(t.preamble, 0x64),
            body=t.body,
        )

    return XYProject(pre_track=project.pre_track, tracks=tracks)
