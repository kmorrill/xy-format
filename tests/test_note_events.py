"""Tests for the note event builder and project_builder append recipe."""

import pytest
from pathlib import Path

from xy.container import XYProject
from xy.note_events import Note, build_0x21_event, build_event, event_type_for_track, STEP_TICKS
from xy.project_builder import (
    append_notes_to_track, append_notes_to_tracks, _activate_body,
    build_multi_pattern_project,
)

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

    def test_count_over_120_rejected(self):
        notes = [Note(step=i + 1, note=48 + (i % 24), velocity=100) for i in range(121)]
        with pytest.raises(ValueError, match="too many notes"):
            build_event(notes, event_type=0x21)

    def test_count_120_allowed(self):
        notes = [Note(step=i + 1, note=48 + (i % 24), velocity=100) for i in range(120)]
        blob = build_event(notes, event_type=0x21)
        assert blob[0] == 0x21
        assert blob[1] == 120

    def test_0x2d_multi_note_rejected_by_default(self):
        notes = [
            Note(step=1, note=60, velocity=100),
            Note(step=5, note=64, velocity=100),
        ]
        with pytest.raises(ValueError, match="known crash-prone"):
            build_event(notes, event_type=0x2D)

    def test_0x2d_multi_note_allowed_with_override(self):
        notes = [
            Note(step=1, note=60, velocity=100),
            Note(step=5, note=64, velocity=100),
        ]
        blob = build_event(
            notes,
            event_type=0x2D,
            allow_unsafe_2d_multi_note=True,
        )
        assert blob[0] == 0x2D
        assert blob[1] == 2


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


# ── Multi-pattern builder tests ──────────────────────────────────────


