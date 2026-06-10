"""Image-writer validation: byte-exact replication of device-saved files.

The standard: building from the decoded baseline with semantic edits must
reproduce real device captures byte-for-byte. No scaffolds, transplants,
event types, or preamble rules involved.
"""
from __future__ import annotations

import pytest

from xy.image_writer import ImageProject

BASE = "src/one-off-changes-from-default/unnamed 1.xy"


def build(edits):
    p = ImageProject.from_file(BASE)
    edits(p)
    return p.to_bytes()


def real(name: str) -> bytes:
    return open(f"src/one-off-changes-from-default/{name}", "rb").read()


def test_replicates_unnamed_2_single_note_step1():
    out = build(lambda p: p.add_note(1, step=1, note=60))
    assert out == real("unnamed 2.xy")


def test_replicates_unnamed_81_single_note_step9():
    out = build(lambda p: p.add_note(1, step=9, note=60))
    assert out == real("unnamed 81.xy")


def test_replicates_unnamed_19_bar_count():
    out = build(lambda p: p.set_bars(1, 4))
    assert out == real("unnamed 19.xy")


def test_replicates_unnamed_92_notes_with_gates():
    def edits(p):
        p.add_note(3, step=1, note=48, gate=960)
        p.add_note(3, step=5, note=50, gate=1920)
        p.add_note(3, step=11, note=53, gate=2880)
    assert build(edits) == real("unnamed 92.xy")


def test_note_equals_velocity_emits_escaped_pair():
    out = build(lambda p: p.add_note(1, step=1, note=60, velocity=60))
    # the equal pair must carry its RLE extension byte
    assert b"\x3c\x3c\x00" in out


def test_note_limit_enforced():
    p = ImageProject.from_file(BASE)
    for i in range(120):
        p.add_note(1, tick=i * 10, note=60)
    with pytest.raises(ValueError):
        p.add_note(1, tick=2000, note=61)


def test_build_arrangement_replicates_j05():
    from xy.image_writer import build_arrangement
    out = build_arrangement(BASE, {2: [[], [], []]})
    assert out == open("src/one-off-changes-from-default/j05_t2_p3_blank.xy", "rb").read()


def test_build_arrangement_replicates_j06():
    from xy.image_writer import build_arrangement
    out = build_arrangement(BASE, {t: [[]] * 9 for t in range(1, 9)})
    assert out == open("src/one-off-changes-from-default/j06_all16_p9_blank.xy", "rb").read()


def test_set_preset_matches_device_kit_load():
    """u116's T4/T7/T8 = boop kit loaded + one C4: our donor-copy must match
    the device byte-for-byte except known UI-session fields."""
    from xy.rle import decode_project
    import re
    p = ImageProject.from_file(BASE)
    for trk in (4, 7, 8):
        p.set_preset(trk, BASE, donor_track=1)
        p.add_note(trk, step=1, note=60)
    _, ours = decode_project(p.to_bytes())
    _, theirs = decode_project(real("unnamed 116.xy"))
    assert len(ours) == len(theirs)
    UI_OK = {0x3CBF, 0x3CC0, 0x3CCB, 0x3CCC, 0x3CD7, 0x3CD8, 0x3DD7, 0x3DD8, 0x389B}
    sig = re.compile(rb"\x00\x00\x00[\x00-\x0f]\xff\x00\xfc\x00")
    starts = [m.start() - 3 for m in sig.finditer(theirs)]
    for i in range(len(ours)):
        if ours[i] != theirs[i]:
            rel = (i - starts[0]) % 17876
            assert rel in UI_OK, f"non-UI residual at image+{i:#x} (track-rel {rel:#x})"
