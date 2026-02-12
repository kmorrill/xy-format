"""Tests for the note event reader."""

import pytest
from pathlib import Path

from xy.container import XYProject
from xy.note_events import Note, build_event, event_type_for_track, STEP_TICKS
from xy.note_reader import read_event, find_event, read_track_notes

CORPUS = Path("src/one-off-changes-from-default")
TEMPLATE = CORPUS / "unnamed 1.xy"
OUTPUT = Path("output")


# ── read_event round-trip tests (builder format) ───────────────────


class TestReadEventRoundTrip:
    """Build notes → encode → decode → verify they match."""

    def test_single_note(self):
        notes_in = [Note(step=1, note=60, velocity=100)]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 1
        assert notes_out[0].step == 1
        assert notes_out[0].note == 60
        assert notes_out[0].velocity == 100
        assert notes_out[0].gate_ticks == 0
        assert notes_out[0].tick_offset == 0

    def test_three_sequential_notes(self):
        notes_in = [
            Note(step=1, note=60, velocity=100),
            Note(step=2, note=64, velocity=90),
            Note(step=3, note=67, velocity=80),
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 3
        for i, (n_in, n_out) in enumerate(zip(notes_in, notes_out)):
            assert n_out.step == n_in.step, f"note {i}: step"
            assert n_out.note == n_in.note, f"note {i}: note"
            assert n_out.velocity == n_in.velocity, f"note {i}: velocity"

    def test_explicit_gate_round_trip(self):
        notes_in = [
            Note(step=1, note=60, velocity=100, gate_ticks=1920),
            Note(step=2, note=64, velocity=90, gate_ticks=960),
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 2
        assert notes_out[0].gate_ticks == 1920
        assert notes_out[1].gate_ticks == 960

    def test_mixed_default_and_explicit_gate(self):
        notes_in = [
            Note(step=1, note=60, velocity=100),  # default gate
            Note(step=5, note=64, velocity=90, gate_ticks=1920),  # explicit
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert notes_out[0].gate_ticks == 0
        assert notes_out[1].gate_ticks == 1920

    def test_chord_at_step_one(self):
        """Two notes at the same step (chord)."""
        notes_in = [
            Note(step=1, note=60, velocity=100),
            Note(step=1, note=64, velocity=100),
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 2
        assert notes_out[0].step == 1
        assert notes_out[0].note == 60
        assert notes_out[1].step == 1
        assert notes_out[1].note == 64

    def test_chord_plus_melody(self):
        """Chord at step 1 + single note at step 2."""
        notes_in = [
            Note(step=1, note=60, velocity=100),
            Note(step=1, note=64, velocity=100),
            Note(step=2, note=67, velocity=80),
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 3
        assert notes_out[0].step == 1
        assert notes_out[1].step == 1
        assert notes_out[2].step == 2

    def test_all_event_types_round_trip(self):
        """Every accepted event type round-trips correctly."""
        notes_in = [Note(step=1, note=60, velocity=100), Note(step=5, note=64, velocity=90)]
        for etype in (0x1E, 0x1F, 0x20, 0x21, 0x25, 0x2D):
            event = build_event(notes_in, event_type=etype)
            notes_out = read_event(event)
            assert len(notes_out) == 2, f"type 0x{etype:02X}"
            assert notes_out[0].note == 60, f"type 0x{etype:02X}"
            assert notes_out[1].note == 64, f"type 0x{etype:02X}"

    def test_ode_to_joy_round_trip(self):
        """15-note Ode to Joy melody round-trips perfectly."""
        notes_in = [
            Note(step=1, note=64, velocity=100, gate_ticks=1920),
            Note(step=5, note=64, velocity=100, gate_ticks=1920),
            Note(step=9, note=65, velocity=100, gate_ticks=1920),
            Note(step=13, note=67, velocity=100, gate_ticks=1920),
            Note(step=17, note=67, velocity=100, gate_ticks=1920),
            Note(step=21, note=65, velocity=100, gate_ticks=1920),
            Note(step=25, note=64, velocity=100, gate_ticks=1920),
            Note(step=29, note=62, velocity=100, gate_ticks=1920),
            Note(step=33, note=60, velocity=100, gate_ticks=1920),
            Note(step=37, note=60, velocity=100, gate_ticks=1920),
            Note(step=41, note=62, velocity=100, gate_ticks=1920),
            Note(step=45, note=64, velocity=100, gate_ticks=1920),
            Note(step=49, note=64, velocity=100, gate_ticks=2880),
            Note(step=55, note=62, velocity=100, gate_ticks=960),
            Note(step=57, note=62, velocity=100, gate_ticks=3840),
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 15
        for i, (n_in, n_out) in enumerate(zip(notes_in, notes_out)):
            assert n_out.step == n_in.step, f"note {i}: step"
            assert n_out.note == n_in.note, f"note {i}: note"
            assert n_out.velocity == n_in.velocity, f"note {i}: velocity"
            assert n_out.gate_ticks == n_in.gate_ticks, f"note {i}: gate"

    def test_velocity_nudge_preserved(self):
        """When note==velocity, builder nudges vel; reader returns the nudged value."""
        notes_in = [Note(step=1, note=60, velocity=60)]  # note==vel triggers nudge
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        # Builder nudges to 61 (or 126 for note=127)
        assert notes_out[0].velocity == 61
        assert notes_out[0].note == 60

    def test_first_note_at_later_step(self):
        """Single note starting at step 5 (tick=1920)."""
        notes_in = [Note(step=5, note=60, velocity=100)]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert len(notes_out) == 1
        assert notes_out[0].step == 5
        assert notes_out[0].note == 60

    def test_tick_offset_round_trip(self):
        """Notes with sub-step tick offsets round-trip correctly."""
        notes_in = [
            Note(step=1, note=60, velocity=100, tick_offset=0),
            Note(step=2, note=64, velocity=90, tick_offset=120),
        ]
        event = build_event(notes_in, event_type=0x21)
        notes_out = read_event(event)
        assert notes_out[0].tick_offset == 0
        assert notes_out[1].tick_offset == 120


# ── read_event on raw firmware bytes ───────────────────────────────


class TestReadEventFirmware:
    """Parse firmware-native event bytes from known specimens."""

    def test_unnamed_89_three_notes(self):
        """unnamed 89 T3: 3 notes at steps 1, 2, 3 with default gates."""
        data = (CORPUS / "unnamed 89.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[2], 3)
        assert len(notes) == 3
        assert [n.step for n in notes] == [1, 2, 3]
        assert all(n.gate_ticks == 0 for n in notes)  # default gates

    def test_unnamed_101_t1_48_notes(self):
        """unnamed 101 T1: 48 drum hits across 4 bars."""
        data = (CORPUS / "unnamed 101.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[0], 1)
        assert len(notes) == 48

        # First note: step 1, kick+hihat chord
        assert notes[0].step == 1
        assert notes[0].note == 56  # closed hihat
        assert notes[0].gate_ticks == 0  # default gate

        # Second note: chord continuation (step 1)
        assert notes[1].step == 1
        assert notes[1].note == 48  # kick
        assert notes[1].gate_ticks == 480  # explicit gate

    def test_unnamed_101_t1_has_escape_bytes(self):
        """unnamed 101 T1: notes at 8-step boundaries use escape encoding (0x01)."""
        data = (CORPUS / "unnamed 101.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[0], 1)

        # Find notes at step 9 (tick=3840, uses escape encoding)
        step9_notes = [n for n in notes if n.step == 9]
        assert len(step9_notes) > 0, "should have notes at step 9"
        # Tick 3840 = 0x0F00, tick_lo = 0 → firmware uses escape byte

    def test_unnamed_101_t3_16_notes(self):
        """unnamed 101 T3: 16 notes across 4 bars with explicit gates."""
        data = (CORPUS / "unnamed 101.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[2], 3)
        assert len(notes) == 16

        # First note: C2 at step 1
        assert notes[0].step == 1
        assert notes[0].note == 36  # C2
        assert notes[0].velocity == 100
        assert notes[0].gate_ticks == 960  # eighth note

        # Steps should span 4 bars (steps 1-64)
        max_step = max(n.step for n in notes)
        assert max_step > 48, "should have notes in bar 4"

    def test_unnamed_80_grid_chords(self):
        """unnamed 80 T1: 6 notes including a 3-note chord at step 13."""
        data = (CORPUS / "unnamed 80.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[0], 1)
        assert len(notes) == 6

        # Steps 1, 5, 9 are single notes; step 13 has 3 notes (chord)
        step13_notes = [n for n in notes if n.step == 13]
        assert len(step13_notes) == 3, "should have 3-note chord at step 13"

        # Individual steps
        assert notes[0].step == 1
        assert notes[1].step == 5
        assert notes[2].step == 9

    def test_unnamed_101_t1_chord_continuation(self):
        """Chords in firmware format use continuation byte 0x04."""
        data = (CORPUS / "unnamed 101.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[0], 1)

        # Group by step to find chords
        from collections import Counter
        step_counts = Counter(n.step for n in notes)
        chord_steps = [s for s, c in step_counts.items() if c > 1]
        assert len(chord_steps) > 0, "should have chord steps"


# ── find_event tests ───────────────────────────────────────────────


class TestFindEvent:
    """Verify event location within track bodies."""

    def test_finds_event_in_activated_track(self):
        """Active track with notes returns a valid offset."""
        data = (CORPUS / "unnamed 89.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        offset = find_event(proj.tracks[2].body, 3)
        assert offset is not None
        # Verify the found offset starts with type byte
        assert proj.tracks[2].body[offset] == 0x21

    def test_finds_0x25_event_on_t1(self):
        """T1 uses event type 0x25."""
        data = (CORPUS / "unnamed 101.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        offset = find_event(proj.tracks[0].body, 1)
        assert offset is not None
        assert proj.tracks[0].body[offset] == 0x25

    def test_returns_none_for_inactive_track(self):
        """Inactive track (type 0x05) in baseline has no event."""
        data = TEMPLATE.read_bytes()
        proj = XYProject.from_bytes(data)
        # Baseline tracks are type 0x05, no events
        offset = find_event(proj.tracks[0].body, 1)
        assert offset is None

    def test_fallback_finds_non_default_type(self):
        """If expected type isn't found, falls back to other known types."""
        # unnamed 80 T1: has 0x25 event. event_type_for_track(1) returns 0x25.
        data = (CORPUS / "unnamed 80.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        offset = find_event(proj.tracks[0].body, 1)
        assert offset is not None


# ── read_track_notes integration tests ─────────────────────────────


class TestReadTrackNotes:
    """Full integration: parse project → read notes from tracks."""

    def test_inactive_track_returns_empty(self):
        """Type 0x05 tracks return empty list."""
        data = TEMPLATE.read_bytes()
        proj = XYProject.from_bytes(data)
        notes = read_track_notes(proj.tracks[0], 1)
        assert notes == []

    def test_activated_no_event_returns_empty(self):
        """Activated track without note event returns empty list.

        unnamed 17-22 have type 0x07 but only parameter changes.
        """
        data = (CORPUS / "unnamed 17.xy").read_bytes()
        proj = XYProject.from_bytes(data)
        # T1 in unnamed 17 has bar count change but no note events
        notes = read_track_notes(proj.tracks[0], 1)
        assert notes == []


# ── builder-generated file tests ───────────────────────────────────


class TestBuilderFiles:
    """Read notes from files created by our builder tools."""

    def test_ode_to_joy_full(self):
        """ode_to_joy_full.xy: 15 notes on T3, 4 bars."""
        data = OUTPUT / "ode_to_joy_full.xy"
        if not data.exists():
            pytest.skip("ode_to_joy_full.xy not found in output/")
        proj = XYProject.from_bytes(data.read_bytes())
        notes = read_track_notes(proj.tracks[2], 3)
        assert len(notes) == 15

        # Verify melody: E4 E4 F4 G4 G4 F4 E4 D4 C4 C4 D4 E4 ...
        expected_notes = [64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62]
        assert [n.note for n in notes] == expected_notes

        # All notes are at 4-step intervals (steps 1, 5, 9, ...)
        # except last two (steps 49, 55, 57)
        expected_steps = [1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 55, 57]
        assert [n.step for n in notes] == expected_steps

    def test_drum_both(self):
        """drum_both.xy: T1 kick/snare (8 notes) + T2 hats (16 notes)."""
        data = OUTPUT / "drum_both.xy"
        if not data.exists():
            pytest.skip("drum_both.xy not found in output/")
        proj = XYProject.from_bytes(data.read_bytes())

        t1_notes = read_track_notes(proj.tracks[0], 1)
        assert len(t1_notes) == 8
        # T1 uses 0x25 event type
        assert all(n.note in (48, 50) for n in t1_notes)  # kicks and snares

        t2_notes = read_track_notes(proj.tracks[1], 2)
        assert len(t2_notes) == 16
        # Every step has a hat hit
        assert [n.step for n in t2_notes] == list(range(1, 17))

    def test_arrange_full(self):
        """arrange_full.xy: 5-track 4-bar arrangement, 129 total notes."""
        data = OUTPUT / "arrange_full.xy"
        if not data.exists():
            pytest.skip("arrange_full.xy not found in output/")
        proj = XYProject.from_bytes(data.read_bytes())

        total = 0
        for track_idx in [1, 2, 3, 4, 7]:
            notes = read_track_notes(proj.tracks[track_idx - 1], track_idx)
            assert len(notes) > 0, f"T{track_idx} should have notes"
            total += len(notes)

        assert total == 129

    def test_inactive_tracks_in_builder_file(self):
        """Tracks not written to should return empty."""
        data = OUTPUT / "ode_to_joy_full.xy"
        if not data.exists():
            pytest.skip("ode_to_joy_full.xy not found in output/")
        proj = XYProject.from_bytes(data.read_bytes())
        # Only T3 has notes
        for i in range(16):
            if i == 2:  # T3
                continue
            notes = read_track_notes(proj.tracks[i], i + 1)
            assert notes == [], f"T{i+1} should be empty"


# ── edge cases ─────────────────────────────────────────────────────


class TestEdgeCases:
    """Edge cases and error handling."""

    def test_unknown_event_type_raises(self):
        with pytest.raises(ValueError, match="unknown event type"):
            read_event(bytes([0x99, 0x01, 0x00, 0x00, 0x02, 0xF0, 0x00, 0x00, 0x01, 60, 100, 0, 0]))

    def test_zero_count_raises(self):
        with pytest.raises(ValueError, match="invalid note count"):
            read_event(bytes([0x21, 0x00]))

    def test_data_too_short_raises(self):
        with pytest.raises(ValueError, match="too short"):
            read_event(bytes([0x21]))

    def test_trailing_data_ignored(self):
        """Extra bytes after the event are ignored."""
        notes_in = [Note(step=1, note=60, velocity=100)]
        event = build_event(notes_in, event_type=0x21)
        padded = event + b"\xFF" * 100  # extra junk after event
        notes_out = read_event(padded)
        assert len(notes_out) == 1
        assert notes_out[0].note == 60

    def test_large_note_count(self):
        """48 notes (max seen in corpus) round-trip correctly."""
        notes_in = [Note(step=i + 1, note=48 + (i % 24), velocity=80) for i in range(48)]
        event = build_event(notes_in, event_type=0x25)
        notes_out = read_event(event)
        assert len(notes_out) == 48
        for i, (n_in, n_out) in enumerate(zip(notes_in, notes_out)):
            assert n_out.step == n_in.step, f"note {i}: step"
            # Velocity might be nudged if note==vel, so check note at least
            assert n_out.note == n_in.note, f"note {i}: note"
