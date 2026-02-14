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
from typing import Dict, List, Optional, Sequence

from .container import TrackBlock, XYProject
from .note_events import Note, build_event, event_type_for_track
from .plocks import (
    list_standard_nonempty_values,
    rewrite_standard_nonempty_values,
    rewrite_standard_values_for_param_groups,
)
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

# Standard 5-byte p-lock writes become unsafe below 256 (device crash path).
MIN_SAFE_STANDARD_PLOCK_VALUE = 256
MAX_SAFE_PLOCK_VALUE = 32767

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


def _validate_track_index(track_index: int) -> int:
    if track_index < 1 or track_index > 16:
        raise ValueError(f"track_index must be 1-16, got {track_index}")
    return track_index - 1


def _validate_plock_value_range(
    values: Sequence[int],
    *,
    where: str,
    min_value: int,
    max_value: int,
) -> None:
    if min_value < 0 or max_value > 0xFFFF or min_value > max_value:
        raise ValueError(
            f"invalid p-lock bounds [{min_value}, {max_value}]; expected 0 <= min <= max <= 65535"
        )
    for idx, value in enumerate(values):
        if not isinstance(value, int) or isinstance(value, bool):
            raise ValueError(f"{where}[{idx}] must be an integer")
        if value < min_value or value > max_value:
            raise ValueError(
                f"{where}[{idx}] must be in [{min_value}, {max_value}], got {value}"
            )


def transplant_track(
    project: XYProject,
    donor: XYProject,
    track_index: int,
    *,
    copy_preamble: bool = True,
) -> XYProject:
    """Copy one track body from a donor project into a target project.

    This is the safe building block used by p-lock demo generation:
    transplant a known-good donor topology, then rewrite only value bytes.
    """
    idx = _validate_track_index(track_index)
    tracks = list(project.tracks)
    donor_block = donor.tracks[idx]
    target_block = tracks[idx]
    preamble = donor_block.preamble if copy_preamble else target_block.preamble
    tracks[idx] = TrackBlock(
        index=target_block.index,
        preamble=preamble,
        body=donor_block.body,
    )
    return XYProject(pre_track=project.pre_track, tracks=tracks)


def rewrite_track_standard_plock_values(
    project: XYProject,
    track_index: int,
    values: Sequence[int],
    *,
    require_exact_count: bool = True,
    min_value: int = MIN_SAFE_STANDARD_PLOCK_VALUE,
    max_value: int = MAX_SAFE_PLOCK_VALUE,
) -> XYProject:
    """Rewrite standard 5-byte p-lock values in encounter order on one track.

    Parameters
    ----------
    project : XYProject
        Source project (not mutated).
    track_index : int
        1-based track index (1-16).
    values : sequence[int]
        Replacement u16 values in non-empty-slot encounter order.
    require_exact_count : bool
        If True, `len(values)` must match the number of non-empty standard
        p-lock entries on the track.
    min_value, max_value : int
        Safe write bounds. Defaults enforce known-safe floor >= 256.
    """
    idx = _validate_track_index(track_index)
    new_values = list(values)
    if not new_values:
        raise ValueError("need at least one p-lock value")
    _validate_plock_value_range(
        new_values,
        where="values",
        min_value=min_value,
        max_value=max_value,
    )

    target = project.tracks[idx]
    try:
        existing = list_standard_nonempty_values(target.body)
    except ValueError as exc:
        raise ValueError(
            f"track {track_index} does not use standard 5-byte p-lock entries"
        ) from exc

    if not existing:
        raise ValueError(
            f"track {track_index} has no standard p-lock entries to rewrite"
        )

    if require_exact_count and len(new_values) != len(existing):
        raise ValueError(
            f"track {track_index} has {len(existing)} non-empty standard p-lock entries; "
            f"got {len(new_values)} values"
        )

    new_body = rewrite_standard_nonempty_values(target.body, new_values)
    tracks = list(project.tracks)
    tracks[idx] = TrackBlock(
        index=target.index,
        preamble=target.preamble,
        body=new_body,
    )
    return XYProject(pre_track=project.pre_track, tracks=tracks)


