"""Targeted regression tests for known device crash classes.

These tests map directly to crash entries in docs/debug/crashes.md:
  - Crash #1: `num_patterns > 0` from 0x05/0x07 misalignment.
  - Crash #2: `fixed_vector.h:77 length < thesize` from malformed multi-note events.
  - Crash #3: later-site `num_patterns > 0` from propagation/offset rules.
"""

from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.note_events import Note
from xy.note_reader import read_track_notes
from xy.project_builder import (
    append_notes_to_track,
    append_notes_to_tracks,
    build_multi_pattern_project,
)


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"
BASELINE = CORPUS / "unnamed 1.xy"


def _baseline_project() -> XYProject:
    return XYProject.from_bytes(BASELINE.read_bytes())


def test_crash1_alignment_regression_matches_unnamed2() -> None:
    """Crash #1 guard: 0x05->0x07 path must keep body alignment valid."""
    project = _baseline_project()

    result = append_notes_to_track(
        project,
        track_index=1,
        notes=[Note(step=1, note=60, velocity=100)],
    )

    # Exact fixture reproduction ensures type flip + padding removal path remains stable.
    assert result.to_bytes() == (CORPUS / "unnamed 2.xy").read_bytes()
    assert result.tracks[0].type_byte == 0x07
    # 0x05-only padding marker must not remain after activation.
    assert result.tracks[0].body[10:12] != b"\x08\x00"


def test_crash2_multinote_event_regression_matches_unnamed89() -> None:
    """Crash #2 guard: multi-note event layout must match known-good specimen."""
    project = _baseline_project()

    result = append_notes_to_track(
        project,
        track_index=3,
        notes=[
            Note(step=1, note=5, velocity=100),
            Note(step=2, note=124, velocity=100),
            Note(step=3, note=60, velocity=100),
        ],
    )

    specimen = XYProject.from_bytes((CORPUS / "unnamed 89.xy").read_bytes())
    assert result.tracks[2].body == specimen.tracks[2].body

    parsed = read_track_notes(result.tracks[2], 3)
    assert [(n.step, n.note, n.velocity) for n in parsed] == [
        (1, 5, 100),
        (2, 124, 100),
        (3, 60, 100),
    ]


def test_crash3_preamble_propagation_regression() -> None:
    """Crash #3 guard: adjacent propagation with Track-5 exemption stays enforced."""
    project = _baseline_project()
    original_t5_preamble = project.tracks[4].preamble

    result = append_notes_to_tracks(
        project,
        {
            1: [Note(step=1, note=48, velocity=120)],
            2: [Note(step=1, note=56, velocity=100)],
            3: [Note(step=1, note=60, velocity=100)],
            4: [Note(step=1, note=62, velocity=100)],
        },
    )

    # Adjacent propagation chain.
    assert result.tracks[1].preamble[0] == 0x64
    assert result.tracks[2].preamble[0] == 0x64
    assert result.tracks[3].preamble[0] == 0x64
    # Critical exemption observed in device captures.
    assert result.tracks[4].preamble == original_t5_preamble

    out = result.to_bytes()
    reparsed = XYProject.from_bytes(out)
    assert reparsed.to_bytes() == out


def test_crash3_t3_leader_offset_regression_matches_unnamed105b() -> None:
    """Guard the 105b branch that previously triggered later-site num_patterns asserts."""
    project = _baseline_project()

    result = build_multi_pattern_project(
        project,
        {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [
                [Note(step=8, note=53, velocity=100)],
                [Note(step=2, note=52, velocity=100)],
            ],
        },
        descriptor_strategy="strict",
    )

    assert result.to_bytes() == (CORPUS / "unnamed 105b.xy").read_bytes()


def test_crash_prevention_strict_rejects_unsafe_track_sets() -> None:
    """Unsafe descriptor topologies must fail fast in strict mode."""
    project = _baseline_project()
    with pytest.raises(ValueError, match="unsupported multi-pattern track set"):
        build_multi_pattern_project(
            project,
            {
                2: [None, [Note(step=1, note=60, velocity=100)]],
                7: [None, [Note(step=1, note=48, velocity=100)]],
            },
            descriptor_strategy="strict",
        )
