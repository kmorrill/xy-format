"""P-lock mapping regressions for hold-record and grid captures (T018)."""

from __future__ import annotations

from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.plocks import (
    count_lane_values,
    first_real_param_id,
    parse_standard_table,
    parse_t10_header,
    t1_first_param_id,
)


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"


def _project(name: str) -> XYProject:
    return XYProject.from_bytes((CORPUS / name).read_bytes())


@pytest.mark.parametrize(
    ("track", "pid", "count"),
    [
        (2, 0x5E, 14),
        (3, 0x60, 14),
        (4, 0x62, 14),
        (5, 0x6C, 14),
        (6, 0x6E, 14),
        (7, 0x70, 14),
        (8, 0x72, 14),
    ],
)
def test_cc_map_1a_standard_param_ids(track: int, pid: int, count: int) -> None:
    proj = _project("unnamed 121.xy")
    entries, _ = parse_standard_table(proj.tracks[track - 1].body)
    assert first_real_param_id(entries) == pid
    assert count_lane_values(entries, pid) == count


@pytest.mark.parametrize(
    ("track", "pid", "count"),
    [
        (2, 0x9E, 12),
        (3, 0xA0, 12),
        (4, 0xA2, 12),
        (5, 0x74, 12),
        (6, 0x76, 12),
        (7, 0x78, 12),
        (8, 0x7A, 12),
    ],
)
def test_cc_map_1b_standard_param_ids(track: int, pid: int, count: int) -> None:
    proj = _project("unnamed 122.xy")
    entries, _ = parse_standard_table(proj.tracks[track - 1].body)
    assert first_real_param_id(entries) == pid
    assert count_lane_values(entries, pid) == count


@pytest.mark.parametrize(
    ("track", "pid", "count"),
    [
        (2, 0x7E, 13),
        (3, 0x80, 13),
        (4, 0x82, 13),
        (5, 0x84, 13),
        (6, 0x86, 13),
        (7, 0x88, 13),
        (8, 0x8A, 13),
    ],
)
def test_cc_map_1c_standard_param_ids(track: int, pid: int, count: int) -> None:
    proj = _project("unnamed 123.xy")
    entries, _ = parse_standard_table(proj.tracks[track - 1].body)
    assert first_real_param_id(entries) == pid
    assert count_lane_values(entries, pid) == count


def test_cc_map_1d_param_ids_and_mute_absence() -> None:
    proj = _project("unnamed 124.xy")

    t2, _ = parse_standard_table(proj.tracks[1].body)
    t3, _ = parse_standard_table(proj.tracks[2].body)
    t4, _ = parse_standard_table(proj.tracks[3].body)  # CC9 mute test
    t5, _ = parse_standard_table(proj.tracks[4].body)

    assert first_real_param_id(t2) == 0x8E
    assert count_lane_values(t2, 0x8E) == 9

    assert first_real_param_id(t3) == 0xAE
    assert count_lane_values(t3, 0xAE) == 9

    assert first_real_param_id(t5) == 0xAC
    assert count_lane_values(t5, 0xAC) == 9

    # Documented gap: CC9 mute on T4 did not produce p-lock entries.
    assert all(entry is None for entry in t4)


def test_cc32_grid_vs_hold_record_param_id_divergence() -> None:
    hold_record, _ = parse_standard_table(_project("unnamed 120.xy").tracks[2].body)
    grid_entered, _ = parse_standard_table(_project("unnamed 115.xy").tracks[2].body)

    assert first_real_param_id(hold_record) == 0xD0
    assert count_lane_values(hold_record, 0xD0) == 12

    assert first_real_param_id(grid_entered) == 0x7C
    assert count_lane_values(grid_entered, 0x7C) == 15


def test_grid_entered_macro1_track3_param_id() -> None:
    entries, _ = parse_standard_table(_project("unnamed 35.xy").tracks[2].body)
    assert first_real_param_id(entries) == 0x08
    assert count_lane_values(entries, 0x08) == 16


def test_cc_map_multi_track3_contains_expected_lane_ids() -> None:
    entries, _ = parse_standard_table(_project("unnamed 125.xy").tracks[2].body)
    non_empty = [entry for entry in entries if entry is not None]
    pids = [pid for pid, _value in non_empty]

    assert len(non_empty) == 37
    assert set(pids) == {0x00, 0x08, 0x18, 0x30, 0x4C, 0xD8}
    assert pids.count(0x00) == 13  # lane separators between multi-param values
    assert pids.count(0x18) == 11
    assert pids.count(0x30) == 10
    assert pids.count(0x08) == 1
    assert pids.count(0x4C) == 1
    assert pids.count(0xD8) == 1


def test_t1_slot_param_space_signatures_across_maps() -> None:
    expected = {
        "unnamed 121.xy": 0x09,
        "unnamed 122.xy": 0x20,
        "unnamed 123.xy": 0x2C,
        "unnamed 124.xy": 0x3A,
    }
    for name, pid in expected.items():
        proj = _project(name)
        assert t1_first_param_id(proj.tracks[0].body) == pid


def test_aux_cc_map_2a_track9_to_track16_and_t10_special_header() -> None:
    proj = _project("unnamed 126.xy")

    # Standard 5-byte path on aux/prism tracks.
    expected = {
        9: (0xAE, 15),
        11: (0x5C, 15),
        12: (0x8C, 15),
        13: (0x5C, 15),
        14: (0x5C, 15),
        15: (0x5C, 15),
        16: (0x5C, 15),
    }
    for track, (pid, count) in expected.items():
        entries, _ = parse_standard_table(proj.tracks[track - 1].body)
        assert first_real_param_id(entries) == pid
        assert count_lane_values(entries, pid) == count

    # T10 uses dedicated 9-byte entry format.
    t10 = proj.tracks[9]
    parsed = parse_t10_header(t10.body)
    assert t10.type_byte == 0x07
    assert parsed.param_id == 0x39
    assert parsed.continuation_count == 14
