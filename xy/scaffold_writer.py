from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Dict, List, Optional

from .container import TrackBlock, XYProject
from .note_events import Note, build_event, event_type_for_track


TRACK_SIG_HEAD = b"\x00\x00\x01"
TRACK_SIG_TAIL = b"\xff\x00\xfc\x00"
TAIL_ENGINES = {0x07}  # EPiano/Pluck insert-before-tail behavior
TAIL_SIZE = 47
TAIL_MARKER_BIT = 0x20


@dataclass(frozen=True)
class LogicalEntry:
    track: int
    pattern: int
    pattern_count: int
    preamble: bytes
    body: bytes


def _find_track_sigs(buf: bytes) -> List[int]:
    offsets: List[int] = []
    i = 0
    while i < len(buf) - 8:
        j = buf.find(TRACK_SIG_HEAD, i)
        if j == -1:
            break
        if j + 8 <= len(buf) and buf[j + 4 : j + 8] == TRACK_SIG_TAIL:
            offsets.append(j)
            i = j + 4
        else:
            i = j + 1
    return offsets


def _split_overflow(track16: TrackBlock) -> List[tuple[bytes, bytes]]:
    body = track16.body
    sigs = _find_track_sigs(body)
    if not sigs:
        raise ValueError("no embedded track signatures in overflow block")

    entries: List[tuple[bytes, bytes]] = []
    for idx, sig_off in enumerate(sigs):
        preamble = track16.preamble if idx == 0 else body[sig_off - 4 : sig_off]
        end = sigs[idx + 1] - 4 if idx + 1 < len(sigs) else len(body)
        entries.append((preamble, body[sig_off:end]))
    return entries


def extract_logical_entries(project: XYProject) -> List[LogicalEntry]:
    raw: List[tuple[bytes, bytes]] = [(t.preamble, t.body) for t in project.tracks[:15]]
    raw.extend(_split_overflow(project.tracks[15]))

    entries: List[LogicalEntry] = []
    i = 0
    track = 1
    while track <= 16 and i < len(raw):
        pattern_count = raw[i][0][1] or 1
        for pattern in range(1, pattern_count + 1):
            if i >= len(raw):
                raise ValueError("ran out of logical entries while mapping tracks")
            preamble, body = raw[i]
            entries.append(
                LogicalEntry(
                    track=track,
                    pattern=pattern,
                    pattern_count=pattern_count,
                    preamble=preamble,
                    body=body,
                )
            )
            i += 1
        track += 1

    if track != 17 or i != len(raw):
        raise ValueError(
            f"logical mapping mismatch: mapped tracks up to {track - 1}, consumed {i}/{len(raw)} entries"
        )
    return entries


def _pattern_count_by_track(entries: List[LogicalEntry]) -> Dict[int, int]:
    counts: Dict[int, int] = {}
    for entry in entries:
        current = counts.get(entry.track)
        if current is None:
            counts[entry.track] = entry.pattern_count
            continue
        if current != entry.pattern_count:
            raise ValueError(
                f"inconsistent pattern count for track {entry.track}: "
                f"saw {current} and {entry.pattern_count}"
            )
    return counts


def _activate_body(body: bytes) -> bytearray:
    buf = bytearray(body)
    type_byte = buf[9]
    if type_byte == 0x05:
        buf[9] = 0x07
        del buf[10:12]
    elif type_byte != 0x07:
        raise ValueError(f"unexpected type byte 0x{type_byte:02X}")
    return buf


def _engine_id(body: bytes) -> int:
    type_byte = body[9]
    if type_byte == 0x05:
        return body[0x0D]
    return body[0x0B]


def _bars_for_notes(notes: List[Note]) -> int:
    return max(1, math.ceil(max(n.step for n in notes) / 16))


