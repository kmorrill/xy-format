"""OS 1.2.0 Drumline captures: header family, layout, and preset identity."""

from __future__ import annotations

import pytest

from xy.image_writer import ImageProject
from xy.preset_path_inspection import inspect_preset_paths_bytes
from xy.rle import decode_project

CAPTURES = "src/factory-preset-captures/firmware-1.2.0/batches"
DRUMLINE_ENGINE_ID = 0x04

EXPECTED = {
    "drumline01.xy": [
        "atom",
        "beatnic",
        "cinortcele",
        "dote yet",
        "helpline",
        "macaroni",
        "that tom tom tom",
        "tyche",
    ],
    "drumline02.xy": ["we will c"] * 8,
}


@pytest.mark.parametrize("name,labels", EXPECTED.items())
def test_drumline_capture_is_pristine_os_1_2_0_project(name, labels):
    raw = open(f"{CAPTURES}/{name}", "rb").read()
    header, image = decode_project(raw)

    assert header.hex() == "ddccbbaa09140786"
    assert len(image) == 289_521

    project = ImageProject.from_bytes(raw)
    assert project.to_bytes() == raw

    tracks = inspect_preset_paths_bytes(raw).tracks
    assert [t.path for t in tracks[:8]] == [f"drumline/{x}" for x in labels]
    assert {t.engine_id for t in tracks[:8]} == {DRUMLINE_ENGINE_ID}
    for track in range(1, 9):
        assert project.note_count(track) == 0
    # Untouched tracks keep their blank-project engines.
    assert DRUMLINE_ENGINE_ID not in {t.engine_id for t in tracks[8:]}
