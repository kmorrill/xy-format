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


def test_set_pattern_steps_writes_final_bar_length_byte():
    from xy.rle import decode_project
    p = ImageProject.from_file(BASE)
    p.set_pattern_steps(1, 24)
    _, img = decode_project(p.to_bytes())
    t1 = p.track_start(1)
    assert img[t1 + 0x01] == 24


def test_set_pattern_steps_rejects_out_of_range_values():
    p = ImageProject.from_file(BASE)
    with pytest.raises(ValueError):
        p.set_pattern_steps(1, 0)
    with pytest.raises(ValueError):
        p.set_pattern_steps(1, 65)


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


def test_build_arrangement_accepts_explicit_pattern_steps():
    from xy.image_writer import build_arrangement
    from xy.rle import decode_project
    out = build_arrangement(BASE, {3: [{"steps": 24, "notes": []}]})
    _, img = decode_project(out)
    t3 = 0xD79 + (3 - 1) * 17876
    assert img[t3 + 0x01] == 24


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


def test_spec_to_xy_image_reproduces_whitney_probe():
    import subprocess, sys, tempfile, os
    out = os.path.join(tempfile.mkdtemp(), "w.xy")
    subprocess.run(
        [sys.executable, "tools/spec_to_xy_image.py",
         "specs/midi-to-xy/Whitney Houston - I Wanna Dance With Somebody song.json",
         "-o", out],
        check=True, capture_output=True,
    )
    assert open(out, "rb").read() == open(
        "output/image-probes/05_e_whitney_img_song.xy", "rb"
    ).read()


def test_drum_voice_tune_matches_device_capture():
    """Decoded drum tune (root note ±48) reproduces the device capture's
    edited voices byte-exactly."""
    from xy.rle import decode_project
    p = ImageProject.from_file(BASE)
    p.set_drum_voice(1, 7, tune=+48)   # shaker -> max
    p.set_drum_voice(1, 9, tune=-48)   # ch boop b -> min
    _, ours = decode_project(p.to_bytes())
    _, cap = decode_project(open("output/image-probes/cap_drum_params.xy", "rb").read())
    T1, SLOT0, STRIDE = 0xD79, 0x3957, 0x80
    for v in (7, 9):
        off = T1 + SLOT0 + v * STRIDE  # +0x00 = tune byte
        assert ours[off] == cap[off]


# --- convenience-method byte-exact replication of corpus captures ---------

import pytest as _pytest


@_pytest.mark.parametrize("target,edit", [
    ("unnamed 5.xy", lambda p: p.set_tempo(121.2)),
    ("unnamed 11.xy", lambda p: p.set_groove(8)),
    ("unnamed 10.xy", lambda p: p.set_click_volume(0)),
    ("unnamed 41.xy", lambda p: (p.set_midi_channel(1, 1), p.set_midi_channel(16, 16))),
    ("unnamed 14.xy", lambda p: p.set_master_eq(low=0)),
    ("unnamed 15.xy", lambda p: p.set_master_eq(mid=0)),
    ("unnamed 16.xy", lambda p: p.set_master_eq(high=0)),
    ("unnamed 20.xy", lambda p: p.set_track_scale(1, 2)),
    ("unnamed 21.xy", lambda p: p.set_track_scale(1, 16)),
    ("unnamed 22.xy", lambda p: p.set_track_scale(1, 0.5)),
    ("unnamed 23.xy", lambda p: p.set_engine_param(3, 1, 0x7FFFFFFF)),
    ("unnamed 8.xy", lambda p: p.set_step_component(1, 1, "pulse", 1)),
    ("unnamed 59.xy", lambda p: p.set_step_component(1, 9, "pulse", 1)),
])
def test_convenience_methods_replicate_device_captures(target, edit):
    p = ImageProject.from_file(BASE)
    edit(p)
    assert p.to_bytes() == real(target)


def test_set_plock_writes_u16_cell():
    p = ImageProject.from_file(BASE)
    p.set_plock(2, 1, "param2", 256)  # step 1, Param 2 = byte offset 4 in row
    T2 = 0xD79 + 17876
    cell = T2 + 0x2A0 + 4
    from xy.rle import decode_project
    _, img = decode_project(p.to_bytes())
    assert img[cell : cell + 2] == (256).to_bytes(2, "little")


def test_automate_param_reproduces_device_capture_structure():
    """automate_param writes the device automation structure (value lane +
    per-step flags + master) matching unnamed 35's param1 automation."""
    from xy.rle import decode_project
    T3 = 0xD79 + 2 * 17876
    _, cap = decode_project(real("unnamed 35.xy"))
    vals = {k + 1: int.from_bytes(cap[T3 + 0x2A0 + k * 84 + 2:T3 + 0x2A0 + k * 84 + 4], "little")
            for k in range(16)}
    p = ImageProject.from_file(BASE)
    p.automate_param(3, "param1", vals)
    _, ours = decode_project(p.to_bytes())
    # value lane, per-step flags, master flag must match the capture
    for k in range(16):
        cell = T3 + 0x2A0 + k * 84 + 2
        assert ours[cell:cell + 2] == cap[cell:cell + 2]
        assert ours[T3 + 0x2C4E + k * 8] == cap[T3 + 0x2C4E + k * 8] == 1
    assert ours[T3 + 0x304E] == cap[T3 + 0x304E] == 1


def test_set_plock_arms_flags():
    from xy.rle import decode_project
    p = ImageProject.from_file(BASE)
    p.set_plock(3, 5, "cutoff", 20000)
    _, img = decode_project(p.to_bytes())
    T3 = 0xD79 + 2 * 17876
    assert img[T3 + 0x2A0 + 4 * 84 + 34:T3 + 0x2A0 + 4 * 84 + 36] == (20000).to_bytes(2, "little")
    assert img[T3 + 0x2C4E + 4 * 8] == 1   # step 5 flag
    assert img[T3 + 0x304E] == 1            # master
