"""Tests for the note event builder and project_builder append recipe."""

import pytest
from pathlib import Path

from xy.container import XYProject
from xy.note_events import Note, build_0x21_event, build_event, event_type_for_track, STEP_TICKS
from xy.project_builder import append_notes_to_track, append_notes_to_tracks, _activate_body

CORPUS = Path("src/one-off-changes-from-default")
TEMPLATE = CORPUS / "unnamed 1.xy"


# ── build_0x21_event unit tests ──────────────────────────────────────


class TestBuild0x21Event:
    """Verify the raw event encoding against device-captured specimens."""

    def test_single_note_at_tick_zero(self):
        """One note at step 1 (tick=0)."""
        blob = build_0x21_event([Note(step=1, note=60, velocity=100)])
        assert blob[0] == 0x21  # type
        assert blob[1] == 0x01  # count
        # tick=0 as u16 LE
        assert blob[2:4] == b"\x00\x00"
        # flag=0x02
        assert blob[4] == 0x02
        # gate constant
        assert blob[5:9] == b"\xF0\x00\x00\x01"
        # note, velocity
        assert blob[9] == 60
        assert blob[10] == 100
        # last note trailing = 2 bytes
        assert blob[11:13] == b"\x00\x00"
        assert len(blob) == 13  # header(2) + 12-1 for single=last

    def test_three_notes_matches_unnamed89_structure(self):
        """Three notes matching the structure of unnamed 89.xy."""
        # unnamed 89 has: F?(5), E?(0x7C=124), C4(60) at steps 1, 2, 3
        notes = [
            Note(step=1, note=5, velocity=100),
            Note(step=2, note=0x7C, velocity=100),
            Note(step=3, note=0x3C, velocity=100),
        ]
        blob = build_0x21_event(notes)

        # Verify against the known bytes from unnamed 89
        expected = bytes.fromhex(
            "21 03"  # header
            "00 00 02 F0 00 00 01 05 64 00 00 00"  # note 1 (12B)
            "E0 01 00 00 00 F0 00 00 01 7C 64 00 00 00"  # note 2 (14B)
            "C0 03 00 00 00 F0 00 00 01 3C 64 00 00"  # note 3 (13B)
        )
        assert blob == expected

    def test_four_notes_matches_ode_to_joy_structure(self):
        """Four notes matching ode_to_joy_v2.xy (E4,E4,F4,G4 at quarter spacing)."""
        notes = [
            Note(step=1, note=0x40, velocity=100),  # E4
            Note(step=5, note=0x40, velocity=100),  # E4
            Note(step=9, note=0x41, velocity=100),  # F4
            Note(step=13, note=0x43, velocity=100),  # G4
        ]
        blob = build_0x21_event(notes)

        expected = bytes.fromhex(
            "21 04"
            "00 00 02 F0 00 00 01 40 64 00 00 00"  # note 1: tick=0
            "80 07 00 00 00 F0 00 00 01 40 64 00 00 00"  # note 2: tick=1920
            "00 0F 00 00 00 F0 00 00 01 41 64 00 00 00"  # note 3: tick=3840
            "80 16 00 00 00 F0 00 00 01 43 64 00 00"  # note 4: tick=5760
        )
        assert blob == expected

    def test_notes_are_sorted_by_tick(self):
        """Notes provided out of order get sorted."""
        notes = [
            Note(step=9, note=64, velocity=100),
            Note(step=1, note=60, velocity=100),
        ]
        blob = build_0x21_event(notes)
        assert blob[0:2] == bytes([0x21, 0x02])
        # First note should be step 1 (tick=0) -> note 60
        assert blob[9] == 60
        # Second note should be step 9 (tick=3840) -> note 64

    def test_empty_raises(self):
        with pytest.raises(ValueError):
            build_0x21_event([])

    def test_single_note_at_later_step(self):
        """One note at step 9 (tick=3840). First note with tick>0."""
        blob = build_0x21_event([Note(step=9, note=60, velocity=100)])
        assert blob[0:2] == bytes([0x21, 0x01])
        # tick=3840 as u32 LE (not u16, because tick > 0)
        assert blob[2:6] == (3840).to_bytes(4, "little")
        # flag=0x00 (tick > 0)
        assert blob[6] == 0x00

    def test_velocity_encoding(self):
        """Various velocity values are preserved."""
        for vel in [1, 40, 64, 100, 127]:
            blob = build_0x21_event([Note(step=1, note=60, velocity=vel)])
            assert blob[10] == vel


