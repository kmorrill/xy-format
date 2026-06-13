from pathlib import Path

import pytest

from xy.image_writer import ImageProject
from xy.master_eq_inspection import (
    EQ_BYTE_DEFAULT,
    EQ_BYTE_MAX,
    EQ_BYTE_MIN,
    EQ_U32_DEFAULT,
    EQ_U32_MAX,
    EQ_U32_MAX_WITH_TAIL,
    EQ_U32_MIN,
    GLOBAL_EQ_BLEND_U32_OFFSET,
    GLOBAL_EQ_HIGH_U32_OFFSET,
    GLOBAL_EQ_LOW_U32_OFFSET,
    GLOBAL_EQ_MID_U32_OFFSET,
    GLOBAL_PREFIX_DEFAULT_U32,
    GLOBAL_PREFIX_SPILL_U32_MAX,
    EQ_BLEND_DEFAULT_U32,
    inspect_master_eq,
    read_master_eq,
    read_master_eq_blend,
)
from xy.rle import decode_project

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "mixer-probes" / "2026-06-eq"
BASELINE = PROBES / "eq0-baseline.xy"


@pytest.mark.parametrize(
    "filename,low,mid,high",
    [
        ("eq0-baseline.xy", EQ_BYTE_DEFAULT, EQ_BYTE_DEFAULT, EQ_BYTE_DEFAULT),
        ("eq1-bass-min.xy", EQ_BYTE_MIN, EQ_BYTE_DEFAULT, EQ_BYTE_DEFAULT),
        ("eq2-bass-max.xy", EQ_BYTE_MAX, EQ_BYTE_DEFAULT, EQ_BYTE_DEFAULT),
        ("eq3-mid-min.xy", EQ_BYTE_DEFAULT, EQ_BYTE_MIN, EQ_BYTE_DEFAULT),
        ("eq4-mid-max.xy", EQ_BYTE_DEFAULT, EQ_BYTE_MAX, EQ_BYTE_DEFAULT),
        ("eq5-treble-min.xy", EQ_BYTE_DEFAULT, EQ_BYTE_DEFAULT, EQ_BYTE_MIN),
        ("eq6-treble-max.xy", EQ_BYTE_DEFAULT, EQ_BYTE_DEFAULT, EQ_BYTE_MAX),
        ("eq8-blend-max.xy", EQ_BYTE_MAX, EQ_BYTE_MAX, EQ_BYTE_MAX),
    ],
)
def test_master_eq_levels(filename: str, low: int, mid: int, high: int) -> None:
    eq = read_master_eq(ImageProject.from_file(str(PROBES / filename)))
    assert eq.low.byte == low
    assert eq.mid.byte == mid
    assert eq.high.byte == high


def test_baseline_eq_full_u32_lanes() -> None:
    project = ImageProject.from_file(str(BASELINE))
    eq = read_master_eq(project)
    assert eq.low.u32 == EQ_U32_DEFAULT
    assert eq.mid.u32 == EQ_U32_DEFAULT
    assert eq.high.u32 == EQ_U32_DEFAULT
    assert read_master_eq_blend(project).u32 == EQ_BLEND_DEFAULT_U32
    _, img = decode_project(BASELINE.read_bytes())
    assert int.from_bytes(
        img[GLOBAL_EQ_BLEND_U32_OFFSET : GLOBAL_EQ_BLEND_U32_OFFSET + 4], "little"
    ) == EQ_BLEND_DEFAULT_U32
    assert int.from_bytes(img[0x64:0x68], "little") == GLOBAL_PREFIX_DEFAULT_U32


def test_min_probes_touch_only_level_byte() -> None:
    base_img = BASELINE.read_bytes()
    _, base = decode_project(base_img)
    for filename, offset in (
        ("eq1-bass-min.xy", GLOBAL_EQ_LOW_U32_OFFSET),
        ("eq3-mid-min.xy", GLOBAL_EQ_MID_U32_OFFSET),
        ("eq5-treble-min.xy", GLOBAL_EQ_HIGH_U32_OFFSET),
    ):
        _, var = decode_project((PROBES / filename).read_bytes())
        diffs = [i for i in range(len(base)) if base[i] != var[i]]
        global_diffs = [d for d in diffs if d < 0xD79]
        assert global_diffs == [offset]


