from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.structs import (
    SENTINEL_BYTES,
    find_track_blocks,
    find_track_handles,
    parse_pointer_words,
)  # noqa: E402
from xy.writer import TrigSpec, activate_track, apply_single_trig  # noqa: E402

BASELINE = Path("src/one-off-changes-from-default/unnamed 1.xy")
ACTIVATED = Path("src/one-off-changes-from-default/unnamed 53.xy")
STEP9 = Path("src/one-off-changes-from-default/unnamed 81.xy")


def _slice(data: bytes, offset: int, length: int) -> bytes:
    return data[offset : offset + length]


@pytest.fixture(scope="module")
def baseline_bytes() -> bytes:
    return BASELINE.read_bytes()


@pytest.fixture(scope="module")
def activated_bytes() -> bytes:
    return ACTIVATED.read_bytes()


def test_activate_matches_reference(baseline_bytes: bytes, activated_bytes: bytes) -> None:
    buf = activate_track(baseline_bytes, track_index=1)
    blocks = find_track_blocks(buf)
    block = blocks[0]

    ref_blocks = find_track_blocks(activated_bytes)
    ref_block = ref_blocks[0]

    # Pointer words
    assert parse_pointer_words(buf, block) == parse_pointer_words(activated_bytes, ref_block)

    # Slot descriptor 0x00FF
    handles = find_track_handles(buf)
    slot = handles[0].slot
    off = slot * 0x10
    assert _slice(buf, off, 0x10) == _slice(activated_bytes, off, 0x10)

    # Sentinel + node + tail + slab windows
    region_offsets = [
        (0x0726, len(SENTINEL_BYTES)),
        (0x0730, 0x20),
        (0x0750, 0xA4),
        (0x07F4, 0x40),
    ]
    for rel, length in region_offsets:
        assert _slice(buf, block + rel, length) == _slice(activated_bytes, ref_block + rel, length)


def test_single_trig_matches_step9(baseline_bytes: bytes) -> None:
    buf = activate_track(baseline_bytes, track_index=1)
    blocks = find_track_blocks(buf)
    block = blocks[0]
    apply_single_trig(
        buf,
        block,
        track_index=1,
        trig=TrigSpec(step=8, note=60, velocity=100, gate_percent=100),
    )

    reference = STEP9.read_bytes()
    ref_block = find_track_blocks(reference)[0]

    # Event header + node + tail + slab
    comparisons = [
        (0x0726, 10),
        (0x0730, 0x20),
        (0x0750, 0xA4),
        (0x07F4, 0x40),
    ]
    for rel, length in comparisons:
        assert _slice(buf, block + rel, length) == _slice(reference, ref_block + rel, length)

    # Slot descriptor
    handles = find_track_handles(buf)
    slot = handles[0].slot
    off = slot * 0x10
    assert _slice(buf, off, 0x10) == _slice(reference, off, 0x10)
