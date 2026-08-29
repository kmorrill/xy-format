from pathlib import Path

import pytest

from xy.image_writer import build_arrangement
from xy.project_inspection import inspect_project_bytes
from xy.rle import decode_project, encode_project
from xy.scene_volume_inspection import inspect_scene_volumes_bytes


ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / "src/one-off-changes-from-default/unnamed 1.xy"
ORIGINAL_TRACK_BASE = 3449


def _project_with_layout(firmware_byte: int, track_base: int) -> bytes:
    header, image = decode_project(BASE.read_bytes())
    if track_base < ORIGINAL_TRACK_BASE:
        resized = image[:track_base] + image[ORIGINAL_TRACK_BASE:]
    else:
        resized = (
            image[:ORIGINAL_TRACK_BASE]
            + bytes(track_base - ORIGINAL_TRACK_BASE)
            + image[ORIGINAL_TRACK_BASE:]
        )
    versioned_header = header[:5] + bytes([firmware_byte]) + header[6:]
    return encode_project(versioned_header, resized)


@pytest.mark.parametrize(
    "firmware_byte,track_base",
    [(0x0E, 3933), (0x0F, 3933), (0x10, 3433), (0x11, 3433), (0x13, 3449)],
)
def test_project_inspector_uses_firmware_dependent_track_base(
    firmware_byte: int, track_base: int
) -> None:
    data = _project_with_layout(firmware_byte, track_base)

    inspection = inspect_project_bytes(data)

    assert len(inspection.tracks) == 16
    assert all(len(track.patterns) == 1 for track in inspection.tracks)


@pytest.mark.parametrize(
    "firmware_byte,track_base",
    [(0x0E, 3933), (0x10, 3433), (0x13, 3449)],
)
def test_scene_volume_reader_uses_firmware_dependent_track_base(
    firmware_byte: int, track_base: int
) -> None:
    data = _project_with_layout(firmware_byte, track_base)

    inspection = inspect_scene_volumes_bytes(data)

    assert len(inspection.track_volumes) == 16
    assert inspection.track_volumes[0].vol_byte == 0x60


def test_project_inspector_reports_all_sixteen_patterns() -> None:
    data = build_arrangement(str(BASE), {1: [[]] * 16})

    inspection = inspect_project_bytes(data)

    assert len(inspection.tracks[0].patterns) == 16
    assert len(inspection.tracks[1].patterns) == 1
