"""Unit tests for shared p-lock parsing/mutation helpers."""

from pathlib import Path
import sys

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.plocks import (
    count_lane_values,
    first_real_param_id,
    list_standard_nonempty_values,
    parse_standard_slots,
    parse_standard_table,
    parse_t10_header,
    rewrite_standard_nonempty_values,
    rewrite_standard_values_for_param_groups,
)


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"


def _track_body(filename: str, track: int) -> bytes:
    project = XYProject.from_bytes((CORPUS / filename).read_bytes())
    return project.tracks[track - 1].body


def test_parse_standard_slots_shape_unnamed121_t2() -> None:
    body = _track_body("unnamed 121.xy", 2)
    slots, _ = parse_standard_slots(body)

    assert len(slots) == 48
    assert all(slot.size in (3, 5) for slot in slots)
    assert sum(1 for slot in slots if slot.is_empty) == 34
    assert sum(1 for slot in slots if not slot.is_empty) == 14

    first = next(slot for slot in slots if not slot.is_empty)
    assert first.param_id == 0x5E
    assert first.value == 2064


def test_list_nonempty_matches_parse_table_projection() -> None:
    body = _track_body("unnamed 121.xy", 3)
    entries, _ = parse_standard_table(body)
    projected = [entry for entry in entries if entry is not None]
    assert list_standard_nonempty_values(body) == projected


def test_rewrite_standard_nonempty_values_updates_in_encounter_order() -> None:
    body = _track_body("unnamed 121.xy", 2)
    new_values = [256 + (i * 1000) for i in range(14)]
    rewritten = rewrite_standard_nonempty_values(body, new_values)

    entries, _ = parse_standard_table(rewritten)
    pid = first_real_param_id(entries)
    assert pid == 0x5E
    assert count_lane_values(entries, pid) == 14

    observed = [value for param_id, value in list_standard_nonempty_values(rewritten)]
    assert observed == new_values


def test_rewrite_groups_on_multilane_track_unnamed125_t3() -> None:
    body = _track_body("unnamed 125.xy", 3)
    lane_a_ids = {0x08, 0x18}
    lane_b_ids = {0x4C, 0x30}
    lane_a_values = [300 + i * 700 for i in range(12)]
    lane_b_values = [32000 - i * 1000 for i in range(11)]

    rewritten, counts = rewrite_standard_values_for_param_groups(
        body,
        [
            (lane_a_ids, lane_a_values),
            (lane_b_ids, lane_b_values),
        ],
    )
    assert counts == [12, 11]

    original = list_standard_nonempty_values(body)
    updated = list_standard_nonempty_values(rewritten)

    # Unchanged lanes remain unchanged.
    assert [v for p, v in updated if p == 0x00] == [v for p, v in original if p == 0x00]
    assert [v for p, v in updated if p == 0xD8] == [v for p, v in original if p == 0xD8]

    # Target lanes are rewritten.
    assert [v for p, v in updated if p in lane_a_ids] == lane_a_values
    assert [v for p, v in updated if p in lane_b_ids] == lane_b_values


def test_parse_t10_header_unnamed126() -> None:
    body = _track_body("unnamed 126.xy", 10)
    parsed = parse_t10_header(body)
    assert parsed.param_id == 0x39
    assert parsed.initial_value == 0x0040
    assert parsed.meta_lo == 0x40
    assert parsed.meta_hi == 0x00
    assert parsed.continuation_count == 14
