import json
import os
from pathlib import Path
import sys

import pytest

# Many of the test specs in this file were authored before the ``profile``
# field existed, and they intentionally exercise the legacy-grandfathered
# inference path. The profile gate raises a DeprecationWarning in that case;
# the warning's correctness is covered directly in ``tests/test_profiles.py``.
# Here we silence it to keep the test output focused on reproduction failures.
pytestmark = pytest.mark.filterwarnings(
    "ignore:spec has no 'profile' field:DeprecationWarning"
)

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYContainer, XYProject
from xy.image_writer import ImageProject
from xy.json_build_spec import (
    build_xy_bytes,
    load_build_spec,
    parse_build_spec,
)
from xy.scene_records import read_scene_assignments, read_t16_scene_list
from xy.scaffold_writer import extract_logical_entries


ROOT = REPO_ROOT
TEMPLATE_REL = "src/one-off-changes-from-default/unnamed 1.xy"
CORPUS_DIR = ROOT / "src" / "one-off-changes-from-default"


def _build_single_pattern_track(track: int, notes: list[dict]) -> bytes:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [
                {
                    "track": track,
                    "patterns": [notes],
                },
            ],
        },
        base_dir=ROOT,
    )
    return build_xy_bytes(spec)


def _minimal_track_spec(track: int = 1) -> dict:
    return {
        "track": track,
        "patterns": [[{"step": 1, "note": 60, "velocity": 100}]],
    }


def _nine_patterns(notes_by_pattern: dict[int, list[dict]]) -> list[object]:
    patterns: list[object] = [None] * 9
    for pattern_idx, notes in notes_by_pattern.items():
        patterns[pattern_idx - 1] = notes
    return patterns


def _track_u32(raw: bytes, track: int, offset: int) -> int:
    project = ImageProject.from_bytes(raw)
    start = project.track_start(track)
    return int.from_bytes(project.image[start + offset : start + offset + 4], "little")


def _global_u32(raw: bytes, offset: int) -> int:
    project = ImageProject.from_bytes(raw)
    return int.from_bytes(project.image[offset : offset + 4], "little")


def test_one_pattern_per_track_compiles_and_activates_track() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [
                {
                    "track": 3,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                    ],
                },
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = XYProject.from_bytes(raw)

    # Track 3 gets activated and contains a 0x21 single-note header.
    assert project.tracks[2].type_byte == 0x07
    assert b"\x21\x01" in project.tracks[2].body

    # Track 4 preamble gets the post-activation 0x64 sentinel.
    assert project.tracks[3].preamble[0] == 0x64


def test_single_note_track1_matches_unnamed2_exact_bytes() -> None:
    raw = _build_single_pattern_track(
        1,
        [
            {"step": 1, "note": 60, "velocity": 100},
        ],
    )
    assert raw == (CORPUS_DIR / "unnamed 2.xy").read_bytes()


def test_single_note_step9_track1_matches_unnamed81_exact_bytes() -> None:
    raw = _build_single_pattern_track(
        1,
        [
            {"step": 9, "note": 60, "velocity": 100},
        ],
    )
    assert raw == (CORPUS_DIR / "unnamed 81.xy").read_bytes()


def test_single_note_track3_long_gate_matches_unnamed56_exact_bytes() -> None:
    raw = _build_single_pattern_track(
        3,
        [
            {"step": 9, "note": 48, "velocity": 100, "gate_ticks": 960},
        ],
    )
    assert raw == (CORPUS_DIR / "unnamed 56.xy").read_bytes()


def test_single_note_track3_longer_gate_matches_unnamed57_exact_bytes() -> None:
    raw = _build_single_pattern_track(
        3,
        [
            {"step": 9, "note": 48, "velocity": 100, "gate_ticks": 1920},
        ],
    )
    assert raw == (CORPUS_DIR / "unnamed 57.xy").read_bytes()


def test_track3_three_notes_explicit_gates_matches_unnamed92_exact_bytes() -> None:
    raw = _build_single_pattern_track(
        3,
        [
            {"step": 1, "note": 48, "velocity": 100, "gate_ticks": 960},
            {"step": 5, "note": 50, "velocity": 100, "gate_ticks": 1920},
            {"step": 11, "note": 53, "velocity": 100, "gate_ticks": 2880},
        ],
    )
    assert raw == (CORPUS_DIR / "unnamed 92.xy").read_bytes()


