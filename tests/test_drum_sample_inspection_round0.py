from pathlib import Path

from xy.drum_sample_inspection import inspect_drum_samples_bytes


ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "app-sample-probes" / "archive-round0-nt-z-fx"
BASELINE = PROBES / "c0-baseline-pp.xy"


def _track1_voices(path: Path):
    inspection = inspect_drum_samples_bytes(path.read_bytes())
    by_track = {track.track: track for track in inspection.tracks}
    assert 1 in by_track
    return by_track[1].voices


def test_baseline_is_all_pp_preset_nested_paths() -> None:
    voices = _track1_voices(BASELINE)
    assert all(v.path.startswith("/fat32/presets/drum/pp.preset/") for v in voices)
    assert not any("nt-z-fx" in v.path for v in voices)


def test_user_preset_nt_z_fx_swaps_use_fx_category_paths() -> None:
    baseline = _track1_voices(BASELINE)
    cases = [
        (
            "c0-pad01-lowf-v23-nt-z-fx-a2-3.xy",
            23,
            "/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav",
        ),
        (
            "c0-pad02-v00-nt-z-fx-a3-3.xy",
            0,
            "/fat32/presets/fx/nt-z-fx.preset/unnamed-a3-3.wav",
        ),
        (
            "c0-pad03-v01-nt-z-fx-b2-4.xy",
            1,
            "/fat32/presets/fx/nt-z-fx.preset/unnamed-b2-4.wav",
        ),
    ]

    for filename, voice, expected in cases:
        voices = _track1_voices(PROBES / filename)
        assert voices[voice].path == expected
        assert "nt-z-fx.preset" in voices[voice].path
        for other, before, after in zip(range(24), baseline, voices):
            if other == voice:
                continue
            assert after.path == before.path
