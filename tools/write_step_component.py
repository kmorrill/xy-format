#!/usr/bin/env python3
"""Generate test .xy files with step components for device verification.

Test matrix:
  A. Control: note only (known working baseline)
  B. Note + component on same step (real use case)
  C. Component only (may not be valid standalone)
"""
import sys
sys.path.insert(0, ".")

from pathlib import Path
from xy.container import XYProject
from xy.note_events import Note
from xy.step_components import StepComponent, ComponentType
from xy.project_builder import add_step_components, append_notes_to_track

CORPUS = Path("src/one-off-changes-from-default")
OUTPUT = Path("output")
OUTPUT.mkdir(exist_ok=True)

baseline = XYProject.from_bytes((CORPUS / "unnamed 1.xy").read_bytes())

print("=== Step Component Test Files ===\n")

# --- A. Control: note only (KNOWN WORKING) ---
proj = append_notes_to_track(baseline, 1, [
    Note(step=9, note=48, velocity=100),
])
(OUTPUT / "comp_A_control.xy").write_bytes(proj.to_bytes())
print("  A. comp_A_control.xy     — note only on T1 step 9 (known working)")

# --- B. Note + component combos ---
for name, comp_type, param, desc in [
    ("comp_B1_hold",     ComponentType.HOLD,       0x01, "Hold min"),
    ("comp_B2_multiply", ComponentType.MULTIPLY,    0x04, "Multiply div4"),
    ("comp_B3_velocity", ComponentType.VELOCITY,    0x00, "Velocity random"),
    ("comp_B4_pulse",    ComponentType.PULSE,        0x01, "Pulse rpt=1"),
    ("comp_B5_rampup",   ComponentType.RAMP_UP,     0x08, "RampUp 4s3o"),
    ("comp_B6_porto",    ComponentType.PORTAMENTO,   0x07, "Porto 70%"),
]:
    proj = append_notes_to_track(baseline, 1, [
        Note(step=9, note=48, velocity=100),
    ])
    proj = add_step_components(proj, 1, [
        StepComponent(9, comp_type, param),
    ])
    fname = f"{name}.xy"
    (OUTPUT / fname).write_bytes(proj.to_bytes())
    print(f"  B. {fname:<28} — note + {desc} on T1 step 9")

# --- C. Component only (crashed before — include for diagnostics) ---
proj = add_step_components(baseline, 1, [
    StepComponent(9, ComponentType.HOLD, 0x01),
])
(OUTPUT / "comp_C_hold_only.xy").write_bytes(proj.to_bytes())
print(f"  C. comp_C_hold_only.xy       — Hold only, NO note (expect crash)")

print(f"\nDone. {8} files in output/")
