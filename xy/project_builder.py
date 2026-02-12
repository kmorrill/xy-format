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

import math
from dataclasses import dataclass
from typing import Dict, List, Optional

from .container import TrackBlock, XYProject
from .note_events import Note, build_event, event_type_for_track
from .step_components import (
    StepComponent, build_component_data, slot_body07_offset,
    compute_alloc_byte, alloc_marker_body07_offset,
)


# Engine IDs with a tail section that events must be inserted before.
# Pluck/EPiano (0x07) has a 47-byte parameter tail starting with 0x28.
# Discovered via unnamed 93: the firmware inserts the event before this
# tail and clears bit 5 of the marker byte (0x28 -> 0x08).
_TAIL_ENGINES = {0x07}
_TAIL_SIZE = 47
_TAIL_MARKER_BIT = 0x20  # bit 5: cleared when event is present

# Track 1 in multi-pattern mode uses an additional in-body rewrite whenever a
# pattern block is activated (seen in unnamed 102/103/104/105).  The last
# occurrence of this sequence changes from a compact single-byte marker to a
# 6-byte blob.
_T1_MULTI_PATCH_OLD = bytes.fromhex("77 61 76 00 00 44 ff ff 02 00 00 02")
_T1_MULTI_PATCH_NEW = bytes.fromhex(
    "77 61 76 00 00 3c a0 40 00 00 04 ff ff 02 00 00 02"
)


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


def _update_preamble(preamble: bytes, new_byte0: int | None = None,
                     pattern_length: int | None = None) -> bytes:
    """Return preamble with selected bytes replaced.

    Parameters
    ----------
    preamble : bytes
        Original 4-byte preamble.
    new_byte0 : int or None
        If set, replace preamble[0] (sentinel byte).
    pattern_length : int or None
        If set, replace preamble[2] (pattern length byte).
        Value is in steps: 0x10 = 1 bar, 0x20 = 2 bars, etc.
    """
    buf = bytearray(preamble)
    if new_byte0 is not None:
        buf[0] = new_byte0 & 0xFF
    if pattern_length is not None:
        buf[2] = pattern_length & 0xFF
    return bytes(buf)


def _bars_for_notes(notes: List[Note]) -> int:
    """Calculate the number of bars needed for a list of notes.

    Returns the number of bars (1-4+) based on the maximum step.
    """
    max_step = max(n.step for n in notes)
    return math.ceil(max_step / 16)


def _patch_t1_multi_pattern_body(body: bytes) -> bytes:
    """Apply the Track 1 multi-pattern activation blob swap.

    In Track 1 pattern blocks with notes, firmware rewrites the *last* matching
    `...wav..44...` sequence into the longer `...wav..3c a0 40 00 00 04...`
    form.  This adds 5 bytes and is required to match device-authored captures.
    """
    idx = body.rfind(_T1_MULTI_PATCH_OLD)
    if idx == -1:
        return body
    return (
        body[:idx]
        + _T1_MULTI_PATCH_NEW
        + body[idx + len(_T1_MULTI_PATCH_OLD):]
    )


def add_step_components(
    project: XYProject,
    track_index: int,
    components: List[StepComponent],
) -> XYProject:
    """Return a new XYProject with step components added to the given track.

    The component data is inserted into the track body's slot table, growing
    the body by the component data size.  The track is activated (type 0x05
    to 0x07) if not already active.

    Currently supports single components on steps 1 and 9 only (the only
    slot positions verified in the corpus).

    Parameters
    ----------
    project : XYProject
        The source project (not mutated).
    track_index : int
        1-based track number (1-16).
    components : list[StepComponent]
        Components to insert.
    """
    if track_index < 1 or track_index > 16:
        raise ValueError(f"track_index must be 1-16, got {track_index}")
    if not components:
        raise ValueError("need at least one component")

    idx = track_index - 1
    tracks = list(project.tracks)
    target = tracks[idx]

    new_body = _activate_body(target.body)

    # Determine engine ID for engine-aware offsets.
    engine_id = target.engine_id

    # Replace 3-byte slot entries with component data.  Process in
    # step-descending order so earlier slots aren't shifted by later inserts.
    total_net_growth = 0
    for comp in sorted(components, key=lambda c: -c.step):
        replace_offset = slot_body07_offset(comp.step, engine_id)
        data = build_component_data(comp)
        # Overwrite the 3-byte slot entry; insert any remaining bytes.
        new_body[replace_offset:replace_offset + 3] = data
        total_net_growth += len(data) - 3

    # Update the allocation marker byte.
    # The marker shifts right by the total net growth.
    if len(components) == 1:
        comp = components[0]
        alloc_offset = alloc_marker_body07_offset(total_net_growth, engine_id)
        if alloc_offset < len(new_body):
            new_body[alloc_offset] = compute_alloc_byte(comp, engine_id)

    tracks[idx] = TrackBlock(
        index=target.index,
        preamble=target.preamble,
        body=bytes(new_body),
    )

    # Note: component-only activation does NOT set preamble 0x64 on the
    # next track.  All 19 component corpus specimens keep original preambles.
    # The 0x64 rule only applies when note events are appended.

    return XYProject(pre_track=project.pre_track, tracks=tracks)


