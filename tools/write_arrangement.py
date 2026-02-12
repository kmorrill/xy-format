#!/usr/bin/env python3
"""Generate a 5-track, 4-bar arrangement in A minor.

Progression: Am | F | Dm | E
Tracks:
  T1  Drums (kick + snare)  — groove bars 1-3, fill bar 4
  T2  Hats (closed + open)  — 8th note pattern, 16ths in fill
  T3  Bass (Prism)          — root movement with passing tones
  T4  Melody (Pluck/EPiano) — singable line outlining the harmony
  T7  Chords (Axis)         — sustained pad triads

Usage:
    python tools/write_arrangement.py
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note, STEP_TICKS
from xy.project_builder import append_notes_to_tracks

# ── Constants ───────────────────────────────────────────────────────

TEMPLATE = Path("src/one-off-changes-from-default/unnamed 1.xy")
OUTPUT_DIR = Path("output")

# Gate lengths in ticks (STEP_TICKS=480, 16 steps per bar)
SIXTEENTH = STEP_TICKS              # 480
EIGHTH = STEP_TICKS * 2             # 960
DOTTED_8TH = STEP_TICKS * 3         # 1440
QUARTER = STEP_TICKS * 4            # 1920
DOTTED_QTR = STEP_TICKS * 6         # 2880
HALF = STEP_TICKS * 8               # 3840
DOTTED_HALF = STEP_TICKS * 12       # 5760
WHOLE = STEP_TICKS * 16             # 7680

# Bar offsets (1-based step numbers)
BAR1 = 0   # steps 1-16
BAR2 = 16  # steps 17-32
BAR3 = 32  # steps 33-48
BAR4 = 48  # steps 49-64

# Drum sounds (Track 1 "boop" kit / Track 2 "phase" kit)
KICK = 48
SNARE = 50
RIM = 52
CLAP = 53
CH = 56     # closed hat
OH = 58     # open hat

# ── Helper ──────────────────────────────────────────────────────────

def n(step, note, vel=100, gate=0):
    """Shorthand note constructor."""
    return Note(step=step, note=note, velocity=vel, gate_ticks=gate)


# ════════════════════════════════════════════════════════════════════
#  TRACK 1 — Kick + Snare
#  Standard backbeat bars 1-3, syncopated fill bar 4
# ════════════════════════════════════════════════════════════════════

TRACK1 = [
    # ── Bar 1: Establish the groove ──
    n(BAR1+1,  KICK,  120),
    n(BAR1+5,  SNARE, 110),
    n(BAR1+7,  KICK,   65),             # ghost kick on the and-of-2
    n(BAR1+9,  KICK,  115),
    n(BAR1+13, SNARE, 112),
    n(BAR1+16, KICK,   55),             # pickup 16th into bar 2

    # ── Bar 2: Same groove, slight variation ──
    n(BAR2+1,  KICK,  120),
    n(BAR2+5,  SNARE, 108),
    n(BAR2+7,  KICK,   60),
    n(BAR2+9,  KICK,  115),
    n(BAR2+11, SNARE,  50),             # ghost snare on and-of-3
    n(BAR2+13, SNARE, 112),

    # ── Bar 3: Build energy ──
    n(BAR3+1,  KICK,  120),
    n(BAR3+4,  KICK,   70),             # extra ghost kick
    n(BAR3+5,  SNARE, 110),
    n(BAR3+7,  KICK,   65),
    n(BAR3+9,  KICK,  118),
    n(BAR3+13, SNARE, 115),
    n(BAR3+15, KICK,   80),             # pickup into fill

    # ── Bar 4: Fill ──
    n(BAR4+1,  KICK,  120),
    n(BAR4+5,  SNARE, 110),
    n(BAR4+7,  KICK,   95),
    # fill starts at beat 3 (step 9)
    n(BAR4+9,  SNARE,  80),
    n(BAR4+10, SNARE,  85),
    n(BAR4+11, SNARE,  95),
    n(BAR4+12, KICK,  105),
    n(BAR4+13, SNARE, 100),
    n(BAR4+14, SNARE, 108),
    n(BAR4+15, KICK,  112),
    n(BAR4+16, SNARE, 120),             # crash into downbeat
]


# ════════════════════════════════════════════════════════════════════
#  TRACK 2 — Hats
#  8th notes bars 1-3 with open hat accents, 16ths during fill
# ════════════════════════════════════════════════════════════════════

def hat_bar(offset, *, fill=False):
    """Generate one bar of hi-hat pattern."""
    if not fill:
        # Standard 8th-note pattern: closed hats, open on snare beats
        return [
            n(offset+1,  CH,  95),
            n(offset+3,  CH,  60),
            n(offset+5,  OH,  80),      # open hat on snare hit
            n(offset+7,  CH,  60),
            n(offset+9,  CH,  90),
            n(offset+11, CH,  55),
            n(offset+13, OH,  85),       # open hat on snare hit
            n(offset+15, CH,  55),
        ]
    else:
        # Fill bar: 8ths first half, 16ths second half
        return [
            n(offset+1,  CH,  95),
            n(offset+3,  CH,  60),
            n(offset+5,  OH,  80),
            n(offset+7,  CH,  60),
            # 16th notes through the fill
            n(offset+9,  CH,  70),
            n(offset+10, CH,  75),
            n(offset+11, CH,  80),
            n(offset+12, CH,  85),
            n(offset+13, CH,  90),
            n(offset+14, CH,  95),
            n(offset+15, OH, 100),
            n(offset+16, CH,  60),
        ]


TRACK2 = (
    hat_bar(BAR1) + hat_bar(BAR2) + hat_bar(BAR3) + hat_bar(BAR4, fill=True)
)


# ════════════════════════════════════════════════════════════════════
#  TRACK 3 — Bass (Prism, 0x21)
#  Root-fifth movement following the chord changes
#  Am | F | Dm | E
# ════════════════════════════════════════════════════════════════════

# MIDI notes: A2=45, B2=47, C3=48, D3=50, E2=40, E3=52, F2=41, G#2=44
TRACK3 = [
    # ── Bar 1: Am ──
    n(BAR1+1,  45, 110, QUARTER),       # A2 on the one
    n(BAR1+5,  45,  80, EIGHTH),        # A2 push
    n(BAR1+9,  52,  95, QUARTER),       # E3 (fifth)
    n(BAR1+13, 48,  85, EIGHTH),        # C3 (walk down to F)
    n(BAR1+15, 45,  70, EIGHTH),        # A2

    # ── Bar 2: F ──
    n(BAR2+1,  41, 110, QUARTER),       # F2
    n(BAR2+5,  41,  80, EIGHTH),        # F2
    n(BAR2+9,  48, 100, QUARTER),       # C3 (fifth)
    n(BAR2+13, 45,  85, EIGHTH),        # A3 (walk to Dm)
    n(BAR2+15, 48,  75, EIGHTH),        # C3

    # ── Bar 3: Dm ──
    n(BAR3+1,  50, 110, QUARTER),       # D3
    n(BAR3+5,  50,  80, EIGHTH),        # D3
    n(BAR3+9,  45,  95, QUARTER),       # A2 (fifth)
    n(BAR3+13, 50,  90, EIGHTH),        # D3
    n(BAR3+15, 47,  75, EIGHTH),        # B2 (leading tone to E)

    # ── Bar 4: E ──
    n(BAR4+1,  40, 112, QUARTER),       # E2
    n(BAR4+5,  40,  80, EIGHTH),        # E2
    n(BAR4+9,  47, 100, QUARTER),       # B2 (fifth)
    n(BAR4+13, 44,  90, DOTTED_QTR),    # G#2 (major third, tension)
]


# ════════════════════════════════════════════════════════════════════
#  TRACK 4 — Melody (Pluck/EPiano, 0x1F)
#  A singable melody that outlines the harmony
#  Starts high, descends, climbs to a peak in bar 3, resolves bar 4
# ════════════════════════════════════════════════════════════════════

# MIDI: A3=57, B3=59, C4=60, D4=62, E4=64, F4=65, G4=67, A4=69
TRACK4 = [
    # ── Bar 1: Am — opening phrase, descending ──
    n(BAR1+1,  64, 100, DOTTED_QTR),    # E4 (sustained opening)
    n(BAR1+7,  62,  75, EIGHTH),        # D4 (passing tone)
    n(BAR1+9,  60,  95, QUARTER),       # C4
    n(BAR1+13, 59,  80, DOTTED_QTR),    # B3 (leading into F)

    # ── Bar 2: F — answer phrase, ascending ──
    n(BAR2+1,  60,  95, QUARTER),       # C4
    n(BAR2+5,  57,  80, EIGHTH),        # A3
    n(BAR2+7,  60,  70, EIGHTH),        # C4 (bounce)
    n(BAR2+9,  62,  90, QUARTER),       # D4
    n(BAR2+13, 64,  85, DOTTED_QTR),    # E4 (reaching up)

    # ── Bar 3: Dm — climax, highest notes ──
    n(BAR3+1,  65, 100, QUARTER),       # F4 (peak!)
    n(BAR3+5,  69,  95, EIGHTH),        # A4 (higher peak)
    n(BAR3+7,  67,  80, EIGHTH),        # G4
    n(BAR3+9,  65,  90, QUARTER),       # F4
    n(BAR3+13, 62,  85, EIGHTH),        # D4 (settling)
    n(BAR3+15, 64,  75, EIGHTH),        # E4

    # ── Bar 4: E — resolution, descending to rest ──
    n(BAR4+1,  64,  95, DOTTED_QTR),    # E4
    n(BAR4+7,  62,  80, EIGHTH),        # D4
    n(BAR4+9,  60,  90, QUARTER),       # C4
    n(BAR4+13, 59,  85, EIGHTH),        # B3 (dominant tension)
    n(BAR4+15, 57,  95, HALF),          # A3 (home — sustain for resolution)
]


# ════════════════════════════════════════════════════════════════════
#  TRACK 7 — Chords (Axis, 0x20)
#  Sustained pad triads, two voicings per bar (beat 1 and beat 3)
#  Am | F | Dm | E
# ════════════════════════════════════════════════════════════════════

def chord(step, notes, vel=75, gate=HALF):
    """Build a triad at the given step."""
    return [n(step, note, vel, gate) for note in notes]


Am = [57, 60, 64]   # A3, C4, E4
F  = [53, 57, 60]   # F3, A3, C4
Dm = [50, 57, 62]   # D3, A3, D4  (open voicing)
E  = [52, 56, 59]   # E3, G#3, B3

TRACK7 = [
    # ── Bar 1: Am ──
    *chord(BAR1+1,  Am, 75, HALF),
    *chord(BAR1+9,  Am, 65, HALF),

    # ── Bar 2: F ──
    *chord(BAR2+1,  F,  75, HALF),
    *chord(BAR2+9,  F,  65, HALF),

    # ── Bar 3: Dm ──
    *chord(BAR3+1,  Dm, 78, HALF),
    *chord(BAR3+9,  Dm, 68, HALF),

    # ── Bar 4: E (harmonic minor V — tension) ──
    *chord(BAR4+1,  E,  80, HALF),
    *chord(BAR4+9,  E,  72, DOTTED_HALF),   # let it ring through the fill
]


# ── File generation ─────────────────────────────────────────────────

def generate(template: XYProject, track_notes: dict, output_path: Path, desc: str):
    """Generate one .xy file and print summary."""
    result = append_notes_to_tracks(template, track_notes)
    data = result.to_bytes()
    output_path.write_bytes(data)

    track_list = ", ".join(f"T{t}" for t in sorted(track_notes))
    total_notes = sum(len(n) for n in track_notes.values())
    print(f"  {output_path.name:30s} {len(data):6d}B  {track_list:20s}  {total_notes:3d} notes  {desc}")
    return result


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    template_data = TEMPLATE.read_bytes()
    template = XYProject.from_bytes(template_data)

    print(f"Template: {TEMPLATE} ({len(template_data)} bytes)")
    print(f"Arrangement: Am | F | Dm | E  (4 bars, A minor)")
    print()

    counts = {
        "T1 Drums": len(TRACK1),
        "T2 Hats":  len(TRACK2),
        "T3 Bass":  len(TRACK3),
        "T4 Melody": len(TRACK4),
        "T7 Chords": len(TRACK7),
    }
    for name, count in counts.items():
        print(f"  {name:12s}: {count:3d} notes")
    print(f"  {'Total':12s}: {sum(counts.values()):3d} notes")
    print()

    print("Generating files:")
    print(f"  {'File':30s} {'Size':>6s}  {'Tracks':20s}  Notes  Description")
    print(f"  {'-'*30} {'-'*6}  {'-'*20}  -----  {'-'*30}")

    # Full 5-track arrangement
    generate(template, {
        1: TRACK1, 2: TRACK2,
        3: TRACK3, 4: TRACK4,
        7: TRACK7,
    }, OUTPUT_DIR / "arrange_full.xy",
             "Full 5-track, 4 bars")

    # Individual tracks for isolation testing
    generate(template, {1: TRACK1, 2: TRACK2},
             OUTPUT_DIR / "arrange_drums.xy", "Drums only (T1+T2)")

    generate(template, {3: TRACK3},
             OUTPUT_DIR / "arrange_bass.xy", "Bass only (T3)")

    generate(template, {4: TRACK4},
             OUTPUT_DIR / "arrange_melody.xy", "Melody only (T4)")

    generate(template, {7: TRACK7},
             OUTPUT_DIR / "arrange_chords.xy", "Chords only (T7)")


if __name__ == "__main__":
    main()
