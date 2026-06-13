from pathlib import Path

import pytest

from xy.image_writer import ImageProject
from xy.master_saturator_inspection import (
    SAT_CLIP_DEFAULT_U32,
    SAT_CLIP_DEFAULT,
    SAT_GAIN_DEFAULT,
    SAT_GAIN_DEFAULT_U32,
    SAT_MIX_DEFAULT,
    SAT_MIX_DEFAULT_U32,
    SAT_TONE_DEFAULT,
    SAT_TONE_DEFAULT_U32,
    SAT_U32_MAX,
    SAT_U32_MIN,
    GLOBAL_SAT_CLIP_BYTE_OFFSET,
    GLOBAL_SAT_GAIN_BYTE_OFFSET,
    GLOBAL_SAT_MIX_BYTE_OFFSET,
    GLOBAL_SAT_TONE_BYTE_OFFSET,
    SAT_BYTE_MAX,
    SAT_BYTE_MIN,
    read_master_saturator,
)
from xy.rle import decode_project

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "app-mixer-probes" / "2026-06-saturator"
BASELINE = PROBES / "sat0-baseline.xy"


@pytest.mark.parametrize(
    "filename,gain,clip,tone,mix",
    [
        (
            "sat0-baseline.xy",
            SAT_GAIN_DEFAULT,
            SAT_CLIP_DEFAULT,
            SAT_TONE_DEFAULT,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat1-gain-min.xy",
            SAT_BYTE_MIN,
            SAT_CLIP_DEFAULT,
            SAT_TONE_DEFAULT,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat2-gain-max.xy",
            SAT_BYTE_MAX,
            SAT_CLIP_DEFAULT,
            SAT_TONE_DEFAULT,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat3-clip-min.xy",
            SAT_GAIN_DEFAULT,
            SAT_BYTE_MIN,
            SAT_TONE_DEFAULT,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat4-clip-max.xy",
            SAT_GAIN_DEFAULT,
            SAT_BYTE_MAX,
            SAT_TONE_DEFAULT,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat5-tone-min.xy",
            SAT_GAIN_DEFAULT,
            SAT_CLIP_DEFAULT,
            SAT_BYTE_MIN,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat6-tone-max.xy",
            SAT_GAIN_DEFAULT,
            SAT_CLIP_DEFAULT,
            SAT_BYTE_MAX,
            SAT_MIX_DEFAULT,
        ),
        (
            "sat7-mix-min.xy",
            SAT_GAIN_DEFAULT,
            SAT_CLIP_DEFAULT,
            SAT_TONE_DEFAULT,
            SAT_BYTE_MIN,
        ),
        (
            "sat8-mix-max.xy",
            SAT_GAIN_DEFAULT,
            SAT_CLIP_DEFAULT,
            SAT_TONE_DEFAULT,
            SAT_BYTE_MAX,
        ),
    ],
)
def test_saturator_levels(
    filename: str, gain: int, clip: int, tone: int, mix: int
) -> None:
    sat = read_master_saturator(ImageProject.from_file(str(PROBES / filename)))
    assert sat.gain.byte == gain
    assert sat.clip.byte == clip
    assert sat.tone.byte == tone
    assert sat.mix.byte == mix


@pytest.mark.parametrize(
    "filename,gain,clip,tone,mix",
    [
        (
            "sat0-baseline.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_CLIP_DEFAULT_U32,
            SAT_TONE_DEFAULT_U32,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat1-gain-min.xy",
            SAT_U32_MIN,
            SAT_CLIP_DEFAULT_U32,
            SAT_TONE_DEFAULT_U32,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat2-gain-max.xy",
            SAT_U32_MAX,
            SAT_CLIP_DEFAULT_U32,
            SAT_TONE_DEFAULT_U32,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat3-clip-min.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_U32_MIN,
            SAT_TONE_DEFAULT_U32,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat4-clip-max.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_U32_MAX,
            SAT_TONE_DEFAULT_U32,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat5-tone-min.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_CLIP_DEFAULT_U32,
            SAT_U32_MIN,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat6-tone-max.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_CLIP_DEFAULT_U32,
            SAT_U32_MAX,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat7-mix-min.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_CLIP_DEFAULT_U32,
            SAT_TONE_DEFAULT_U32,
            SAT_MIX_DEFAULT_U32,
        ),
        (
            "sat8-mix-max.xy",
            SAT_GAIN_DEFAULT_U32,
            SAT_CLIP_DEFAULT_U32,
            SAT_TONE_DEFAULT_U32,
            SAT_U32_MAX,
        ),
    ],
)
def test_saturator_u32_lanes(
    filename: str, gain: int, clip: int, tone: int, mix: int
) -> None:
    sat = read_master_saturator(ImageProject.from_file(str(PROBES / filename)))
    assert sat.gain.u32 == gain
    assert sat.clip.u32 == clip
    assert sat.tone.u32 == tone
    assert sat.mix.u32 == mix


def test_mix_min_matches_baseline() -> None:
    base = read_master_saturator(ImageProject.from_file(str(BASELINE)))
    mix_min = read_master_saturator(ImageProject.from_file(str(PROBES / "sat7-mix-min.xy")))
    assert mix_min == base
    assert base.mix.byte == SAT_BYTE_MIN


@pytest.mark.parametrize(
    "filename,byte_offset",
    [
        ("sat1-gain-min.xy", GLOBAL_SAT_GAIN_BYTE_OFFSET),
        ("sat3-clip-min.xy", GLOBAL_SAT_CLIP_BYTE_OFFSET),
        ("sat5-tone-min.xy", GLOBAL_SAT_TONE_BYTE_OFFSET),
    ],
)
def test_min_probes_primary_global_byte(filename: str, byte_offset: int) -> None:
    _, base = decode_project(BASELINE.read_bytes())
    _, var = decode_project((PROBES / filename).read_bytes())
    global_diffs = sorted(d for d in range(len(base)) if base[d] != var[d] if d < 0xD79)
    assert byte_offset in global_diffs


@pytest.mark.parametrize(
    "filename,byte_offset",
    [
        ("sat2-gain-max.xy", GLOBAL_SAT_GAIN_BYTE_OFFSET),
        ("sat4-clip-max.xy", GLOBAL_SAT_CLIP_BYTE_OFFSET),
        ("sat6-tone-max.xy", GLOBAL_SAT_TONE_BYTE_OFFSET),
        ("sat8-mix-max.xy", GLOBAL_SAT_MIX_BYTE_OFFSET),
    ],
)
def test_max_probes_set_level_byte(filename: str, byte_offset: int) -> None:
    sat = read_master_saturator(ImageProject.from_file(str(PROBES / filename)))
    band = {
        GLOBAL_SAT_GAIN_BYTE_OFFSET: sat.gain,
        GLOBAL_SAT_CLIP_BYTE_OFFSET: sat.clip,
        GLOBAL_SAT_TONE_BYTE_OFFSET: sat.tone,
        GLOBAL_SAT_MIX_BYTE_OFFSET: sat.mix,
    }[byte_offset]
    assert band.byte == SAT_BYTE_MAX
