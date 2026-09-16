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


def test_default_presence_includes_all_pattern_one_scenes() -> None:
    from xy.scene_volume_inspection import read_present_scene_slots

    project = ImageProject.from_bytes(build_arrangement(
        BASE, {}, scenes=[{}, {}], song_chain=[0, 1],
    ))
    assert read_present_scene_slots(project) == (0, 1)
    assert project.get_song_chain() == ([0, 1], True)


def test_spec_export_marks_every_referenced_scene_present(tmp_path) -> None:
    import json
    import subprocess
    import sys
    from pathlib import Path
    from xy.scene_volume_inspection import read_present_scene_slots

    root = Path(__file__).resolve().parents[1]
    spec = tmp_path / 'spec.json'
    output = tmp_path / 'song.xy'
    spec.write_text(json.dumps({'tracks': [{'track': 1, 'patterns': [
        [{'step': 1, 'note': 60}], [{'step': 1, 'note': 64}],
    ]}]}))
    subprocess.run([
        sys.executable, str(root / 'tools/spec_to_xy_image.py'), str(spec),
        '-o', str(output), '--baseline', str(root / BASE),
    ], check=True, capture_output=True, text=True)
    project = ImageProject.from_file(str(output))
    assert read_present_scene_slots(project) == (0, 1)
    assert project.get_song_chain() == ([0, 1], True)
    assert project.image[SCENE_SLOT0] == 0
    assert project.image[SCENE_SLOT0 + SCENE_SLOT_SIZE] == 1
