from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import XYContainer, XYProject  # noqa: E402


BASELINE = Path("src/one-off-changes-from-default/unnamed 1.xy")
CORPUS = sorted(Path("src/one-off-changes-from-default").glob("*.xy"))


def test_container_roundtrip() -> None:
    data = BASELINE.read_bytes()
    container = XYContainer.from_bytes(data)
    rebuilt = container.to_bytes()
    assert rebuilt == data


def test_container_header_fields() -> None:
    data = BASELINE.read_bytes()
    container = XYContainer.from_bytes(data)
    assert container.header.tempo_tenths == 1200


# --- XYProject round-trip tests ---


def test_project_roundtrip_baseline() -> None:
    """XYProject round-trips the baseline file byte-perfectly."""
    data = BASELINE.read_bytes()
    proj = XYProject.from_bytes(data)
    assert proj.to_bytes() == data


def test_project_structure_baseline() -> None:
    """Verify structural properties of the baseline project."""
    data = BASELINE.read_bytes()
    proj = XYProject.from_bytes(data)

    assert len(proj.pre_track) == 0x7C
    assert len(proj.tracks) == 16
    assert proj.pre_track[:8] == b"\xDD\xCC\xBB\xAA\x09\x13\x03\x86"

    # All baseline tracks are engine 0x03 (Drum), type 0x05 (default)
    for track in proj.tracks:
        assert track.engine_id == 0x03
        assert track.type_byte == 0x05
        assert track.has_padding is True


@pytest.mark.parametrize("xy_file", CORPUS, ids=lambda p: p.name)
def test_project_roundtrip_corpus(xy_file: Path) -> None:
    """XYProject round-trips every file in the corpus byte-perfectly."""
    data = xy_file.read_bytes()
    proj = XYProject.from_bytes(data)
    assert proj.to_bytes() == data


@pytest.mark.parametrize("xy_file", CORPUS, ids=lambda p: p.name)
def test_project_track_count(xy_file: Path) -> None:
    """Every corpus file has exactly 16 tracks."""
    data = xy_file.read_bytes()
    proj = XYProject.from_bytes(data)
    assert len(proj.tracks) == 16


@pytest.mark.parametrize("xy_file", CORPUS, ids=lambda p: p.name)
def test_project_type_byte_padding(xy_file: Path) -> None:
    """Type byte 0x05 has padding bytes 0x08 0x00; type 0x07 does not."""
    data = xy_file.read_bytes()
    proj = XYProject.from_bytes(data)
    for track in proj.tracks:
        if track.type_byte == 0x05:
            assert track.body[10:12] == b"\x08\x00", (
                f"Track {track.index}: type 0x05 missing padding"
            )
        elif track.type_byte == 0x07:
            assert track.body[10:12] != b"\x08\x00", (
                f"Track {track.index}: type 0x07 should not have padding"
            )
