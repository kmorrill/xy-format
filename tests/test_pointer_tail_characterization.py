"""Characterization tests for pointer-tail / pointer-21 fixtures (T011 prep)."""

from pathlib import Path
import sys

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from tools.inspect_xy import build_track_infos, tail_has_pointer_reference
from xy.structs import find_track_blocks, find_track_handles


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"


def _track_infos(filename: str):
    data = (CORPUS / filename).read_bytes()
    handles = find_track_handles(data)
    blocks = find_track_blocks(data)
    return build_track_infos(data, handles, blocks)


def _pointer_events(filename: str):
    events = []
    for info in _track_infos(filename):
        for event in info.events:
            if event.variant in {"pointer-21", "pointer-tail", "hybrid-tail"}:
                events.append((info.index, event))
    return events


def test_pointer21_fixtures_expose_pointer21_events() -> None:
    # Known pointer-21/live-record family fixtures from issue notes.
    fixtures = [
        "unnamed 38.xy",
        "unnamed 39.xy",
        "unnamed 65.xy",
        "unnamed 79.xy",
        "unnamed 86.xy",
        "unnamed 87.xy",
    ]
    for fixture in fixtures:
        pointer_events = _pointer_events(fixture)
        assert any(event.variant == "pointer-21" for _track, event in pointer_events), fixture
        for _track, event in pointer_events:
            if event.variant != "pointer-21":
                continue
            # Current known gap: musical note/gate payload unresolved here.
            assert event.notes == []
            assert event.tail_entries


def test_hybrid_tail_chord_fixtures_expose_pointer_references() -> None:
    fixtures = [
        "unnamed 3.xy",
        "unnamed 80.xy",
    ]
    for fixture in fixtures:
        pointer_events = _pointer_events(fixture)
        assert any(event.variant == "hybrid-tail" for _track, event in pointer_events), fixture
        for _track, event in pointer_events:
            if event.variant != "hybrid-tail":
                continue
            assert event.tail_entries
            assert tail_has_pointer_reference(event.tail_entries)
