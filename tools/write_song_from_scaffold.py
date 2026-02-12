#!/usr/bin/env python3
"""Write an A/B song into a known-good multi-pattern scaffold.

This writer intentionally avoids descriptor synthesis. It preserves the
template pre-track bytes and block-rotation topology, then injects note
events into selected (track, pattern) logical entries.
"""

from __future__ import annotations

import argparse
import math
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Tuple

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import TrackBlock, XYProject
from xy.note_events import Note, build_event, event_type_for_track


TRACK_SIG_HEAD = b"\x00\x00\x01"
TRACK_SIG_TAIL = b"\xff\x00\xfc\x00"
TAIL_ENGINES = {0x07}  # EPiano/Pluck insert-before-tail behavior
TAIL_SIZE = 47
TAIL_MARKER_BIT = 0x20


@dataclass
class LogicalEntry:
    track: int          # 1-based logical track index
    pattern: int        # 1-based pattern index
    pattern_count: int  # total patterns for this track in this topology
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


def _split_overflow(track16: TrackBlock) -> List[Tuple[bytes, bytes]]:
    body = track16.body
    sigs = _find_track_sigs(body)
    if not sigs:
        raise ValueError("no embedded track signatures in overflow block")

    entries: List[Tuple[bytes, bytes]] = []
    for idx, sig_off in enumerate(sigs):
        preamble = track16.preamble if idx == 0 else body[sig_off - 4 : sig_off]
        end = sigs[idx + 1] - 4 if idx + 1 < len(sigs) else len(body)
        entries.append((preamble, body[sig_off:end]))
    return entries


def _extract_logical_entries(project: XYProject) -> List[LogicalEntry]:
    raw: List[Tuple[bytes, bytes]] = [
        (t.preamble, t.body) for t in project.tracks[:15]
    ]
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


def _activate_body(body: bytes) -> bytearray:
    buf = bytearray(body)
    type_byte = buf[9]
    if type_byte == 0x05:
        buf[9] = 0x07
        del buf[10:12]  # remove 0x08 0x00 pad
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
) -> LogicalEntry:
    """Inject notes using a track's full-body donor, then optional trim.

    Device-authored multi-pattern captures show non-last patterns are stored in
    a one-byte-trimmed body form. To reproduce those exactly, write events into
    the full body first, then trim one byte for non-last patterns.
    """
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
    return LogicalEntry(
        track=track,
        pattern=0,          # caller overwrites these bookkeeping fields
        pattern_count=0,    # caller overwrites these bookkeeping fields
        preamble=bytes(pre),
        body=new_body,
    )


def _apply_preamble_chain(entries: List[LogicalEntry], leader_pre0: Dict[int, int]) -> None:
    # Track 5 exemption observed in corpus.
    exempt = {5}
    for i in range(1, len(entries)):
        prev_activated = entries[i - 1].body[9] == 0x07
        cur = entries[i]
        pre = bytearray(cur.preamble)
        is_clone = cur.pattern_count > 1 and cur.pattern > 1

        if is_clone:
            pre[0] = 0x00
            if prev_activated:
                # Clone byte1 only folds to 0x64 for the high-bit family
                # (0x8A/0x86/0x85/0x83 observed).  Track-4 clone chains carry
                # 0x2E and must keep it stable even when the previous pattern
                # is active; forcing 0x64 reproduces known crashers.
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
        e = entries[i]
        tracks.append(TrackBlock(index=i, preamble=e.preamble, body=e.body))

    overflow = entries[15:]
    first = overflow[0]
    parts = [first.body]
    for e in overflow[1:]:
        parts.append(e.preamble)
        parts.append(e.body)
    tracks.append(TrackBlock(index=15, preamble=first.preamble, body=b"".join(parts)))
    return XYProject(pre_track=template.pre_track, tracks=tracks)


