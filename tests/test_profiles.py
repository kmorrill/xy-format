"""Tests for the build-profile validation layer."""

from __future__ import annotations

import json
import warnings
from pathlib import Path

import pytest

from xy.json_build_spec import BuildSpec, build_xy_bytes, parse_build_spec
from xy.profiles import (
    PROFILES,
    STRICT_DESCRIPTOR_TRACK_SETS,
    infer_profile,
    profile_names,
    validate_against_profile,
)


ROOT = Path(__file__).resolve().parents[1]
TEMPLATE_REL = "src/one-off-changes-from-default/unnamed 1.xy"
MULTI_PATTERN_TEMPLATE = "src/one-off-changes-from-default/unnamed 1.xy"
MATRIX_TEMPLATE = "src/one-off-changes-from-default/unnamed 1.xy"


def _base_spec_dict(**overrides):
    spec = {
        "version": 1,
        "mode": "multi_pattern",
        "template": TEMPLATE_REL,
        "tracks": [
            {"track": 1, "patterns": [[{"step": 1, "note": 60}]]},
        ],
    }
    spec.update(overrides)
    return spec


# ── Registry ──────────────────────────────────────────────────────────


def test_profile_registry_has_expected_entries():
    # Any drift here is intentional — update both code and this test
    # together so the safety contract stays explicit.
    assert set(profile_names()) == {
        "header_only",
        "single_pattern_notes",
        "multi_pattern_strict",
        "bootstrap_t1_t8_p9",
        "scene_song_tokens",
        "scene_assignments",
        "sound_state",
    }


def test_profile_registry_entries_have_evidence():
    for name, profile in PROFILES.items():
        assert profile.name == name
        assert profile.description
        assert profile.evidence


def test_strict_descriptor_track_sets_matches_project_builder():
    # Profiles.STRICT_DESCRIPTOR_TRACK_SETS must stay in sync with
    # project_builder._STRICT_DESCRIPTORS keys.
    from xy.project_builder import _STRICT_DESCRIPTORS

    assert STRICT_DESCRIPTOR_TRACK_SETS == frozenset(_STRICT_DESCRIPTORS.keys())


# ── validate_against_profile ─────────────────────────────────────────


def test_validate_unknown_profile_raises():
    spec = parse_build_spec(_base_spec_dict(profile="single_pattern_notes"), base_dir=ROOT)
    with pytest.raises(ValueError, match="unknown profile"):
        validate_against_profile(spec, "does_not_exist")


def test_single_pattern_notes_accepts_one_pattern_with_notes():
    spec = parse_build_spec(
        _base_spec_dict(profile="single_pattern_notes"),
        base_dir=ROOT,
    )
    validate_against_profile(spec, "single_pattern_notes")  # no raise


def test_single_pattern_notes_rejects_multi_pattern():
    spec = parse_build_spec(
        _base_spec_dict(
            profile="single_pattern_notes",
            tracks=[{"track": 3, "patterns": [None, [{"step": 1, "note": 60}]]}],
        ),
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="exactly one pattern entry"):
        validate_against_profile(spec, "single_pattern_notes")


def test_multi_pattern_strict_accepts_t3_only():
    spec = parse_build_spec(
        _base_spec_dict(
            profile="multi_pattern_strict",
            tracks=[{"track": 3, "patterns": [None, None]}],
        ),
        base_dir=ROOT,
    )
    validate_against_profile(spec, "multi_pattern_strict")


def test_multi_pattern_strict_accepts_scheme_a_t3_plus_t7():
    # T3+T7 is a T3+-only combination; Scheme A encodes any such set.
    spec = parse_build_spec(
        _base_spec_dict(
            profile="multi_pattern_strict",
            tracks=[
                {"track": 3, "patterns": [None, None]},
                {"track": 7, "patterns": [None, None]},
            ],
        ),
        base_dir=ROOT,
    )
    validate_against_profile(spec, "multi_pattern_strict")


def test_multi_pattern_strict_rejects_unverified_track_set():
    # T1+T5 is neither in the lookup nor a T3+-only Scheme A set.
    spec = parse_build_spec(
        _base_spec_dict(
            profile="multi_pattern_strict",
            tracks=[
                {"track": 1, "patterns": [None, None]},
                {"track": 5, "patterns": [None, None]},
            ],
        ),
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="not device-verified"):
        validate_against_profile(spec, "multi_pattern_strict")


def test_multi_pattern_strict_rejects_heuristic_descriptor_strategy():
    spec = parse_build_spec(
        _base_spec_dict(
            profile="multi_pattern_strict",
            descriptor_strategy="heuristic_v1",
            tracks=[{"track": 3, "patterns": [None, None]}],
        ),
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="descriptor_strategy=strict"):
        validate_against_profile(spec, "multi_pattern_strict")