# ── _activate_body tests ─────────────────────────────────────────────


class TestActivateBody:
    """Test the type-byte flip and padding removal."""

    def test_type05_gets_activated(self):
        template = TEMPLATE.read_bytes()
        proj = XYProject.from_bytes(template)
        body = proj.tracks[0].body  # Track 1, type 0x05
        assert body[9] == 0x05
        activated = _activate_body(body)
        assert activated[9] == 0x07
        assert len(activated) == len(body) - 2

    def test_type07_stays_same(self):
        """Already-activated body passes through unchanged."""
        template = TEMPLATE.read_bytes()
        proj = XYProject.from_bytes(template)
        body = proj.tracks[0].body
        activated = _activate_body(body)
        # Activate again
        double = _activate_body(bytes(activated))
        assert double == activated

    def test_activate_matches_unnamed89_track3(self):
        """Activating baseline Track 3 should match unnamed 89 Track 3 body prefix."""
        baseline = XYProject.from_bytes(TEMPLATE.read_bytes())
        specimen = XYProject.from_bytes(
            (CORPUS / "unnamed 89.xy").read_bytes()
        )
        activated = _activate_body(baseline.tracks[2].body)
        # The activated body (without appended notes) should match
        # unnamed 89 Track 3 body up to where the 0x21 event starts
        event_start = specimen.tracks[2].body.index(0x21, 400)
        assert bytes(activated) == specimen.tracks[2].body[:event_start]


# ── append_notes_to_track integration tests ──────────────────────────