def test_max_probes_set_level_and_prior_field_tail() -> None:
    base_img = BASELINE.read_bytes()
    _, base = decode_project(base_img)
    cases = (
        ("eq2-bass-max.xy", (0x65, 0x66, 0x67, GLOBAL_EQ_LOW_U32_OFFSET)),
        ("eq4-mid-max.xy", (0x69, 0x6A, 0x6B, GLOBAL_EQ_MID_U32_OFFSET)),
        ("eq6-treble-max.xy", (0x6D, 0x6E, 0x6F, GLOBAL_EQ_HIGH_U32_OFFSET)),
    )
    for filename, expected_global in cases:
        _, var = decode_project((PROBES / filename).read_bytes())
        diffs = [i for i in range(len(base)) if base[i] != var[i]]
        global_diffs = sorted(d for d in diffs if d < 0xD79)
        assert global_diffs == list(expected_global)
        eq = inspect_master_eq(ImageProject.from_file(str(PROBES / filename)))
        band = {"eq2-bass-max.xy": eq.low, "eq4-mid-max.xy": eq.mid, "eq6-treble-max.xy": eq.high}[
            filename
        ]
        assert band.byte == EQ_BYTE_MAX
        assert band.u32 == EQ_U32_MAX


@pytest.mark.parametrize(
    "filename,low_u32,mid_u32,high_u32,prefix_u32",
    [
        ("eq1-bass-min.xy", EQ_U32_MIN, EQ_U32_DEFAULT, EQ_U32_DEFAULT, GLOBAL_PREFIX_DEFAULT_U32),
        ("eq2-bass-max.xy", EQ_U32_MAX, EQ_U32_DEFAULT, EQ_U32_DEFAULT, GLOBAL_PREFIX_SPILL_U32_MAX),
        ("eq3-mid-min.xy", EQ_U32_DEFAULT, EQ_U32_MIN, EQ_U32_DEFAULT, GLOBAL_PREFIX_DEFAULT_U32),
        ("eq4-mid-max.xy", 0xFFFFFF40, EQ_U32_MAX, EQ_U32_DEFAULT, GLOBAL_PREFIX_DEFAULT_U32),
        ("eq5-treble-min.xy", EQ_U32_DEFAULT, EQ_U32_DEFAULT, EQ_U32_MIN, GLOBAL_PREFIX_DEFAULT_U32),
        ("eq6-treble-max.xy", EQ_U32_DEFAULT, 0xFFFFFF40, EQ_U32_MAX, GLOBAL_PREFIX_DEFAULT_U32),
        (
            "eq8-blend-max.xy",
            EQ_U32_MAX_WITH_TAIL,
            EQ_U32_MAX_WITH_TAIL,
            EQ_U32_MAX,
            GLOBAL_PREFIX_SPILL_U32_MAX,
        ),
    ],
)
def test_eq_full_u32_lanes(
    filename: str, low_u32: int, mid_u32: int, high_u32: int, prefix_u32: int
) -> None:
    project = ImageProject.from_file(str(PROBES / filename))
    eq = read_master_eq(project)
    assert eq.low.u32 == low_u32
    assert eq.mid.u32 == mid_u32
    assert eq.high.u32 == high_u32
    assert read_master_eq_blend(project).u32 == EQ_BLEND_DEFAULT_U32
    _, img = decode_project((PROBES / filename).read_bytes())
    assert int.from_bytes(img[0x64:0x68], "little") == prefix_u32


def test_blend_min_matches_baseline() -> None:
    _, base = decode_project(BASELINE.read_bytes())
    _, blend = decode_project((PROBES / "eq7-blend-min.xy").read_bytes())
    assert read_master_eq(ImageProject(b"", bytearray(base))) == read_master_eq(
        ImageProject(b"", bytearray(blend))
    )
    global_diffs = [i for i in range(len(base)) if base[i] != blend[i] and i < 0xD79]
    assert global_diffs == []


def test_blend_max_sets_all_bands() -> None:
    eq = read_master_eq(ImageProject.from_file(str(PROBES / "eq8-blend-max.xy")))
    assert eq.low.byte == eq.mid.byte == eq.high.byte == EQ_BYTE_MAX
