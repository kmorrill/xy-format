import pytest

from xy.image_writer import (
    SCENE_SLOT0,
    SCENE_SLOT_SIZE,
    ImageProject,
    build_arrangement,
)


BASE = "src/one-off-changes-from-default/unnamed 1.xy"


def test_build_arrangement_maps_scene_n_to_slot_n_minus_one() -> None:
    out = build_arrangement(
        BASE,
        {1: [[], [], []]},
        scenes=[{1: 0}, {1: 1}, {1: 2}],
        force_scene_presence=True,
    )
    reloaded = ImageProject.from_bytes(out)

    for scene_index in range(3):
        slot = SCENE_SLOT0 + scene_index * SCENE_SLOT_SIZE
        assert reloaded.image[slot] == scene_index
        assert reloaded.image[slot + 32] == 1
    assert reloaded.image[SCENE_SLOT0 + 3 * SCENE_SLOT_SIZE + 32] == 0


def test_build_arrangement_rejects_scene_and_mute_limits() -> None:
    with pytest.raises(ValueError, match="at most 99 scenes"):
        build_arrangement(BASE, {}, scenes=[{}] * 100)
    with pytest.raises(ValueError, match="scene mute track"):
        build_arrangement(
            BASE,
            {},
            scenes=[{}],
            scene_mutes=[[17]],
            force_scene_presence=True,
        )


def test_build_arrangement_validates_zero_pattern_scene_entries() -> None:
    with pytest.raises(ValueError, match="scene selection"):
        build_arrangement(BASE, {}, scenes=[{17: 0}])