def append_notes_to_track(
    project: XYProject,
    track_index: int,
    notes: List[Note],
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
    """
    return append_notes_to_tracks(project, {track_index: notes})


def append_notes_to_tracks(
    project: XYProject,
    track_notes: Dict[int, List[Note]],
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
        etype = event_type_for_track(track_index)
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

        # Set pattern length in preamble based on max step.
        # preamble[2] = bars * 16: 0x10=1bar, 0x20=2bars, 0x30=3bars, 0x40=4bars
        bars = _bars_for_notes(notes)
        pattern_len_byte = bars * 16
        new_preamble = _update_preamble(target.preamble, pattern_length=pattern_len_byte)

        tracks[idx] = TrackBlock(
            index=target.index,
            preamble=new_preamble,
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
            preamble=_update_preamble(t.preamble, new_byte0=0x64),
            body=t.body,
        )

    return XYProject(pre_track=project.pre_track, tracks=tracks)


# ── Multi-pattern support ─────────────────────────────────────────────


# Pre-track descriptors inserted at offset 0x58 when multiple patterns exist.
# These encode which tracks have extra patterns.  "strict" mode only allows the
# combinations we captured on device and verified byte-for-byte.
_STRICT_DESCRIPTORS = {
    # frozenset of 0-based track indices -> descriptor bytes
    frozenset({0}): b"\x00\x1D\x01\x00\x00",              # T1 only (5 bytes)
    frozenset({0, 2}): b"\x01\x00\x00\x1B\x01\x00\x00",   # T1 + T3 (7 bytes)
}

# 105b compatibility mode (T1+T3, both 2 patterns, T3 leader has notes).
_T1_ONLY_DESCRIPTOR = b"\x00\x1D\x01\x00\x00"

_AUX_PATCH_OLD_A = bytes.fromhex("00 00 19 40 00 00 01 60 00 00 16 ff ff 01 7f")
_AUX_PATCH_NEW_A = bytes.fromhex(
    "00 00 11 40 00 00 01 40 00 00 01 40 00 00 01 60 00 00 16 ff ff 01 7f"
)
_AUX_PATCH_OLD_B = bytes.fromhex("00 00 91 40 00 00 01 60 00 00 16 ff ff 01 7f")
_AUX_PATCH_NEW_B = bytes.fromhex(
    "00 00 89 40 00 00 01 40 00 00 01 40 00 00 01 60 00 00 16 ff ff 01 7f"
)


def _is_105b_mode(
    track_patterns: Dict[int, List[Optional[List[Note]]]],
) -> bool:
    """Return True for the observed `unnamed 105b` serialization branch."""
    if set(track_patterns) != {1, 3}:
        return False
    t1 = track_patterns.get(1, [])
    t3 = track_patterns.get(3, [])
    if len(t1) != 2 or len(t3) != 2:
        return False
    # 105b: T1 leader blank, T1 clone active; T3 leader active.
    return (not t1[0]) and bool(t1[1]) and bool(t3[0])


def _heuristic_descriptor(track_set: frozenset[int]) -> bytes:
    """Build an experimental descriptor for multi-pattern track sets.

    This is intentionally isolated from strict mode so validated captures keep
    exact behavior.  The heuristic is derived from these known descriptors:
      - {T1}:    00 1D 01 00 00
      - {T1,T3}: 01 00 00 1B 01 00 00

    Rules:
      - T1 must be present (all observed multi-pattern captures include T1).
      - Byte 0 = number of extra multi-pattern tracks beyond T1.
      - If no extra tracks: emit 1D 01.
      - If extra tracks exist: emit 00 00, then one pair per extra track:
        [token, 0x01], where token = 0x1E - track_index_1_based.
      - Append terminator 00 00.
    """
    if 0 not in track_set:
        raise ValueError(
            "descriptor heuristic currently requires Track 1 in the multi-pattern set"
        )

    ordered = sorted(track_set)
    extras = [ti for ti in ordered if ti != 0]  # 0-based, excluding T1

    out = bytearray()
    out.append(len(extras) & 0xFF)

    if not extras:
        out.extend((0x1D, 0x01))
    else:
        out.extend((0x00, 0x00))
        for ti in extras:
            track_1_based = ti + 1
            token = 0x1E - track_1_based
            if token <= 0:
                raise ValueError(
                    f"invalid track token for track {track_1_based}: 0x{token:02X}"
                )
            out.extend((token & 0xFF, 0x01))

    out.extend((0x00, 0x00))
    return bytes(out)


def _descriptor_for_track_set(
    track_set: frozenset[int],
    *,
    strategy: str,
) -> bytes:
    """Return descriptor bytes for the given multi-pattern track set."""
    if strategy == "strict":
        if track_set not in _STRICT_DESCRIPTORS:
            supported = ", ".join(
                "{" + ",".join(f"T{i+1}" for i in s) + "}"
                for s in _STRICT_DESCRIPTORS
            )
            raise ValueError(
                f"unsupported multi-pattern track set {track_set}; "
                f"supported in strict mode: {supported}"
            )
        return _STRICT_DESCRIPTORS[track_set]

    if strategy == "heuristic_v1":
        return _heuristic_descriptor(track_set)

    raise ValueError(
        f"unknown descriptor strategy {strategy!r}; "
        "expected 'strict' or 'heuristic_v1'"
    )


@dataclass
class _BlockEntry:
    """Internal plan entry describing one block in the output layout."""

    owner: int             # 0-based original track index
    pattern: int           # 0-based pattern number (0 = leader)
    notes: Optional[List[Note]]  # None = blank / regular
    is_leader: bool        # True for leader blocks of multi-pattern tracks
    is_clone: bool         # True for clone blocks (pattern > 0)
    is_last_in_set: bool   # True for the last block in a multi-pattern set


def _plan_blocks(
    track_patterns: Dict[int, List[Optional[List[Note]]]],
) -> List[_BlockEntry]:
    """Build an ordered list of block entries for the 16-slot layout.

    Returns one entry per block (may exceed 16 — overflow handled by caller).
    """
    multi_tracks = {ti - 1 for ti in track_patterns}  # 0-based
    entries: List[_BlockEntry] = []

    for ti_0 in range(16):
        ti_1 = ti_0 + 1
        if ti_1 in track_patterns:
            patterns = track_patterns[ti_1]
            num_pats = len(patterns)
            for pi, pat_notes in enumerate(patterns):
                entries.append(_BlockEntry(
                    owner=ti_0,
                    pattern=pi,
                    notes=pat_notes if pat_notes else None,
                    is_leader=(pi == 0),
                    is_clone=(pi > 0),
                    is_last_in_set=(pi == num_pats - 1),
                ))
        else:
            entries.append(_BlockEntry(
                owner=ti_0, pattern=0, notes=None,
                is_leader=False, is_clone=False, is_last_in_set=True,
            ))

    return entries


def _build_pre_track(
    original: bytes,
    track_patterns: Dict[int, List[Optional[List[Note]]]],
    *,
    descriptor_strategy: str,
) -> bytes:
    """Update the pre-track region for multi-pattern storage.

    Sets pattern_max_slot at 0x56 and inserts the track descriptor at 0x58.
    """
    max_count = max(len(pats) for pats in track_patterns.values())
    slot_value = max_count - 1  # 0 = 1 pattern, 1 = 2 patterns, etc.

    if _is_105b_mode(track_patterns):
        # Device-authored 105b switches back to the 5-byte T1-style descriptor
        # when T3 leader pattern carries note data.
        descriptor = _T1_ONLY_DESCRIPTOR
    else:
        multi_set = frozenset(ti - 1 for ti in track_patterns)
        descriptor = _descriptor_for_track_set(
            multi_set,
            strategy=descriptor_strategy,
        )

    buf = bytearray(original)
    # Update pattern_max_slot at 0x56
    buf[0x56:0x58] = slot_value.to_bytes(2, "little")
    # Insert descriptor at 0x58 (shifts handle table right)
    buf[0x58:0x58] = descriptor
    return bytes(buf)


def build_multi_pattern_project(
    project: XYProject,
    track_patterns: Dict[int, List[Optional[List[Note]]]],
    *,
    descriptor_strategy: str = "strict",
) -> XYProject:
    """Build a multi-pattern project via block rotation.

    Parameters
    ----------
    project : XYProject
        Baseline project (not mutated).
    track_patterns : dict[int, list[list[Note] | None]]
        Mapping of 1-based track index to list of patterns.
        Each pattern is either None (blank) or a list of Notes.
        Must have at least 2 patterns per track.
    descriptor_strategy : str
        Descriptor encoding strategy for the pre-track insert at 0x58.
        - "strict": only device-verified sets (T1, T1+T3).
        - "heuristic_v1": experimental formula for broader sets.

    Returns a new XYProject with the multi-pattern block layout.
    """
    # ── Validate ──────────────────────────────────────────────────────
    if not track_patterns:
        raise ValueError("need at least one track with patterns")
    for ti, patterns in track_patterns.items():
        if ti < 1 or ti > 16:
            raise ValueError(f"track_index must be 1-16, got {ti}")
        if len(patterns) < 2:
            raise ValueError(
                f"need at least 2 patterns for track {ti}, got {len(patterns)}"
            )

    baseline = project.tracks  # 16 original TrackBlocks
    entries = _plan_blocks(track_patterns)

    # ── Build blocks ──────────────────────────────────────────────────
    # Split into normal slots (0-14) and overflow (15+)
    if len(entries) > 16:
        normal_entries = entries[:15]
        overflow_entries = entries[15:]
    else:
        normal_entries = entries
        overflow_entries = []

    blocks: List[TrackBlock] = []

    for slot_idx, entry in enumerate(normal_entries):
        block = _build_single_block(baseline, entry, slot_idx, track_patterns)
        blocks.append(block)

    # ── Overflow block (slot 15) ──────────────────────────────────────
    if overflow_entries:
        first = overflow_entries[0]
        first_base = baseline[first.owner]
        parts = [first_base.body]
        for oe in overflow_entries[1:]:
            ob = baseline[oe.owner]
            parts.append(ob.preamble)
            parts.append(ob.body)
        overflow_body = b"".join(parts)
        blocks.append(TrackBlock(
            index=15,
            preamble=first_base.preamble,
            body=overflow_body,
        ))
    else:
        # Slot 15 is the last normal entry
        pass  # already appended above

    assert len(blocks) == 16

    # ── Apply preamble rules ──────────────────────────────────────────
    # Rebuild the entry list for all 16 slots (normal + overflow stand-in)
    all_entries = list(normal_entries)
    if overflow_entries:
        all_entries.append(overflow_entries[0])  # overflow block's identity

    _apply_preamble_rules(blocks, all_entries, baseline)

    if _is_105b_mode(track_patterns):
        _apply_105b_aux_patch(blocks)

    # ── Update pre-track ──────────────────────────────────────────────
    new_pre_track = _build_pre_track(
        project.pre_track,
        track_patterns,
        descriptor_strategy=descriptor_strategy,
    )

    return XYProject(pre_track=new_pre_track, tracks=blocks)


def _build_single_block(
    baseline: List[TrackBlock],
    entry: _BlockEntry,
    slot_idx: int,
    track_patterns: Dict[int, List[Optional[List[Note]]]],
) -> TrackBlock:
    """Build one TrackBlock for a given block plan entry."""
    base_block = baseline[entry.owner]
    base_body = base_block.body
    base_preamble = base_block.preamble
    ti_1 = entry.owner + 1
    num_patterns = len(track_patterns.get(ti_1, [None]))

    if not entry.is_leader and not entry.is_clone:
        # Regular track — pass through unchanged
        return TrackBlock(index=slot_idx, preamble=base_preamble, body=base_body)

    if entry.is_leader:
        # Leader: blank leaders are baseline-minus-1.
        # Leaders with notes use the full body before activation, then drop the
        # final byte after insertion (matches unnamed 103 Track 1).
        if entry.notes:
            # Non-T1 leaders with notes must follow the same full-body
            # activation path we observed in 105b.  Using the trimmed
            # pre-activation body shifts the appended event by one byte and
            # produces files that crash on device with `num_patterns > 0`.
            body = base_body
        else:
            body = base_body[:-1]

        if entry.notes:
            # Activate and append event
            body = bytes(_activate_body(body))
            etype = event_type_for_track(ti_1)
            event_blob = build_event(entry.notes, event_type=etype)

            if base_block.engine_id in _TAIL_ENGINES and len(body) >= _TAIL_SIZE:
                buf = bytearray(body)
                insert_pos = len(buf) - _TAIL_SIZE
                buf[insert_pos] &= ~_TAIL_MARKER_BIT
                buf[insert_pos:insert_pos] = event_blob
                body = bytes(buf)
            else:
                body = body + event_blob

            if entry.owner == 0:  # Track 1 multi-pattern blob rewrite
                body = _patch_t1_multi_pattern_body(body)
                # Firmware leaves leaders one byte shorter at the tail.
                body = body[:-1]
            else:
                # Non-T1 leaders with notes are also one byte shorter.
                body = body[:-1]

        # Preamble: T1 gets byte[0] = 0xB5; others keep original.
        # byte[1] = pattern count.
        preamble_buf = bytearray(base_preamble)
        if entry.owner == 0:  # T1
            preamble_buf[0] = 0xB5
        preamble_buf[1] = num_patterns

        if entry.notes:
            bars = _bars_for_notes(entry.notes)
            preamble_buf[2] = bars * 16

        return TrackBlock(index=slot_idx, preamble=bytes(preamble_buf), body=body)

    # Clone block
    if entry.notes:
        # Activated clone: activate full baseline body, append event
        body = bytes(_activate_body(base_body))
        etype = event_type_for_track(ti_1)
        event_blob = build_event(entry.notes, event_type=etype)

        if base_block.engine_id in _TAIL_ENGINES and len(body) >= _TAIL_SIZE:
            buf = bytearray(body)
            insert_pos = len(buf) - _TAIL_SIZE
            buf[insert_pos] &= ~_TAIL_MARKER_BIT
            buf[insert_pos:insert_pos] = event_blob
            body = bytes(buf)
        else:
            body = body + event_blob

        if entry.owner == 0:  # Track 1 multi-pattern blob rewrite
            body = _patch_t1_multi_pattern_body(body)
    else:
        # Blank clone
        if entry.is_last_in_set:
            body = base_body       # full baseline body
        else:
            body = base_body[:-1]  # trimmed like leader

    # Clone preamble: byte[0] = 0x00, byte[1] = placeholder (set in preamble pass)
    preamble_buf = bytearray(base_preamble)
    preamble_buf[0] = 0x00
    preamble_buf[1] = 0x00  # will be set by _apply_preamble_rules

    if entry.notes:
        bars = _bars_for_notes(entry.notes)
        preamble_buf[2] = bars * 16

    return TrackBlock(index=slot_idx, preamble=bytes(preamble_buf), body=body)


def _apply_preamble_rules(
    blocks: List[TrackBlock],
    entries: List[_BlockEntry],
    baseline: List[TrackBlock],
) -> None:
    """Mutate block preambles in-place for the 0x64 and clone byte[1] rules.

    Rules (verified 9/9 across all multi-pattern corpus files):
      - Clone byte[1] = 0x64 if predecessor is type 0x07
      - Clone byte[1] = baseline byte[0] of next original track otherwise
      - Non-clone byte[0] = 0x64 if predecessor is type 0x07
      - Exception: T5 (0-based idx 4) is exempt from the 0x64 rule
    """
    _PREAMBLE_EXEMPT = {4}  # T5

    for i in range(1, 16):
        prev_activated = blocks[i - 1].type_byte == 0x07
        entry = entries[i]

        preamble_buf = bytearray(blocks[i].preamble)

        if entry.is_clone:
            if prev_activated:
                preamble_buf[1] = 0x64
            else:
                # baseline byte[0] of the next original track after clone's owner
                next_ti = entry.owner + 1
                if next_ti < 16:
                    preamble_buf[1] = baseline[next_ti].preamble[0]
                else:
                    preamble_buf[1] = 0x00
        else:
            # Regular or leader block
            if prev_activated and entry.owner not in _PREAMBLE_EXEMPT:
                preamble_buf[0] = 0x64

        blocks[i] = TrackBlock(
            index=blocks[i].index,
            preamble=bytes(preamble_buf),
            body=blocks[i].body,
        )


def _replace_all(data: bytes, old: bytes, new: bytes) -> bytes:
    out = data
    while True:
        idx = out.find(old)
        if idx == -1:
            return out
        out = out[:idx] + new + out[idx + len(old):]


def _apply_105b_aux_patch(blocks: List[TrackBlock]) -> None:
    """Mutate blocks 11-16 to match the 105b mid-body aux rewrite."""
    for idx in range(10, 16):  # 0-based blocks 11..16
        body = blocks[idx].body
        body = _replace_all(body, _AUX_PATCH_OLD_A, _AUX_PATCH_NEW_A)
        body = _replace_all(body, _AUX_PATCH_OLD_B, _AUX_PATCH_NEW_B)
        blocks[idx] = TrackBlock(
            index=blocks[idx].index,
            preamble=blocks[idx].preamble,
            body=body,
        )
