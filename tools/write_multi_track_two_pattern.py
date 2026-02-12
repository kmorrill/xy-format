#!/usr/bin/env python3
"""Generate a two-pattern multi-track OP-XY stress project.

This script is for testing multi-pattern track authoring.

Examples:
  python tools/write_multi_track_two_pattern.py
  python tools/write_multi_track_two_pattern.py output/t1_t3.xy --tracks 1,3 --strategy strict
  python tools/write_multi_track_two_pattern.py output/t1_t4.xy --tracks 1,2,3,4 --strategy heuristic_v1
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Dict, List

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note
from xy.project_builder import build_multi_pattern_project


TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
DEFAULT_OUTPUT = Path("output/multi_track_two_pattern.xy")


def _parse_tracks(raw: str) -> List[int]:
    tracks: List[int] = []
    for chunk in raw.split(","):
        chunk = chunk.strip()
        if not chunk:
            continue
        value = int(chunk)
        if value < 1 or value > 16:
            raise ValueError(f"track index out of range: {value} (expected 1-16)")
        if value not in tracks:
            tracks.append(value)
    if not tracks:
        raise ValueError("need at least one track")
    return sorted(tracks)


def _note_seed_for_track(track: int) -> List[int]:
    # Purposefully varied note seeds so each track/pattern is easy to identify.
    seeds = {
        1: [48, 50, 52, 55],
        2: [56, 58, 60, 62],
        3: [45, 48, 52, 55],
        4: [60, 64, 67, 69],
        5: [52, 55, 57, 59],
        6: [47, 50, 54, 57],
        7: [53, 57, 60, 64],
        8: [41, 45, 48, 52],
    }
    if track in seeds:
        return seeds[track]

    # Auxiliary tracks fallback: spread values by track index.
    base = 36 + (track * 2)
    return [base, base + 3, base + 5, base + 7]


def _build_track_patterns(
    tracks: List[int],
    *,
    dense: bool = False,
) -> Dict[int, List[List[Note]]]:
    mapping: Dict[int, List[List[Note]]] = {}
    for track in tracks:
        n1, n2, n3, n4 = _note_seed_for_track(track)
        if dense:
            pattern_1 = [
                Note(step=1, note=n1, velocity=100),
                Note(step=9, note=n2, velocity=108),
            ]
            pattern_2 = [
                Note(step=5, note=n3, velocity=102),
                Note(step=13, note=n4, velocity=112, gate_ticks=960),
            ]
        else:
            # Conservative default: one note per pattern to stay close to the
            # known-good corpus multi-pattern captures (unnamed 102/103/105).
            pattern_1 = [Note(step=1, note=n1, velocity=100)]
            pattern_2 = [Note(step=9, note=n3, velocity=110)]
        mapping[track] = [pattern_1, pattern_2]
    return mapping


def _descriptor_bytes(result: XYProject, template: XYProject) -> bytes:
    delta = len(result.pre_track) - len(template.pre_track)
    if delta <= 0:
        return b""
    return result.pre_track[0x58 : 0x58 + delta]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "output",
        nargs="?",
        default=str(DEFAULT_OUTPUT),
        help="output .xy path (default: output/multi_track_two_pattern.xy)",
    )
    parser.add_argument(
        "--tracks",
        default="1,3",
        help="comma-separated track list; default: 1,3",
    )
    parser.add_argument(
        "--strategy",
        choices=("strict", "heuristic_v1"),
        default="strict",
        help="descriptor encoding strategy (default: strict)",
    )
    parser.add_argument(
        "--template",
        default=str(TEMPLATE),
        help="template .xy path",
    )
    parser.add_argument(
        "--dense",
        action="store_true",
        help="write two notes per pattern (default writes one note per pattern)",
    )
    args = parser.parse_args()

    tracks = _parse_tracks(args.tracks)
    template_path = Path(args.template)
    output_path = Path(args.output)

    template_raw = template_path.read_bytes()
    project = XYProject.from_bytes(template_raw)

    track_patterns = _build_track_patterns(tracks, dense=args.dense)
    try:
        result = build_multi_pattern_project(
            project,
            track_patterns,
            descriptor_strategy=args.strategy,
        )
    except ValueError as exc:
        raise SystemExit(f"error: {exc}") from exc

    raw = result.to_bytes()
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_bytes(raw)

    reparsed = XYProject.from_bytes(raw)
    assert reparsed.to_bytes() == raw, "round-trip failed"

    descriptor = _descriptor_bytes(result, project)
    print(f"Wrote {len(raw)} bytes to {output_path}")
    print(f"Template: {template_path}")
    print(f"Tracks: {','.join(str(t) for t in tracks)}")
    print(f"Strategy: {args.strategy}")
    print(f"Max Slot Index @0x56: {int.from_bytes(result.pre_track[0x56:0x58], 'little')}")
    print(f"Descriptor @0x58 ({len(descriptor)} bytes): {descriptor.hex(' ')}")

    for track in tracks:
        p1, p2 = track_patterns[track]
        p1_notes = ", ".join(f"{n.note}@{n.step}" for n in p1)
        p2_notes = ", ".join(f"{n.note}@{n.step}" for n in p2)
        print(f"  T{track:02d} P1[{p1_notes}]  P2[{p2_notes}]")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
