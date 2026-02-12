#!/usr/bin/env python3
"""Generate targeted test .xy files to validate unnamed 94 findings.

Each file tests exactly one unknown. Load them on the OP-XY and report
what happens (loads/crashes, notes play correctly, etc.).

Tests:
  A. chord_t3.xy       — C+E+G chord on T3 step 1 (tests our flag=0x02 chord encoding)
  B. single_t7.xy      — E4 on T7 step 9 (tests 0x20 event type for authoring)
  C. melody_t7.xy      — C4-D4-E4-F4 on T7 steps 1/5/9/13 (tests 0x20 multi-note)
  D. single_t6.xy      — C4 on T6 step 1 (tests 0x1E event type for authoring)
  E. chord_t1.xy       — C4+E4+G4 chord on T1 step 1 (tests 0x25 chord encoding)
  F. mixed_t3.xy       — chord on step 1 + single notes on steps 5, 9 (melody+chord mix)
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note
from xy.project_builder import append_notes_to_track, append_notes_to_tracks

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
OUTPUT = Path("output")


def write(project: XYProject, filename: str, label: str) -> None:
    path = OUTPUT / filename
    data = project.to_bytes()
    path.write_bytes(data)
    print(f"  {filename:25s} {len(data):5d}B  {label}")


def main() -> None:
    OUTPUT.mkdir(exist_ok=True)
    template_data = TEMPLATE.read_bytes()
    print(f"Template: {TEMPLATE} ({len(template_data)} bytes)\n")

    # ── Test A: Chord on T3 (0x21) ──────────────────────────────────
    # Three notes at same step = chord. Tests our flag=0x02 encoding.
    # Expected: C major triad plays simultaneously on step 1.
    proj = XYProject.from_bytes(template_data)
    proj = append_notes_to_track(proj, track_index=3, notes=[
        Note(step=1, note=60, velocity=100),   # C4
        Note(step=1, note=64, velocity=100),   # E4
        Note(step=1, note=67, velocity=100),   # G4
    ])
    write(proj, "test_A_chord_t3.xy", "T3 C+E+G chord step 1 (0x21, flag=0x02)")

    # ── Test B: Single note on T7 (0x20 Axis) ───────────────────────
    # First authoring test of 0x20 event type.
    # Expected: single E4 plays on step 9.
    proj = XYProject.from_bytes(template_data)
    proj = append_notes_to_track(proj, track_index=7, notes=[
        Note(step=9, note=64, velocity=100),   # E4
    ])
    write(proj, "test_B_single_t7.xy", "T7 E4 step 9 (0x20 Axis)")

    # ── Test C: Multi-note melody on T7 (0x20 Axis) ─────────────────
    # Tests 0x20 with count>1. Expected: ascending C-D-E-F on steps 1/5/9/13.
    proj = XYProject.from_bytes(template_data)
    proj = append_notes_to_track(proj, track_index=7, notes=[
        Note(step=1, note=60, velocity=100),   # C4
        Note(step=5, note=62, velocity=100),   # D4
        Note(step=9, note=64, velocity=100),   # E4
        Note(step=13, note=65, velocity=100),  # F4
    ])
    write(proj, "test_C_melody_t7.xy", "T7 C-D-E-F steps 1/5/9/13 (0x20 multi)")

    # ── Test D: Single note on T6 (0x1E Hardsync) ───────────────────
    # First authoring test of 0x1E event type.
    # Expected: single C4 plays on step 1.
    proj = XYProject.from_bytes(template_data)
    proj = append_notes_to_track(proj, track_index=6, notes=[
        Note(step=1, note=60, velocity=100),   # C4
    ])
    write(proj, "test_D_single_t6.xy", "T6 C4 step 1 (0x1E Hardsync)")

    # ── Test E: Chord on T1 (0x25 Drum) ─────────────────────────────
    # Tests whether 0x25 accepts multiple notes at same tick (chord).
    # For drums this means multiple simultaneous hits.
    # Expected: kick + snare + hat play simultaneously on step 1.
    proj = XYProject.from_bytes(template_data)
    proj = append_notes_to_track(proj, track_index=1, notes=[
        Note(step=1, note=48, velocity=120),   # kick a
        Note(step=1, note=50, velocity=110),   # snare a
        Note(step=1, note=56, velocity=100),   # closed hat a
    ])
    write(proj, "test_E_chord_t1.xy", "T1 kick+snare+hat step 1 (0x25 chord)")

    # ── Test F: Chord + melody mix on T3 (0x21) ─────────────────────
    # Chord on step 1, single notes on steps 5 and 9.
    # Tests transition from same-tick notes to different-tick notes.
    # Expected: C+E+G chord on 1, then A4 on 5, then B4 on 9.
    proj = XYProject.from_bytes(template_data)
    proj = append_notes_to_track(proj, track_index=3, notes=[
        Note(step=1, note=60, velocity=100),   # C4 \
        Note(step=1, note=64, velocity=100),   # E4  > chord
        Note(step=1, note=67, velocity=100),   # G4 /
        Note(step=5, note=69, velocity=100),   # A4 (single)
        Note(step=9, note=71, velocity=100),   # B4 (single)
    ])
    write(proj, "test_F_mixed_t3.xy", "T3 chord(1)+A4(5)+B4(9) (0x21 mixed)")

    print(f"\nGenerated 6 test files in {OUTPUT}/")
    print("""
Expected results if everything works:
  A: C major triad on T3 Prism, step 1
  B: Single E4 on T7 Axis, step 9
  C: C-D-E-F melody on T7 Axis, steps 1/5/9/13
  D: Single C4 on T6 Hardsync, step 1
  E: Simultaneous kick+snare+hat on T1 Drum, step 1
  F: C major chord then A4 then B4 on T3 Prism
""")


if __name__ == "__main__":
    main()
