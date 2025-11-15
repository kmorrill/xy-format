from pathlib import Path
import sys

import pytest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from tools.inspect_xy import detect_filter_enabled, detect_m4_enabled  # noqa: E402
from xy.structs import find_track_blocks, parse_pointer_words  # noqa: E402


DATA_DIR = Path(__file__).resolve().parents[1] / "src" / "one-off-changes-from-default"


def _pointer_words(filename: str, track_index: int) -> list[int]:
    data = (DATA_DIR / filename).read_bytes()
    blocks = find_track_blocks(data)
    block = blocks[track_index - 1]
    words = parse_pointer_words(data, block)
    assert words is not None
    return words


@pytest.mark.parametrize(
    "filename,track_index,expected",
    [
        ("unnamed 30.xy", 3, True),
        ("unnamed 29.xy", 3, False),
        ("unnamed 1.xy", 1, False),
    ],
)
def test_detect_filter_enabled_known_states(filename: str, track_index: int, expected: bool) -> None:
    words = _pointer_words(filename, track_index)
    assert detect_filter_enabled(words) is expected


def test_detect_filter_enabled_unknown_signature() -> None:
    words = _pointer_words("unnamed 30.xy", 3)
    mutated = list(words)
    mutated[5] ^= 0x0001
    assert detect_filter_enabled(mutated) is None


@pytest.mark.parametrize(
    "filename,track_index,expected",
    [
        ("unnamed 1.xy", 3, False),
        ("unnamed 31.xy", 3, True),
    ],
)
def test_detect_m4_enabled_known_states(filename: str, track_index: int, expected: bool) -> None:
    words = _pointer_words(filename, track_index)
    assert detect_m4_enabled(words) is expected


def test_detect_m4_enabled_unknown_signature() -> None:
    words = _pointer_words("unnamed 31.xy", 3)
    mutated = list(words)
    index = (0x0E - 0x08) // 2
    mutated[index] ^= 0x0001
    assert detect_m4_enabled(mutated) is None
