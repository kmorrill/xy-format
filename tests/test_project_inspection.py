from pathlib import Path

from tools.inspect_xy import generate_report
from xy.project_inspection import inspect_project_bytes


ROOT = Path(__file__).resolve().parents[1]
APP_PROBES = ROOT / "src" / "preset-probes"
APP_REQUIRED = APP_PROBES / "2026-06-app-required"
PHASE_B = APP_PROBES / "2026-06-phase-b"


def _inspect(path: Path):
    return inspect_project_bytes(path.read_bytes())


def test_app_required_p9_drum_preset_refs_are_mapped_by_track_pattern() -> None:
    expected_names = ["pp", "qq", "rr", "ss", "tt", "uu", "vv", "ww", "xx"]

    for track in range(1, 5):
        inspection = _inspect(APP_REQUIRED / f"a{track}-t{track}-p9.xy")
        track_info = inspection.tracks[track - 1]

        assert [pattern.pattern for pattern in track_info.patterns] == list(range(1, 10))

        refs = [pattern.preset_refs[0] for pattern in track_info.patterns]
        assert [ref.folder for ref in refs] == [
            f"/fat32/presets/drum/{name}" for name in expected_names
        ]
        assert {ref.kind for ref in refs} == {"drum"}
        assert {ref.hit_count for ref in refs} == {24}
        assert {ref.confidence for ref in refs} == {"strong"}


def test_phase_b_engine_preset_fragments_are_inferred() -> None:
    cases = [
        ("b1-t1eng1bar2.xy", "Axis", "nt-accord", "synth"),
        ("b1-t1eng2bar1.xy", "Dissolve", "nt-cold brew", "synth"),
        ("b1-t1eng3bar1.xy", "Drum", "/fat32/presets/drum/nt-aeroplane.preset", "drum"),
        ("b1-t1eng4bar1.xy", "EPiano", "nt-crowded", "synth"),
        ("b1-t1eng5bar1.xy", "Hardsync", "nt-cabin pressure", "synth"),
        ("b1-t1eng6bar3.xy", "Multisampler", "bandpasser", "multi"),
        ("b1-t1eng7bar1.xy", "Organ", "nt-castle vania", "synth"),
        ("b1-t1eng8bar1.xy", "Prism", "nt-blip tips", "synth"),
        ("b1-t1eng9bar1.xy", "Sampler", "nt-106 bass", "sampler"),
        ("b1-t1eng10bar1.xy", "Simple", "nt-dunce cap", "synth"),
        ("b1-t1eng11bar1.xy", "Wavetable", "nt-tall drink", "synth"),
    ]

    for filename, engine_name, folder, kind in cases:
        inspection = _inspect(PHASE_B / filename)
        pattern = inspection.tracks[0].patterns[0]
        ref = pattern.preset_refs[0]

        assert pattern.active
        assert pattern.engine_name == engine_name
        assert ref.folder == folder
        assert ref.kind == kind
        assert ref.confidence in {"strong", "medium"}


def test_active_preset_refs_flatten_active_patterns_only() -> None:
    inspection = _inspect(APP_REQUIRED / "a2-t2-p9.xy")

    flattened = inspection.active_preset_refs

    assert [(track, pattern.pattern) for track, pattern, _ref in flattened] == [
        (2, pattern) for pattern in range(1, 10)
    ]


def test_inspector_report_handles_unknown_sampler_tune_encoding() -> None:
    path = APP_REQUIRED / "a1-t1-p9.xy"

    report = generate_report(path, path.read_bytes())

    assert "[Pattern Presets]" in report
    assert "[Sampler Sample]" in report
    assert "tune=unknown (raw 0x30/0x00)" in report
