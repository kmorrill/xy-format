from pathlib import Path

from xy.preset_path_inspection import PRESET_PATH_OFFSET, inspect_preset_paths_bytes


ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "preset-probes" / "2026-06-preset-path"


def _track1_path(path: Path) -> str:
    inspection = inspect_preset_paths_bytes(path.read_bytes())
    by_track = {row.track: row for row in inspection.tracks}
    assert 1 in by_track
    return by_track[1].path


def test_preset_path_strings_at_track_plus_453f() -> None:
    cases = [
        ("e0-baseline-empty.xy", "drum/boop"),
        ("e1-t1-drum-pp.xy", "drum/pp"),
        ("e2-t1-drum-aeroplane.xy", "drum/nt-aeroplane"),
        ("e3-t1-sampler-106bass.xy", "bass/nt-106 bass"),
        ("e4-t1-axis-accord.xy", "wind/nt-accord"),
        ("e5-t1-engine-only-no-preset.xy", "/"),
    ]
    for filename, expected in cases:
        assert _track1_path(PROBES / filename) == expected


def test_engine_only_swap_leaves_bare_slash() -> None:
    row = next(
        t
        for t in inspect_preset_paths_bytes((PROBES / "e5-t1-engine-only-no-preset.xy").read_bytes()).tracks
        if t.track == 1
    )
    assert row.engine_id == 0x12
    assert row.path == "/"


def test_drum_pp_changes_preset_path_field_vs_baseline() -> None:
    from xy.image_writer import ImageProject
    from xy.rle import decode_project

    _, base_img = decode_project((PROBES / "e0-baseline-empty.xy").read_bytes())
    _, var_img = decode_project((PROBES / "e1-t1-drum-pp.xy").read_bytes())
    project = ImageProject.from_file(str(PROBES / "e0-baseline-empty.xy"))
    path_start = project.track_start(1) + PRESET_PATH_OFFSET
    path_slice = slice(path_start, path_start + 64)
    assert base_img[path_slice] != var_img[path_slice]
    assert _track1_path(PROBES / "e0-baseline-empty.xy") == "drum/boop"
    assert _track1_path(PROBES / "e1-t1-drum-pp.xy") == "drum/pp"
