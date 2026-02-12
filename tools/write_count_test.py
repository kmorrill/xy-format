#!/usr/bin/env python3
"""Diagnose the per-event note count limit for 0x21 and 0x25 event types.

Theory: 0x25 (T1) and 0x21 (T2, T3) have a 16-note limit per event,
while 0x1F (T4) and 0x20 (T7) support more.  Generate files with
exactly 16 and 17 notes to find the boundary.

Usage:
    python tools/write_count_test.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note, STEP_TICKS
from xy.project_builder import append_notes_to_tracks

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
OUTPUT_DIR = Path("output/count_tests")

QUARTER = STEP_TICKS * 4  # 1920
EIGHTH = STEP_TICKS * 2   # 960


def make_notes(count, *, note=60, gate=QUARTER):
    """Generate `count` notes spread evenly across steps 1..count."""
    return [
        Note(step=i + 1, note=note, velocity=100, gate_ticks=gate)
        for i in range(count)
    ]


def generate(template, track_notes, path, desc):
    result = append_notes_to_tracks(template, track_notes)
    data = result.to_bytes()
    path.write_bytes(data)
    total = sum(len(n) for n in track_notes.values())
    tracks = "+".join(f"T{t}" for t in sorted(track_notes))
    print(f"  {path.name:35s} {tracks:8s} {total:3d} notes  {desc}")


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    template_data = TEMPLATE.read_bytes()
    template = XYProject.from_bytes(template_data)

    print("Note count limit tests:")
    print(f"  {'File':35s} {'Track':8s} {'Notes':>5s}  Description")
    print(f"  {'-'*35} {'-'*8} {'-'*5}  {'-'*40}")

    # ── T3 (Prism, 0x21) — boundary between 15 (works) and 19 (crashes) ──
    for count in [15, 16, 17, 18, 19, 20]:
        generate(template,
                 {3: make_notes(count, note=60, gate=QUARTER)},
                 OUTPUT_DIR / f"t3_{count}notes.xy",
                 f"T3 Prism 0x21, {count} notes")

    # ── T1 (Drum, 0x25) — boundary around 16? ──
    for count in [8, 16, 17, 20]:
        generate(template,
                 {1: make_notes(count, note=48, gate=0)},  # kick, default gate
                 OUTPUT_DIR / f"t1_{count}notes.xy",
                 f"T1 Drum 0x25, {count} notes")

    # ── T2 (Drum, 0x21) — exactly 16 worked before ──
    for count in [16, 17, 20]:
        generate(template,
                 {2: make_notes(count, note=56, gate=0)},  # closed hat, default gate
                 OUTPUT_DIR / f"t2_{count}notes.xy",
                 f"T2 Drum 0x21, {count} notes")

    # ── T4 (Pluck, 0x1F) — 20 works, test higher ──
    for count in [20, 32]:
        generate(template,
                 {4: make_notes(count, note=64, gate=EIGHTH)},
                 OUTPUT_DIR / f"t4_{count}notes.xy",
                 f"T4 Pluck 0x1F, {count} notes")

    print()
    print("Test order (find the boundary):")
    print("  1. t3_16notes.xy  — if works, limit > 16")
    print("  2. t3_17notes.xy  — if crashes, limit = 16")
    print("  3. t1_16notes.xy  — same test for 0x25")
    print("  4. t1_17notes.xy")
    print("  5. t2_17notes.xy")
    print("  6. t4_32notes.xy  — does 0x1F have a higher limit?")


if __name__ == "__main__":
    main()