def test_single_pattern_unnamed3_live_chord_compact_variant_is_not_yet_byte_exact() -> None:
    # unnamed 3 uses a compact continuation flavor in the event tail
    # (0x04/0x05 progression) that the current semantic note writer does not emit.
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[
                        {"step": 1, "note": 60, "velocity": 75, "gate_ticks": 5885},
                        {"step": 1, "note": 67, "velocity": 74, "gate_ticks": 5868},
                        {"step": 1, "note": 64, "velocity": 103, "gate_ticks": 5852},
                    ]],
                }
            ],
        },
        base_dir=ROOT,
    )
    raw = build_xy_bytes(spec)
    fixture = (CORPUS_DIR / "unnamed 3.xy").read_bytes()
    assert raw != fixture
    assert len(raw) == len(fixture) + 2
    first_diff = next(
        idx for idx, (built_b, fixture_b) in enumerate(zip(raw, fixture)) if built_b != fixture_b
    )
    assert first_diff == 0x7B4


def test_multi_pattern_build_compiles_with_strict_descriptor() -> None:
    base = XYProject.from_bytes((ROOT / TEMPLATE_REL).read_bytes())
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        None,
                        [{"step": 1, "note": 60, "velocity": 100}],
                    ],
                },
                {
                    "track": 3,
                    "patterns": [
                        None,
                        [{"step": 2, "note": 52, "velocity": 100}],
                    ],
                },
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = XYProject.from_bytes(raw)

    assert len(project.tracks) == 16
    assert int.from_bytes(project.pre_track[0x56:0x58], "little") == 1
    assert len(project.pre_track) == len(base.pre_track) + 7


def test_multi_pattern_t1_t3_matches_unnamed105_exact_bytes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None, [{"step": 1, "note": 60, "velocity": 100}]],
                },
                {
                    "track": 3,
                    "patterns": [None, [{"step": 2, "note": 52, "velocity": 100}]],
                },
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "unnamed 105.xy").read_bytes()


def test_multi_pattern_t1_t3_105b_branch_matches_unnamed105b_exact_bytes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None, [{"step": 1, "note": 60, "velocity": 100}]],
                },
                {
                    "track": 3,
                    "patterns": [
                        [{"step": 8, "note": 53, "velocity": 100}],
                        [{"step": 2, "note": 52, "velocity": 100}],
                    ],
                },
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "unnamed 105b.xy").read_bytes()


def test_multi_pattern_t1_two_pattern_matches_unnamed102_exact_bytes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None, [{"step": 9, "note": 60, "velocity": 100}]],
                }
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "unnamed 102.xy").read_bytes()


def test_multi_pattern_t1_two_pattern_both_active_matches_unnamed103_exact_bytes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                        [{"step": 9, "note": 64, "velocity": 100}],
                    ],
                }
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "unnamed 103.xy").read_bytes()


def test_multi_pattern_t1_three_pattern_matches_unnamed104_exact_bytes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                        None,
                        [{"step": 9, "note": 64, "velocity": 100}],
                    ],
                }
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "unnamed 104.xy").read_bytes()


def test_header_patch_applies_tempo() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "header": {"tempo_tenths": 980},
            "tracks": [
                {
                    "track": 1,
                    "patterns": [
                        [{"step": 1, "note": 60, "velocity": 100}],
                    ],
                },
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    container = XYContainer.from_bytes(raw)
    assert container.header.tempo_tenths == 980


def test_parse_rejects_duplicate_tracks() -> None:
    with pytest.raises(ValueError, match="duplicate track"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "tracks": [
                    {"track": 1, "patterns": [[{"step": 1, "note": 60}]]},
                    {"track": 1, "patterns": [[{"step": 5, "note": 62}]]},
                ],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_invalid_mode() -> None:
    with pytest.raises(ValueError, match="mode must be one of"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "live_midi",
                "template": TEMPLATE_REL,
                "tracks": [],
            },
            base_dir=ROOT,
        )


def test_build_rejects_mixed_pattern_counts() -> None:
    # Mixed pattern counts (T1 one pattern, T3 two patterns) matches neither
    # single_pattern_notes nor multi_pattern_strict. The profile gate rejects
    # it with a catalog hint before the builder-specific "mixed pattern
    # counts" error fires. Declaring an explicit profile surfaces the
    # profile-level rejection.
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [
                {"track": 1, "patterns": [[{"step": 1, "note": 60}]]},
                {"track": 3, "patterns": [None, [{"step": 2, "note": 52}]]},
            ],
        },
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="does not match any registered profile"):
        build_xy_bytes(spec)

    # With an explicit profile, the mismatch is attributed to the profile.
    spec_with_profile = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "profile": "multi_pattern_strict",
            "template": TEMPLATE_REL,
            "tracks": [
                {"track": 1, "patterns": [[{"step": 1, "note": 60}]]},
                {"track": 3, "patterns": [None, [{"step": 2, "note": 52}]]},
            ],
        },
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="profile=multi_pattern_strict"):
        build_xy_bytes(spec_with_profile)


