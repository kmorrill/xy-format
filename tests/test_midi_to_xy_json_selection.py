from __future__ import annotations

import importlib.util
from pathlib import Path
import sys

import mido

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.json_build_spec import parse_build_spec


def _load_midi_tool_module():
    module_path = REPO_ROOT / "tools" / "midi_to_xy.py"
    spec = importlib.util.spec_from_file_location("midi_to_xy_tool", module_path)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def _build_track(notes: list[tuple[int, int, int, int]], channel: int) -> mido.MidiTrack:
    """Build one MIDI track from absolute note tuples.

    notes tuple: (onset_tick, pitch, duration_ticks, velocity)
    """
    events: list[tuple[int, mido.Message]] = []
    for onset, pitch, dur, vel in notes:
        events.append((onset, mido.Message("note_on", channel=channel, note=pitch, velocity=vel, time=0)))
        events.append((onset + dur, mido.Message("note_off", channel=channel, note=pitch, velocity=0, time=0)))
    events.sort(key=lambda item: (item[0], 0 if item[1].type == "note_off" else 1))

    track = mido.MidiTrack()
    last_tick = 0
    for tick, msg in events:
        msg.time = tick - last_tick
        track.append(msg)
        last_tick = tick
    return track


def _synthetic_mix_midi() -> mido.MidiFile:
    """8-bar synthetic arrangement with >8 source lanes and duplicate content."""
    tpb = 480
    bar = tpb * 4

    mid = mido.MidiFile(ticks_per_beat=tpb)
    tempo_track = mido.MidiTrack()
    tempo_track.append(mido.MetaMessage("set_tempo", tempo=mido.bpm2tempo(120), time=0))
    mid.tracks.append(tempo_track)

    # Drum lane 1 (kick)
    drum1 = [(b * bar + beat * tpb, 36, tpb // 2, 100) for b in range(8) for beat in (0, 2)]
    mid.tracks.append(_build_track(drum1, channel=9))

    # Drum lane 2 (snare)
    drum2 = [(b * bar + beat * tpb, 38, tpb // 2, 96) for b in range(8) for beat in (1, 3)]
    mid.tracks.append(_build_track(drum2, channel=9))

    # Bass lane (low mono)
    bass = [(b * bar, 40 + (b % 2) * 2, bar, 98) for b in range(8)]
    mid.tracks.append(_build_track(bass, channel=1))

    # Lead lanes
    lead1 = [(b * bar + i * (tpb // 2), 72 + (i % 5), tpb // 2, 90) for b in range(8) for i in range(8)]
    lead2 = [(b * bar + i * tpb, 67 + (i % 7), tpb, 85) for b in range(8) for i in range(4)]
    lead3 = [(b * bar + i * (tpb // 2), 60 + ((i + 1) % 6), tpb // 2, 88) for b in range(8) for i in range(6)]
    mid.tracks.append(_build_track(lead1, channel=2))
    mid.tracks.append(_build_track(lead2, channel=3))
    mid.tracks.append(_build_track(lead3, channel=4))

    # Chord lane 1
    chord1: list[tuple[int, int, int, int]] = []
    for b in range(8):
        onset = b * bar
        for pitch in (60, 64, 67):
            chord1.append((onset, pitch, int(bar * 0.75), 78))
    mid.tracks.append(_build_track(chord1, channel=5))

    # Chord lane 2
    chord2: list[tuple[int, int, int, int]] = []
    for b in range(8):
        onset = b * bar + tpb
        for pitch in (62, 65, 69):
            chord2.append((onset, pitch, int(bar * 0.6), 80))
    mid.tracks.append(_build_track(chord2, channel=6))

    # Duplicate of chord lane 1 (should be deduped out by similarity)
    mid.tracks.append(_build_track(chord1, channel=7))

    # Sparse mostly-empty lane
    sparse = [(bar * 2, 75, tpb // 2, 50), (bar * 6, 77, tpb // 2, 52)]
    mid.tracks.append(_build_track(sparse, channel=8))

    return mid


def _single_drum_single_chord_midi() -> mido.MidiFile:
    """8-bar mix with one drum lane and one chord lane."""
    tpb = 480
    bar = tpb * 4

    mid = mido.MidiFile(ticks_per_beat=tpb)
    tempo_track = mido.MidiTrack()
    tempo_track.append(mido.MetaMessage("set_tempo", tempo=mido.bpm2tempo(118), time=0))
    mid.tracks.append(tempo_track)

    # One drum lane with kick/snare/hat content.
    drum_notes: list[tuple[int, int, int, int]] = []
    for b in range(8):
        base = b * bar
        drum_notes.extend(
            [
                (base + 0 * tpb, 36, tpb // 2, 100),
                (base + 1 * tpb, 42, tpb // 2, 85),
                (base + 2 * tpb, 38, tpb // 2, 98),
                (base + 3 * tpb, 46, tpb // 2, 87),
            ]
        )
    mid.tracks.append(_build_track(drum_notes, channel=9))

    # Bass.
    bass = [(b * bar, 40 + (b % 2) * 2, bar, 95) for b in range(8)]
    mid.tracks.append(_build_track(bass, channel=1))

    # Lead.
    lead = [(b * bar + i * (tpb // 2), 72 + (i % 4), tpb // 2, 88) for b in range(8) for i in range(8)]
    mid.tracks.append(_build_track(lead, channel=2))

    # Single chord lane.
    chord: list[tuple[int, int, int, int]] = []
    for b in range(8):
        onset = b * bar + tpb
        for pitch in (60, 64, 67):
            chord.append((onset, pitch, int(bar * 0.75), 78))
    mid.tracks.append(_build_track(chord, channel=3))

    return mid


def test_role_mapping_prefers_drums_bass_chords() -> None:
    tool = _load_midi_tool_module()
    mid = _synthetic_mix_midi()

    sel = tool.select_best_parts(mid, start_bar=0, total_bars=8)
    assignments = sel.assignments

    # Drums to T1/T2.
    assert 1 in assignments
    assert 2 in assignments
    assert assignments[1].key[1] == 9
    assert assignments[2].key[1] == 9

    # Bass to T3 should be a non-drum low register lane.
    assert 3 in assignments
    assert assignments[3].key[1] != 9
    assert assignments[3].mean_pitch < 55

    # Chords to T7/T8 should favor polyphonic lanes.
    assert 7 in assignments
    assert 8 in assignments
    assert assignments[7].polyphony_ratio > 0.25
    assert assignments[8].polyphony_ratio > 0.25

    # Duplicate lane was detected and dropped at least once.
    assert len(sel.dropped_duplicates) >= 1


def test_secondary_drum_and_chord_slots_are_derived_when_missing() -> None:
    tool = _load_midi_tool_module()
    mid = _single_drum_single_chord_midi()

    sel = tool.select_best_parts(mid, start_bar=0, total_bars=8)
    track_patterns = tool.build_track_patterns(sel, mid.ticks_per_beat, start_bar=0, num_patterns=2)

    # Even with only one source drum/chord lane, fallback derivation should
    # populate the second role slot so T2/T8 are not entirely empty.
    assert any(track_patterns[2])
    assert any(track_patterns[8])


def test_json_payload_is_schema_valid_for_compiler() -> None:
    tool = _load_midi_tool_module()
    mid = _synthetic_mix_midi()

    sel = tool.select_best_parts(mid, start_bar=0, total_bars=8)
    track_patterns = tool.build_track_patterns(sel, mid.ticks_per_beat, start_bar=0, num_patterns=2)

    payload = tool.build_json_payload(
        track_patterns=track_patterns,
        template_path=str((REPO_ROOT / "src/one-off-changes-from-default/unnamed 1.xy").resolve()),
        xy_output_path="output/from-midi/synth_test.xy",
        num_patterns=2,
    )

    spec = parse_build_spec(payload, base_dir=REPO_ROOT)
    assert spec.mode == "multi_pattern"
    assert len(spec.multi_tracks) == 8
