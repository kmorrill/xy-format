from pathlib import Path

import pytest

from xy.scene_volume_inspection import (
    MIX_VOL_BYTE_MAX,
    MIX_VOL_U32_MAX,
    encode_mix_vol_byte,
    inspect_scene_volumes_bytes,
    read_present_scene_slots,
    read_scene_track_volume,
)
from xy.image_writer import ImageProject
from xy.rle import decode_project

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "scene-probes" / "2026-06-volumes"


@pytest.fixture(scope="module")
def baseline() -> Path:
    return PROBES / "s0b-baseline-2scenes.xy"


def test_baseline_track_and_master_defaults(baseline: Path) -> None:
    inspection = inspect_scene_volumes_bytes(baseline.read_bytes())
    assert inspection.scene_count == 1
    assert inspection.scene_flags[:3] == (1, 1, 0)
    assert inspection.present_scene_slots == (0, 1)
    assert inspection.present_scene_count == 2
    t1 = inspection.track_volumes[0]
    assert t1.vol_byte == 0x60
    assert t1.vol_u32 == encode_mix_vol_byte(0x60)
    assert inspection.master_vol_byte == 0x40


def test_scene_slot_flags_mark_two_populated_rows_in_clean_volume_fixtures(
    baseline: Path,
) -> None:
    project = ImageProject.from_file(str(baseline))
    assert read_present_scene_slots(project) == (0, 1)


def test_scene1_t1_low_is_single_byte_on_t1() -> None:
    base = PROBES / "s0b-baseline-2scenes.xy"
    low = PROBES / "s1b-scene1-t1-vol-low.xy"
    _, base_img = decode_project(base.read_bytes())
    _, low_img = decode_project(low.read_bytes())
    project = ImageProject.from_file(str(base))
    off = project.track_start(1) + 0x38FE
    diffs = [i for i in range(len(base_img)) if base_img[i] != low_img[i]]
    assert diffs == [off]
    assert low_img[off] == 0x00
    low_project = ImageProject.from_file(str(low))
    vol = read_scene_track_volume(low_project, scene=1, track=1)
    assert vol.vol_byte == 0x00


def test_scene2_t1_high_lands_on_t2_struct() -> None:
    high = PROBES / "s2b-scene2-t1-vol-high.xy"
    inspection = inspect_scene_volumes_bytes(high.read_bytes())
    assert inspection.scene_count == 2
    assert inspection.present_scene_count == 2
    assert inspection.track_volumes[0].vol_byte == 0x60
    assert inspection.track_volumes[1].vol_byte == MIX_VOL_BYTE_MAX
    assert inspection.track_volumes[1].vol_u32 == MIX_VOL_U32_MAX
    project = ImageProject.from_file(str(high))
    assert read_scene_track_volume(project, scene=2, track=1).vol_byte == MIX_VOL_BYTE_MAX


def test_master_volume_max_is_global_only() -> None:
    base = PROBES / "s0b-baseline-2scenes.xy"
    master = PROBES / "s5b-scene1-master-vol.xy"
    _, base_img = decode_project(base.read_bytes())
    _, mas_img = decode_project(master.read_bytes())
    diffs = [i for i in range(len(base_img)) if base_img[i] != mas_img[i]]
    assert diffs == [0x91, 0x92, 0x93, 0x94]
    assert mas_img[0x94] == MIX_VOL_BYTE_MAX
    assert inspect_scene_volumes_bytes(master.read_bytes()).master_vol_u32 == MIX_VOL_U32_MAX


def test_flawed_s0_series_s2_has_many_spurious_diffs() -> None:
    base = PROBES / "s0-baseline-2scenes.xy"
    high = PROBES / "s2-scene2-t1-vol-high.xy"
    if not base.exists() or not high.exists():
        pytest.skip("flawed s0 series not promoted")
    _, base_img = decode_project(base.read_bytes())
    _, high_img = decode_project(high.read_bytes())
    diffs = [i for i in range(len(base_img)) if base_img[i] != high_img[i]]
    assert len(diffs) > 10
