#!/usr/bin/env python3
"""Phase Shift — a groove that evolves with step components on tonal tracks.

Single-pattern arrangement with step components on every active track:
  T1 (Drums):    Kick/snare/hat groove  +  PULSE on step 9 (retrig flam)
  T3 (Bass):     Cm walking bass         +  PORTAMENTO on step 9 (glide 70%)
  T5 (Lead):     Dissolve melody          +  VELOCITY on step 9 (random velocity)
  T7 (Chords):   Axis sustained pads      +  RAMP_UP on step 9 (4s 3oct)

Also generates crash-isolation variants:
  - notes_only:    all 4 tracks, NO components (control)
  - t1_comp:       drums only with PULSE (confirmed working)
  - t3_comp:       bass only with PORTAMENTO (tonal test)
  - t1t3_comp:     drums + bass with components
  - t1t3t5_comp:   drums + bass + lead with components
  - full_comp:     all 4 tracks with components

Usage:
    python tools/write_phase_shift.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note, STEP_TICKS
from xy.step_components import StepComponent, ComponentType
from xy.project_builder import (
    append_notes_to_tracks, add_step_components,
)

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
OUTPUT_DIR = Path("output")
OUTPUT_DIR.mkdir(exist_ok=True)

# Timing constants
QUARTER = STEP_TICKS * 4    # 1920
EIGHTH = STEP_TICKS * 2     # 960
DOTTED_QTR = STEP_TICKS * 6 # 2880
HALF = STEP_TICKS * 8       # 3840
WHOLE = STEP_TICKS * 16     # 7680

def n(step, note, vel=100, gate=0):
    return Note(step=step, note=note, velocity=vel, gate_ticks=gate)


# ── Musical content ─────────────────────────────────────────────────

# T1 Drums (boop kit): C-minor groove
# Kick=48, Snare=50, Rim=52, Clap=53, CH=56, OH=58
KICK, SNARE, RIM, CH, OH = 48, 50, 52, 56, 58

t1_drums = [
    n(1,  KICK,  112),           # downbeat kick
    n(3,  CH,    75),            # hat
    n(5,  SNARE, 105),           # backbeat snare
    n(7,  CH,    70),            # hat
    n(9,  KICK,  110),           # mid-bar kick
    n(9,  OH,    80),            # open hat layer
    n(11, CH,    72),            # hat
    n(13, SNARE, 108),           # backbeat snare
    n(15, CH,    78),            # hat
    n(16, RIM,   88),            # end-bar rim click pickup
]

# T3 Bass (Prism): Cm root motion — C Eb Ab G
t3_bass = [
    n(1,  36, 104, QUARTER),     # C2
    n(5,  39, 100, QUARTER),     # Eb2
    n(9,  44, 106, QUARTER),     # Ab1 — CONDITIONAL here
    n(13, 43, 102, QUARTER),     # G1
]

# T5 Lead (Dissolve): Cm pentatonic melody
t5_lead = [
    n(1,  67,  95, EIGHTH),      # G4
    n(3,  65,  88, EIGHTH),      # F4
    n(5,  63,  92, QUARTER),     # Eb4
    n(9,  58,  100, DOTTED_QTR), # Bb3 — BEND here (pitch wobble)
    n(13, 60,  90, QUARTER),     # C4
    n(16, 63,  78, EIGHTH),      # Eb4 pickup
]

# T7 Chords (Axis): Cm → Fm sustained pads
t7_chords = [
    # Cm triad: C4+Eb4+G4 (whole note)
    n(1, 60, 82, WHOLE),
    n(1, 63, 80, WHOLE),
    n(1, 67, 78, WHOLE),
    # Fm triad: F3+Ab3+C4 (half note) — TONALITY here
    n(9, 53, 82, HALF),
    n(9, 56, 80, HALF),
    n(9, 60, 78, HALF),
]


# ── Step components per track ───────────────────────────────────────

# Each track gets ONE component on step 9 (most verified position)
COMP_T1 = StepComponent(9, ComponentType.PULSE, 0x01)       # retrig (drum flam)
COMP_T3 = StepComponent(9, ComponentType.PORTAMENTO, 0x07)   # portamento 70%
COMP_T5 = StepComponent(9, ComponentType.VELOCITY, 0x00)     # velocity (random)
COMP_T7 = StepComponent(9, ComponentType.RAMP_UP, 0x08)      # ramp up (4 steps, 3 octaves)


# ── Build files ─────────────────────────────────────────────────────

baseline = XYProject.from_bytes(TEMPLATE.read_bytes())

all_notes = {1: t1_drums, 3: t3_bass, 5: t5_lead, 7: t7_chords}

print("=== Phase Shift: Tonal Step Components ===\n")

# Control: notes only, no components
proj = append_notes_to_tracks(baseline, all_notes)
data = proj.to_bytes()
(OUTPUT_DIR / "ps_notes_only.xy").write_bytes(data)
print(f"  {'ps_notes_only.xy':40s} {len(data):5d}B  Control: 4-track, no components")

# T1 drums + PULSE only (confirmed working)
proj = append_notes_to_tracks(baseline, {1: t1_drums})
proj = add_step_components(proj, 1, [COMP_T1])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_t1_pulse.xy").write_bytes(data)
print(f"  {'ps_t1_pulse.xy':40s} {len(data):5d}B  T1 drums + PULSE(s9)")

# T3 bass + PORTAMENTO only
proj = append_notes_to_tracks(baseline, {3: t3_bass})
proj = add_step_components(proj, 3, [COMP_T3])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_t3_porto.xy").write_bytes(data)
print(f"  {'ps_t3_porto.xy':40s} {len(data):5d}B  T3 bass + PORTAMENTO(s9) [TONAL TEST]")

# T5 lead + VELOCITY only
proj = append_notes_to_tracks(baseline, {5: t5_lead})
proj = add_step_components(proj, 5, [COMP_T5])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_t5_vel.xy").write_bytes(data)
print(f"  {'ps_t5_vel.xy':40s} {len(data):5d}B  T5 lead + VELOCITY(s9) [TONAL TEST]")

# T7 chords + RAMP_UP only
proj = append_notes_to_tracks(baseline, {7: t7_chords})
proj = add_step_components(proj, 7, [COMP_T7])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_t7_ramp.xy").write_bytes(data)
print(f"  {'ps_t7_ramp.xy':40s} {len(data):5d}B  T7 chords + RAMP_UP(s9) [TONAL TEST]")

# T1+T3 combo
proj = append_notes_to_tracks(baseline, {1: t1_drums, 3: t3_bass})
proj = add_step_components(proj, 1, [COMP_T1])
proj = add_step_components(proj, 3, [COMP_T3])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_t1t3_comp.xy").write_bytes(data)
print(f"  {'ps_t1t3_comp.xy':40s} {len(data):5d}B  T1+T3 with components")

# T1+T3+T5
proj = append_notes_to_tracks(baseline, {1: t1_drums, 3: t3_bass, 5: t5_lead})
proj = add_step_components(proj, 1, [COMP_T1])
proj = add_step_components(proj, 3, [COMP_T3])
proj = add_step_components(proj, 5, [COMP_T5])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_t1t3t5_comp.xy").write_bytes(data)
print(f"  {'ps_t1t3t5_comp.xy':40s} {len(data):5d}B  T1+T3+T5 with components")

# Full: all 4 tracks + all components
proj = append_notes_to_tracks(baseline, all_notes)
proj = add_step_components(proj, 1, [COMP_T1])
proj = add_step_components(proj, 3, [COMP_T3])
proj = add_step_components(proj, 5, [COMP_T5])
proj = add_step_components(proj, 7, [COMP_T7])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_full_comp.xy").write_bytes(data)
print(f"  {'ps_full_comp.xy':40s} {len(data):5d}B  Full 4-track + all components")

# Bonus: RANDOM + JUMP variants on T3 and T5
proj = append_notes_to_tracks(baseline, all_notes)
proj = add_step_components(proj, 1, [COMP_T1])
proj = add_step_components(proj, 3, [StepComponent(9, ComponentType.RANDOM, 0x03)])
proj = add_step_components(proj, 5, [StepComponent(9, ComponentType.JUMP, 0x04)])
proj = add_step_components(proj, 7, [COMP_T7])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_full_random_jump.xy").write_bytes(data)
print(f"  {'ps_full_random_jump.xy':40s} {len(data):5d}B  Full + RANDOM(T3) + JUMP(T5)")

# Bonus: Hold component on T5 lead
proj = append_notes_to_tracks(baseline, all_notes)
proj = add_step_components(proj, 1, [COMP_T1])
proj = add_step_components(proj, 3, [COMP_T3])
proj = add_step_components(proj, 5, [StepComponent(9, ComponentType.HOLD, 0x01)])
proj = add_step_components(proj, 7, [COMP_T7])
data = proj.to_bytes()
(OUTPUT_DIR / "ps_full_hold.xy").write_bytes(data)
print(f"  {'ps_full_hold.xy':40s} {len(data):5d}B  Full + HOLD on T5 lead")

print(f"""
=== Test plan ===
  1. ps_notes_only      — control, should definitely work
  2. ps_t1_pulse        — T1 PULSE confirmed working (sanity check)
  3. ps_t3_porto        — T3 Prism PORTAMENTO 70%
  4. ps_t5_vel          — T5 Dissolve VELOCITY (random)
  5. ps_t7_ramp         — T7 Axis RAMP_UP (4s 3oct)
  6. ps_t1t3_comp       — drums + bass combo
  7. ps_t1t3t5_comp     — 3-track combo
  8. ps_full_comp       — full 4-track (PORTAMENTO, VELOCITY, RAMP_UP)
  9. ps_full_random_jump — full 4-track (RANDOM + JUMP variants)
 10. ps_full_hold        — full 4-track (HOLD on T5)

Musical content: C minor groove
  T1: kick/snare/hat pattern (boop kit) + PULSE
  T3: C-Eb-Ab-G bass motion (Prism) + PORTAMENTO
  T5: pentatonic melody G-F-Eb-Bb-C (Dissolve) + VELOCITY
  T7: Cm/Fm sustained chord pads (Axis) + RAMP_UP

Total: 10 files""")
