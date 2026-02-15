"""Generated multi-pattern device-pass stability checks (T013)."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import re
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from xy.container import TrackBlock, XYProject
from xy.note_reader import read_track_notes


OUTPUT_DIR = REPO_ROOT / "output"
CHANGE_LOG = REPO_ROOT / "src" / "one-off-changes-from-default" / "op-xy_project_change_log.md"

TRACK_SIG_HEAD = b"\x00\x00\x01"
TRACK_SIG_TAIL = b"\xff\x00\xfc\x00"

DESC_5B = bytes.fromhex("001d010000")
DESC_7B = bytes.fromhex("0100001b010000")


@dataclass(frozen=True)
class FixtureExpectation:
    descriptor: bytes
    pre_track_len: int
    active_entries: int
    notes: tuple[tuple[int, int, int, int, int, int], ...]


FIXTURES: dict[str, FixtureExpectation] = {
    "mp2_v5_105b_novel_single.xy": FixtureExpectation(
        descriptor=DESC_5B,
        pre_track_len=129,
        active_entries=3,
        notes=(
            (1, 2, 5, 62, 104, 0),
            (3, 1, 12, 55, 96, 0),
            (3, 2, 2, 50, 108, 0),
        ),
    ),
    "mp2_v5_105b_novel_dense.xy": FixtureExpectation(
        descriptor=DESC_5B,
        pre_track_len=129,
        active_entries=3,
        notes=(
            (1, 2, 1, 60, 100, 0),
            (1, 2, 9, 64, 110, 0),
            (3, 1, 4, 53, 96, 0),
            (3, 1, 12, 57, 102, 0),
            (3, 2, 2, 52, 100, 0),
            (3, 2, 10, 55, 112, 0),
        ),
    ),
    "mp2_v7_diag_h5_both_sparse.xy": FixtureExpectation(
        descriptor=DESC_5B,
        pre_track_len=129,
        active_entries=4,
        notes=(
            (1, 1, 1, 48, 110, 0),
            (1, 2, 9, 52, 110, 0),
            (3, 1, 1, 36, 100, 0),
            (3, 2, 9, 43, 104, 0),
        ),
    ),
    "mp2_v7_diag_h7_both_sparse.xy": FixtureExpectation(
        descriptor=DESC_7B,
        pre_track_len=131,
        active_entries=4,
        notes=(
            (1, 1, 1, 48, 110, 0),
            (1, 2, 9, 52, 110, 0),
            (3, 1, 1, 36, 100, 0),
            (3, 2, 9, 43, 104, 0),
        ),
    ),
    "mp2_v7_diag_h5_both_dense.xy": FixtureExpectation(
        descriptor=DESC_5B,
        pre_track_len=129,
        active_entries=4,
        notes=(
            (1, 1, 1, 48, 120, 0),
            (1, 1, 3, 55, 86, 0),
            (1, 1, 5, 52, 112, 0),
            (1, 1, 7, 55, 88, 0),
            (1, 1, 9, 48, 118, 0),
            (1, 1, 11, 55, 90, 0),
            (1, 1, 13, 52, 114, 0),
            (1, 1, 15, 55, 92, 0),
            (1, 2, 1, 48, 120, 0),
            (1, 2, 3, 55, 86, 0),
            (1, 2, 5, 52, 112, 0),
            (1, 2, 7, 55, 88, 0),
            (1, 2, 9, 48, 118, 0),
            (1, 2, 11, 55, 90, 0),
            (1, 2, 12, 48, 110, 0),
            (1, 2, 13, 52, 114, 0),
            (1, 2, 14, 57, 106, 0),
            (1, 2, 15, 59, 108, 0),
            (1, 2, 16, 60, 112, 0),
            (3, 1, 1, 36, 102, 720),
            (3, 1, 5, 36, 100, 720),
            (3, 1, 9, 43, 104, 720),
            (3, 1, 13, 41, 102, 720),
            (3, 2, 1, 36, 102, 720),
            (3, 2, 4, 38, 98, 480),
            (3, 2, 7, 39, 100, 480),
            (3, 2, 10, 43, 106, 960),
            (3, 2, 13, 34, 102, 720),
            (3, 2, 15, 36, 100, 480),
        ),
    ),
    "mp2_v7_diag_h7_both_dense.xy": FixtureExpectation(
        descriptor=DESC_7B,
        pre_track_len=131,
        active_entries=4,
        notes=(
            (1, 1, 1, 48, 120, 0),
            (1, 1, 3, 55, 86, 0),
            (1, 1, 5, 52, 112, 0),
            (1, 1, 7, 55, 88, 0),
            (1, 1, 9, 48, 118, 0),
            (1, 1, 11, 55, 90, 0),
            (1, 1, 13, 52, 114, 0),
            (1, 1, 15, 55, 92, 0),
            (1, 2, 1, 48, 120, 0),
            (1, 2, 3, 55, 86, 0),
            (1, 2, 5, 52, 112, 0),
            (1, 2, 7, 55, 88, 0),
            (1, 2, 9, 48, 118, 0),
            (1, 2, 11, 55, 90, 0),
            (1, 2, 12, 48, 110, 0),
            (1, 2, 13, 52, 114, 0),
            (1, 2, 14, 57, 106, 0),
            (1, 2, 15, 59, 108, 0),
            (1, 2, 16, 60, 112, 0),
            (3, 1, 1, 36, 102, 720),
            (3, 1, 5, 36, 100, 720),
            (3, 1, 9, 43, 104, 720),
            (3, 1, 13, 41, 102, 720),
            (3, 2, 1, 36, 102, 720),
            (3, 2, 4, 38, 98, 480),
            (3, 2, 7, 39, 100, 480),
            (3, 2, 10, 43, 106, 960),
            (3, 2, 13, 34, 102, 720),
            (3, 2, 15, 36, 100, 480),
        ),
    ),
    "mp2_v7_diag_t1both_dense_t3clone.xy": FixtureExpectation(
        descriptor=DESC_7B,
        pre_track_len=131,
        active_entries=3,
        notes=(
            (1, 1, 1, 48, 120, 0),
            (1, 1, 3, 55, 86, 0),
            (1, 1, 5, 52, 112, 0),
            (1, 1, 7, 55, 88, 0),
            (1, 1, 9, 48, 118, 0),
            (1, 1, 11, 55, 90, 0),
            (1, 1, 13, 52, 114, 0),
            (1, 1, 15, 55, 92, 0),
            (1, 2, 1, 48, 120, 0),
            (1, 2, 3, 55, 86, 0),
            (1, 2, 5, 52, 112, 0),
            (1, 2, 7, 55, 88, 0),
            (1, 2, 9, 48, 118, 0),
            (1, 2, 11, 55, 90, 0),
            (1, 2, 12, 48, 110, 0),
            (1, 2, 13, 52, 114, 0),
            (1, 2, 14, 57, 106, 0),
            (1, 2, 15, 59, 108, 0),
            (1, 2, 16, 60, 112, 0),
            (3, 2, 1, 36, 102, 720),
            (3, 2, 4, 38, 98, 480),
            (3, 2, 7, 39, 100, 480),
            (3, 2, 10, 43, 106, 960),
            (3, 2, 13, 34, 102, 720),
            (3, 2, 15, 36, 100, 480),
        ),
    ),
}


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


def _split_overflow(track16) -> list[tuple[bytes, bytes]]:
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


def _collect_note_rows(entries: list[tuple[int, int, bytes, bytes]]) -> list[tuple[int, int, int, int, int, int]]:
    rows: list[tuple[int, int, int, int, int, int]] = []
    for track, pattern, preamble, body in entries:
        notes = read_track_notes(TrackBlock(index=0, preamble=preamble, body=body), track)
        for n in notes:
            rows.append((track, pattern, n.step, n.note, n.velocity, n.gate_ticks))
    return sorted(rows)


def _load_generated_fixture(filename: str) -> XYProject:
    path = OUTPUT_DIR / filename
    if not path.exists():
        pytest.skip(f"generated fixture not present: {path}")
    raw = path.read_bytes()
    project = XYProject.from_bytes(raw)
    # Generated artifact should always remain parse/round-trip stable.
    assert project.to_bytes() == raw
    return project


@pytest.mark.parametrize("filename", sorted(FIXTURES))
def test_change_log_records_device_pass_for_generated_fixture(filename: str) -> None:
    text = CHANGE_LOG.read_text(encoding="utf-8")
    m = re.search(rf"\*\*{re.escape(filename)}\*\*.*", text)
    assert m is not None, filename
    assert "Device load result: **PASS**" in m.group(0)


@pytest.mark.parametrize(
    ("filename", "expect"),
    sorted(FIXTURES.items()),
    ids=[name for name, _ in sorted(FIXTURES.items())],
)
def test_generated_fixture_topology_descriptor_and_notes(
    filename: str,
    expect: FixtureExpectation,
) -> None:
    project = _load_generated_fixture(filename)
    entries = _extract_logical_entries(project)
    counts = _pattern_counts(entries)

    assert project.pre_track[0x56:0x58] == b"\x01\x00"
    assert len(project.pre_track) == expect.pre_track_len
    assert project.pre_track[0x58 : 0x58 + len(expect.descriptor)] == expect.descriptor

    assert len(entries) == 18
    for track in range(1, 17):
        wanted = 2 if track in {1, 3} else 1
        assert counts.get(track) == wanted

    active = sum(1 for _t, _p, _pre, body in entries if body[9] == 0x07)
    assert active == expect.active_entries

    assert _collect_note_rows(entries) == sorted(expect.notes)


def _notes_for(filename: str) -> list[tuple[int, int, int, int, int, int]]:
    project = _load_generated_fixture(filename)
    return _collect_note_rows(_extract_logical_entries(project))


def test_h5_and_h7_sparse_have_identical_note_content() -> None:
    h5 = _notes_for("mp2_v7_diag_h5_both_sparse.xy")
    h7 = _notes_for("mp2_v7_diag_h7_both_sparse.xy")
    assert h5 == h7


def test_h5_and_h7_dense_have_identical_note_content() -> None:
    h5 = _notes_for("mp2_v7_diag_h5_both_dense.xy")
    h7 = _notes_for("mp2_v7_diag_h7_both_dense.xy")
    assert h5 == h7