def test_parse_defaults_version_and_descriptor_strategy() -> None:
    spec = parse_build_spec(
        {
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [_minimal_track_spec(3)],
        },
        base_dir=ROOT,
    )

    assert spec.version == 1
    assert spec.descriptor_strategy == "strict"
    assert spec.topology_policy == "none"
    assert spec.scene_song.pretrack_mode == "none"
    assert spec.scene_song.track16_mode == "none"
    assert spec.scene_assignments == {}
    assert spec.song_arrangement == []
    assert spec.output is None


def test_parse_scene_assignments_accepts_prefixed_keys() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "scene_assignments": {
                "S1": {f"T{track}": 1 for track in range(1, 9)},
                "S2": {f"T{track}": 2 for track in range(1, 9)},
            },
            "tracks": [_minimal_track_spec(1)],
        },
        base_dir=ROOT,
    )

    assert sorted(spec.scene_assignments) == [1, 2]
    assert spec.scene_assignments[1][1] == 1
    assert spec.scene_assignments[2][8] == 2


def test_parse_rejects_non_contiguous_scene_assignments() -> None:
    with pytest.raises(ValueError, match="scene_assignments scene ids must be contiguous"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "scene_assignments": {
                    "S1": {f"T{track}": 1 for track in range(1, 9)},
                    "S3": {f"T{track}": 1 for track in range(1, 9)},
                },
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_incomplete_scene_track_assignments() -> None:
    with pytest.raises(ValueError, match="must contain tracks 1..8"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "scene_assignments": {
                    "S1": {f"T{track}": 1 for track in range(1, 8)},
                },
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_build_applies_scene_assignments_matrix_template() -> None:
    template = ROOT / "src" / "unnamed 156.xy"
    if not template.exists():
        pytest.skip("unnamed 156 matrix template not available")

    expected = {
        1: {track: track for track in range(1, 9)},
        2: {track: track + 1 for track in range(1, 9)},
    }
    expected[2][8] = 8

    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(template),
            "scene_assignments": {
                f"S{scene}": {f"T{track}": pattern for track, pattern in row.items()}
                for scene, row in expected.items()
            },
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[{"step": 1, "note": 60, "velocity": 100}]],
                }
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = XYProject.from_bytes(raw)
    assert read_scene_assignments(project) == expected


def test_parse_song_arrangement_accepts_positive_scene_ids() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "song_arrangement": [1, 2, 1, 2],
            "tracks": [_minimal_track_spec(1)],
        },
        base_dir=ROOT,
    )
    assert spec.song_arrangement == [1, 2, 1, 2]


def test_build_rejects_song_arrangement_matrix_template_without_valid_track16_list() -> None:
    template = ROOT / "src" / "unnamed 156.xy"
    if not template.exists():
        pytest.skip("unnamed 156 matrix template not available")

    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(template),
            "song_arrangement": [1, 2, 1, 2],
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[{"step": 1, "note": 60, "velocity": 100}]],
                }
            ],
        },
        base_dir=ROOT,
    )

    with pytest.raises(ValueError, match="valid existing Track16 scene list"):
        build_xy_bytes(spec)


def test_build_applies_song_arrangement_tag_template() -> None:
    template = ROOT / "src" / "one-off-changes-from-default" / "07_scene_s3_t4p3.xy"
    if not template.exists():
        pytest.skip("tag-record scene template not available")

    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(template),
            "song_arrangement": [1, 3, 2, 3],
            "tracks": [
                {
                    "track": 3,
                    "patterns": [[{"step": 1, "note": 48, "velocity": 100}]],
                }
            ],
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = XYProject.from_bytes(raw)
    count, ids = read_t16_scene_list(project.tracks[15].body)
    assert count == 4
    assert ids == [0, 2, 1, 2]


