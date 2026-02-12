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

    assert len(proj.pre_track) == 0x7C  # Baseline-specific
    assert len(proj.tracks) == 16
    assert proj.pre_track[:4] == b"\xDD\xCC\xBB\xAA"

    # All baseline tracks are type 0x05 (default, with padding)
    EXPECTED_ENGINES = {
        0: 0x03,   # Drum
        1: 0x03,   # Drum
        2: 0x12,   # Prism
        3: 0x07,   # EPiano
        4: 0x14,   # Dissolve
        5: 0x13,   # Hardsync
        6: 0x16,   # Axis
        7: 0x1E,   # Multisampler
        8: 0x12,   # Prism (aux)
        9: 0x12,   # Prism (aux)
        10: 0x12,  # Prism (aux)
        11: 0x12,  # Prism (aux)
        12: 0x12,  # Prism (aux)
        13: 0x12,  # Prism (aux)
        14: 0x00,  # aux
        15: 0x05,  # aux
    }
    for track in proj.tracks:
        assert track.type_byte == 0x05
        assert track.has_padding is True
        assert track.engine_id == EXPECTED_ENGINES[track.index], (
            f"Track {track.index}: expected engine 0x{EXPECTED_ENGINES[track.index]:02X}, "
            f"got 0x{track.engine_id:02X}"
        )


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