def _song_patterns() -> Dict[Tuple[int, int], List[Note]]:
    # Track 1 (drums except hats): A groove, B fill.
    t1_a = [
        Note(step=1, note=60, velocity=118),
        Note(step=5, note=62, velocity=110),
        Note(step=9, note=60, velocity=118),
        Note(step=12, note=64, velocity=98),
        Note(step=13, note=62, velocity=112),
    ]
    t1_b = [
        Note(step=1, note=60, velocity=118),
        Note(step=9, note=60, velocity=118),
        Note(step=13, note=67, velocity=108),
        Note(step=14, note=67, velocity=106),
        Note(step=15, note=64, velocity=104),
        Note(step=16, note=62, velocity=120),
    ]

    # Track 2 (hats): A steady, B with end-bar variation.
    t2_a = [Note(step=s, note=66, velocity=90 + ((i % 3) * 4))
            for i, s in enumerate([1, 3, 5, 7, 9, 11, 13, 15])]
    t2_b = [
        Note(step=1, note=66, velocity=92),
        Note(step=3, note=66, velocity=90),
        Note(step=5, note=66, velocity=94),
        Note(step=7, note=66, velocity=92),
        Note(step=9, note=66, velocity=94),
        Note(step=11, note=66, velocity=92),
        Note(step=12, note=68, velocity=98),
        Note(step=13, note=66, velocity=94),
        Note(step=14, note=66, velocity=92),
        Note(step=15, note=66, velocity=96),
        Note(step=16, note=66, velocity=104),
    ]

    # Track 3 (bass): A/B variants.
    t3_a = [
        Note(step=1, note=36, velocity=104, gate_ticks=720),
        Note(step=5, note=36, velocity=102, gate_ticks=720),
        Note(step=9, note=43, velocity=106, gate_ticks=720),
        Note(step=13, note=41, velocity=104, gate_ticks=720),
    ]
    t3_b = [
        Note(step=1, note=36, velocity=104, gate_ticks=720),
        Note(step=4, note=38, velocity=100, gate_ticks=480),
        Note(step=8, note=41, velocity=104, gate_ticks=720),
        Note(step=11, note=43, velocity=108, gate_ticks=720),
        Note(step=14, note=34, velocity=102, gate_ticks=960),
    ]

    # Track 4 (melody): A phrase + B variation.
    t4_a = [
        Note(step=1, note=64, velocity=102),
        Note(step=4, note=67, velocity=100),
        Note(step=7, note=69, velocity=104),
        Note(step=10, note=67, velocity=100),
        Note(step=13, note=64, velocity=102),
        Note(step=15, note=62, velocity=98),
    ]
    t4_b = [
        Note(step=1, note=64, velocity=102),
        Note(step=3, note=67, velocity=100),
        Note(step=6, note=71, velocity=106),
        Note(step=9, note=69, velocity=104),
        Note(step=12, note=67, velocity=100),
        Note(step=14, note=66, velocity=98),
        Note(step=16, note=64, velocity=102),
    ]

    # Track 7 (chords): A and B (B with added lift near end).
    t7_a = [
        Note(step=1, note=57, velocity=92, gate_ticks=1440),
        Note(step=1, note=60, velocity=90, gate_ticks=1440),
        Note(step=1, note=64, velocity=88, gate_ticks=1440),
        Note(step=5, note=53, velocity=92, gate_ticks=1440),
        Note(step=5, note=57, velocity=90, gate_ticks=1440),
        Note(step=5, note=60, velocity=88, gate_ticks=1440),
        Note(step=9, note=50, velocity=92, gate_ticks=1440),
        Note(step=9, note=53, velocity=90, gate_ticks=1440),
        Note(step=9, note=57, velocity=88, gate_ticks=1440),
        Note(step=13, note=52, velocity=92, gate_ticks=1440),
        Note(step=13, note=56, velocity=90, gate_ticks=1440),
        Note(step=13, note=59, velocity=88, gate_ticks=1440),
    ]
    t7_b = [
        Note(step=1, note=57, velocity=92, gate_ticks=960),
        Note(step=1, note=60, velocity=90, gate_ticks=960),
        Note(step=1, note=64, velocity=88, gate_ticks=960),
        Note(step=5, note=53, velocity=92, gate_ticks=960),
        Note(step=5, note=57, velocity=90, gate_ticks=960),
        Note(step=5, note=60, velocity=88, gate_ticks=960),
        Note(step=5, note=64, velocity=86, gate_ticks=960),
        Note(step=9, note=50, velocity=92, gate_ticks=960),
        Note(step=9, note=53, velocity=90, gate_ticks=960),
        Note(step=9, note=57, velocity=88, gate_ticks=960),
        Note(step=13, note=52, velocity=92, gate_ticks=960),
        Note(step=13, note=56, velocity=90, gate_ticks=960),
        Note(step=13, note=59, velocity=88, gate_ticks=960),
        Note(step=15, note=50, velocity=96, gate_ticks=960),
        Note(step=15, note=56, velocity=94, gate_ticks=960),
        Note(step=15, note=59, velocity=92, gate_ticks=960),
        Note(step=15, note=62, velocity=90, gate_ticks=960),
    ]

    return {
        (1, 1): t1_a,
        (1, 2): t1_b,
        (2, 1): t2_a,
        (2, 2): t2_b,
        (3, 1): t3_a,
        (3, 2): t3_b,
        (4, 1): t4_a,
        (4, 2): t4_b,
        (7, 1): t7_a,
        (7, 2): t7_b,
    }


