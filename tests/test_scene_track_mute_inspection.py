from pathlib import Path

import pytest

from xy.image_writer import ImageProject, SCENE_SLOT0, SCENE_SLOT_SIZE
from xy.rle import decode_project
from xy.scene_volume_inspection import (
    SCENE_MUTE_OFFSET,
    SCENE_MUTE_VALUE,
    read_present_scene_slots,
    read_scene_muted_tracks,
    read_scene_slot_flag,
    read_scene_slot_mute_bytes,
    scene_mute_storage_slot,
)

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "scene-probes" / "2026-06-track-mutes"
BASELINE = PROBES / "mute-#-#-#-#.xy"
MULTI_BASELINE = PROBES / "mute#-#-#-#-#.xy"
SLOT0 = 0  # scene 1 on single-scene project (firmware 1.1.4)


@pytest.mark.parametrize(
    "filename,expected",
    [
        ("mute-1-3-6-7.xy", (1, 3, 6, 7)),
        ("mute-2-7-8-#.xy", (2, 7, 8)),
        ("mute-3-4-5-6.xy", (3, 4, 5, 6)),
    ],
)
def test_scene1_mutes_are_in_slot0_mute_region(filename: str, expected: tuple[int, ...]) -> None:
    project = ImageProject.from_file(str(PROBES / filename))
    assert read_scene_muted_tracks(project, SLOT0) == expected
    for track in expected:
        mutes = read_scene_slot_mute_bytes(project, SLOT0)
        assert mutes[track - 1] == SCENE_MUTE_VALUE


def test_baseline_has_no_muted_tracks() -> None:
    project = ImageProject.from_file(str(BASELINE))
    assert read_scene_muted_tracks(project, SLOT0) == ()
    assert all(b == 0 for b in read_scene_slot_mute_bytes(project, SLOT0))


def test_mute_diffs_are_only_slot0_mute_bytes() -> None:
    base_img = BASELINE.read_bytes()
    _, base = decode_project(base_img)
    for filename in ("mute-2-7-8-#.xy", "mute-3-4-5-6.xy"):
        _, var = decode_project((PROBES / filename).read_bytes())
        diffs = [i for i in range(len(base)) if base[i] != var[i]]
        mute_start = SCENE_SLOT0 + SLOT0 * SCENE_SLOT_SIZE + SCENE_MUTE_OFFSET
        mute_end = mute_start + 16
        assert all(mute_start <= d < mute_end for d in diffs)


@pytest.mark.parametrize(
    "scene,expected_slot",
    [(1, 0), (2, 1), (8, 7)],
)
def test_scene_mute_storage_slot_mapping(scene: int, expected_slot: int) -> None:
    assert scene_mute_storage_slot(scene) == expected_slot


@pytest.mark.parametrize(
    "filename,scene,expected",
    [
        ("mute2-1-7-8-#.xy", 2, (1, 7, 8)),
        ("mute3-1-7-8-#.xy", 3, (1, 7, 8)),
        ("mute3-2-3-6-7.xy", 3, (2, 3, 6, 7)),
        ("mute4-6-7-8-#.xy", 4, (6, 7, 8)),
        ("mute5-2-4-6-7.xy", 5, (2, 4, 6, 7)),
        ("mute6-1-7-8-#.xy", 6, (1, 7, 8)),
        ("mute7-2-3-6-7.xy", 7, (2, 3, 6, 7)),
        ("mute8-6-7-8-#.xy", 8, (6, 7, 8)),
    ],
)
def test_multi_scene_mutes_land_in_expected_slot(
    filename: str, scene: int, expected: tuple[int, ...]
) -> None:
    project = ImageProject.from_file(str(PROBES / filename))
    slot = scene_mute_storage_slot(scene)
    assert read_scene_muted_tracks(project, slot) == expected
    mutes = read_scene_slot_mute_bytes(project, slot)
    for track in expected:
        assert mutes[track - 1] == SCENE_MUTE_VALUE


def test_multi_baseline_has_no_muted_tracks() -> None:
    project = ImageProject.from_file(str(MULTI_BASELINE))
    for slot in range(8):
        assert read_scene_muted_tracks(project, slot) == ()