def test_parse_resolves_relative_paths_against_base_dir(tmp_path: Path) -> None:
    template_abs = (ROOT / TEMPLATE_REL).resolve()
    template_rel = Path(os.path.relpath(template_abs, tmp_path))
    output_rel = Path("out") / "built.xy"

    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(template_rel),
            "output": str(output_rel),
            "tracks": [_minimal_track_spec(1)],
        },
        base_dir=tmp_path,
    )

    assert spec.template == template_abs
    assert spec.output == (tmp_path / output_rel).resolve()


def test_load_build_spec_resolves_relative_paths_from_file(tmp_path: Path) -> None:
    template_abs = (ROOT / TEMPLATE_REL).resolve()
    template_rel = Path(os.path.relpath(template_abs, tmp_path))
    output_rel = Path("output") / "from_load.xy"
    spec_file = tmp_path / "spec.json"
    spec_file.write_text(
        json.dumps(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": str(template_rel),
                "output": str(output_rel),
                "tracks": [_minimal_track_spec(1)],
            }
        ),
        encoding="utf-8",
    )

    loaded = load_build_spec(spec_file)
    assert loaded.template == template_abs
    assert loaded.output == (tmp_path / output_rel).resolve()


def test_parse_rejects_unsupported_spec_version() -> None:
    with pytest.raises(ValueError, match="unsupported spec version"):
        parse_build_spec(
            {
                "version": 2,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_invalid_descriptor_strategy() -> None:
    with pytest.raises(ValueError, match="descriptor_strategy must be one of"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "descriptor_strategy": "unsafe",
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_invalid_topology_policy() -> None:
    with pytest.raises(ValueError, match="topology_policy must be one of"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "topology_policy": "unsafe",
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_invalid_scene_song_pretrack_mode() -> None:
    with pytest.raises(ValueError, match="scene_song.pretrack_mode must be one of"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "scene_song": {"pretrack_mode": "unsafe"},
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_invalid_scene_song_track16_mode() -> None:
    with pytest.raises(ValueError, match="scene_song.track16_mode must be one of"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "scene_song": {"track16_mode": "unsafe"},
                "tracks": [_minimal_track_spec(1)],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_missing_patterns_key() -> None:
    with pytest.raises(ValueError, match="patterns is required"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "tracks": [{"track": 1}],
            },
            base_dir=ROOT,
        )


def test_parse_rejects_empty_patterns_array() -> None:
    with pytest.raises(ValueError, match="at least 1 pattern entry"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "tracks": [{"track": 1, "patterns": []}],
            },
            base_dir=ROOT,
        )


def test_parse_treats_empty_pattern_list_as_blank_pattern() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [{"track": 1, "patterns": [[]]}],
        },
        base_dir=ROOT,
    )
    assert spec.multi_tracks[0].patterns == [None]


def test_parse_note_defaults_are_applied() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "tracks": [
                {
                    "track": 1,
                    "patterns": [[{"step": 9, "note": 64}]],
                }
            ],
        },
        base_dir=ROOT,
    )
    note = spec.multi_tracks[0].patterns[0][0]
    assert note.velocity == 100
    assert note.tick_offset == 0
    assert note.gate_ticks == 0


def test_parse_rejects_note_value_out_of_range() -> None:
    with pytest.raises(ValueError, match=r"tracks\[0\].patterns\[0\]\[0\].note must be in \[0, 127\]"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "tracks": [
                    {
                        "track": 1,
                        "patterns": [[{"step": 1, "note": 128}]],
                    }
                ],
            },
            base_dir=ROOT,
        )


def test_build_rejects_single_pattern_blank_pattern0() -> None:
    # A single-pattern blank is not a valid single_pattern_notes spec.
    # Declaring the profile explicitly surfaces the profile-level message.
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "profile": "single_pattern_notes",
            "template": TEMPLATE_REL,
            "tracks": [
                {
                    "track": 1,
                    "patterns": [None],
                },
            ],
        },
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="empty/null patterns\\[0\\]"):
        build_xy_bytes(spec)


def test_multi_pattern_t2_three_pattern_blank_matches_j05_exact_bytes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "tracks": [{"track": 2, "patterns": [None, None, None]}],
        },
        base_dir=ROOT,
    )
    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "j05_t2_p3_blank.xy").read_bytes()


def test_build_accepts_large_t1_to_t8_nine_pattern_scaffold_topology() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(CORPUS_DIR / "unnamed 94.xy"),
            "descriptor_strategy": "strict",
            "tracks": [{"track": t, "patterns": [None] * 9} for t in range(1, 9)],
        },
        base_dir=ROOT,
    )
    result = build_xy_bytes(spec)
    assert len(result) > 0