class TestAppendNotesToTrack:
    """End-to-end tests for the pure-append recipe."""

    def test_reproduces_ode_to_joy_v2(self):
        """Generating the same 4 notes on Track 3 should match ode_to_joy_v2.xy."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)

        notes = [
            Note(step=1, note=0x40, velocity=100),
            Note(step=5, note=0x40, velocity=100),
            Note(step=9, note=0x41, velocity=100),
            Note(step=13, note=0x43, velocity=100),
        ]
        result = append_notes_to_track(project, track_index=3, notes=notes)
        result_bytes = result.to_bytes()

        reference = Path("output/ode_to_joy_v2.xy").read_bytes()
        assert result_bytes == reference

    def test_unnamed89_track3_body_matches(self):
        """The 0x21 event appended to Track 3 should match unnamed 89's Track 3 tail.

        unnamed 89 has header/handle-table differences from the baseline
        (the device rewrote those during save), so we compare only the
        Track 3 body — specifically the activated prefix + appended event.
        """
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)

        notes = [
            Note(step=1, note=5, velocity=100),
            Note(step=2, note=0x7C, velocity=100),
            Note(step=3, note=0x3C, velocity=100),
        ]
        result = append_notes_to_track(project, track_index=3, notes=notes)

        # Load the device-authored reference
        ref = XYProject.from_bytes((CORPUS / "unnamed 89.xy").read_bytes())
        ref_body = ref.tracks[2].body

        # Our generated Track 3 body should match exactly
        gen_body = result.tracks[2].body
        assert gen_body == ref_body

    def test_preamble_update(self):
        """Next track's preamble byte 0 should become 0x64."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)
        original_preamble = project.tracks[1].preamble[0]

        result = append_notes_to_track(
            project, track_index=1, notes=[Note(step=1, note=48, velocity=100)]
        )
        assert result.tracks[1].preamble[0] == 0x64
        assert original_preamble != 0x64  # sanity: it was different before

    def test_non_target_tracks_unchanged(self):
        """Tracks other than target and target+1 remain byte-identical."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)
        result = append_notes_to_track(
            project, track_index=3, notes=[Note(step=1, note=60, velocity=100)]
        )
        for i in range(16):
            if i == 2:  # Track 3 (modified)
                continue
            if i == 3:  # Track 4 (preamble updated)
                assert result.tracks[i].body == project.tracks[i].body
                continue
            assert result.tracks[i].preamble == project.tracks[i].preamble
            assert result.tracks[i].body == project.tracks[i].body

    def test_two_adjacent_tracks_preamble_rule(self):
        """Adjacent activated tracks: 0x64 on every track after an activated one (unnamed 93)."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)

        result = append_notes_to_tracks(project, {
            1: [Note(step=1, note=48, velocity=120)],
            2: [Note(step=1, note=56, velocity=100)],
        })
        out = result.to_bytes()

        reparsed = XYProject.from_bytes(out)
        assert reparsed.to_bytes() == out
        assert len(reparsed.tracks) == 16

        # Both tracks should be type 0x07
        assert reparsed.tracks[0].type_byte == 0x07
        assert reparsed.tracks[1].type_byte == 0x07

        # Track 2 (activated) gets 0x64 because Track 1 is activated before it
        assert reparsed.tracks[1].preamble[0] == 0x64

        # Track 3 (first unmodified after the group) also gets 0x64
        assert reparsed.tracks[2].preamble[0] == 0x64

    def test_two_nonadjacent_tracks_preamble_rule(self):
        """Non-adjacent activated tracks: each gets its own 0x64 on the next track."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)

        result = append_notes_to_tracks(project, {
            3: [Note(step=1, note=60, velocity=100)],
            8: [Note(step=1, note=60, velocity=100)],
        })

        # Track 4 and Track 9 should get 0x64 (they are each the next unmodified)
        assert result.tracks[3].preamble[0] == 0x64
        assert result.tracks[8].preamble[0] == 0x64

        # Track 3 and Track 8 keep originals
        assert result.tracks[2].preamble == project.tracks[2].preamble
        assert result.tracks[7].preamble == project.tracks[7].preamble

    def test_three_adjacent_tracks(self):
        """Three consecutive tracks: 0x64 on T2, T3, and T4 (per unnamed 93 rule)."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)

        result = append_notes_to_tracks(project, {
            1: [Note(step=1, note=48, velocity=100)],
            2: [Note(step=1, note=56, velocity=100)],
            3: [Note(step=1, note=60, velocity=100)],
        })

        # Track 1 keeps original preamble (first in chain)
        assert result.tracks[0].preamble == project.tracks[0].preamble

        # Track 2 and 3 get 0x64 (following an activated track)
        assert result.tracks[1].preamble[0] == 0x64
        assert result.tracks[2].preamble[0] == 0x64

        # Track 4 also gets 0x64 (first unmodified after the group)
        assert result.tracks[3].preamble[0] == 0x64

        # Track 5+ unchanged
        for i in range(4, 16):
            assert result.tracks[i].preamble == project.tracks[i].preamble

    def test_t4_insert_before_tail(self):
        """T4 (Pluck/EPiano engine) inserts event before 47-byte tail, not at end.

        Verified by matching unnamed 93 specimen byte-for-byte.
        """
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)
        specimen = XYProject.from_bytes(
            (CORPUS / "unnamed 93.xy").read_bytes()
        )

        # Reproduce the unnamed 93 T4 event: C4, vel 100, explicit gate 480 ticks
        # event_type_for_track(4) returns 0x1F (Pluck/EPiano native)
        result = append_notes_to_track(
            project, track_index=4,
            notes=[Note(step=1, note=60, velocity=100, gate_ticks=480)],
        )

        # T4 body must match unnamed 93 specimen exactly
        assert result.tracks[3].body == specimen.tracks[3].body

    def test_t4_tail_marker_cleared(self):
        """After event insertion, T4 tail marker bit 5 is cleared (0x28 -> 0x08)."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)

        result = append_notes_to_track(
            project, track_index=4,
            notes=[Note(step=1, note=60, velocity=100)],
        )

        body = result.tracks[3].body
        # Tail is last 47 bytes; first byte should have bit 5 cleared
        assert body[-47] == 0x08

    def test_track5_preamble_exempt(self):
        """Track 5 (0-based idx 4) must NOT get 0x64 — unnamed 93 exception.

        When T4 is activated, T5 keeps its original preamble (0x2E in corpus).
        Setting T5 to 0x64 causes num_patterns crash (serialize_latest.cpp:90).
        """
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)
        original_t5_preamble = project.tracks[4].preamble

        # Activate only T4
        result = append_notes_to_track(
            project, track_index=4, notes=[Note(step=1, note=60, velocity=100)]
        )
        # T5 must keep its original preamble
        assert result.tracks[4].preamble == original_t5_preamble

    def test_track5_exempt_in_chain(self):
        """T5 keeps preamble even when T1-T4 are all activated (unnamed 93 pattern)."""
        template = TEMPLATE.read_bytes()
        project = XYProject.from_bytes(template)
        original_t5_preamble = project.tracks[4].preamble

        result = append_notes_to_tracks(project, {
            1: [Note(step=1, note=48, velocity=100)],
            2: [Note(step=1, note=56, velocity=100)],
            3: [Note(step=1, note=60, velocity=100)],
            4: [Note(step=1, note=64, velocity=100)],
        })

        # T2, T3, T4 get 0x64 (after an activated track)
        assert result.tracks[1].preamble[0] == 0x64
        assert result.tracks[2].preamble[0] == 0x64
        assert result.tracks[3].preamble[0] == 0x64

        # T5 must NOT get 0x64 — exempt per unnamed 93
        assert result.tracks[4].preamble == original_t5_preamble


# ── event_type_for_track tests ──────────────────────────────────────


class TestEventTypeForTrack:
    """Verify event type selection for each track slot."""

    def test_track1_0x25(self):
        assert event_type_for_track(1) == 0x25

    def test_device_verified_types(self):
        """Tracks return firmware-native event types (device-verified on T1-T5, T7)."""
        expected = {
            1: 0x25, 2: 0x21, 3: 0x21, 4: 0x1F,
            5: 0x21, 6: 0x1E, 7: 0x20, 8: 0x20,
        }
        for track, etype in expected.items():
            assert event_type_for_track(track) == etype

    def test_tracks_9_16_fallback(self):
        """Tracks 9-16 (auxiliary) fall back to 0x21."""
        for t in range(9, 17):
            assert event_type_for_track(t) == 0x21

    def test_out_of_range(self):
        with pytest.raises(ValueError):
            event_type_for_track(0)
        with pytest.raises(ValueError):
            event_type_for_track(17)


# ── build_event with various event types ────────────────────────────


class TestBuildEventTypes:
    """Verify build_event produces correct type bytes for all accepted types."""

    def test_all_accepted_types(self):
        """Each accepted event type produces the correct header byte."""
        for etype in (0x1E, 0x1F, 0x20, 0x21, 0x25, 0x2D):
            blob = build_event([Note(step=1, note=60, velocity=100)], event_type=etype)
            assert blob[0] == etype
            assert blob[1] == 1  # count

    def test_0x1f_single_note(self):
        """0x1F event (EPiano) with one note has same structure as 0x21."""
        blob_1f = build_event([Note(step=1, note=64, velocity=90)], event_type=0x1F)
        blob_21 = build_event([Note(step=1, note=64, velocity=90)], event_type=0x21)
        # Only the type byte differs
        assert blob_1f[0] == 0x1F
        assert blob_21[0] == 0x21
        assert blob_1f[1:] == blob_21[1:]

    def test_0x20_single_note(self):
        """0x20 event (Axis) with one note has same structure as 0x21."""
        blob_20 = build_event([Note(step=1, note=55, velocity=80)], event_type=0x20)
        blob_21 = build_event([Note(step=1, note=55, velocity=80)], event_type=0x21)
        assert blob_20[0] == 0x20
        assert blob_20[1:] == blob_21[1:]

    def test_rejected_type(self):
        with pytest.raises(ValueError):
            build_event([Note(step=1, note=60, velocity=100)], event_type=0x99)


# ── chord encoding (multiple notes at same tick) ────────────────────


class TestChordEncoding:
    """Verify encoding of multiple notes at the same step (chords)."""

    def test_two_notes_at_tick_zero(self):
        """Two notes at step 1 — both get 2-byte tick encoding."""
        notes = [
            Note(step=1, note=60, velocity=100),
            Note(step=1, note=64, velocity=100),
        ]
        blob = build_event(notes, event_type=0x20)
        assert blob[0] == 0x20
        assert blob[1] == 2  # count
        # First note (non-last): tick=0 u16(2) + flag(1) + gate(4) + note(1) + vel(1) + pad(3) = 12B
        assert blob[2:4] == b"\x00\x00"  # tick=0 u16
        assert blob[4] == 0x02  # flag for tick=0
        assert blob[9] == 60
        # Second note starts at offset 2+12=14 (last): tick=0 u16(2) + flag(1) + gate(4) + note(1) + vel(1) + pad(2) = 11B
        assert blob[14:16] == b"\x00\x00"  # tick=0 u16
        assert blob[16] == 0x02  # flag for tick=0
        assert blob[21] == 64

    def test_three_note_chord(self):
        """Three notes at the same step — Am triad."""
        notes = [
            Note(step=1, note=57, velocity=90),  # A3
            Note(step=1, note=60, velocity=90),  # C4
            Note(step=1, note=64, velocity=90),  # E4
        ]
        blob = build_event(notes, event_type=0x20)
        assert blob[0] == 0x20
        assert blob[1] == 3
        # All three notes have tick=0 -> 2-byte encoding + flag=0x02
        # Note 1: 2+1+4+1+1+3 = 12 bytes (non-last)
        # Note 2: 2+1+4+1+1+3 = 12 bytes (non-last)
        # Note 3: 2+1+4+1+1+2 = 11 bytes (last)
        # Total: 2 (header) + 12 + 12 + 11 = 37
        assert len(blob) == 37
        # Verify note bytes
        assert blob[9] == 57   # A3
        assert blob[21] == 60  # C4
        assert blob[33] == 64  # E4

    def test_chord_with_gate(self):
        """Three-note chord with explicit gates."""
        gate = 1920  # quarter note
        notes = [
            Note(step=1, note=57, velocity=90, gate_ticks=gate),
            Note(step=1, note=60, velocity=90, gate_ticks=gate),
            Note(step=1, note=64, velocity=90, gate_ticks=gate),
        ]
        blob = build_event(notes, event_type=0x20)
        assert blob[0] == 0x20
        assert blob[1] == 3
        # With explicit gate, each note is 1 byte longer (5-byte gate vs 4)
        # Note 1: 2+1+5+1+1+3 = 13 bytes (non-last)
        # Note 2: 2+1+5+1+1+3 = 13 bytes (non-last)
        # Note 3: 2+1+5+1+1+2 = 12 bytes (last)
        # Total: 2 (header) + 13 + 13 + 12 = 40
        assert len(blob) == 40

    def test_chord_plus_melody(self):
        """Chord at step 1 followed by single note at step 5."""
        notes = [
            Note(step=1, note=57, velocity=90),   # A3 (chord)
            Note(step=1, note=60, velocity=90),   # C4 (chord)
            Note(step=1, note=64, velocity=90),   # E4 (chord)
            Note(step=5, note=53, velocity=80),   # F3 (melody)
        ]
        blob = build_event(notes, event_type=0x20)
        assert blob[0] == 0x20
        assert blob[1] == 4
        # Notes 1-3 at tick=0 (2-byte encoding), note 4 at tick=1920 (4-byte encoding)
        # Note 1: 2+1+4+1+1+3 = 12
        # Note 2: 2+1+4+1+1+3 = 12
        # Note 3: 2+1+4+1+1+3 = 12
        # Note 4: 4+1+4+1+1+2 = 13 (last, tick>0)
        # Total: 2 + 12 + 12 + 12 + 13 = 51
        assert len(blob) == 51


# ── bar_count property tests ──────────────────────────────────────


class TestBarCount:
    """Verify TrackBlock.bar_count decodes preamble byte 2 correctly."""

    def test_baseline_all_one_bar(self):
        project = XYProject.from_bytes(TEMPLATE.read_bytes())
        for i in range(16):
            assert project.tracks[i].bar_count == 1

    def test_unnamed_17_two_bars(self):
        project = XYProject.from_bytes((CORPUS / "unnamed 17.xy").read_bytes())
        assert project.tracks[0].bar_count == 2
        for i in range(1, 16):
            assert project.tracks[i].bar_count == 1

    def test_unnamed_19_four_bars(self):
        project = XYProject.from_bytes((CORPUS / "unnamed 19.xy").read_bytes())
        assert project.tracks[0].bar_count == 4

    def test_unnamed_101_two_tracks_four_bars(self):
        project = XYProject.from_bytes((CORPUS / "unnamed 101.xy").read_bytes())
        assert project.tracks[0].bar_count == 4   # T1
        assert project.tracks[1].bar_count == 1   # T2 unchanged
        assert project.tracks[2].bar_count == 4   # T3
        assert project.tracks[3].bar_count == 1   # T4 unchanged
