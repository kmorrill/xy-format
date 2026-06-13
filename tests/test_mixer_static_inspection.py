from pathlib import Path

import pytest

from xy.image_writer import ImageProject, STRIDE
from xy.mixer_static_inspection import (
    MASTER_GROUP_MIN_U32,
    MIX_U32_MAX,
    MIX_U32_MIN,
    PAN_BYTE_CENTER,
    TRACK_MIX_PAN_BYTE_OFFSET,
    TRACK_SEND_FX1_BYTE_OFFSET,
    TRACK_SEND_FX2_BYTE_OFFSET,
    inspect_static_mixer_bytes,
)
from xy.rle import decode_project
from xy.scene_volume_inspection import TRACK_MIX_VOL_BYTE_OFFSET

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "mixer-probes" / "2026-06-static"
BASELINE = PROBES / "f0-baseline-mix-default.xy"


@pytest.fixture(scope="module")
def base_img():
    return decode_project(BASELINE.read_bytes())[1]


def _primary_diffs(base_img: bytes, path: Path) -> list[int]:
    var_img = decode_project(path.read_bytes())[1]
    return [i for i in range(len(base_img)) if base_img[i] != var_img[i]]


def test_baseline_defaults() -> None:
    mixer = inspect_static_mixer_bytes(BASELINE.read_bytes())
    t1 = mixer.tracks[0]
    assert t1.volume.byte == 0x60
    assert t1.pan.byte == PAN_BYTE_CENTER
    assert t1.send_fx1.byte == 0
    assert t1.send_fx2.byte == 0
    assert mixer.master.percussion.byte == 0x40
    assert mixer.master.melody.byte == 0x40
    assert mixer.master.compressor.byte == 0x0C
    assert mixer.master.master.byte == 0x40


@pytest.mark.parametrize(
    "filename,field,expected",
    [
        ("f1-t1-vol-min.xy", "volume", 0x00),
        ("f2-t1-vol-max.xy", "volume", 0x7F),
        ("f3-t1-pan-hard-left.xy", "pan", 0x00),
        ("f4-t1-pan-hard-right.xy", "pan", 0x7F),
        ("f6-t1-send-fx1-max.xy", "send_fx1", 0x7F),
        ("f8-t1-send-fx2-max.xy", "send_fx2", 0x7F),
        ("f10-master-perc-vol-0.xy", "percussion", 0x00),
        ("f11-master-perc-vol-100.xy", "percussion", 0x7F),
        ("f12-master-melody-vol-0.xy", "melody", 0x00),
        ("f13-master-melody-vol-100.xy", "melody", 0x7F),
        ("f14-master-compressor-min.xy", "compressor", 0x00),
        ("f15-master-compressor-max.xy", "compressor", 0x7F),
    ],
)
def test_t1_and_master_fields(filename: str, field: str, expected: int) -> None:
    path = PROBES / filename
    mixer = inspect_static_mixer_bytes(path.read_bytes())
    if field in {"percussion", "melody", "compressor"}:
        assert getattr(mixer.master, field).byte == expected
    else:
        assert getattr(mixer.tracks[0], field).byte == expected


def test_t1_vol_max_uses_full_u32_pattern() -> None:
    mixer = inspect_static_mixer_bytes((PROBES / "f2-t1-vol-max.xy").read_bytes())
    assert mixer.tracks[0].volume.u32 == MIX_U32_MAX


@pytest.mark.parametrize(
    "filename,field,expected_u32",
    [
        ("f1-t1-vol-min.xy", "volume", MIX_U32_MIN),
        ("f2-t1-vol-max.xy", "volume", MIX_U32_MAX),
        ("f3-t1-pan-hard-left.xy", "pan", MIX_U32_MIN),
        ("f4-t1-pan-hard-right.xy", "pan", MIX_U32_MAX),
        ("f6-t1-send-fx1-max.xy", "send_fx1", MIX_U32_MAX),
        ("f7-t1-send-fx1-min.xy", "send_fx1", MIX_U32_MIN),
        ("f8-t1-send-fx2-max.xy", "send_fx2", MIX_U32_MAX),
        ("f9-t1-send-fx2-min.xy", "send_fx2", MIX_U32_MIN),
    ],
)
def test_t1_mix_fields_use_full_u32_min_max_lanes(
    filename: str, field: str, expected_u32: int
) -> None:
    mixer = inspect_static_mixer_bytes((PROBES / filename).read_bytes())
    assert getattr(mixer.tracks[0], field).u32 == expected_u32