def test_scaffold_preserving_j06_blank_round_trips_byte_exact() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(CORPUS_DIR / "j06_all16_p9_blank.xy"),
            "descriptor_strategy": "strict",
            "tracks": [{"track": t, "patterns": [None] * 9} for t in range(1, 9)],
        },
        base_dir=ROOT,
    )
    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "j06_all16_p9_blank.xy").read_bytes()


def test_topology_policy_bootstrap_t1_t8_p9_can_recreate_j06_from_sparse_blank_spec() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "topology_policy": "bootstrap_t1_t8_p9",
            "tracks": [
                {"track": 3, "patterns": [None] * 5},
                {"track": 6, "patterns": [None] * 5},
            ],
        },
        base_dir=ROOT,
    )
    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "j06_all16_p9_blank.xy").read_bytes()


def test_topology_policy_bootstrap_t1_t8_p9_rejects_tracks_outside_t1_t8() -> None:
    # The bootstrap profile validates tracks up-front, so T9 is rejected at
    # the profile layer rather than by _apply_bootstrap_t1_t8_p9. Both layers
    # catch this; the profile layer runs first.
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "profile": "bootstrap_t1_t8_p9",
            "template": TEMPLATE_REL,
            "descriptor_strategy": "strict",
            "topology_policy": "bootstrap_t1_t8_p9",
            "tracks": [
                {"track": 9, "patterns": [None, None]},
            ],
        },
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="tracks must be in T1..T8"):
        build_xy_bytes(spec)


def test_scaffold_preserving_j06_to_j07_sparsemap_matches_exact_bytes() -> None:
    sparse_tracks = [
        {"track": 1, "patterns": _nine_patterns({
            1: [{"step": 1, "note": 60, "velocity": 100}],
            9: [{"step": 9, "note": 60, "velocity": 100}],
        })},
        {"track": 2, "patterns": _nine_patterns({
            2: [{"step": 2, "note": 60, "velocity": 100}],
            9: [{"step": 10, "note": 60, "velocity": 100}],
        })},
        {"track": 3, "patterns": _nine_patterns({
            1: [{"step": 3, "note": 53, "velocity": 100}],
            9: [{"step": 11, "note": 53, "velocity": 100}],
        })},
        {"track": 4, "patterns": _nine_patterns({
            2: [{"step": 4, "note": 53, "velocity": 100}],
            9: [{"step": 12, "note": 53, "velocity": 100}],
        })},
        {"track": 5, "patterns": _nine_patterns({
            1: [{"step": 5, "note": 53, "velocity": 100}],
            9: [{"step": 13, "note": 53, "velocity": 100}],
        })},
        {"track": 6, "patterns": _nine_patterns({
            2: [{"step": 6, "note": 53, "velocity": 100}],
            9: [{"step": 14, "note": 53, "velocity": 100}],
        })},
        {"track": 7, "patterns": _nine_patterns({
            1: [{"step": 7, "note": 53, "velocity": 100}],
            9: [{"step": 15, "note": 53, "velocity": 100}],
        })},
        {"track": 8, "patterns": _nine_patterns({
            2: [{"step": 8, "note": 53, "velocity": 100}],
            9: [{"step": 16, "note": 53, "velocity": 100}],
        })},
    ]
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(CORPUS_DIR / "j06_all16_p9_blank.xy"),
            "descriptor_strategy": "strict",
            "tracks": sparse_tracks,
        },
        base_dir=ROOT,
    )
    raw = build_xy_bytes(spec)
    assert raw == (CORPUS_DIR / "j07_all16_p9_sparsemap.xy").read_bytes()


def test_scene_song_patch_applies_pretrack_and_track16_structure_modes() -> None:
    template_path = CORPUS_DIR / "j06_all16_p9_blank.xy"
    base_project = XYProject.from_bytes(template_path.read_bytes())
    base_entries = extract_logical_entries(base_project)
    base_body = next(e.body for e in base_entries if (e.track, e.pattern) == (16, 1))

    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": str(template_path),
            "descriptor_strategy": "strict",
            "tracks": [{"track": t, "patterns": [None] * 9} for t in range(1, 9)],
            "scene_song": {
                "pretrack_mode": "song2_scene2_bytes",
                "track16_mode": "song2_scene2_struct_154",
            },
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = XYProject.from_bytes(raw)
    assert project.pre_track[0x0F:0x12] == bytes.fromhex("010100")

    entries = extract_logical_entries(project)
    body = next(e.body for e in entries if (e.track, e.pattern) == (16, 1))
    assert len(body) == len(base_body) + 2
    assert body[351:357] == bytes.fromhex("020001010000")


