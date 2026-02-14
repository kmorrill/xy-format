#!/usr/bin/env python3
"""Interactive MIDI harness for 9-pattern × 8-track capture.

Fires one note per track (channels 1-8) for each pattern round.
Uses a unique MIDI note per pattern so we can identify them in the binary.

Workflow:
  1. On the OP-XY: create a new project
  2. Add 8 patterns to EVERY track (T1-T8), so each has 9 patterns (A-I)
  3. Set MIDI channels 1-8 mapped to tracks 1-8
  4. Set OP-XY to receive external MIDI clock
  5. Run this script
  6. For each round: navigate all tracks to the indicated pattern,
     arm record, press Enter — the script fires 8 notes and stops
  7. After all 9 rounds, export the .xy file

Requirements:
  pip install mido python-rtmidi

Usage:
  python tools/capture_9pat.py --port "OP-XY"
  python tools/capture_9pat.py --list-ports
"""

from __future__ import annotations

import argparse
import sys
import time

try:
    import mido
except ImportError:
    print("Missing dependency: pip install mido python-rtmidi", file=sys.stderr)
    sys.exit(1)

CLOCKS_PER_16TH = 6
STEPS_PER_BAR = 16

# Unique note per pattern for identification in the binary.
# All in the valid drum range (48-71) so they work on T1/T2 drum tracks
# AND on T3-T8 synth tracks.
PATTERN_NOTES = {
    1: 48,   # C3  — kick slot on drums
    2: 50,   # D3  — snare slot
    3: 52,   # E3  — rim
    4: 53,   # F3  — clap
    5: 55,   # G3
    6: 57,   # A3
    7: 59,   # B3
    8: 60,   # C4
    9: 62,   # D4
}

PATTERN_NAMES = "ABCDEFGHI"

VELOCITY = 100  # safe: won't collide with any of the note values above


def fire_round(port: mido.ports.BaseOutput, pattern_num: int, bpm: float) -> None:
    """Send MIDI Start, clock 1 bar with 8 notes at step 1, then Stop."""
    note = PATTERN_NOTES[pattern_num]
    interval = 60.0 / (bpm * 24)  # seconds per MIDI clock pulse
    total_pulses = STEPS_PER_BAR * CLOCKS_PER_16TH  # 96 pulses = 1 bar

    # Start
    port.send(mido.Message("start"))

    next_time = time.perf_counter()
    for pulse in range(total_pulses + 1):
        # Fire notes on pulse 0 (step 1)
        if pulse == 0:
            for ch in range(8):
                port.send(mido.Message(
                    "note_on", channel=ch, note=note, velocity=VELOCITY
                ))

        # Note off after 1 step (6 pulses)
        if pulse == CLOCKS_PER_16TH:
            for ch in range(8):
                port.send(mido.Message(
                    "note_off", channel=ch, note=note, velocity=0
                ))

        # Clock
        port.send(mido.Message("clock"))

        next_time += interval
        sleep_for = next_time - time.perf_counter()
        if sleep_for > 0:
            time.sleep(sleep_for)

    # All notes off + stop
    for ch in range(16):
        port.send(mido.Message("control_change", channel=ch, control=123, value=0))
    port.send(mido.Message("stop"))


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Interactive 9-pattern × 8-track MIDI capture harness"
    )
    parser.add_argument("--list-ports", action="store_true",
                        help="List MIDI ports and exit")
    parser.add_argument("--port", "-p", type=str,
                        help="MIDI output port name")
    parser.add_argument("--bpm", type=float, default=120.0,
                        help="Tempo (default 120, must match project)")
    parser.add_argument("--start", type=int, default=1,
                        help="Start from pattern N (1-9, for resuming)")
    args = parser.parse_args()

    if args.list_ports:
        for p in mido.get_output_names():
            print(f"  {p}")
        return

    if not args.port:
        parser.error("--port required (use --list-ports)")

    port = mido.open_output(args.port)
    print(f"Connected to: {args.port}")
    print()
    print("=" * 60)
    print("9-PATTERN × 8-TRACK CAPTURE")
    print("=" * 60)
    print()
    print("Each round fires 1 note on channels 1-8 (all tracks) at step 1.")
    print("Different MIDI note per pattern for identification:")
    print()
    for pn, note in PATTERN_NOTES.items():
        names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
        name = f"{names[note % 12]}{note // 12 - 1}"
        print(f"  Pattern {PATTERN_NAMES[pn-1]} (P{pn}): MIDI note {note} ({name})")
    print()
    print(f"Velocity: {VELOCITY} for all notes")
    print(f"BPM: {args.bpm}")
    print()

    try:
        for pn in range(args.start, 10):
            letter = PATTERN_NAMES[pn - 1]
            note = PATTERN_NOTES[pn]
            names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
            note_name = f"{names[note % 12]}{note // 12 - 1}"

            print("-" * 60)
            print(f"ROUND {pn}/9 — Pattern {letter}")
            print(f"  Note: {note} ({note_name}), Velocity: {VELOCITY}")
            print()
            print(f"  1. Select Pattern {letter} on ALL tracks (T1-T8)")
            print(f"  2. Arm record mode on the OP-XY")
            input(f"  3. Press ENTER to fire → ")

            print(f"  >>> Firing 8 notes (note={note}) ...")
            fire_round(port, pn, args.bpm)
            print(f"  >>> Done! Stop recording on device.")
            print()

        print("=" * 60)
        print("ALL 9 ROUNDS COMPLETE!")
        print("Export the .xy file from the OP-XY.")
        print("=" * 60)

    except KeyboardInterrupt:
        print("\nAborted — sending All Notes Off + Stop")
        for ch in range(16):
            port.send(mido.Message("control_change", channel=ch, control=123, value=0))
        port.send(mido.Message("stop"))
    finally:
        port.close()


if __name__ == "__main__":
    main()