def _inject_notes_from_full(
    *,
    track: int,
    target_preamble: bytes,
    full_body: bytes,
    notes: List[Note],
    trim_tail_byte: bool,
) -> tuple[bytes, bytes]:
    body07 = bytes(_activate_body(full_body))
    event_blob = build_event(notes, event_type=event_type_for_track(track))

    engine = _engine_id(body07)
    if engine in TAIL_ENGINES and len(body07) >= TAIL_SIZE:
        tmp = bytearray(body07)
        insert_pos = len(tmp) - TAIL_SIZE
        tmp[insert_pos] &= ~TAIL_MARKER_BIT
        tmp[insert_pos:insert_pos] = event_blob
        new_body = bytes(tmp)
    else:
        new_body = body07 + event_blob

    if trim_tail_byte:
        new_body = new_body[:-1]

    pre = bytearray(target_preamble)
    pre[2] = (_bars_for_notes(notes) * 16) & 0xFF
    return bytes(pre), new_body


def _apply_preamble_chain(entries: List[LogicalEntry], leader_pre0: Dict[int, int]) -> None:
    exempt = {5}
    for i in range(1, len(entries)):
        prev_activated = entries[i - 1].body[9] == 0x07
        cur = entries[i]
        pre = bytearray(cur.preamble)
        is_clone = cur.pattern_count > 1 and cur.pattern > 1

        if is_clone:
            pre[0] = 0x00
            if prev_activated:
                if pre[1] & 0x80:
                    pre[1] = 0x64
            else:
                pre[1] = leader_pre0.get(cur.track + 1, 0x00)
        else:
            if prev_activated and cur.track not in exempt:
                pre[0] = 0x64

        entries[i] = LogicalEntry(
            track=cur.track,
            pattern=cur.pattern,
            pattern_count=cur.pattern_count,
            preamble=bytes(pre),
            body=cur.body,
        )


def _rebuild_project(template: XYProject, entries: List[LogicalEntry]) -> XYProject:
    if len(entries) < 16:
        raise ValueError(f"need >=16 logical entries, got {len(entries)}")

    tracks: List[TrackBlock] = []
    for i in range(15):
        entry = entries[i]
        tracks.append(TrackBlock(index=i, preamble=entry.preamble, body=entry.body))

    overflow = entries[15:]
    first = overflow[0]
    parts = [first.body]
    for entry in overflow[1:]:
        parts.append(entry.preamble)
        parts.append(entry.body)
    tracks.append(TrackBlock(index=15, preamble=first.preamble, body=b"".join(parts)))
    return XYProject(pre_track=template.pre_track, tracks=tracks)


def apply_notes_to_matching_scaffold(
    template: XYProject,
    track_patterns: Dict[int, List[Optional[List[Note]]]],
) -> XYProject | None:
    """Apply notes by preserving the template's existing multi-pattern topology.

    Returns None when the template topology does not match `track_patterns`.
    """
    entries = extract_logical_entries(template)
    counts = _pattern_count_by_track(entries)
    template_multi = {track: count for track, count in counts.items() if count > 1}
    if not template_multi:
        return None

    if set(track_patterns) != set(template_multi):
        return None

    for track, patterns in track_patterns.items():
        if len(patterns) != template_multi[track]:
            return None

    index = {(entry.track, entry.pattern): i for i, entry in enumerate(entries)}
    donor_full_body_by_track: Dict[int, bytes] = {}
    for track, count in template_multi.items():
        slot = index.get((track, count))
        if slot is None:
            return None
        donor_full_body_by_track[track] = entries[slot].body

    leader_pre0: Dict[int, int] = {
        entry.track: entry.preamble[0] for entry in entries if entry.pattern == 1
    }

    for track, patterns in sorted(track_patterns.items()):
        for pattern_idx, notes in enumerate(patterns, start=1):
            if not notes:
                continue
            slot = index.get((track, pattern_idx))
            if slot is None:
                return None
            target = entries[slot]
            preamble, body = _inject_notes_from_full(
                track=track,
                target_preamble=target.preamble,
                full_body=donor_full_body_by_track[track],
                notes=notes,
                trim_tail_byte=(pattern_idx < target.pattern_count),
            )
            entries[slot] = LogicalEntry(
                track=target.track,
                pattern=target.pattern,
                pattern_count=target.pattern_count,
                preamble=preamble,
                body=body,
            )

    _apply_preamble_chain(entries, leader_pre0)
    return _rebuild_project(template, entries)
