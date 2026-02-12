#!/usr/bin/env python3
"""MIDI harness for OP-XY format reverse engineering.

Sends precisely-timed MIDI notes over a MIDI clock to the OP-XY while
it records, producing .xy files with known ground-truth input.

Workflow:
  1. On the OP-XY: enable MIDI channel reception for the tracks you want
     (e.g., ch 1 → Track 1, ch 2 → Track 2, ..., ch 8 → Track 8).
  2. Set the OP-XY to receive external MIDI clock (sync settings).
  3. Arm record mode on the OP-XY.
  4. Run this script — it will send Start, clock + notes, then Stop.
  5. Export the .xy project file from the device.

Requirements:
  pip install mido python-rtmidi

Usage:
  # List available MIDI ports:
  python tools/midi_harness.py --list-ports

  # Run a built-in experiment:
  python tools/midi_harness.py --port "OP-XY" --experiment single_note_all_tracks

  # Custom notes:
  python tools/midi_harness.py --port "OP-XY" --notes "1:1:60:100:1 2:5:62:80:2"
  # Format: channel:step:note:velocity:duration_steps (space-separated)
"""

from __future__ import annotations

import argparse
import sys
import time
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple

try:
    import mido
except ImportError:
    print("Missing dependency: pip install mido python-rtmidi", file=sys.stderr)
    sys.exit(1)

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

CLOCKS_PER_QUARTER = 24   # MIDI spec
CLOCKS_PER_16TH = 6       # 24 / 4
STEPS_PER_BAR = 16         # 16th-note grid


# ---------------------------------------------------------------------------
# Data model
# ---------------------------------------------------------------------------

@dataclass
class NoteEvent:
    """A single note to send during a test."""
    channel: int            # MIDI channel 0-15 (displayed as 1-16)
    step: int               # 1-based grid step (1 = beat 1, 5 = beat 2, ...)
    note: int               # MIDI note 0-127
    velocity: int = 100     # 0-127
    duration_steps: float = 1.0  # gate length in steps (1.0 = one 16th)

    def __str__(self) -> str:
        names = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
        name = f"{names[self.note % 12]}{self.note // 12 - 1}"
        return f"ch{self.channel+1}:step{self.step}:{name}:v{self.velocity}:{self.duration_steps}s"


@dataclass
class TestPlan:
    """A complete test to run on the OP-XY."""
    name: str
    description: str
    events: List[NoteEvent]
    bars: int = 1               # bars of content
    pre_roll_bars: int = 0      # empty bars before notes
    post_roll_bars: int = 0     # empty bars after notes (for release tails)


# ---------------------------------------------------------------------------
# Built-in experiments
# ---------------------------------------------------------------------------

def make_single_note_all_tracks() -> TestPlan:
    """Single C4 on step 1 for all 8 instrument tracks.

    Purpose: discover event type (0x25 vs 0x21 vs 0x2d) per track slot.
    Requires: MIDI channels 1-8 mapped to tracks 1-8 on device.
    """
    events = []
    for ch in range(8):
        events.append(NoteEvent(channel=ch, step=1, note=60, velocity=100, duration_steps=1.0))
    return TestPlan(
        name="single_note_all_tracks",
        description="Single C4 on step 1 for tracks 1-8 (channels 1-8). "
                    "Reveals event type per track slot.",
        events=events,
        bars=1,
    )


def make_single_note_per_track() -> List[TestPlan]:
    """One plan per track — record them one at a time.

    Purpose: same as all_tracks but avoids multi-track preamble interactions.
    Requires: only one MIDI channel enabled at a time.
    """
    plans = []
    for ch in range(8):
        plans.append(TestPlan(
            name=f"single_note_track{ch+1}",
            description=f"Single C4 on step 1, Track {ch+1} only (channel {ch+1}).",
            events=[NoteEvent(channel=ch, step=1, note=60, velocity=100, duration_steps=1.0)],
            bars=1,
        ))
    return plans


def make_velocity_sweep() -> TestPlan:
    """Notes at known velocities on Track 3.

    Purpose: verify velocity encoding across the range.
    Requires: MIDI channel 3 → Track 3.
    """
    velocities = [1, 32, 64, 96, 127]
    events = []
    for i, vel in enumerate(velocities):
        events.append(NoteEvent(channel=2, step=1 + i * 3, note=60, velocity=vel, duration_steps=1.0))
    return TestPlan(
        name="velocity_sweep",
        description="C4 at velocities 1/32/64/96/127 on Track 3 (ch 3), steps 1/4/7/10/13.",
        events=events,
        bars=1,
    )


