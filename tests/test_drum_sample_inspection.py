from pathlib import Path

from xy.drum_sample_inspection import inspect_drum_samples_bytes


ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "app-sample-probes" / "2026-06-sample-paths"
BASELINE = PROBES / "c1-baseline-pp.xy"


def _track1_voices(path: Path):
    inspection = inspect_drum_samples_bytes(path.read_bytes())
    by_track = {track.track: track for track in inspection.tracks}
    assert 1 in by_track, f"expected drum track 1, got {sorted(by_track)}"
    return by_track[1].voices


def test_baseline_pp_kit_uses_preset_nested_paths() -> None:
    voices = _track1_voices(BASELINE)

    assert voices[0].path.startswith("/fat32/presets/drum/pp.preset/")
    assert voices[23].path.startswith("/fat32/presets/drum/pp.preset/")
    assert voices[23].key_assignment == 53  # low F pad on pp kit
    assert len(voices) == 24


def test_builtin_perc_assignments_are_isolated_by_voice() -> None:
    baseline = _track1_voices(BASELINE)
    cases = [
        ("c1-pad01-lowf-v23-chi-box.xy", 23, "content/samples/perc/chi box.wav"),
        ("c1-pad02-v00-chi-cham.xy", 0, "content/samples/perc/chi cham.wav"),
        ("c1-pad03-v01-chi-flet.xy", 1, "content/samples/perc/chi flet.wav"),
    ]

    for filename, voice, expected_path in cases:
        voices = _track1_voices(PROBES / filename)
        assert voices[voice].path == expected_path
        for other_voice, before, after in zip(range(24), baseline, voices):
            if other_voice == voice:
                continue
            assert after.path == before.path, f"{filename} voice {other_voice} drifted"
