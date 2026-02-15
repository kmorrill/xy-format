"""Project-builder p-lock authoring tests."""

from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.plocks import list_standard_nonempty_values
from xy.project_builder import (
    MIN_SAFE_STANDARD_PLOCK_VALUE,
    rewrite_track_standard_plock_groups,
    rewrite_track_standard_plock_values,
    transplant_track,
)


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"


def _project(name: str) -> XYProject:
    return XYProject.from_bytes((CORPUS / name).read_bytes())


def test_transplant_track_copies_body_and_preamble() -> None:
    base = _project("unnamed 1.xy")
    donor = _project("unnamed 121.xy")

    result = transplant_track(base, donor, track_index=2, copy_preamble=True)

    assert result.tracks[1].body == donor.tracks[1].body
    assert result.tracks[1].preamble == donor.tracks[1].preamble
    assert result.tracks[0] == base.tracks[0]
    assert result.tracks[2] == base.tracks[2]


def test_transplant_track_can_keep_target_preamble() -> None:
    base = _project("unnamed 1.xy")
    donor = _project("unnamed 121.xy")

    result = transplant_track(base, donor, track_index=2, copy_preamble=False)

    assert result.tracks[1].body == donor.tracks[1].body
    assert result.tracks[1].preamble == base.tracks[1].preamble


def test_rewrite_track_standard_plock_values_updates_all_nonempty_slots() -> None:
    project = _project("unnamed 121.xy")
    original = list_standard_nonempty_values(project.tracks[1].body)
    values = [MIN_SAFE_STANDARD_PLOCK_VALUE + i * 900 for i in range(14)]

    result = rewrite_track_standard_plock_values(project, track_index=2, values=values)
    updated = list_standard_nonempty_values(result.tracks[1].body)

    assert [pid for pid, _ in updated] == [pid for pid, _ in original]
    assert [value for _pid, value in updated] == values
    assert result.tracks[0] == project.tracks[0]
    assert result.tracks[2] == project.tracks[2]


def test_rewrite_track_standard_plock_values_requires_exact_count() -> None:
    project = _project("unnamed 121.xy")
    values = [MIN_SAFE_STANDARD_PLOCK_VALUE] * 13

    with pytest.raises(ValueError, match="has 14 non-empty standard p-lock entries"):
        rewrite_track_standard_plock_values(project, track_index=2, values=values)


def test_rewrite_track_standard_plock_values_rejects_unsafe_floor() -> None:
    project = _project("unnamed 121.xy")
    values = [255] * 14

    with pytest.raises(ValueError, match="must be in \\[256, 32767\\]"):
        rewrite_track_standard_plock_values(project, track_index=2, values=values)


def test_rewrite_track_standard_plock_values_rejects_nonstandard_t1_format() -> None:
    project = _project("unnamed 121.xy")

    with pytest.raises(ValueError, match="does not use standard 5-byte p-lock entries"):
        rewrite_track_standard_plock_values(
            project,
            track_index=1,
            values=[MIN_SAFE_STANDARD_PLOCK_VALUE],
            require_exact_count=False,
        )


def test_rewrite_track_standard_plock_groups_updates_selected_lanes() -> None:
    project = _project("unnamed 125.xy")
    original = list_standard_nonempty_values(project.tracks[2].body)

    lane_a_ids = {0x08, 0x18}
    lane_b_ids = {0x4C, 0x30}
    lane_a_values = [300 + i * 700 for i in range(12)]
    lane_b_values = [32000 - i * 1000 for i in range(11)]

    result, counts = rewrite_track_standard_plock_groups(
        project,
        track_index=3,
        groups=[
            (lane_a_ids, lane_a_values),
            (lane_b_ids, lane_b_values),
        ],
    )
    updated = list_standard_nonempty_values(result.tracks[2].body)

    assert counts == [12, 11]
    assert [v for p, v in updated if p in lane_a_ids] == lane_a_values
    assert [v for p, v in updated if p in lane_b_ids] == lane_b_values
    assert [v for p, v in updated if p == 0x00] == [v for p, v in original if p == 0x00]
    assert [v for p, v in updated if p == 0xD8] == [v for p, v in original if p == 0xD8]


def test_rewrite_track_standard_plock_groups_rejects_overlap() -> None:
    project = _project("unnamed 125.xy")

    with pytest.raises(ValueError, match="overlap previous groups"):
        rewrite_track_standard_plock_groups(
            project,
            track_index=3,
            groups=[
                ({0x08}, [300]),
                ({0x08, 0x18}, [400]),
            ],
        )


def test_rewrite_track_standard_plock_groups_requires_full_consumption() -> None:
    project = _project("unnamed 125.xy")

    with pytest.raises(ValueError, match="consumed 12 of 13 values"):
        rewrite_track_standard_plock_groups(
            project,
            track_index=3,
            groups=[
                ({0x08, 0x18}, [600 + i for i in range(13)]),
            ],
        )