def make_gate_sweep() -> TestPlan:
    """Notes with different gate lengths on Track 3.

    Purpose: verify gate encoding for known durations.
    Requires: MIDI channel 3 → Track 3.
    """
    events = [
        NoteEvent(channel=2, step=1, note=60, velocity=100, duration_steps=1.0),   # 16th
        NoteEvent(channel=2, step=5, note=62, velocity=100, duration_steps=2.0),   # 8th
        NoteEvent(channel=2, step=9, note=64, velocity=100, duration_steps=4.0),   # quarter
        NoteEvent(channel=2, step=13, note=65, velocity=100, duration_steps=8.0),  # half
    ]
    return TestPlan(
        name="gate_sweep",
        description="C4/D4/E4/F4 with 1/2/4/8 step gates on Track 3 (ch 3), steps 1/5/9/13.",
        events=events,
        bars=2,  # need 2 bars for the half-note tail
    )


def make_chromatic_scale() -> TestPlan:
    """Chromatic scale on Track 3.

    Purpose: verify note number encoding across range.
    Requires: MIDI channel 3 → Track 3.
    """
    events = []
    for i in range(16):
        events.append(NoteEvent(channel=2, step=i + 1, note=48 + i, velocity=100, duration_steps=1.0))
    return TestPlan(
        name="chromatic_scale",
        description="C3 through D#4 (notes 48-63) on all 16 steps, Track 3 (ch 3).",
        events=events,
        bars=1,
    )


def make_chord_test() -> TestPlan:
    """Simultaneous notes (chord) on Track 3.

    Purpose: see how the firmware serializes polyphonic input.
    Requires: MIDI channel 3 → Track 3.
    """
    events = [
        # C major triad on step 1
        NoteEvent(channel=2, step=1, note=60, velocity=100, duration_steps=2.0),
        NoteEvent(channel=2, step=1, note=64, velocity=100, duration_steps=2.0),
        NoteEvent(channel=2, step=1, note=67, velocity=100, duration_steps=2.0),
        # Single note on step 9 for comparison
        NoteEvent(channel=2, step=9, note=60, velocity=100, duration_steps=1.0),
    ]
    return TestPlan(
        name="chord_test",
        description="C major triad on step 1 (2-step gate) + single C4 on step 9, Track 3 (ch 3).",
        events=events,
        bars=1,
    )


def make_track2_test() -> TestPlan:
    """Single note on Track 2 only.

    Purpose: fill the Track 2 evidence gap — does it use 0x25 or 0x21?
    Requires: MIDI channel 2 → Track 2.
    """
    return TestPlan(
        name="track2_test",
        description="Single C4 on step 1, Track 2 only (ch 2). "
                    "Key experiment: Track 2 event type is unknown.",
        events=[NoteEvent(channel=1, step=1, note=60, velocity=100, duration_steps=1.0)],
        bars=1,
    )


def make_pitchbend_sweep() -> TestPlan:
    """Note + pitch bend ramp on Track 3.

    Purpose: capture pitch bend automation format.
    Requires: MIDI channel 3 → Track 3.
    Note: pitch bend messages are sent separately from notes.
    """
    events = [
        NoteEvent(channel=2, step=1, note=60, velocity=100, duration_steps=16.0),
    ]
    return TestPlan(
        name="pitchbend_sweep",
        description="Sustained C4 on Track 3 with pitch bend ramp from center to max "
                    "over 16 steps. Captures automation serialization.",
        events=events,
        bars=1,
    )


