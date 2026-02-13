#!/usr/bin/env python3
"""Round 3 diagnostics: test corrected step component encoding.

Previous encoding was fundamentally wrong (insertion instead of slot replacement,
wrong bitmask, wrong payload sizes, wrong type IDs).  Now byte-perfect matches
5 corpus specimens (unnamed 8, 9, 59, 60, 61).

Test matrix:
  A. Component-only (no notes): all 10 verified configurations
  B. Component + notes on T1: Pulse(s9) + drum pattern
  C. Musical 4-track arrangement + T1 Pulse(s9)

Usage:
    python tools/write_step_comp_diag3.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note, STEP_TICKS
from xy.step_components import StepComponent, ComponentType
from xy.project_builder import (
    append_notes_to_track, append_notes_to_tracks, add_step_components,
)

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
OUTPUT_DIR = Path("output/step_diag")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

KICK = 48
SNARE = 50
CH = 56

def n(step, note, vel=100, gate=0):
    return Note(step=step, note=note, velocity=vel, gate_ticks=gate)

baseline = XYProject.from_bytes(TEMPLATE.read_bytes())

print("=== Round 3: Corrected Step Component Encoding ===")
print("    (byte-perfect match on 5 corpus specimens)\n")

# --- A: Component-only, no notes ---
print("--- A: Component-only (no notes) ---")
comp_only = [
    ("r3_A01_pulse_s1",     StepComponent(1, ComponentType.PULSE, 0x01),
     "Pulse step 1 (corpus: unnamed 8)"),
    ("r3_A02_pulse_max_s1", StepComponent(1, ComponentType.PULSE_MAX, 0x00),
     "PulseMax step 1 (corpus: unnamed 9)"),
    ("r3_A03_pulse_s9",     StepComponent(9, ComponentType.PULSE, 0x01),
     "Pulse step 9 (corpus: unnamed 59)"),
    ("r3_A04_pulse_max_s9", StepComponent(9, ComponentType.PULSE_MAX, 0x00),
     "PulseMax step 9 (corpus: unnamed 60)"),
    ("r3_A05_hold_s9",      StepComponent(9, ComponentType.HOLD, 0x01),
     "Hold step 9 (corpus: unnamed 61)"),
    ("r3_A06_velocity_s9",  StepComponent(9, ComponentType.VELOCITY, 0x00),
     "Velocity step 9"),
    ("r3_A07_ramp_up_s9",   StepComponent(9, ComponentType.RAMP_UP, 0x08),
     "Ramp Up step 9"),
    ("r3_A08_ramp_down_s9", StepComponent(9, ComponentType.RAMP_DOWN, 0x02),
     "Ramp Down step 9 (corpus: unnamed 69)"),
    ("r3_A09_random_s9",    StepComponent(9, ComponentType.RANDOM, 0x03),
     "Random step 9"),
    ("r3_A10_portamento_s9", StepComponent(9, ComponentType.PORTAMENTO, 0x07),
     "Portamento step 9"),
]

for name, comp, desc in comp_only:
    proj = add_step_components(baseline, 1, [comp])
    data = proj.to_bytes()
    (OUTPUT_DIR / f"{name}.xy").write_bytes(data)
    print(f"  {name + '.xy':40s} {len(data):5d}B  {desc}")

# --- B: Component + drum notes on T1 ---
print("\n--- B: Component + T1 drum notes ---")
drum_notes = [
    n(1, KICK, 110), n(5, SNARE, 100), n(9, KICK, 110), n(13, SNARE, 100),
]

comp_note_tests = [
    ("r3_B01_pulse_s1_notes",    StepComponent(1, ComponentType.PULSE, 0x01),
     "Pulse(s1) + 4 drum notes"),
    ("r3_B02_pulse_max_s1_notes", StepComponent(1, ComponentType.PULSE_MAX, 0x00),
     "PulseMax(s1) + 4 drum notes"),
    ("r3_B03_pulse_s9_notes",    StepComponent(9, ComponentType.PULSE, 0x01),
     "Pulse(s9) + 4 drum notes"),
    ("r3_B04_hold_s9_notes",     StepComponent(9, ComponentType.HOLD, 0x01),
     "Hold(s9) + 4 drum notes"),
    ("r3_B05_porto_s9_notes",    StepComponent(9, ComponentType.PORTAMENTO, 0x07),
     "Portamento(s9) + 4 drum notes"),
]

for name, comp, desc in comp_note_tests:
    proj = append_notes_to_track(baseline, 1, drum_notes)
    proj = add_step_components(proj, 1, [comp])
    data = proj.to_bytes()
    (OUTPUT_DIR / f"{name}.xy").write_bytes(data)
    print(f"  {name + '.xy':40s} {len(data):5d}B  {desc}")

# --- C: Full musical arrangement + T1 Pulse(s9) ---
print("\n--- C: Musical arrangement ---")
QUARTER = STEP_TICKS * 4
EIGHTH = STEP_TICKS * 2
DOTTED_QTR = STEP_TICKS * 6
HALF = STEP_TICKS * 8
WHOLE = STEP_TICKS * 16

t1_notes = [
    n(1, KICK, 110), n(3, CH, 70), n(5, SNARE, 100), n(7, CH, 70),
    n(9, KICK, 110), n(11, CH, 70), n(13, SNARE, 100), n(15, CH, 80),
    n(16, CH, 90),
]
t3_notes = [
    n(1, 48, 100, QUARTER), n(5, 43, 90, QUARTER),
    n(9, 44, 95, QUARTER), n(13, 41, 85, QUARTER),
]
t5_notes = [
    n(1, 63, 90, EIGHTH), n(4, 62, 80, EIGHTH), n(6, 60, 85, QUARTER),
    n(9, 67, 100, DOTTED_QTR), n(15, 63, 75, EIGHTH),
]
t7_notes = [
    n(1, 60, 80, WHOLE), n(9, 67, 70, HALF),
]

proj = append_notes_to_tracks(baseline, {
    1: t1_notes, 3: t3_notes, 5: t5_notes, 7: t7_notes,
})
proj = add_step_components(proj, 1,
    [StepComponent(9, ComponentType.PULSE, 0x01)])
data = proj.to_bytes()
(OUTPUT_DIR / "r3_C01_full_pulse_s9.xy").write_bytes(data)
print(f"  {'r3_C01_full_pulse_s9.xy':40s} {len(data):5d}B  4-track + T1 Pulse(s9)")

print(f"\n=== Test plan ===")
print(f"  A01-A05: MUST work (byte-perfect corpus matches)")
print(f"  A06-A10: Should work (same encoding pattern, untested params)")
print(f"  B01-B05: Component + notes combo (B03 = prev confirmed working)")
print(f"  C01:     Full musical arrangement (prev Pulse(s9) confirmed)")
print(f"\nTotal: 16 test files in output/step_diag/")
