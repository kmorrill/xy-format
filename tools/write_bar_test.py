#!/usr/bin/env python3
"""Diagnose 4-bar crashes by incrementally adding bars.

The count_test files (20 notes, steps 1-20) all work.
The arrangement files (19 notes, steps 1-64) crash on T1/T2/T3.
This isolates whether it's the tick range (4 bars) or specific note data.

Usage:
    python tools/write_bar_test.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note, STEP_TICKS
from xy.project_builder import append_notes_to_tracks

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
OUTPUT_DIR = Path("output/bar_tests")

QUARTER = STEP_TICKS * 4
EIGHTH = STEP_TICKS * 2


def generate(template, track_notes, path, desc):
    result = append_notes_to_tracks(template, track_notes)
    data = result.to_bytes()
    path.write_bytes(data)
    total = sum(len(n) for n in track_notes.values())
    tracks = "+".join(f"T{t}" for t in sorted(track_notes))
    print(f"  {path.name:40s} {tracks:8s} {total:3d} notes  {desc}")


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    template_data = TEMPLATE.read_bytes()
    template = XYProject.from_bytes(template_data)

    print("Bar range tests:")
    print(f"  {'File':40s} {'Track':8s} {'Notes':>5s}  Description")
    print(f"  {'-'*40} {'-'*8} {'-'*5}  {'-'*40}")

    # ── Test A: T3 with uniform notes at quarter spacing across 4 bars ──
    # (Same count/note as working test, but spread across 4 bars)
    for bars in [1, 2, 3, 4]:
        steps = list(range(1, bars * 16 + 1, 4))  # quarter note spacing
        notes = [Note(step=s, note=60, velocity=100, gate_ticks=QUARTER) for s in steps]
        generate(template, {3: notes},
                 OUTPUT_DIR / f"t3_uniform_{bars}bar.xy",
                 f"T3 C4 quarters, {bars} bar(s), {len(notes)} notes")

    # ── Test B: T3 bass arrangement sliced by bar ──
    from write_arrangement import TRACK3
    for bars in [1, 2, 3, 4]:
        max_step = bars * 16
        notes = [n for n in TRACK3 if n.step <= max_step]
        generate(template, {3: notes},
                 OUTPUT_DIR / f"t3_bass_{bars}bar.xy",
                 f"T3 bass arrangement, {bars} bar(s), {len(notes)} notes")

    # ── Test C: T1 drums sliced by bar ──
    from write_arrangement import TRACK1
    for bars in [1, 2, 3, 4]:
        max_step = bars * 16
        notes = [n for n in TRACK1 if n.step <= max_step]
        generate(template, {1: notes},
                 OUTPUT_DIR / f"t1_drums_{bars}bar.xy",
                 f"T1 drums, {bars} bar(s), {len(notes)} notes")

    # ── Test D: T1+T2 drums sliced by bar ──
    from write_arrangement import TRACK2
    for bars in [1, 2, 3, 4]:
        max_step = bars * 16
        t1 = [n for n in TRACK1 if n.step <= max_step]
        t2 = [n for n in TRACK2 if n.step <= max_step]
        generate(template, {1: t1, 2: t2},
                 OUTPUT_DIR / f"drums_{bars}bar.xy",
                 f"T1+T2 drums, {bars} bar(s), {len(t1)}+{len(t2)} notes")

    print()
    print("Key tests:")
    print("  t3_uniform_4bar.xy — 16 uniform C4 quarters across 4 bars")
    print("    If works: tick range is fine, issue is specific arrangement notes")
    print("    If crashes: tick range itself is the problem")
    print()
    print("  t3_bass_Nbar.xy — arrangement bass, bar by bar")
    print("    Find which bar addition causes the crash")


if __name__ == "__main__":
    main()