def _song_patterns_safe_j07() -> Dict[Tuple[int, int], List[Note]]:
    """A/B song mapped onto the known-good j07 activation topology.

    Active pattern slots:
      T1: P1 + P9
      T2: P2 + P9
      T3: P1 + P9
      T4: P2 + P9
      T7: P1 + P9
    """
    # Track 1 drums (except hats): A groove, B fill.
    t1_a = [
        Note(step=1, note=60, velocity=118),
        Note(step=5, note=62, velocity=110),
        Note(step=9, note=60, velocity=118),
        Note(step=12, note=64, velocity=98),
        Note(step=13, note=62, velocity=112),
    ]
    t1_b = [
        Note(step=1, note=60, velocity=118),
        Note(step=9, note=60, velocity=118),
        Note(step=13, note=67, velocity=108),
        Note(step=14, note=67, velocity=106),
        Note(step=15, note=64, velocity=104),
        Note(step=16, note=62, velocity=120),
    ]

    # Track 2 hats: A/B variation.
    t2_a = [Note(step=s, note=66, velocity=90 + ((i % 3) * 4))
            for i, s in enumerate([1, 3, 5, 7, 9, 11, 13, 15])]
    t2_b = [
        Note(step=1, note=66, velocity=92),
        Note(step=3, note=66, velocity=90),
        Note(step=5, note=66, velocity=94),
        Note(step=7, note=66, velocity=92),
        Note(step=9, note=66, velocity=94),
        Note(step=11, note=66, velocity=92),
        Note(step=12, note=68, velocity=98),
        Note(step=13, note=66, velocity=94),
        Note(step=14, note=66, velocity=92),
        Note(step=15, note=66, velocity=96),
        Note(step=16, note=66, velocity=104),
    ]

    # Track 3 bass: A/B variants.
    t3_a = [
        Note(step=1, note=36, velocity=104, gate_ticks=720),
        Note(step=5, note=36, velocity=102, gate_ticks=720),
        Note(step=9, note=43, velocity=106, gate_ticks=720),
        Note(step=13, note=41, velocity=104, gate_ticks=720),
    ]
    t3_b = [
        Note(step=1, note=36, velocity=104, gate_ticks=720),
        Note(step=4, note=38, velocity=100, gate_ticks=480),
        Note(step=8, note=41, velocity=104, gate_ticks=720),
        Note(step=11, note=43, velocity=108, gate_ticks=720),
        Note(step=14, note=34, velocity=102, gate_ticks=960),
    ]

    # Track 4 melody: A/B variation.
    t4_a = [
        Note(step=1, note=64, velocity=102),
        Note(step=4, note=67, velocity=100),
        Note(step=7, note=69, velocity=104),
        Note(step=10, note=67, velocity=100),
        Note(step=13, note=64, velocity=102),
        Note(step=15, note=62, velocity=98),
    ]
    t4_b = [
        Note(step=1, note=64, velocity=102),
        Note(step=3, note=67, velocity=100),
        Note(step=6, note=71, velocity=106),
        Note(step=9, note=69, velocity=104),
        Note(step=12, note=67, velocity=100),
        Note(step=14, note=66, velocity=98),
        Note(step=16, note=64, velocity=102),
    ]

    # Track 7 chords: A/B variation.
    t7_a = [
        Note(step=1, note=57, velocity=92, gate_ticks=1440),
        Note(step=1, note=60, velocity=90, gate_ticks=1440),
        Note(step=1, note=64, velocity=88, gate_ticks=1440),
        Note(step=5, note=53, velocity=92, gate_ticks=1440),
        Note(step=5, note=57, velocity=90, gate_ticks=1440),
        Note(step=5, note=60, velocity=88, gate_ticks=1440),
        Note(step=9, note=50, velocity=92, gate_ticks=1440),
        Note(step=9, note=53, velocity=90, gate_ticks=1440),
        Note(step=9, note=57, velocity=88, gate_ticks=1440),
        Note(step=13, note=52, velocity=92, gate_ticks=1440),
        Note(step=13, note=56, velocity=90, gate_ticks=1440),
        Note(step=13, note=59, velocity=88, gate_ticks=1440),
    ]
    t7_b = [
        Note(step=1, note=57, velocity=92, gate_ticks=960),
        Note(step=1, note=60, velocity=90, gate_ticks=960),
        Note(step=1, note=64, velocity=88, gate_ticks=960),
        Note(step=5, note=53, velocity=92, gate_ticks=960),
        Note(step=5, note=57, velocity=90, gate_ticks=960),
        Note(step=5, note=60, velocity=88, gate_ticks=960),
        Note(step=5, note=64, velocity=86, gate_ticks=960),
        Note(step=9, note=50, velocity=92, gate_ticks=960),
        Note(step=9, note=53, velocity=90, gate_ticks=960),
        Note(step=9, note=57, velocity=88, gate_ticks=960),
        Note(step=13, note=52, velocity=92, gate_ticks=960),
        Note(step=13, note=56, velocity=90, gate_ticks=960),
        Note(step=13, note=59, velocity=88, gate_ticks=960),
        Note(step=15, note=50, velocity=96, gate_ticks=960),
        Note(step=15, note=56, velocity=94, gate_ticks=960),
        Note(step=15, note=59, velocity=92, gate_ticks=960),
        Note(step=15, note=62, velocity=90, gate_ticks=960),
    ]

    return {
        (1, 1): t1_a, (1, 9): t1_b,
        (2, 2): t2_a, (2, 9): t2_b,
        (3, 1): t3_a, (3, 9): t3_b,
        (4, 2): t4_a, (4, 9): t4_b,
        (7, 1): t7_a, (7, 9): t7_b,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "output",
        nargs="?",
        default="output/k01_song_ab_12347.xy",
        help="output .xy file path",
    )
    parser.add_argument(
        "--template",
        default="src/one-off-changes-from-default/j06_all16_p9_blank.xy",
        help="scaffold template path (default: j06_all16_p9_blank.xy)",
    )
    parser.add_argument(
        "--layout",
        choices=("safe_j07", "dense_p1p2"),
        default="safe_j07",
        help="song slot layout: safe_j07 keeps j07-proven activation topology",
    )
    args = parser.parse_args()

    template_path = Path(args.template)
    output_path = Path(args.output)

    template = XYProject.from_bytes(template_path.read_bytes())
    entries = _extract_logical_entries(template)

    index: Dict[Tuple[int, int], int] = {
        (e.track, e.pattern): i for i, e in enumerate(entries)
    }
    leader_pre0: Dict[int, int] = {
        e.track: e.preamble[0] for e in entries if e.pattern == 1
    }

    if args.layout == "safe_j07":
        targets = _song_patterns_safe_j07()
    else:
        targets = _song_patterns()
    for key in targets:
        if key not in index:
            raise ValueError(f"missing scaffold slot for track/pattern {key}")

    for (track, pattern), notes in targets.items():
        i = index[(track, pattern)]
        target = entries[i]
        donor = entries[index[(track, target.pattern_count)]]
        injected = _inject_notes_from_full(
            track=track,
            target_preamble=target.preamble,
            full_body=donor.body,
            notes=notes,
            trim_tail_byte=(pattern < target.pattern_count),
        )
        entries[i] = LogicalEntry(
            track=target.track,
            pattern=target.pattern,
            pattern_count=target.pattern_count,
            preamble=injected.preamble,
            body=injected.body,
        )

    _apply_preamble_chain(entries, leader_pre0)
    result = _rebuild_project(template, entries)
    raw = result.to_bytes()

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_bytes(raw)

    reparsed = XYProject.from_bytes(raw)
    if reparsed.to_bytes() != raw:
        raise RuntimeError("round-trip validation failed")

    print(f"Wrote {len(raw)} bytes to {output_path}")
    print(f"Template: {template_path}")
    print(f"Layout: {args.layout}")
    print("Song layout:")
    print("  T1 drums A/B (B=fill), T2 hats A/B, T3 bass A/B, T4 melody A/B, T7 chords A/B")
    for (track, pattern), notes in sorted(targets.items()):
        preview = ", ".join(f"{n.note}@{n.step}" for n in notes[:6])
        if len(notes) > 6:
            preview += ", ..."
        print(f"  T{track:02d} P{pattern}: {preview}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