def rewrite_track_standard_plock_groups(
    project: XYProject,
    track_index: int,
    groups: Sequence[tuple[set[int], Sequence[int]]],
    *,
    require_full_consumption: bool = True,
    min_value: int = MIN_SAFE_STANDARD_PLOCK_VALUE,
    max_value: int = MAX_SAFE_PLOCK_VALUE,
) -> tuple[XYProject, list[int]]:
    """Rewrite standard p-lock values for multiple param-id groups.

    `groups` entries are `(param_id_set, values)`. Values are consumed in
    encounter order for slots whose param_id is in that group's id set.
    """
    idx = _validate_track_index(track_index)
    if not groups:
        raise ValueError("need at least one p-lock group")

    normalized: list[tuple[set[int], list[int]]] = []
    seen_ids: set[int] = set()
    for gidx, (param_ids, values_seq) in enumerate(groups):
        where = f"groups[{gidx}]"
        if not param_ids:
            raise ValueError(f"{where}.param_ids must not be empty")
        norm_ids: set[int] = set()
        for pid in param_ids:
            if not isinstance(pid, int) or isinstance(pid, bool):
                raise ValueError(f"{where}.param_ids must contain integers")
            if pid < 0 or pid > 0xFF:
                raise ValueError(f"{where}.param_ids contains out-of-range value {pid}")
            norm_ids.add(pid)
        overlap = seen_ids.intersection(norm_ids)
        if overlap:
            overlap_hex = ", ".join(f"0x{pid:02X}" for pid in sorted(overlap))
            raise ValueError(f"{where}.param_ids overlap previous groups: {overlap_hex}")
        seen_ids.update(norm_ids)

        values = list(values_seq)
        if not values:
            raise ValueError(f"{where}.values must not be empty")
        _validate_plock_value_range(
            values,
            where=f"{where}.values",
            min_value=min_value,
            max_value=max_value,
        )
        normalized.append((norm_ids, values))

    target = project.tracks[idx]
    try:
        new_body, counts = rewrite_standard_values_for_param_groups(
            target.body,
            normalized,
        )
    except ValueError as exc:
        raise ValueError(
            f"track {track_index} does not use standard 5-byte p-lock entries"
        ) from exc

    if require_full_consumption:
        for gidx, (_ids, vals) in enumerate(normalized):
            if counts[gidx] != len(vals):
                raise ValueError(
                    f"groups[{gidx}] consumed {counts[gidx]} of {len(vals)} values"
                )

    tracks = list(project.tracks)
    tracks[idx] = TrackBlock(
        index=target.index,
        preamble=target.preamble,
        body=new_body,
    )
    return XYProject(pre_track=project.pre_track, tracks=tracks), counts


