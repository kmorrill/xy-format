from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.structs import (  # noqa: E402
    TRACK_SIGNATURE_HEAD,
    find_track_blocks,
    is_probable_track_start,
)

FIXTURES = Path("src/one-off-changes-from-default")


@pytest.mark.parametrize(
    "filename",
    [
        "unnamed 6.xy",
        "unnamed 7.xy",
    ],
)
def test_find_track_blocks_limits_to_sixteen_tracks(filename: str) -> None:
    data = (FIXTURES / filename).read_bytes()
    offsets = find_track_blocks(data)
    assert len(offsets) == 16
    assert offsets == sorted(set(offsets))


def test_is_probable_track_start_rejects_intra_block_signature() -> None:
    data = (FIXTURES / "unnamed 6.xy").read_bytes()
    block_offsets = set(find_track_blocks(data))
    search_from = 0
    while True:
        idx = data.find(TRACK_SIGNATURE_HEAD, search_from)
        if idx == -1:
            pytest.skip("No intra-block signature match found to validate heuristics")
        if idx not in block_offsets:
            assert not is_probable_track_start(data, idx)
            break
        search_from = idx + 1