@pytest.mark.parametrize(
    "filename,field,expected_u32",
    [
        ("f10-master-perc-vol-0.xy", "percussion", MASTER_GROUP_MIN_U32),
        ("f11-master-perc-vol-100.xy", "percussion", MIX_U32_MAX),
        ("f12-master-melody-vol-0.xy", "melody", MASTER_GROUP_MIN_U32),
        ("f13-master-melody-vol-100.xy", "melody", MIX_U32_MAX),
        ("f14-master-compressor-min.xy", "compressor", MASTER_GROUP_MIN_U32),
        ("f15-master-compressor-max.xy", "compressor", MIX_U32_MAX),
        ("f16-master-master-vol-0.xy", "master", MASTER_GROUP_MIN_U32),
        ("f17-master-master-vol-100.xy", "master", MIX_U32_MAX),
    ],
)
def test_master_group_fields_preserve_min_tail_pattern(
    filename: str, field: str, expected_u32: int
) -> None:
    mixer = inspect_static_mixer_bytes((PROBES / filename).read_bytes())
    assert getattr(mixer.master, field).u32 == expected_u32


def test_pan_center_matches_baseline(base_img: bytes) -> None:
    path = PROBES / "f5-t1-pan-center.xy"
    mixer = inspect_static_mixer_bytes(path.read_bytes())
    assert mixer.tracks[0].pan.byte == PAN_BYTE_CENTER
    t1_pan_diffs = [d for d in _primary_diffs(base_img, path) if 0x4670 <= d <= 0x4677]
    assert not t1_pan_diffs


def test_send_mins_are_unchanged_from_baseline() -> None:
    mixer = inspect_static_mixer_bytes((PROBES / "f7-t1-send-fx1-min.xy").read_bytes())
    assert mixer.tracks[0].send_fx1.byte == 0
    mixer = inspect_static_mixer_bytes((PROBES / "f9-t1-send-fx2-min.xy").read_bytes())
    assert mixer.tracks[0].send_fx2.byte == 0


@pytest.mark.parametrize(
    "filename,field,track,expected",
    [
        ("f16-master-master-vol-0.xy", "master", 0, 0x00),
        ("f17-master-master-vol-100.xy", "master", 0, 0x7F),
        ("f18-t2-vol-min.xy", "volume", 2, 0x00),
        ("f19-t3-vol-max.xy", "volume", 3, 0x7F),
        ("f20-t4-pan-left.xy", "pan", 4, 0x00),
        ("f21-t5-pan-right.xy", "pan", 5, 0x7F),
        ("f22-t6-send-fx1-max.xy", "send_fx1", 6, 0x7F),
        ("f23-t7-send-fx1-min.xy", "send_fx1", 7, 0x00),
        ("f24-t8-send-fx2-max.xy", "send_fx2", 8, 0x7F),
    ],
)
def test_f16_f24_cross_track_and_master_fields(
    filename: str, field: str, track: int, expected: int
) -> None:
    mixer = inspect_static_mixer_bytes((PROBES / filename).read_bytes())
    if field == "master":
        assert mixer.master.master.byte == expected
    else:
        assert getattr(mixer.tracks[track - 1], field).byte == expected


def test_f19_t3_vol_max_uses_full_u32_pattern() -> None:
    mixer = inspect_static_mixer_bytes((PROBES / "f19-t3-vol-max.xy").read_bytes())
    assert mixer.tracks[2].volume.u32 == MIX_U32_MAX


def _session_noise_offsets(project: ImageProject) -> set[int]:
    noise: set[int] = set()
    for track in range(9, 17):
        base = project.track_start(track)
        noise.add(base + 0x38F2)
        noise.add(base + 0x38F6)
    return noise


@pytest.mark.parametrize(
    "filename,track,field_offset",
    [
        ("f18-t2-vol-min.xy", 2, TRACK_MIX_VOL_BYTE_OFFSET),
        ("f20-t4-pan-left.xy", 4, TRACK_MIX_PAN_BYTE_OFFSET),
        ("f22-t6-send-fx1-max.xy", 6, TRACK_SEND_FX1_BYTE_OFFSET),
        ("f24-t8-send-fx2-max.xy", 8, TRACK_SEND_FX2_BYTE_OFFSET),
    ],
)
def test_cross_track_edits_are_isolated_on_target_struct(
    base_img: bytes, filename: str, track: int, field_offset: int
) -> None:
    path = PROBES / filename
    var_img = decode_project(path.read_bytes())[1]
    project = ImageProject.from_file(str(BASELINE))
    target = project.track_start(track)
    allowed = set(range(target + field_offset - 3, target + field_offset + 1))
    allowed.add(target + 0x11)  # pristine u16
    allowed |= _session_noise_offsets(project)
    outside = [
        i
        for i in range(len(base_img))
        if base_img[i] != var_img[i] and i not in allowed
    ]
    assert not outside