def add_step_components(
    project: XYProject,
    track_index: int,
    components: List[StepComponent],
) -> XYProject:
    """Return a new XYProject with step components added to the given track.

    The component data is inserted into the track body's slot table, growing
    the body by the component data size.  The track is activated (type 0x05
    to 0x07) if not already active.

    Supports any step 1-16.  The bar is split into two halves (steps 1-8
    and 9-16), each with one slot.  At most one component per half is
    allowed per call.  To add components on both halves, pass both in a
    single call — do NOT call this function twice on the same track (the
    second call would use stale slot offsets).

    Parameters
    ----------
    project : XYProject
        The source project (not mutated).
    track_index : int
        1-based track number (1-16).
    components : list[StepComponent]
        Components to insert (max 2 — one per half of the bar).
    """
    _validate_track_index(track_index)
    if not components:
        raise ValueError("need at least one component")

    # Validate: at most one component per step-slot (step 1 and step 9)
    steps_used: set[int] = set()
    for comp in components:
        if comp.step in steps_used:
            raise ValueError(
                f"duplicate component on step {comp.step}"
            )
        steps_used.add(comp.step)

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
        _validate_track_index(track_index)
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
#
# Scheme A (T3+-only, v56=0, v57=0): gap/maxslot pairs terminated by 00 00.
# Scheme B (T1/T2 involved): per-topology lookup, partially generalised.
# See docs/format/descriptor_encoding.md for the full encoding reference.
_STRICT_DESCRIPTORS = {
    # frozenset of 0-based track indices -> descriptor bytes (inserted at 0x58)
    # ── T1/T2 involved (Scheme B) ──
    frozenset({0}):       b"\x00\x1D\x01\x00\x00",                          # T1 only
    frozenset({0, 1}):    b"\x00\x00\x00\x1C\x01\x00\x00",                  # T1+T2
    frozenset({0, 2}):    b"\x01\x00\x00\x1B\x01\x00\x00",                  # T1+T3
    frozenset({0, 3}):    b"\x00\x00\x01\x00\x00\x1A\x01\x00\x00",          # T1+T4
    frozenset({0, 1, 2}): b"\x01\x00\x00\x1B\x01\x00\x00",                  # T1+T2+T3 (m06)
    # ── T3+-only (Scheme A) — computed by _scheme_a_descriptor() ──
    # These are also in the lookup for fast-path / test validation.
    frozenset({2}):       b"\x00\x01\x00\x00\x1B\x01\x00\x00",              # T3 only
    frozenset({3}):       b"\x01\x01\x00\x00\x1A\x01\x00\x00",              # T4 only
    frozenset({6}):       b"\x04\x01\x00\x00\x17\x01\x00\x00",              # T7 only
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


def _scheme_a_descriptor(
    track_set: frozenset[int],
    pattern_counts: Dict[int, int] | None = None,
) -> bytes:
    """Build a Scheme A descriptor for T3+-only multi-pattern sets.

    Scheme A (v56=0, v57=0) uses gap/maxslot pairs:
      body = [gap₁ slot₁] [gap₂ slot₂] … [00 00] [token] [01] [00 00]

    Where gap = track_1based - 3, slot = pattern_count - 1.
    See docs/format/descriptor_encoding.md for full reference.

    Parameters
    ----------
    track_set : frozenset[int]
        0-based track indices, all must be >= 2 (T3+).
    pattern_counts : dict or None
        Optional {0-based index: pattern_count}.  If None, assumes 2 patterns
        per track (maxslot=1).
    """
    if any(ti < 2 for ti in track_set):
        raise ValueError(
            "Scheme A requires T3+ tracks only (0-based index >= 2); "
            f"got indices {sorted(track_set)}"
        )

    out = bytearray()
    for ti in sorted(track_set):
        track_1based = ti + 1
        gap = track_1based - 3
        if pattern_counts and ti in pattern_counts:
            maxslot = pattern_counts[ti] - 1
        else:
            maxslot = 1  # default: 2 patterns
        out.extend((gap & 0xFF, maxslot & 0xFF))

    # Terminator pair, then token + marker + sentinel
    last_track_1based = max(ti + 1 for ti in track_set)
    token = 0x1E - last_track_1based
    out.extend((0x00, 0x00, token & 0xFF, 0x01, 0x00, 0x00))
    return bytes(out)


def _heuristic_descriptor(track_set: frozenset[int]) -> bytes:
    """Build an experimental descriptor for multi-pattern track sets.

    DEPRECATED — this heuristic generates per-track token pairs which do NOT
    match the device's compact range format.  It works by coincidence for
    T1-only and T1+one-extra-track, but fails for wider sets.

    Retained for backwards compatibility; prefer 'strict' strategy.
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
    pattern_counts: Dict[int, int] | None = None,
) -> bytes:
    """Return descriptor bytes for the given multi-pattern track set.

    Parameters
    ----------
    track_set : frozenset[int]
        0-based track indices that have multiple patterns.
    strategy : str
        'strict' = lookup + Scheme A encoder for T3+-only sets.
        'heuristic_v1' = deprecated per-token heuristic.
    pattern_counts : dict or None
        Optional {0-based index: pattern_count} for Scheme A.
    """
    if strategy == "strict":
        # Fast path: exact lookup for device-verified topologies
        if track_set in _STRICT_DESCRIPTORS:
            return _STRICT_DESCRIPTORS[track_set]

        # Scheme A encoder: any T3+-only set (fully cracked encoding)
        if all(ti >= 2 for ti in track_set):
            return _scheme_a_descriptor(track_set, pattern_counts)

        # Scheme B: no general encoder yet, must be in lookup
        supported = ", ".join(
            "{" + ",".join(f"T{i+1}" for i in sorted(s)) + "}"
            for s in sorted(_STRICT_DESCRIPTORS, key=lambda s: sorted(s))
        )
        raise ValueError(
            f"unsupported multi-pattern track set "
            f"{{{','.join(f'T{i+1}' for i in sorted(track_set))}}}; "
            f"supported in strict mode: {supported} "
            f"(plus any T3+-only combination via Scheme A encoder)"
        )

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

    Sets v56 (T1 max_slot) and v57 (T2 max_slot) as independent bytes,
    then inserts the track descriptor body at 0x58.
    """
    # v56 = T1 max_slot, v57 = T2 max_slot (independent per-track bytes)
    t1_count = len(track_patterns.get(1, [None]))
    t2_count = len(track_patterns.get(2, [None]))
    v56 = t1_count - 1  # 0 if T1 has 1 pattern
    v57 = t2_count - 1  # 0 if T2 has 1 pattern

    if _is_105b_mode(track_patterns):
        # Device-authored 105b switches back to the 5-byte T1-style descriptor
        # when T3 leader pattern carries note data.
        descriptor = _T1_ONLY_DESCRIPTOR
    else:
        multi_set = frozenset(ti - 1 for ti in track_patterns)
        # Build pattern_counts for Scheme A encoder
        pcounts = {ti - 1: len(pats) for ti, pats in track_patterns.items()}
        descriptor = _descriptor_for_track_set(
            multi_set,
            strategy=descriptor_strategy,
            pattern_counts=pcounts,
        )

    buf = bytearray(original)
    # Set v56 and v57 as independent bytes
    buf[0x56] = v56 & 0xFF
    buf[0x57] = v57 & 0xFF
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
        - "strict" (recommended): device-verified lookup for T1, T1+T2,
          T1+T3, T1+T4, T3, T4, T7; plus Scheme A encoder for any
          T3+-only combination.
        - "heuristic_v1": deprecated per-token heuristic (do not use).

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