def make_selective_multi_note() -> TestPlan:
    """Non-contiguous tracks with engine changes and varied content.

    Purpose (8 unknowns in one test):
      1. Multi-note 0x25 on T1 — does device write count>1 in one event, or separate events?
      2. Chord encoding via MIDI — how are simultaneous notes serialized?
      3. Does 0x2D follow Wavetable engine? (unnamed 85/86 showed 0x2D on T3/Wavetable grid-entered)
      4. Does Drum engine on non-Drum slot (T5) produce 0x2D? (unnamed 91: T4→Drum used 0x2D)
      5. Velocity fidelity — does MIDI velocity 50 map 1:1?
      6. Non-contiguous activation — preamble behavior with gaps (T5 anomaly diagnostic)
      7. Non-step-1 tick encoding — absolute tick for step 9
      8. Gate length from MIDI hold — 4-step hold on T7

    Requires:
      - MIDI channels 1, 3, 5, 7 mapped to tracks 1, 3, 5, 7 on device
      - T3 engine changed to Wavetable (from Prism)
      - T5 engine changed to Drum (from Dissolve)
      - T1 and T7 left at defaults (Drum boop and Axis)

    Track plan:
      T1 (ch1, Drum default):     C4 step 1 + D4 step 5  — multi-note 0x25 control
      T3 (ch3, → Wavetable):      C4+E4+G4 chord step 1  — chord + 0x2D test
      T5 (ch5, → Drum):           C4 step 1 at vel 50     — 0x2D? + preamble + velocity
      T7 (ch7, Axis default):     E4 step 9, 4-step hold  — tick/gate control (0x20)
    """
    events = [
        # T1 (Drum default): two notes at different steps
        NoteEvent(channel=0, step=1, note=60, velocity=100, duration_steps=1.0),
        NoteEvent(channel=0, step=5, note=62, velocity=100, duration_steps=1.0),
        # T3 (→ Wavetable): C major triad at step 1
        NoteEvent(channel=2, step=1, note=60, velocity=100, duration_steps=1.0),
        NoteEvent(channel=2, step=1, note=64, velocity=100, duration_steps=1.0),
        NoteEvent(channel=2, step=1, note=67, velocity=100, duration_steps=1.0),
        # T5 (→ Drum): single note, low velocity
        NoteEvent(channel=4, step=1, note=60, velocity=50, duration_steps=1.0),
        # T7 (Axis default): single note at step 9 with 4-step gate
        NoteEvent(channel=6, step=9, note=64, velocity=100, duration_steps=4.0),
    ]
    return TestPlan(
        name="selective_multi_note",
        description="Non-contiguous tracks (T1/T3/T5/T7) with engine changes: "
                    "T3→Wavetable, T5→Drum, T1+T7 default. "
                    "Tests multi-note, chord, 0x2D, velocity, preamble gaps, tick/gate.",
        events=events,
        bars=1,
    )


EXPERIMENTS: Dict[str, TestPlan] = {}
_single_plans = make_single_note_per_track()
for _p in _single_plans:
    EXPERIMENTS[_p.name] = _p
EXPERIMENTS["single_note_all_tracks"] = make_single_note_all_tracks()
EXPERIMENTS["velocity_sweep"] = make_velocity_sweep()
EXPERIMENTS["gate_sweep"] = make_gate_sweep()
EXPERIMENTS["chromatic_scale"] = make_chromatic_scale()
EXPERIMENTS["chord_test"] = make_chord_test()
EXPERIMENTS["track2_test"] = make_track2_test()
EXPERIMENTS["pitchbend_sweep"] = make_pitchbend_sweep()
EXPERIMENTS["selective_multi_note"] = make_selective_multi_note()


# ---------------------------------------------------------------------------
# MIDI harness
# ---------------------------------------------------------------------------

