"""Pre-track descriptor and handle-table safety regressions (T009)."""

from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYProject
from xy.note_events import Note
from xy.project_builder import build_multi_pattern_project


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"
BASELINE = CORPUS / "unnamed 1.xy"


def _load_pre_track(name: str) -> bytes:
    return XYProject.from_bytes((CORPUS / name).read_bytes()).pre_track


def _find_ff_table_start(pre_track: bytes) -> int | None:
    for i in range(0x40, len(pre_track) - 24):
        if all(pre_track[i + k * 3 : i + k * 3 + 3] == b"\xff\x00\x00" for k in range(8)):
            return i
    return None


@pytest.mark.parametrize(
    ("name", "offset", "descriptor_hex", "expected_ff_start"),
    [
        ("unnamed 6.xy", 0x56, "0100001d01", 0x5D),
        ("unnamed 7.xy", 0x56, "0200001d01", 0x5D),
        ("unnamed 105.xy", 0x56, "01000100001b01", 0x5F),
        ("unnamed 105b.xy", 0x56, "0100001d01", 0x5D),
        ("j05_t2_p3_blank.xy", 0x57, "0200001c0100", 0x5E),
        ("j06_all16_p9_blank.xy", 0x56, "08080600001601", 0x5F),
        ("j07_all16_p9_sparsemap.xy", 0x56, "08080600001601", 0x5F),
    ],
)
def test_device_fixture_descriptor_variants_and_handle_table(
    name: str,
    offset: int,
    descriptor_hex: str,
    expected_ff_start: int,
) -> None:
    pre = _load_pre_track(name)
    descriptor = bytes.fromhex(descriptor_hex)

    assert pre[offset : offset + len(descriptor)] == descriptor

    ff_start = _find_ff_table_start(pre)
    assert ff_start == expected_ff_start
    # Canonical handle table is 12 x 3-byte entries at pre-track tail.
    assert len(pre) - ff_start == 36


def test_strict_writer_t1_descriptor_and_handle_layout() -> None:
    baseline = XYProject.from_bytes(BASELINE.read_bytes())
    result = build_multi_pattern_project(
        baseline,
        {1: [None, [Note(step=1, note=60, velocity=100)]]},
        descriptor_strategy="strict",
    )

    pre = result.pre_track
    assert pre[0x56:0x5B] == bytes.fromhex("0100001d01")
    ff_start = _find_ff_table_start(pre)
    assert ff_start == 0x5D
    assert len(pre) - ff_start == 36


def test_strict_writer_t1_t3_descriptor_and_handle_layout() -> None:
    baseline = XYProject.from_bytes(BASELINE.read_bytes())
    result = build_multi_pattern_project(
        baseline,
        {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [None, [Note(step=2, note=52, velocity=100)]],
        },
        descriptor_strategy="strict",
    )

    pre = result.pre_track
    assert pre[0x56:0x5D] == bytes.fromhex("01000100001b01")
    ff_start = _find_ff_table_start(pre)
    assert ff_start == 0x5F
    assert len(pre) - ff_start == 36


def test_105b_writer_branch_uses_t1_style_descriptor_and_handle_layout() -> None:
    baseline = XYProject.from_bytes(BASELINE.read_bytes())
    result = build_multi_pattern_project(
        baseline,
        {
            1: [None, [Note(step=1, note=60, velocity=100)]],
            3: [
                [Note(step=8, note=53, velocity=100)],
                [Note(step=2, note=52, velocity=100)],
            ],
        },
        descriptor_strategy="strict",
    )

    pre = result.pre_track
    assert pre[0x56:0x5B] == bytes.fromhex("0100001d01")
    ff_start = _find_ff_table_start(pre)
    assert ff_start == 0x5D
    assert len(pre) - ff_start == 36
