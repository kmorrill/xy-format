"""Build profiles: the known-safe contract for ``xy/json_build_spec.py``.

A *profile* names a specific validated build recipe. Every JSON spec must
declare a ``profile`` so the compiler can reject requests that fall outside
the device-verified paths. Each profile ties back to fixtures and log entries
that demonstrate it produces files the device loads.

Profiles are intentionally narrow. Generalising a profile requires:
1. Corpus evidence (fixture reproduction or device-verified output), and
2. A regression test pinning the new case, and
3. An entry in ``docs/format/*`` documenting the rule.

This module is pure validation — it does not perform any writes. The compiler
in ``json_build_spec.build_xy_bytes`` runs the profile's validator after
parsing and before any template mutation.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import TYPE_CHECKING, Callable, Dict, FrozenSet, Optional, Tuple

if TYPE_CHECKING:  # pragma: no cover - import only for type hints
    from .json_build_spec import BuildSpec


# ── Known-safe multi-pattern track sets ────────────────────────────────
#
# These must stay in sync with ``xy/project_builder.py::_STRICT_DESCRIPTORS``.
# Entries are 0-based track indices. Any T3+-only set is additionally
# supported via Scheme A encoding (see ``_scheme_a_descriptor``).
STRICT_DESCRIPTOR_TRACK_SETS: FrozenSet[FrozenSet[int]] = frozenset({
    frozenset({0}),                      # T1
    frozenset({1}),                      # T2
    frozenset({0, 1}),                   # T1+T2
    frozenset({0, 2}),                   # T1+T3
    frozenset({0, 3}),                   # T1+T4
    frozenset({0, 1, 2}),                # T1+T2+T3
    frozenset({0, 1, 2, 3, 4, 5, 6, 7}),  # all 8 tracks
    frozenset({2}),                      # T3
    frozenset({3}),                      # T4
    frozenset({6}),                      # T7
})


def _is_scheme_a_track_set(track_set_0based: FrozenSet[int]) -> bool:
    """Return True if a multi-pattern track set is encodable by Scheme A.

    Scheme A applies when every track is T3+ (0-based index >= 2). The
    encoder is fully cracked — see ``docs/format/descriptor_encoding.md``.
    """
    return bool(track_set_0based) and all(ti >= 2 for ti in track_set_0based)


def _is_supported_track_set(track_set_0based: FrozenSet[int]) -> bool:
    """Return True if the strict-mode path can emit this track set safely."""
    if track_set_0based in STRICT_DESCRIPTOR_TRACK_SETS:
        return True
    return _is_scheme_a_track_set(track_set_0based)


# ── Profile definitions ────────────────────────────────────────────────


@dataclass(frozen=True)
class Profile:
    """Named build recipe with its validation contract.

    Attributes
    ----------
    name : str
        The string users put in the JSON ``profile`` field.
    description : str
        One-sentence summary of what the profile does.
    evidence : str
        Pointer to the fixtures/logs that validate the recipe.
    validate : callable
        ``validate(spec) -> None``. Raises ``ValueError`` if the spec does
        not fit this profile.
    """

    name: str
    description: str
    evidence: str
    validate: Callable[["BuildSpec"], None]


def _no_track_changes(spec: "BuildSpec") -> bool:
    return not spec.multi_tracks


def _pattern_lengths(spec: "BuildSpec") -> FrozenSet[int]:
    return frozenset(len(t.patterns) for t in spec.multi_tracks)


def _active_track_set_0based(spec: "BuildSpec") -> FrozenSet[int]:
    return frozenset((t.track - 1) for t in spec.multi_tracks)


def _require(cond: bool, msg: str) -> None:
    if not cond:
        raise ValueError(msg)


# ── header_only ───────────────────────────────────────────────────────


def _validate_header_only(spec: "BuildSpec") -> None:
    _require(
        spec.header.has_changes(),
        "profile=header_only requires at least one header field "
        "(tempo_tenths, groove_type, groove_amount, metronome_level)",
    )
    _require(
        _no_track_changes(spec),
        "profile=header_only does not allow track changes; "
        "use multi_pattern_strict or single_pattern_notes instead",
    )
    _require(
        not spec.scene_song.has_changes(),
        "profile=header_only does not allow scene_song patches; "
        "use profile=scene_song_tokens instead",
    )
    _require(
        not spec.scene_assignments,
        "profile=header_only does not allow scene_assignments; "
        "use profile=scene_assignments instead",
    )
    _require(
        not spec.song_arrangement,
        "profile=header_only does not allow song_arrangement; "
        "use profile=scene_assignments instead",
    )
    _require(
        not spec.sound_state.has_changes(),
        "profile=header_only does not allow sound_state patches; "
        "use profile=sound_state instead",
    )
    _require(
        spec.topology_policy == "none",
        "profile=header_only requires topology_policy=none",
    )


# ── single_pattern_notes ──────────────────────────────────────────────


def _validate_single_pattern_notes(spec: "BuildSpec") -> None:
    _require(
        spec.mode == "multi_pattern",
        "profile=single_pattern_notes requires mode=multi_pattern",
    )
    _require(
        bool(spec.multi_tracks),
        "profile=single_pattern_notes requires at least one track",
    )
    lengths = _pattern_lengths(spec)
    _require(
        lengths == {1},
        "profile=single_pattern_notes requires every listed track to have "
        "exactly one pattern entry; got pattern counts "
        f"{sorted(lengths)}",
    )
    for entry in spec.multi_tracks:
        _require(
            bool(entry.patterns[0]),
            f"profile=single_pattern_notes: track {entry.track} has an "
            "empty/null patterns[0]; use multi_pattern_strict for blanks",
        )
    _require(
        spec.topology_policy == "none",
        "profile=single_pattern_notes requires topology_policy=none",
    )


# ── multi_pattern_strict ──────────────────────────────────────────────


def _validate_multi_pattern_strict(spec: "BuildSpec") -> None:
    _require(
        spec.mode == "multi_pattern",
        "profile=multi_pattern_strict requires mode=multi_pattern",
    )
    _require(
        bool(spec.multi_tracks),
        "profile=multi_pattern_strict requires at least one track",
    )
    lengths = _pattern_lengths(spec)
    _require(
        1 not in lengths,
        "profile=multi_pattern_strict requires every listed track to have "
        "at least 2 pattern entries; use profile=single_pattern_notes for "
        "one-pattern-per-track builds",
    )
    _require(
        spec.descriptor_strategy == "strict",
        "profile=multi_pattern_strict requires descriptor_strategy=strict "
        "(heuristic_v1 is deprecated and crash-prone)",
    )
    _require(
        spec.topology_policy == "none",
        "profile=multi_pattern_strict requires topology_policy=none; "
        "use profile=bootstrap_t1_t8_p9 for the sparse-topology mitigation",
    )

    track_set = _active_track_set_0based(spec)
    _require(
        _is_supported_track_set(track_set),
        "profile=multi_pattern_strict: track set "
        f"{{{','.join(f'T{ti + 1}' for ti in sorted(track_set))}}} is not "
        "device-verified. Strict mode supports the lookup table and any "
        "T3+-only combination. See docs/format/descriptor_encoding.md",
    )


# ── bootstrap_t1_t8_p9 ────────────────────────────────────────────────


def _validate_bootstrap_t1_t8_p9(spec: "BuildSpec") -> None:
    _require(
        spec.mode == "multi_pattern",
        "profile=bootstrap_t1_t8_p9 requires mode=multi_pattern",
    )
    _require(
        spec.topology_policy == "bootstrap_t1_t8_p9",
        "profile=bootstrap_t1_t8_p9 requires topology_policy=bootstrap_t1_t8_p9",
    )
    _require(
        bool(spec.multi_tracks),
        "profile=bootstrap_t1_t8_p9 requires at least one track entry",
    )
    for entry in spec.multi_tracks:
        _require(
            1 <= entry.track <= 8,
            "profile=bootstrap_t1_t8_p9: tracks must be in T1..T8; "
            f"got T{entry.track}",
        )


# ── scene_song_tokens ─────────────────────────────────────────────────


def _validate_scene_song_tokens(spec: "BuildSpec") -> None:
    _require(
        spec.scene_song.has_changes(),
        "profile=scene_song_tokens requires scene_song.pretrack_mode or "
        "scene_song.track16_mode to be set",
    )
    _require(
        not spec.scene_assignments,
        "profile=scene_song_tokens does not mix with scene_assignments; "
        "use profile=scene_assignments instead",
    )


# ── scene_assignments ─────────────────────────────────────────────────


def _validate_scene_assignments(spec: "BuildSpec") -> None:
    _require(
        bool(spec.scene_assignments) or bool(spec.song_arrangement),
        "profile=scene_assignments requires at least one of "
        "scene_assignments or song_arrangement",
    )
    _require(
        not spec.scene_song.has_changes(),
        "profile=scene_assignments does not mix with scene_song patches; "
        "use profile=scene_song_tokens instead",
    )


# ── sound_state ───────────────────────────────────────────────────────


def _validate_sound_state(spec: "BuildSpec") -> None:
    _require(
        spec.sound_state.has_changes(),
        "profile=sound_state requires at least one sound_state edit",
    )
    _require(
        _no_track_changes(spec),
        "profile=sound_state does not allow note/pattern changes; "
        "use a note/multi-pattern profile and include sound_state there",
    )
    _require(
        not spec.scene_song.has_changes(),
        "profile=sound_state does not allow scene_song patches; "
        "use profile=scene_song_tokens and include sound_state there",
    )
    _require(
        not spec.scene_assignments,
        "profile=sound_state does not allow scene_assignments; "
        "use profile=scene_assignments and include sound_state there",
    )
    _require(
        not spec.song_arrangement,
        "profile=sound_state does not allow song_arrangement; "
        "use profile=scene_assignments and include sound_state there",
    )
    _require(
        spec.topology_policy == "none",
        "profile=sound_state requires topology_policy=none",
    )


# ── Registry ──────────────────────────────────────────────────────────


PROFILES: Dict[str, Profile] = {
    "header_only": Profile(
        name="header_only",
        description=(
            "Header patch (tempo/groove/metronome) on any valid template. "
            "No track, scene, or song changes."
        ),
        evidence="T003 header patch writer safety; xy/container.py round-trip (206/206 corpus)",
        validate=_validate_header_only,
    ),
    "single_pattern_notes": Profile(
        name="single_pattern_notes",
        description=(
            "Pure append of note events to one or more tracks that each "
            "carry a single pattern. No descriptor changes."
        ),
        evidence="T004 (unnamed 2, 81); docs/format/events.md; output/ode_to_joy*.xy",
        validate=_validate_single_pattern_notes,
    ),
    "multi_pattern_strict": Profile(
        name="multi_pattern_strict",
        description=(
            "Multi-pattern build with device-verified descriptor. Track set "
            "must be in the strict lookup table or T3+-only (Scheme A)."
        ),
        evidence="T005 (unnamed 102-105b); docs/format/descriptor_encoding.md",
        validate=_validate_multi_pattern_strict,
    ),
    "bootstrap_t1_t8_p9": Profile(
        name="bootstrap_t1_t8_p9",
        description=(
            "8-track x 9-pattern strict topology starting from unnamed 1 / "
            "j06 scaffold. Safe mitigation for sparse-topology crashes."
        ),
        evidence=(
            "docs/issues/sparse_topology_stability.md; "
            "docs/format/multi_pattern_block_rotation.md 2026-02-28 bootstrap rule"
        ),
        validate=_validate_bootstrap_t1_t8_p9,
    ),
    "scene_song_tokens": Profile(
        name="scene_song_tokens",
        description=(
            "Pre-track and Track16 token patches for scene/song control. "
            "Works only on scaffolds with matching pre-track shape."
        ),
        evidence="docs/format/scenes_songs.md sections 4-6; tools/patch_scene_song_tokens.py",
        validate=_validate_scene_song_tokens,
    ),
    "scene_assignments": Profile(
        name="scene_assignments",
        description=(
            "Scene pattern-map and/or song arrangement rewrite on a "
            "scaffold whose scene family is decoded (tag-record or matrix)."
        ),
        evidence=(
            "docs/format/scenes_songs.md sections 15, 17; "
            "xy/scene_patcher.py; xy/scene_records.py"
        ),
        validate=_validate_scene_assignments,
    ),
    "sound_state": Profile(
        name="sound_state",
        description=(
            "Decoded-image sound-state patch for master EQ and per-track "
            "engine params, envelopes, filter, sends, LFO current lanes, "
            "and mix pan/volume."
        ),
        evidence=(
            "docs/format/decoded_image_map.md current-value lanes; "
            "tests/test_image_writer.py current-lane capture regressions"
        ),
        validate=_validate_sound_state,
    ),
}


# ── Public API ────────────────────────────────────────────────────────


def profile_names() -> Tuple[str, ...]:
    """Return the registered profile names in stable order."""
    return tuple(PROFILES.keys())


def validate_against_profile(spec: "BuildSpec", profile_name: str) -> None:
    """Validate that a BuildSpec conforms to the named profile.

    Raises
    ------
    ValueError
        If the profile does not exist, or if the spec violates it.
    """
    if profile_name not in PROFILES:
        known = ", ".join(sorted(PROFILES))
        raise ValueError(
            f"unknown profile {profile_name!r}; registered profiles: {known}"
        )
    PROFILES[profile_name].validate(spec)


def infer_profile(spec: "BuildSpec") -> Optional[str]:
    """Best-effort infer a profile for legacy specs without a ``profile`` field.

    Returns the most specific profile the spec would fit, or ``None`` if
    the spec does not match any registered profile. This is used to help
    users migrate existing specs; the inferred value is NEVER trusted as
    a safety gate.
    """
    # Order matters: try the most specific first.
    ordered = (
        "bootstrap_t1_t8_p9",
        "scene_assignments",
        "scene_song_tokens",
        "multi_pattern_strict",
        "single_pattern_notes",
        "sound_state",
        "header_only",
    )
    for name in ordered:
        try:
            PROFILES[name].validate(spec)
        except ValueError:
            continue
        return name
    return None