def test_header_patch_applies_all_supported_fields() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "header": {
                "tempo_tenths": 1110,
                "groove_type": 2,
                "groove_amount": 77,
                "metronome_level": 64,
            },
            "tracks": [_minimal_track_spec(1)],
        },
        base_dir=ROOT,
    )
    raw = build_xy_bytes(spec)
    container = XYContainer.from_bytes(raw)
    assert container.header.tempo_tenths == 1110
    assert container.header.groove_type == 2
    assert container.header.groove_amount == 77
    assert container.header.metronome_level == 64


def test_sound_state_profile_applies_decoded_track_fields() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "profile": "sound_state",
            "sound_state": {
                "master_eq": {"low": 0, "mid": 0x12345678},
                "tracks": [
                    {
                        "track": 3,
                        "engine_id": 0x12,
                        "engine_params": {"param1": 0x01020304, "param4": 0x05060708},
                        "amp_envelope": {"attack": 0x11111111},
                        "m2_shift": {"engine_volume": 0x22222222},
                        "filter": {
                            "type": 2,
                            "enabled": False,
                            "cutoff": 0x33333333,
                            "resonance": 0x44444444,
                        },
                        "sends": {"fx1": 0x55555555},
                        "lfo_current": {"cc40": 0x66666666},
                        "filter_envelope": {"release": 0x77777777},
                        "mix": {"pan": 0x7FFFFFFF, "volume": 0x64C99326},
                    }
                ],
            },
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = ImageProject.from_bytes(raw)
    t3 = project.track_start(3)

    assert _global_u32(raw, 0x68) == 0
    assert _global_u32(raw, 0x6C) == 0x12345678
    assert project.image[t3 + 0x14] == 0x12
    assert project.image[t3 + 0x21] == 2
    assert project.image[t3 + 0x25] == 0
    assert _track_u32(raw, 3, 0x3857) == 0x01020304
    assert _track_u32(raw, 3, 0x3863) == 0x05060708
    assert _track_u32(raw, 3, 0x3877) == 0x11111111
    assert _track_u32(raw, 3, 0x3893) == 0x22222222
    assert _track_u32(raw, 3, 0x3897) == 0x33333333
    assert _track_u32(raw, 3, 0x389B) == 0x44444444
    assert _track_u32(raw, 3, 0x38AF) == 0x55555555
    assert _track_u32(raw, 3, 0x38B7) == 0x66666666
    assert _track_u32(raw, 3, 0x38E3) == 0x77777777
    assert _track_u32(raw, 3, 0x38F7) == 0x7FFFFFFF
    assert _track_u32(raw, 3, 0x38FB) == 0x64C99326


def test_sound_state_can_overlay_single_pattern_notes() -> None:
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "profile": "single_pattern_notes",
            "template": TEMPLATE_REL,
            "tracks": [_minimal_track_spec(3)],
            "sound_state": {
                "tracks": [
                    {"track": 3, "mix": {"volume": 0x7FFFFFFF}},
                ],
            },
        },
        base_dir=ROOT,
    )

    raw = build_xy_bytes(spec)
    project = XYProject.from_bytes(raw)

    assert project.tracks[2].type_byte == 0x07
    assert b"\x21\x01" in project.tracks[2].body
    assert _track_u32(raw, 3, 0x38FB) == 0x7FFFFFFF


def test_sound_state_rejects_unknown_keys_and_bad_values() -> None:
    with pytest.raises(ValueError, match="sound_state.tracks\\[0\\].mix.loudness"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "sound_state": {
                    "tracks": [{"track": 3, "mix": {"loudness": 1}}],
                },
            },
            base_dir=ROOT,
        )

    with pytest.raises(ValueError, match="sound_state.tracks\\[0\\].mix.volume"):
        parse_build_spec(
            {
                "version": 1,
                "mode": "multi_pattern",
                "template": TEMPLATE_REL,
                "sound_state": {
                    "tracks": [{"track": 3, "mix": {"volume": 0x1_0000_0000}}],
                },
            },
            base_dir=ROOT,
        )