class TestMultiPatternBuilder:
    """Tests for build_multi_pattern_project() block rotation and preamble rules."""

    def _load_baseline(self):
        return XYProject.from_bytes(TEMPLATE.read_bytes())

    def _load_specimen(self, name):
        return XYProject.from_bytes((CORPUS / name).read_bytes())

    # ── Block layout tests ────────────────────────────────────────────

    def test_block_count_always_16(self):
        """Output must always have exactly 16 track blocks."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
        })
        assert len(result.tracks) == 16

    def test_block_count_two_tracks(self):
        """Two tracks with 2 patterns each still produces 16 blocks."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, None],
        })
        assert len(result.tracks) == 16

    def test_three_patterns_block_count(self):
        """Three patterns on T1 still produces 16 blocks."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None, None],
        })
        assert len(result.tracks) == 16

    # ── Leader preamble tests ─────────────────────────────────────────

    def test_t1_leader_byte0_changes_to_b5(self):
        """T1 leader preamble byte[0] changes from D6 to B5."""
        proj = self._load_baseline()
        assert proj.tracks[0].preamble[0] == 0xD6  # sanity
        result = build_multi_pattern_project(proj, {1: [None, None]})
        assert result.tracks[0].preamble[0] == 0xB5

    def test_leader_byte1_is_pattern_count(self):
        """Leader preamble byte[1] = number of patterns for that track."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None, None],  # 3 patterns
        })
        assert result.tracks[0].preamble[1] == 3

    def test_non_t1_leader_keeps_byte0(self):
        """Non-T1 leaders keep their original preamble byte[0]."""
        proj = self._load_baseline()
        original_t3_byte0 = proj.tracks[2].preamble[0]
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, None],
        })
        # T3 leader is at block[3] (after T1 leader, T1 clone, T2)
        assert result.tracks[3].preamble[0] == original_t3_byte0
        assert result.tracks[3].preamble[1] == 2

    # ── Clone preamble tests ─────────────────────────────────────────

    def test_clone_byte0_always_zero(self):
        """Clone preamble byte[0] is always 0x00."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, None],
        })
        # Block[1] = T1 clone, Block[4] = T3 clone
        assert result.tracks[1].preamble[0] == 0x00
        assert result.tracks[4].preamble[0] == 0x00

    def test_clone_byte1_when_pred_not_activated(self):
        """Clone byte[1] = next track's baseline byte[0] when predecessor is blank."""
        proj = self._load_baseline()
        t2_baseline_byte0 = proj.tracks[1].preamble[0]  # T2
        t4_baseline_byte0 = proj.tracks[3].preamble[0]  # T4

        result = build_multi_pattern_project(proj, {
            1: [None, None],     # leader blank → clone pred is blank
            3: [None, None],     # leader blank → clone pred is blank
        })
        # T1 clone at block[1]: pred = T1 leader (type 0x05) → byte[1] = T2 baseline
        assert result.tracks[1].preamble[1] == t2_baseline_byte0
        # T3 clone at block[4]: pred = T3 leader (type 0x05) → byte[1] = T4 baseline
        assert result.tracks[4].preamble[1] == t4_baseline_byte0

    def test_clone_byte1_when_pred_activated(self):
        """Clone byte[1] = 0x64 when predecessor is type 0x07."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [[Note(step=1, note=48, velocity=100)], None],  # leader has notes
        })
        # T1 clone at block[1]: pred = T1 leader (type 0x07) → byte[1] = 0x64
        assert result.tracks[1].preamble[1] == 0x64

    def test_t4_clone_byte1_exempt_from_0x64(self):
        """T4 clone byte[1] uses baseline[T5].preamble[0], not 0x64.

        Crash #11: Clone byte[1] represents the next original track's
        preamble byte[0].  T5 (0-based idx 4) is exempt from the 0x64
        rule, so T4 clones (whose next track IS T5) must use T5's baseline
        value (0x2E) instead of 0x64.  Same exemption as crash #6, applied
        to clone byte[1] instead of non-clone byte[0].

        Verified against n110: all T4 clones have byte[1]=0x2E even when
        their predecessors are activated (type 0x07).
        """
        proj = self._load_baseline()
        t5_baseline_byte0 = proj.tracks[4].preamble[0]  # T5 = 0x2E
        assert t5_baseline_byte0 == 0x2E, "sanity: T5 baseline byte[0]"

        # T4 with notes → leader activated (type 0x07) → clone pred is 0x07
        # But T4 clone byte[1] should still be 0x2E (T5 exempt from 0x64)
        result = build_multi_pattern_project(proj, {
            4: [[Note(step=1, note=64, velocity=100)],
                [Note(step=1, note=67, velocity=100)]],
        })
        t4_clone = result.tracks[4]
        assert t4_clone.preamble[0] == 0x00, "clone marker byte[0]"
        assert t4_clone.preamble[1] == t5_baseline_byte0, (
            f"T4 clone byte[1] should be 0x{t5_baseline_byte0:02X} "
            f"(T5 exempt from 0x64), got 0x{t4_clone.preamble[1]:02X}"
        )

    def test_t4_clone_byte1_baseline_when_pred_blank(self):
        """T4 clone byte[1] = baseline[T5] even when pred is blank (T5 exempt)."""
        proj = self._load_baseline()
        t5_baseline_byte0 = proj.tracks[4].preamble[0]

        # T4 with blank patterns → leader type 0x05 → clone pred is 0x05
        result = build_multi_pattern_project(proj, {
            4: [None, None],
        })
        t4_clone = result.tracks[4]
        assert t4_clone.preamble[1] == t5_baseline_byte0

    def test_non_t4_clone_byte1_gets_0x64(self):
        """Clones whose next track is NOT T5-exempt still get 0x64."""
        proj = self._load_baseline()

        # T3 clones → next track is T4, not exempt → 0x64 when pred activated
        result = build_multi_pattern_project(proj, {
            3: [[Note(step=1, note=60, velocity=100)],
                [Note(step=1, note=64, velocity=100)]],
        })
        t3_clone = result.tracks[3]
        assert t3_clone.preamble[1] == 0x64, (
            "T3 clone byte[1] should be 0x64 (T4 not exempt)"
        )

    # ── POST-ACT 0x64 rule ────────────────────────────────────────────

    def test_post_act_0x64_after_activated_clone(self):
        """Block after an activated clone gets 0x64 preamble byte[0]."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=48, velocity=100)]],
        })
        # Block[1] = T1 clone (type 0x07), Block[2] = T2 → gets 0x64
        assert result.tracks[1].type_byte == 0x07
        assert result.tracks[2].preamble[0] == 0x64

    def test_no_0x64_after_blank_clone(self):
        """Block after a blank clone does NOT get 0x64."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],  # all blank
        })
        # Block[1] = T1 clone (type 0x05), Block[2] = T2 → keeps original
        original_t2 = proj.tracks[1].preamble[0]
        assert result.tracks[1].type_byte == 0x05
        assert result.tracks[2].preamble[0] == original_t2

    # ── Leader body tests ─────────────────────────────────────────────

    def test_leader_body_trimmed_by_one(self):
        """Leader body is baseline body minus 1 trailing byte."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {1: [None, None]})
        base_body = proj.tracks[0].body
        leader_body = result.tracks[0].body
        assert len(leader_body) == len(base_body) - 1
        assert leader_body == base_body[:-1]

    def test_blank_last_clone_keeps_full_body(self):
        """Last blank clone keeps full baseline body size."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {1: [None, None]})
        base_body = proj.tracks[0].body
        clone_body = result.tracks[1].body
        assert clone_body == base_body

    def test_blank_intermediate_clone_trimmed(self):
        """Non-last blank clones are trimmed like leaders."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {1: [None, None, None]})
        base_body = proj.tracks[0].body
        # Block[1] = clone 1 (intermediate), Block[2] = clone 2 (last)
        assert len(result.tracks[1].body) == len(base_body) - 1
        assert len(result.tracks[2].body) == len(base_body)

    # ── Overflow packing tests ────────────────────────────────────────

    def test_overflow_block_structure(self):
        """Displaced blocks are packed into block 15 with embedded preambles."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, None],
        })
        # 18 entries → 15 normal + 3 overflow (T14, T15, T16)
        ovf = result.tracks[15]
        base_t14 = proj.tracks[13]
        base_t15 = proj.tracks[14]
        base_t16 = proj.tracks[15]
        expected = base_t14.body + base_t15.preamble + base_t15.body + \
                   base_t16.preamble + base_t16.body
        assert ovf.body == expected

    def test_overflow_preamble_from_first_displaced(self):
        """Block 15 preamble comes from the first displaced track."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, None],
        })
        base_t14 = proj.tracks[13]
        assert result.tracks[15].preamble == base_t14.preamble

    # ── Activated clone tests ─────────────────────────────────────────

    def test_activated_clone_has_event(self):
        """Clone with notes gets activated body (type 0x07) + event."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=48, velocity=100)]],
        })
        # T1 clone at block[1]
        clone = result.tracks[1]
        assert clone.type_byte == 0x07
        # Should contain 0x25 event (T1 drum)
        assert b"\x25\x01" in clone.body

    def test_t3_clone_body_matches_single_track_activation(self):
        """T3 activated clone body = activated baseline body + event (same as single-track)."""
        proj = self._load_baseline()
        notes = [Note(step=2, note=52, velocity=100)]

        # Build via multi-pattern (T1+T3 combination)
        multi = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, notes],
        })
        clone_body = multi.tracks[4].body  # T3 clone at block[4]

        # Build via single-track append (for comparison)
        single = append_notes_to_track(proj, track_index=3, notes=notes)
        single_body = single.tracks[2].body

        assert clone_body == single_body

    # ── Pre-track tests ───────────────────────────────────────────────

    def test_pre_track_slot_count_updated(self):
        """pre_track[0x56:0x58] = max_patterns - 1."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {1: [None, None]})
        slot = int.from_bytes(result.pre_track[0x56:0x58], "little")
        assert slot == 1  # 2 patterns - 1

    def test_pre_track_descriptor_inserted(self):
        """Descriptor bytes are inserted at 0x58, growing pre-track region."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {1: [None, None]})
        # T1-only descriptor is 5 bytes
        assert len(result.pre_track) == len(proj.pre_track) + 5

    def test_pre_track_two_track_descriptor(self):
        """T1+T3 descriptor is 7 bytes."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            3: [None, None],
        })
        assert len(result.pre_track) == len(proj.pre_track) + 7

    # ── Structural match against unnamed 105 ──────────────────────────

    def test_unnamed_105_block_layout(self):
        """Generated layout matches unnamed 105's block types and preamble patterns."""
        proj = self._load_baseline()
        u105 = self._load_specimen("unnamed 105.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],   # T1 pat2: C4 step 1
            3: [None, [Note(step=2, note=52, velocity=100)]],   # T3 pat2: E3 step 2
        })

        # Verify all 16 preambles match
        for i in range(16):
            assert result.tracks[i].preamble == u105.tracks[i].preamble, \
                f"Block[{i}] preamble mismatch: " \
                f"got {result.tracks[i].preamble.hex()} " \
                f"expected {u105.tracks[i].preamble.hex()}"

    def test_unnamed_105_pre_track(self):
        """Generated pre-track matches unnamed 105."""
        proj = self._load_baseline()
        u105 = self._load_specimen("unnamed 105.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        })

        assert result.pre_track == u105.pre_track

    def test_unnamed_105_overflow_block(self):
        """Block 15 overflow content matches unnamed 105."""
        proj = self._load_baseline()
        u105 = self._load_specimen("unnamed 105.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        })

        assert result.tracks[15].body == u105.tracks[15].body

    def test_unnamed_105_t3_clone_body(self):
        """T3 clone body matches unnamed 105 byte-for-byte.

        T3 (Prism) uses standard activation without firmware metadata insertion,
        so the clone body should be reproducible from baseline.
        """
        proj = self._load_baseline()
        u105 = self._load_specimen("unnamed 105.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        })

        # Block[4] = T3 clone in both
        assert result.tracks[4].body == u105.tracks[4].body

    def test_unnamed_102_t1_clone_body(self):
        """Track 1 clone body matches unnamed 102 (pattern 2 note only)."""
        proj = self._load_baseline()
        u102 = self._load_specimen("unnamed 102.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=9, note=60, velocity=100)]],
        })

        # Block[1] = T1 clone
        assert result.tracks[1].body == u102.tracks[1].body

    def test_unnamed_103_t1_leader_and_clone_bodies(self):
        """Track 1 leader+clone bodies match unnamed 103 byte-for-byte."""
        proj = self._load_baseline()
        u103 = self._load_specimen("unnamed 103.xy")

        result = build_multi_pattern_project(proj, {
            1: [
                [Note(step=1, note=60, velocity=100)],
                [Note(step=9, note=64, velocity=100)],
            ],
        })

        # Block[0] = T1 leader, Block[1] = T1 clone
        assert result.tracks[0].body == u103.tracks[0].body
        assert result.tracks[1].body == u103.tracks[1].body

    def test_unnamed_105_leader_bodies(self):
        """Leader bodies (blank, trimmed) match unnamed 105."""
        proj = self._load_baseline()
        u105 = self._load_specimen("unnamed 105.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        })

        # Block[0] = T1 leader (blank, type 0x05)
        assert result.tracks[0].body == u105.tracks[0].body
        # Block[3] = T3 leader (blank, type 0x05)
        assert result.tracks[3].body == u105.tracks[3].body

    def test_unnamed_105_regular_blocks_unchanged(self):
        """Regular (non-leader, non-clone) blocks keep baseline bodies."""
        proj = self._load_baseline()
        u105 = self._load_specimen("unnamed 105.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        })

        # Blocks 2 (T2), 5 (T4), 6 (T5), 7-14 (T6-T13) should match baseline
        for i in [2, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]:
            base_ti = None
            # Map block index to original track index
            if i == 2:
                base_ti = 1   # T2
            elif i >= 5 and i <= 14:
                base_ti = i - 2  # shifted by 2 clones
            if base_ti is not None:
                assert result.tracks[i].body == proj.tracks[base_ti].body, \
                    f"Block[{i}] (T{base_ti+1}) body mismatch"

    def test_unnamed_105b_exact(self):
        """Reproduce unnamed 105b (T3 leader note in multi-track layout)."""
        proj = self._load_baseline()
        u105b = self._load_specimen("unnamed 105b.xy")

        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [
                [Note(step=8, note=53, velocity=100)],
                [Note(step=2, note=52, velocity=100)],
            ],
        })

        assert result.to_bytes() == u105b.to_bytes()

    def test_t3_leader_notes_use_full_body_path_when_t1_leader_active(self):
        """Regression: T3 leader note offset must not depend on T1 leader state.

        Device-pass diagnostics (mp2_v7) showed that when T1 leader is also
        active, T3 leader note events still need the 105b-style full-body
        activation path before trimming. The old trimmed-preactivation path
        shifted the T3 event by one byte and caused `num_patterns > 0` crashes.
        """
        proj = self._load_baseline()

        t1_patterns = [
            [
                Note(step=1, note=48, velocity=120),
                Note(step=5, note=52, velocity=112),
                Note(step=9, note=48, velocity=118),
                Note(step=13, note=52, velocity=114),
            ],
            [
                Note(step=1, note=48, velocity=120),
                Note(step=9, note=48, velocity=118),
                Note(step=13, note=52, velocity=114),
                Note(step=16, note=60, velocity=112),
            ],
        ]
        t3_patterns = [
            [
                Note(step=1, note=36, velocity=102, gate_ticks=720),
                Note(step=5, note=36, velocity=100, gate_ticks=720),
                Note(step=9, note=43, velocity=104, gate_ticks=720),
                Note(step=13, note=41, velocity=102, gate_ticks=720),
            ],
            [
                Note(step=1, note=36, velocity=102, gate_ticks=720),
                Note(step=4, note=38, velocity=98, gate_ticks=480),
                Note(step=10, note=43, velocity=106, gate_ticks=960),
                Note(step=13, note=34, velocity=102, gate_ticks=720),
            ],
        ]

        both_active = build_multi_pattern_project(
            proj,
            {1: t1_patterns, 3: t3_patterns},
        )
        t1_clone_only = build_multi_pattern_project(
            proj,
            {1: [None, t1_patterns[1]], 3: t3_patterns},
        )

        # Block[3] is the T3 leader block in both layouts.
        assert both_active.tracks[3].body == t1_clone_only.tracks[3].body

    # ── Validation tests ──────────────────────────────────────────────

    def test_rejects_single_pattern(self):
        """Must have at least 2 patterns per track."""
        proj = self._load_baseline()
        with pytest.raises(ValueError, match="at least 2"):
            build_multi_pattern_project(proj, {1: [None]})

    def test_rejects_empty_dict(self):
        """Must have at least one track."""
        proj = self._load_baseline()
        with pytest.raises(ValueError, match="at least one"):
            build_multi_pattern_project(proj, {})

    def test_strict_rejects_unknown_track_set(self):
        """Strict mode rejects Scheme B sets without a device-verified descriptor."""
        proj = self._load_baseline()
        # T1+T7 is a Scheme B topology we haven't captured yet
        with pytest.raises(ValueError, match="strict mode"):
            build_multi_pattern_project(
                proj,
                {
                    1: [None, None],
                    7: [None, None],
                },
            )

    def test_heuristic_matches_strict_for_known_t1(self):
        """Heuristic descriptor reproduces strict bytes for T1-only sets."""
        proj = self._load_baseline()
        strict = build_multi_pattern_project(
            proj,
            {1: [None, None]},
            descriptor_strategy="strict",
        )
        heur = build_multi_pattern_project(
            proj,
            {1: [None, None]},
            descriptor_strategy="heuristic_v1",
        )
        assert heur.pre_track == strict.pre_track

    def test_heuristic_matches_strict_for_known_t1_t3(self):
        """Heuristic descriptor reproduces strict bytes for T1+T3 sets."""
        proj = self._load_baseline()
        patterns = {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        }
        strict = build_multi_pattern_project(
            proj,
            patterns,
            descriptor_strategy="strict",
        )
        heur = build_multi_pattern_project(
            proj,
            patterns,
            descriptor_strategy="heuristic_v1",
        )
        assert heur.pre_track == strict.pre_track

    def test_heuristic_requires_t1_anchor(self):
        """Heuristic mode currently requires Track 1 in the set."""
        proj = self._load_baseline()
        with pytest.raises(ValueError, match="requires Track 1"):
            build_multi_pattern_project(
                proj,
                {3: [None, None]},
                descriptor_strategy="heuristic_v1",
            )

    def test_heuristic_three_tracks_two_patterns_roundtrip(self):
        """Heuristic mode can build a 3-track / 2-pattern stress file."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(
            proj,
            {
                1: [
                    [Note(step=1, note=48, velocity=100)],
                    [Note(step=9, note=50, velocity=110)],
                ],
                2: [
                    [Note(step=3, note=52, velocity=100)],
                    [Note(step=11, note=55, velocity=110)],
                ],
                3: [
                    [Note(step=5, note=45, velocity=100)],
                    [Note(step=13, note=48, velocity=110)],
                ],
            },
            descriptor_strategy="heuristic_v1",
        )

        delta = len(result.pre_track) - len(proj.pre_track)
        descriptor = result.pre_track[0x58 : 0x58 + delta]
        assert descriptor == bytes.fromhex("02 00 00 1c 01 1b 01 00 00")

        raw = result.to_bytes()
        reparsed = XYProject.from_bytes(raw)
        assert reparsed.to_bytes() == raw
        assert len(reparsed.tracks) == 16

    def test_round_trip_parses(self):
        """Generated bytes can be parsed back into an XYProject with 16 tracks."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, [Note(step=1, note=48, velocity=100)]],
        })
        raw = result.to_bytes()
        reparsed = XYProject.from_bytes(raw)
        assert len(reparsed.tracks) == 16
        assert reparsed.to_bytes() == raw

    # ── Descriptor encoding tests ─────────────────────────────────────

    def test_scheme_a_encoder_t3(self):
        """Scheme A encoder produces correct descriptor for T3-only."""
        from xy.project_builder import _scheme_a_descriptor
        result = _scheme_a_descriptor(frozenset({2}))
        assert result == bytes.fromhex("00 01 00 00 1b 01 00 00")

    def test_scheme_a_encoder_t4(self):
        """Scheme A encoder produces correct descriptor for T4-only."""
        from xy.project_builder import _scheme_a_descriptor
        result = _scheme_a_descriptor(frozenset({3}))
        assert result == bytes.fromhex("01 01 00 00 1a 01 00 00")

    def test_scheme_a_encoder_t7(self):
        """Scheme A encoder produces correct descriptor for T7-only."""
        from xy.project_builder import _scheme_a_descriptor
        result = _scheme_a_descriptor(frozenset({6}))
        assert result == bytes.fromhex("04 01 00 00 17 01 00 00")

    def test_scheme_a_encoder_multi_track(self):
        """Scheme A encoder handles multiple T3+ tracks."""
        from xy.project_builder import _scheme_a_descriptor
        # T3+T7: two gap/maxslot pairs
        result = _scheme_a_descriptor(frozenset({2, 6}))
        assert result == bytes.fromhex("00 01 04 01 00 00 17 01 00 00")

    def test_scheme_a_rejects_t1(self):
        """Scheme A encoder rejects sets containing T1/T2."""
        from xy.project_builder import _scheme_a_descriptor
        with pytest.raises(ValueError, match="T3\\+ tracks only"):
            _scheme_a_descriptor(frozenset({0, 2}))

    def test_scheme_a_matches_strict_lookup(self):
        """Scheme A encoder results match all T3+-only strict descriptors."""
        from xy.project_builder import _scheme_a_descriptor, _STRICT_DESCRIPTORS
        for track_set, expected in _STRICT_DESCRIPTORS.items():
            if all(ti >= 2 for ti in track_set):
                result = _scheme_a_descriptor(track_set)
                names = ",".join(f"T{i+1}" for i in sorted(track_set))
                assert result == expected, f"Scheme A mismatch for {{{names}}}"

    def test_v56_v57_independent_t1_t2(self):
        """T1+T2 sets v56=1, v57=1 independently (not u16 LE)."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            2: [None, None],
        })
        assert result.pre_track[0x56] == 0x01  # T1 max_slot
        assert result.pre_track[0x57] == 0x01  # T2 max_slot

    def test_v56_v57_t3_only(self):
        """T3-only sets v56=0, v57=0."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            3: [None, None],
        })
        assert result.pre_track[0x56] == 0x00
        assert result.pre_track[0x57] == 0x00

    def test_v56_v57_t1_t4(self):
        """T1+T4 sets v56=1, v57=0."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            4: [None, None],
        })
        assert result.pre_track[0x56] == 0x01
        assert result.pre_track[0x57] == 0x00

    def test_descriptor_t1_t2_matches_corpus(self):
        """T1+T2 descriptor matches m05 corpus specimen."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            2: [None, None],
        })
        expected_insert = bytes.fromhex("00 00 00 1c 01 00 00")
        delta = len(result.pre_track) - len(proj.pre_track)
        actual_insert = result.pre_track[0x58:0x58 + delta]
        assert actual_insert == expected_insert

    def test_descriptor_t1_t4_matches_corpus(self):
        """T1+T4 descriptor matches m09 corpus specimen."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            4: [None, None],
        })
        expected_insert = bytes.fromhex("00 00 01 00 00 1a 01 00 00")
        delta = len(result.pre_track) - len(proj.pre_track)
        actual_insert = result.pre_track[0x58:0x58 + delta]
        assert actual_insert == expected_insert

    def test_descriptor_t3_only_matches_corpus(self):
        """T3-only descriptor matches m01 corpus specimen."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            3: [None, None],
        })
        expected_insert = bytes.fromhex("00 01 00 00 1b 01 00 00")
        delta = len(result.pre_track) - len(proj.pre_track)
        actual_insert = result.pre_track[0x58:0x58 + delta]
        assert actual_insert == expected_insert

    def test_scheme_a_fallback_for_t5(self):
        """Strict mode uses Scheme A encoder for T5-only (not in lookup)."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            5: [None, None],
        })
        # T5: gap=2, maxslot=1, token=0x19
        expected_insert = bytes.fromhex("02 01 00 00 19 01 00 00")
        delta = len(result.pre_track) - len(proj.pre_track)
        actual_insert = result.pre_track[0x58:0x58 + delta]
        assert actual_insert == expected_insert
        assert result.pre_track[0x56] == 0x00
        assert result.pre_track[0x57] == 0x00

    def test_descriptor_t1_t2_t3_matches_corpus(self):
        """T1+T2+T3 descriptor matches m06 corpus specimen."""
        proj = self._load_baseline()
        result = build_multi_pattern_project(proj, {
            1: [None, None],
            2: [None, None],
            3: [None, None],
        })
        expected_insert = bytes.fromhex("01 00 00 1b 01 00 00")
        delta = len(result.pre_track) - len(proj.pre_track)
        actual_insert = result.pre_track[0x58:0x58 + delta]
        assert actual_insert == expected_insert
        assert result.pre_track[0x56] == 0x01  # T1 max_slot
        assert result.pre_track[0x57] == 0x01  # T2 max_slot

    def test_8track_9pattern_t4_preamble_in_overflow(self):
        """8-track × 9-pattern topology: T4 clones in overflow get 0x2E.

        This is the full n110 topology.  Crash #11 was caused by T4
        clones in the overflow block receiving byte[1]=0x64 instead of
        the correct 0x2E.  T5 is exempt from the 0x64 rule, so T4 clones
        (whose next original track is T5) must use T5's baseline value.
        """
        proj = self._load_baseline()
        t5_byte0 = proj.tracks[4].preamble[0]  # 0x2E

        n = Note(step=1, note=60, velocity=100)
        tp = {ti: [[n]] * 9 for ti in range(1, 9)}
        result = build_multi_pattern_project(
            proj, tp, descriptor_strategy="strict",
        )

        # Parse overflow block to check embedded T4 clone preambles
        sig = bytes([0x00, 0x00, 0x01, 0x03, 0xFF, 0x00, 0xFC, 0x00])
        overflow_body = result.tracks[15].body
        positions = []
        pos = 8
        while True:
            idx = overflow_body.find(sig, pos)
            if idx == -1:
                break
            positions.append(idx)
            pos = idx + 1

        # Track-sequential layout: T2 clones (3), T3 (9), T4 (9), ...
        # T4 entries start at overflow entry index 12 (leader) through 20
        # T4 clones are entries 13-20, each preceded by 4-byte preamble
        for entry_idx in range(13, 21):
            sig_pos = positions[entry_idx - 1]  # -1 because entry 0 has no sig
            preamble = overflow_body[sig_pos - 4:sig_pos]
            assert preamble[0] == 0x00, f"entry {entry_idx} byte[0] should be 0x00 (clone)"
            assert preamble[1] == t5_byte0, (
                f"entry {entry_idx} (T4 clone) byte[1] should be "
                f"0x{t5_byte0:02X}, got 0x{preamble[1]:02X}"
            )

        # Also verify round-trip
        raw = result.to_bytes()
        assert XYProject.from_bytes(raw).to_bytes() == raw

    def test_new_topologies_roundtrip(self):
        """All new topology descriptors produce parseable round-trip files."""
        proj = self._load_baseline()
        topologies = [
            {1: [None, None], 2: [None, None]},       # T1+T2
            {1: [None, None], 4: [None, None]},       # T1+T4
            {1: [None, None], 2: [None, None], 3: [None, None]},  # T1+T2+T3
            {3: [None, None]},                          # T3 only
            {4: [None, None]},                          # T4 only
            {7: [None, None]},                          # T7 only
            {5: [None, None]},                          # T5 only (Scheme A)
            {8: [None, None]},                          # T8 only (Scheme A)
        ]
        for tp in topologies:
            result = build_multi_pattern_project(proj, tp)
            raw = result.to_bytes()
            reparsed = XYProject.from_bytes(raw)
            assert reparsed.to_bytes() == raw, f"round-trip failed for {tp}"
            assert len(reparsed.tracks) == 16