class MidiHarness:
    """Sends timed MIDI data over a clock to the OP-XY."""

    def __init__(self, port_name: str, bpm: float = 120.0):
        self.port_name = port_name
        self.bpm = bpm
        self.port: Optional[mido.ports.BaseOutput] = None

    @property
    def clock_interval(self) -> float:
        """Seconds between MIDI clock pulses."""
        return 60.0 / (self.bpm * CLOCKS_PER_QUARTER)

    def connect(self) -> None:
        self.port = mido.open_output(self.port_name)
        print(f"Connected to: {self.port_name}")

    def close(self) -> None:
        if self.port:
            self.port.close()
            self.port = None

    def _build_schedule(self, plan: TestPlan) -> Dict[int, List[mido.Message]]:
        """Convert a TestPlan into a pulse-indexed schedule of MIDI messages."""
        pre_roll_pulses = plan.pre_roll_bars * STEPS_PER_BAR * CLOCKS_PER_16TH
        total_bars = plan.pre_roll_bars + plan.bars + plan.post_roll_bars
        total_pulses = total_bars * STEPS_PER_BAR * CLOCKS_PER_16TH

        schedule: Dict[int, List[mido.Message]] = {}

        for ev in plan.events:
            on_pulse = pre_roll_pulses + (ev.step - 1) * CLOCKS_PER_16TH
            off_pulse = on_pulse + int(ev.duration_steps * CLOCKS_PER_16TH)

            schedule.setdefault(on_pulse, []).append(
                mido.Message("note_on", channel=ev.channel,
                             note=ev.note, velocity=ev.velocity)
            )
            if off_pulse <= total_pulses:
                schedule.setdefault(off_pulse, []).append(
                    mido.Message("note_off", channel=ev.channel,
                                 note=ev.note, velocity=0)
                )

        # Special: pitch bend ramp for the pitchbend_sweep experiment
        if plan.name == "pitchbend_sweep":
            steps_total = plan.bars * STEPS_PER_BAR
            for s in range(steps_total):
                pulse = pre_roll_pulses + s * CLOCKS_PER_16TH
                # Ramp from 8192 (center) to 16383 (max) linearly
                bend = 8192 + int((s / max(steps_total - 1, 1)) * 8191)
                bend = min(bend, 16383)
                schedule.setdefault(pulse, []).append(
                    mido.Message("pitchwheel", channel=2, pitch=bend - 8192)
                )
            # Reset pitch bend at the end
            end_pulse = pre_roll_pulses + steps_total * CLOCKS_PER_16TH
            schedule.setdefault(end_pulse, []).append(
                mido.Message("pitchwheel", channel=2, pitch=0)
            )

        return schedule

    def run(self, plan: TestPlan, *, countdown: int = 3) -> None:
        """Execute a test plan: Start → clock + notes → Stop."""
        if not self.port:
            raise RuntimeError("not connected — call connect() first")

        total_bars = plan.pre_roll_bars + plan.bars + plan.post_roll_bars
        total_pulses = total_bars * STEPS_PER_BAR * CLOCKS_PER_16TH
        schedule = self._build_schedule(plan)

        # Display plan
        print(f"\n{'='*60}")
        print(f"Experiment: {plan.name}")
        print(f"  {plan.description}")
        print(f"  BPM: {self.bpm}")
        print(f"  Bars: {plan.bars} (+ {plan.pre_roll_bars} pre-roll, {plan.post_roll_bars} post-roll)")
        print(f"  Total clocks: {total_pulses}")
        print(f"  Notes:")
        for ev in plan.events:
            print(f"    {ev}")
        print(f"{'='*60}")

        # Wait for user
        print(f"\nArm record mode on OP-XY, then press Enter...")
        input()

        # Countdown
        for i in range(countdown, 0, -1):
            print(f"  {i}...")
            time.sleep(1)

        # Send Start
        print(">>> MIDI Start")
        self.port.send(mido.Message("start"))

        # Clock loop with scheduled events
        interval = self.clock_interval
        next_time = time.perf_counter()
        notes_sent = 0

        for pulse in range(total_pulses + 1):
            # Send scheduled messages at this pulse
            if pulse in schedule:
                for msg in schedule[pulse]:
                    self.port.send(msg)
                    if msg.type == "note_on":
                        notes_sent += 1
                        step = (pulse // CLOCKS_PER_16TH) + 1
                        print(f"  [pulse {pulse:4d}, step {step:2d}] {msg}")

            # Send clock
            self.port.send(mido.Message("clock"))

            # Sleep until next pulse
            next_time += interval
            sleep_for = next_time - time.perf_counter()
            if sleep_for > 0:
                time.sleep(sleep_for)

        # All notes off on all channels
        for ch in range(16):
            self.port.send(mido.Message("control_change", channel=ch,
                                        control=123, value=0))  # All Notes Off

        # Stop
        self.port.send(mido.Message("stop"))
        print(f"\n>>> MIDI Stop  ({notes_sent} note-ons sent)")
        print(f"\nDone! Export the .xy file from the OP-XY.")


# ---------------------------------------------------------------------------
# CLI helpers
# ---------------------------------------------------------------------------

def parse_note_spec(spec: str) -> NoteEvent:
    """Parse 'channel:step:note:velocity:duration' string.

    Examples:
      '1:1:60:100:1'     channel 1, step 1, C4, vel 100, 1 step
      '3:5:62:80:2.5'    channel 3, step 5, D4, vel 80, 2.5 steps
    """
    parts = spec.strip().split(":")
    if len(parts) != 5:
        raise ValueError(f"expected channel:step:note:vel:dur, got {spec!r}")
    ch, step, note, vel, dur = parts
    return NoteEvent(
        channel=int(ch) - 1,  # display 1-based, internal 0-based
        step=int(step),
        note=int(note),
        velocity=int(vel),
        duration_steps=float(dur),
    )


def list_ports() -> None:
    """Print available MIDI output ports."""
    ports = mido.get_output_names()
    if not ports:
        print("No MIDI output ports found.")
        print("Make sure the OP-XY is connected via USB.")
    else:
        print("Available MIDI output ports:")
        for p in ports:
            print(f"  {p}")


def list_experiments() -> None:
    """Print available built-in experiments."""
    print("Built-in experiments:")
    print()
    for name, plan in sorted(EXPERIMENTS.items()):
        print(f"  {name}")
        print(f"    {plan.description}")
        print()


def main() -> None:
    parser = argparse.ArgumentParser(
        description="MIDI harness for OP-XY format reverse engineering",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s --list-ports
  %(prog)s --list-experiments
  %(prog)s --port "OP-XY" --experiment single_note_all_tracks
  %(prog)s --port "OP-XY" --experiment track2_test
  %(prog)s --port "OP-XY" --notes "3:1:60:100:1 3:5:62:80:2"
  %(prog)s --port "OP-XY" --experiment velocity_sweep --bpm 100
""",
    )
    parser.add_argument("--list-ports", action="store_true",
                        help="List available MIDI output ports and exit")
    parser.add_argument("--list-experiments", action="store_true",
                        help="List built-in experiments and exit")
    parser.add_argument("--port", "-p", type=str, default=None,
                        help="MIDI output port name (use --list-ports to find it)")
    parser.add_argument("--experiment", "-e", type=str, default=None,
                        help="Built-in experiment name (use --list-experiments)")
    parser.add_argument("--notes", "-n", type=str, default=None,
                        help="Custom notes: 'ch:step:note:vel:dur' space-separated")
    parser.add_argument("--bpm", type=float, default=120.0,
                        help="Tempo in BPM (default: 120, should match project)")
    parser.add_argument("--bars", type=int, default=None,
                        help="Override number of bars (default: from experiment)")
    parser.add_argument("--pre-roll", type=int, default=0,
                        help="Empty bars before notes start (default: 0)")
    parser.add_argument("--post-roll", type=int, default=1,
                        help="Empty bars after notes end (default: 1)")
    parser.add_argument("--no-countdown", action="store_true",
                        help="Skip the 3-second countdown")

    args = parser.parse_args()

    if args.list_ports:
        list_ports()
        return

    if args.list_experiments:
        list_experiments()
        return

    if not args.port:
        parser.error("--port is required (use --list-ports to find your device)")

    # Build the plan
    if args.experiment and args.notes:
        parser.error("use --experiment or --notes, not both")

    if args.experiment:
        if args.experiment not in EXPERIMENTS:
            parser.error(f"unknown experiment {args.experiment!r}. "
                         f"Use --list-experiments to see options.")
        plan = EXPERIMENTS[args.experiment]
    elif args.notes:
        events = [parse_note_spec(s) for s in args.notes.split()]
        plan = TestPlan(
            name="custom",
            description=f"{len(events)} custom notes",
            events=events,
            bars=args.bars or 1,
        )
    else:
        parser.error("specify --experiment or --notes")

    # Apply overrides
    if args.bars is not None:
        plan.bars = args.bars
    plan.pre_roll_bars = args.pre_roll
    plan.post_roll_bars = args.post_roll

    # Run
    harness = MidiHarness(args.port, bpm=args.bpm)
    try:
        harness.connect()
        harness.run(plan, countdown=0 if args.no_countdown else 3)
    except KeyboardInterrupt:
        print("\nInterrupted — sending All Notes Off + Stop")
        if harness.port:
            for ch in range(16):
                harness.port.send(mido.Message("control_change", channel=ch,
                                               control=123, value=0))
            harness.port.send(mido.Message("stop"))
    finally:
        harness.close()


if __name__ == "__main__":
    main()
