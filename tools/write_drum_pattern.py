#!/usr/bin/env python3
"""Generate a two-track drum pattern .xy file.

Uses the pure-append 0x21 recipe on Track 1 (kick/snare) and Track 2
(hats/percussion) of the default "unnamed 1.xy" template.

Drum kit mapping (24 keys, C3=48 through B4=71):
  Track 1 "boop" kit / Track 2 "phase" kit share the same layout:
    48  C3   kick a          56  G#3  closed hat a
    49  C#3  kick b          57  A3   closed hat b
    50  D3   snare a         58  A#3  open hat
    51  D#3  snare b         59  B3   clave
    52  E3   rim             60  C4   low tom
    53  F3   clap            61  C#4  ride
    54  F#3  tambourine      62  D4   mid tom
    55  G3   shaker          63  D#4  crash

Usage:
    python tools/write_drum_pattern.py [output_path]
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from xy.container import XYProject
from xy.note_events import Note
from xy.project_builder import append_notes_to_tracks

# ── Drum note constants ──────────────────────────────────────────────
KICK_A = 48
KICK_B = 49
SNARE_A = 50
SNARE_B = 51
RIM = 52
CLAP = 53
TAMB = 54
SHAKER = 55
CH_A = 56  # closed hat a
CH_B = 57  # closed hat b
OH = 58  # open hat
CLAVE = 59
LO_TOM = 60
RIDE = 61
MID_TOM = 62
CRASH = 63
HI_TOM = 64

# ── Pattern definitions ──────────────────────────────────────────────
# Steps are 1-based (1-16 = one bar of 16th notes).
# Each track gets ONE sound per step to stay within proven territory.

# Track 1: Kick + Snare — punchy syncopated groove
TRACK1_NOTES = [
    # Kicks — four-on-the-floor backbone with a ghost and pickup
    Note(step=1, note=KICK_A, velocity=120),
    Note(step=3, note=KICK_A, velocity=65),  # ghost kick
    Note(step=5, note=SNARE_A, velocity=110),
    Note(step=7, note=KICK_A, velocity=100),
    Note(step=9, note=KICK_A, velocity=120),
    Note(step=11, note=KICK_A, velocity=70),  # ghost kick
    Note(step=13, note=SNARE_A, velocity=115),
    Note(step=15, note=KICK_A, velocity=90),  # pickup into next bar
]

# Track 2: Hats + Percussion — full 16th hat pattern with dynamics + accents
TRACK2_NOTES = [
    Note(step=1, note=CH_A, velocity=100),
    Note(step=2, note=CH_A, velocity=55),
    Note(step=3, note=CH_A, velocity=80),
    Note(step=4, note=CH_A, velocity=45),
    Note(step=5, note=OH, velocity=90),  # open hat on snare hit
    Note(step=6, note=CH_A, velocity=50),
    Note(step=7, note=CH_A, velocity=85),
    Note(step=8, note=CH_A, velocity=40),
    Note(step=9, note=CH_A, velocity=100),
    Note(step=10, note=CH_A, velocity=50),
    Note(step=11, note=RIM, velocity=75),  # rimshot accent
    Note(step=12, note=CH_A, velocity=45),
    Note(step=13, note=OH, velocity=95),  # open hat on snare hit
    Note(step=14, note=CH_A, velocity=55),
    Note(step=15, note=CH_A, velocity=80),
    Note(step=16, note=CH_A, velocity=60),
]


def main() -> None:
    template_path = Path("src/one-off-changes-from-default/unnamed 1.xy")
    output_path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("output/drum_pattern.xy")

    output_path.parent.mkdir(parents=True, exist_ok=True)

    data = template_path.read_bytes()
    project = XYProject.from_bytes(data)

    # Apply notes to both tracks atomically (correct preamble handling)
    project = append_notes_to_tracks(project, {
        1: TRACK1_NOTES,
        2: TRACK2_NOTES,
    })

    result = project.to_bytes()
    output_path.write_bytes(result)

    # Summary
    delta = len(result) - len(data)
    print(f"Template:  {template_path} ({len(data)} bytes)")
    print(f"Output:    {output_path} ({len(result)} bytes, {delta:+d})")
    print(f"Track 1:   {len(TRACK1_NOTES)} notes (kick + snare)")
    print(f"Track 2:   {len(TRACK2_NOTES)} notes (hats + percussion)")
    print()

    # Verify round-trip integrity of non-modified tracks
    orig = XYProject.from_bytes(data)
    out = XYProject.from_bytes(result)
    print("Verification:")
    print(f"  Pre-track region:  {'OK' if out.pre_track == orig.pre_track else 'CHANGED'}")
    for i in range(16):
        if i in (0, 1):
            # These tracks were modified
            ot = orig.tracks[i]
            nt = out.tracks[i]
            print(f"  Track {i+1:2d}: type 0x{ot.type_byte:02X}->0x{nt.type_byte:02X}, "
                  f"body {len(ot.body)}->{len(nt.body)}B ({len(nt.body)-len(ot.body):+d})")
        elif i in (1, 2):
            # Next-track preamble may have changed
            if out.tracks[i].preamble != orig.tracks[i].preamble:
                print(f"  Track {i+1:2d}: preamble updated (byte0=0x{out.tracks[i].preamble[0]:02X})")
            elif out.tracks[i].body != orig.tracks[i].body:
                print(f"  Track {i+1:2d}: body changed unexpectedly!")
            else:
                print(f"  Track {i+1:2d}: unchanged")
        else:
            ok = out.tracks[i].body == orig.tracks[i].body
            print(f"  Track {i+1:2d}: {'OK' if ok else 'CHANGED!'}")


if __name__ == "__main__":
    main()
