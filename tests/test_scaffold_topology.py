"""Scaffold topology regressions for j06/j07 (T010)."""

from pathlib import Path
import sys

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import TrackBlock, XYProject
from xy.note_reader import read_track_notes


CORPUS = REPO_ROOT / "src" / "one-off-changes-from-default"
J06 = CORPUS / "j06_all16_p9_blank.xy"
J07 = CORPUS / "j07_all16_p9_sparsemap.xy"

TRACK_SIG_HEAD = b"\x00\x00\x01"
TRACK_SIG_TAIL = b"\xff\x00\xfc\x00"


def _find_track_sigs(buf: bytes) -> list[int]:
    offsets: list[int] = []
    i = 0
    while i < len(buf) - 8:
        j = buf.find(TRACK_SIG_HEAD, i)
        if j == -1:
            break
        if j + 8 <= len(buf) and buf[j + 4 : j + 8] == TRACK_SIG_TAIL:
            offsets.append(j)
            i = j + 4
        else:
            i = j + 1
    return offsets


def _split_overflow(track16: TrackBlock) -> list[tuple[bytes, bytes]]:
    body = track16.body
    sigs = _find_track_sigs(body)
    if not sigs:
        return [(track16.preamble, track16.body)]

    entries: list[tuple[bytes, bytes]] = []
    for idx, sig_off in enumerate(sigs):
        preamble = track16.preamble if idx == 0 else body[sig_off - 4 : sig_off]
        end = sigs[idx + 1] - 4 if idx + 1 < len(sigs) else len(body)
        entries.append((preamble, body[sig_off:end]))
    return entries


def _extract_logical_entries(project: XYProject) -> list[tuple[int, int, bytes, bytes]]:
    raw: list[tuple[bytes, bytes]] = [(t.preamble, t.body) for t in project.tracks[:15]]
    raw.extend(_split_overflow(project.tracks[15]))

    entries: list[tuple[int, int, bytes, bytes]] = []
    i = 0
    for track in range(1, 17):
        pattern_count = raw[i][0][1] or 1
        for pattern in range(1, pattern_count + 1):
            preamble, body = raw[i]
            entries.append((track, pattern, preamble, body))
            i += 1

    if i != len(raw):
        raise ValueError(f"logical mapping consumed {i}/{len(raw)} raw entries")
    return entries


def _pattern_counts(entries: list[tuple[int, int, bytes, bytes]]) -> dict[int, int]:
    counts: dict[int, int] = {}
    for track, _pattern, _pre, _body in entries:
        counts[track] = counts.get(track, 0) + 1
    return counts


def test_j06_topology_mapping_and_overflow_shape() -> None:
    project = XYProject.from_bytes(J06.read_bytes())
    entries = _extract_logical_entries(project)

    assert len(entries) == 80
    counts = _pattern_counts(entries)
    for track in range(1, 9):
        assert counts[track] == 9
    for track in range(9, 17):
        assert counts[track] == 1

    overflow = _split_overflow(project.tracks[15])
    assert len(overflow) == 65  # 80 logical entries - 15 fixed slots

    sigs = _find_track_sigs(project.tracks[15].body)
    assert len(sigs) == 65
    assert sigs[0] == 0

    # Blank scaffold: no active pattern entries and no decoded notes.
    for track, _pattern, preamble, body in entries:
        assert body[9] == 0x05
        notes = read_track_notes(TrackBlock(index=0, preamble=preamble, body=body), track)
        assert notes == []


def test_j07_sparsemap_note_addressing_is_deterministic() -> None:
    project = XYProject.from_bytes(J07.read_bytes())
    entries = _extract_logical_entries(project)

    assert len(entries) == 80
    counts = _pattern_counts(entries)
    for track in range(1, 9):
        assert counts[track] == 9
    for track in range(9, 17):
        assert counts[track] == 1

    # Documented sparse placements from change log.
    expected_steps = {
        (1, 1): 1,
        (1, 9): 9,
        (2, 2): 2,
        (2, 9): 10,
        (3, 1): 3,
        (3, 9): 11,
        (4, 2): 4,
        (4, 9): 12,
        (5, 1): 5,
        (5, 9): 13,
        (6, 2): 6,
        (6, 9): 14,
        (7, 1): 7,
        (7, 9): 15,
        (8, 2): 8,
        (8, 9): 16,
    }

    found: dict[tuple[int, int], tuple[int, int, int]] = {}
    active_entries = 0

    for track, pattern, preamble, body in entries:
        if body[9] == 0x07:
            active_entries += 1
        notes = read_track_notes(TrackBlock(index=0, preamble=preamble, body=body), track)
        if not notes:
            continue
        assert len(notes) == 1
        note = notes[0]
        found[(track, pattern)] = (note.step, note.note, note.velocity)

    assert active_entries == 16
    assert set(found) == set(expected_steps)

    for key, expected_step in expected_steps.items():
        step, _note, velocity = found[key]
        assert step == expected_step
        assert velocity == 100

    # Value mapping in fixture: T1/T2 use C4 (60), T3-T8 use F3 (53).
    assert found[(1, 1)][1] == 60
    assert found[(1, 9)][1] == 60
    assert found[(2, 2)][1] == 60
    assert found[(2, 9)][1] == 60
    for track in (3, 4, 5, 6, 7, 8):
        left_pat = 1 if track % 2 == 1 else 2
        assert found[(track, left_pat)][1] == 53
        assert found[(track, 9)][1] == 53


def test_j06_and_j07_overflow_split_counts_stable() -> None:
    j06 = XYProject.from_bytes(J06.read_bytes())
    j07 = XYProject.from_bytes(J07.read_bytes())

    for project in (j06, j07):
        overflow = _split_overflow(project.tracks[15])
        sigs = _find_track_sigs(project.tracks[15].body)
        assert len(overflow) == 65
        assert len(sigs) == 65
        assert sigs[0] == 0