@pytest.mark.parametrize(
    "filename,expected_slots",
    [
        ("mute-#-#-#-#.xy", (0,)),
        ("mute-1-3-6-7.xy", (0,)),
        ("mute#-#-#-#-#.xy", tuple(range(8))),
        ("mute2-1-7-8-#.xy", tuple(range(8))),
        ("mute8-6-7-8-#.xy", tuple(range(8))),
    ],
)
def test_scene_slot_flags_mark_populated_rows(
    filename: str, expected_slots: tuple[int, ...]
) -> None:
    project = ImageProject.from_file(str(PROBES / filename))
    assert read_present_scene_slots(project) == expected_slots
    for slot in expected_slots:
        assert read_scene_slot_flag(project, slot) == 1


def _scene_region_diffs(base: bytes, var: bytes) -> list[int]:
    scene_end = SCENE_SLOT0 + 9 * SCENE_SLOT_SIZE
    limit = min(len(base), len(var), scene_end)
    return [i for i in range(SCENE_SLOT0, limit) if base[i] != var[i]]


def test_mute2_vs_multi_baseline_only_touches_slot1_mute_region() -> None:
    """Scene 2 → slot 1; T1, T7, T8 muted (scene region only)."""
    _, base = decode_project(MULTI_BASELINE.read_bytes())
    _, var = decode_project((PROBES / "mute2-1-7-8-#.xy").read_bytes())
    slot = scene_mute_storage_slot(2)
    mute_start = SCENE_SLOT0 + slot * SCENE_SLOT_SIZE + SCENE_MUTE_OFFSET
    mute_end = mute_start + 16
    scene_diffs = _scene_region_diffs(base, var)
    assert scene_diffs
    assert all(mute_start <= d < mute_end for d in scene_diffs)
    assert {d - mute_start for d in scene_diffs} == {0, 6, 7}


@pytest.mark.parametrize(
    "filename,scene",
    [
        ("mute2-1-7-8-#.xy", 2),
        ("mute3-1-7-8-#.xy", 3),
        ("mute3-2-3-6-7.xy", 3),
        ("mute5-2-4-6-7.xy", 5),
        ("mute6-1-7-8-#.xy", 6),
        ("mute7-2-3-6-7.xy", 7),
        ("mute8-6-7-8-#.xy", 8),
    ],
)
def test_multi_scene_mute_diffs_are_isolated_to_target_slot(
    filename: str, scene: int
) -> None:
    """Vs clean ``mute#`` baseline: scene-region diffs only in target slot mute bytes."""
    _, base = decode_project(MULTI_BASELINE.read_bytes())
    _, var = decode_project((PROBES / filename).read_bytes())
    slot = scene_mute_storage_slot(scene)
    mute_start = SCENE_SLOT0 + slot * SCENE_SLOT_SIZE + SCENE_MUTE_OFFSET
    mute_end = mute_start + 16
    scene_diffs = _scene_region_diffs(base, var)
    assert scene_diffs, f"expected scene-region diffs for {filename}"
    assert all(mute_start <= d < mute_end for d in scene_diffs), scene_diffs


def test_mute3_vs_mute2_adds_slot2_mutes_and_bumps_scene_count() -> None:
    """Incremental capture: scene 3 mutes on top of scene 2 file."""
    _, base = decode_project((PROBES / "mute2-1-7-8-#.xy").read_bytes())
    _, var = decode_project((PROBES / "mute3-1-7-8-#.xy").read_bytes())
    slot = scene_mute_storage_slot(3)
    mute_start = SCENE_SLOT0 + slot * SCENE_SLOT_SIZE + SCENE_MUTE_OFFSET
    mute_end = mute_start + 16
    scene_diffs = _scene_region_diffs(base, var)
    slot2_diffs = [d for d in scene_diffs if mute_start <= d < mute_end]
    assert {d - mute_start for d in slot2_diffs} == {0, 6, 7}
    if len(base) == len(var):
        assert base[0x6] != var[0x6]