def test_bootstrap_t1_t8_p9_requires_topology_policy():
    spec = parse_build_spec(
        _base_spec_dict(
            profile="bootstrap_t1_t8_p9",
            tracks=[{"track": 3, "patterns": [None, None]}],
        ),
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="topology_policy=bootstrap_t1_t8_p9"):
        validate_against_profile(spec, "bootstrap_t1_t8_p9")


def test_bootstrap_t1_t8_p9_rejects_aux_tracks():
    spec = parse_build_spec(
        _base_spec_dict(
            profile="bootstrap_t1_t8_p9",
            topology_policy="bootstrap_t1_t8_p9",
            tracks=[{"track": 9, "patterns": [None, None]}],
        ),
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="tracks must be in T1..T8"):
        validate_against_profile(spec, "bootstrap_t1_t8_p9")


def test_sound_state_accepts_pure_sound_edits():
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "profile": "sound_state",
            "sound_state": {
                "tracks": [
                    {"track": 3, "mix": {"volume": 0x7FFFFFFF}},
                ],
            },
        },
        base_dir=ROOT,
    )
    validate_against_profile(spec, "sound_state")


def test_header_only_rejects_sound_state():
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "profile": "header_only",
            "header": {"tempo_tenths": 1200},
            "sound_state": {"tracks": [{"track": 3, "mix": {"pan": 0}}]},
        },
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="sound_state patches"):
        validate_against_profile(spec, "header_only")


def test_sound_state_profile_rejects_note_changes():
    spec = parse_build_spec(
        _base_spec_dict(
            profile="sound_state",
            sound_state={"tracks": [{"track": 3, "mix": {"volume": 1}}]},
        ),
        base_dir=ROOT,
    )
    with pytest.raises(ValueError, match="does not allow note/pattern changes"):
        validate_against_profile(spec, "sound_state")


# ── infer_profile ─────────────────────────────────────────────────────


def test_infer_profile_single_pattern_notes():
    spec = parse_build_spec(_base_spec_dict(), base_dir=ROOT)
    assert infer_profile(spec) == "single_pattern_notes"


def test_infer_profile_multi_pattern_strict():
    spec = parse_build_spec(
        _base_spec_dict(
            tracks=[{"track": 3, "patterns": [None, [{"step": 1, "note": 60}]]}]
        ),
        base_dir=ROOT,
    )
    assert infer_profile(spec) == "multi_pattern_strict"


def test_infer_profile_bootstrap_takes_precedence_over_strict():
    spec = parse_build_spec(
        _base_spec_dict(
            topology_policy="bootstrap_t1_t8_p9",
            tracks=[
                {"track": t, "patterns": [None] * 9} for t in range(1, 9)
            ],
        ),
        base_dir=ROOT,
    )
    assert infer_profile(spec) == "bootstrap_t1_t8_p9"


def test_infer_profile_sound_state():
    spec = parse_build_spec(
        {
            "version": 1,
            "mode": "multi_pattern",
            "template": TEMPLATE_REL,
            "sound_state": {"tracks": [{"track": 3, "mix": {"volume": 1}}]},
        },
        base_dir=ROOT,
    )
    assert infer_profile(spec) == "sound_state"


def test_infer_profile_returns_none_for_unmatched_spec():
    # Mixed pattern counts match no profile.
    spec = parse_build_spec(
        _base_spec_dict(
            tracks=[
                {"track": 1, "patterns": [[{"step": 1, "note": 60}]]},
                {"track": 3, "patterns": [None, [{"step": 2, "note": 52}]]},
            ],
        ),
        base_dir=ROOT,
    )
    assert infer_profile(spec) is None


# ── Integration with build_xy_bytes ───────────────────────────────────


def test_build_with_explicit_profile_silences_warning():
    spec = parse_build_spec(
        _base_spec_dict(profile="single_pattern_notes"),
        base_dir=ROOT,
    )
    with warnings.catch_warnings():
        warnings.simplefilter("error")  # any warning becomes an error
        build_xy_bytes(spec)


def test_build_without_profile_emits_deprecation_warning():
    spec = parse_build_spec(_base_spec_dict(), base_dir=ROOT)
    with pytest.warns(DeprecationWarning, match="inferred 'single_pattern_notes'"):
        build_xy_bytes(spec)


def test_build_with_profile_mismatch_raises():
    # Declares single_pattern_notes but actually has 2-pattern tracks.
    spec_dict = _base_spec_dict(
        profile="single_pattern_notes",
        tracks=[{"track": 3, "patterns": [None, None]}],
    )
    spec = parse_build_spec(spec_dict, base_dir=ROOT)
    with pytest.raises(ValueError, match="profile=single_pattern_notes"):
        build_xy_bytes(spec)


def test_parse_rejects_unknown_profile_name():
    with pytest.raises(ValueError, match="profile must be one of"):
        parse_build_spec(
            _base_spec_dict(profile="not_a_profile"),
            base_dir=ROOT,
        )
