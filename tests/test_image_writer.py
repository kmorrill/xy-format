"""Image-writer validation: byte-exact replication of device-saved files.

The standard: building from the decoded baseline with semantic edits must
reproduce real device captures byte-for-byte. No scaffolds, transplants,
event types, or preamble rules involved.
"""
from __future__ import annotations

import re
from pathlib import Path

import pytest

from xy.image_writer import OFF_NOTE_COUNT, ImageProject, build_arrangement
from xy.rle import decode_project, encode_project

BASE = "src/one-off-changes-from-default/unnamed 1.xy"
SIG_RE = re.compile(rb"\x00\x00\x00[\x00-\x10]\xff\x00\xfc\x00", re.S)


def build(edits):
    p = ImageProject.from_file(BASE)
    edits(p)
    return p.to_bytes()


def real(name: str) -> bytes:
    return open(f"src/one-off-changes-from-default/{name}", "rb").read()


def _decoded(data: bytes) -> bytes:
    return decode_project(data)[1]


def _leader_starts(image: bytes) -> list[int]:
    starts = [m.start() - 3 for m in SIG_RE.finditer(image)]
    leaders: list[int] = []
    idx = 0
    while idx < len(starts) and len(leaders) < 16:
        start = starts[idx]
        leaders.append(start)
        count = image[start]
        if not 1 <= count <= 16:
            count = 1
        idx += count
    if len(leaders) < 16 and len(starts) >= 16:
        leaders = starts[:16]
    return leaders


def _track_u32(image: bytes, track: int, offset: int) -> int:
    start = _leader_starts(image)[track - 1]
    return int.from_bytes(image[start + offset : start + offset + 4], "little")


def test_replicates_unnamed_2_single_note_step1():
    out = build(lambda p: p.add_note(1, step=1, note=60))
    assert out == real("unnamed 2.xy")


def test_decoded_track_scanner_accounts_for_inserted_note_records():
    p = ImageProject.from_file(BASE)
    t1 = p.track_start(1)
    t2 = p.track_start(2)

    p.add_note(1, step=1, note=60)
    assert p.track_start(1) == t1
    assert p.track_start(2) == t2 + 12

    reloaded = ImageProject.from_bytes(p.to_bytes())
    assert reloaded.track_start(1) == t1
    assert reloaded.track_start(2) == t2 + 12


@pytest.mark.parametrize(
    "firmware_byte,track_base",
    [(0x0E, 3933), (0x0F, 3933), (0x10, 3433), (0x11, 3433), (0x13, 3449)],
)
def test_track_scanner_uses_firmware_dependent_global_header_size(
    firmware_byte: int, track_base: int
) -> None:
    header, image = decode_project(real("unnamed 1.xy"))
    original_base = 3449
    resized = image[:track_base] + image[original_base:]
    if track_base > original_base:
        resized = (
            image[:original_base]
            + bytes(track_base - original_base)
            + image[original_base:]
        )
    versioned_header = header[:5] + bytes([firmware_byte]) + header[6:]

    project = ImageProject.from_bytes(encode_project(versioned_header, resized))

    assert project.track_start(1) == track_base
    assert project.track_start(2) == track_base + 17876


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


def test_negative_pickup_tick_round_trips_as_signed_i32():
    p = ImageProject.from_file(BASE)
    p.add_note(9, tick=-129, note=60)
    reloaded = ImageProject.from_bytes(p.to_bytes())
    start = reloaded.track_start(9) + 0x456F + 1
    assert int.from_bytes(
        reloaded.image[start : start + 4], "little", signed=True
    ) == -129


def test_build_arrangement_replicates_j05():
    from xy.image_writer import build_arrangement
    out = build_arrangement(BASE, {2: [[], [], []]})
    assert out == open("src/one-off-changes-from-default/j05_t2_p3_blank.xy", "rb").read()


def test_build_arrangement_replicates_j06():
    from xy.image_writer import build_arrangement
    out = build_arrangement(BASE, {t: [[]] * 9 for t in range(1, 9)})
    assert out == open("src/one-off-changes-from-default/j06_all16_p9_blank.xy", "rb").read()


def test_build_arrangement_supports_sixteen_patterns_per_track():
    from xy.image_writer import ImageProject, build_arrangement, pattern_starts_from_image
    out = build_arrangement(BASE, {1: [[]] * 16}, scenes=[{1: 15}])
    reloaded = ImageProject.from_bytes(out)
    assert len(pattern_starts_from_image(reloaded.image)) >= 16
    assert reloaded.pattern_start(1, 16) > reloaded.pattern_start(1, 15)


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


def test_set_preset_rejects_non_pristine_donor_track(tmp_path):
    """Generated projects contain note vectors, so they are unsafe preset donors."""
    donor = ImageProject.from_file(BASE)
    donor.add_note(2, step=1, note=48)
    donor_path = tmp_path / "donor-with-notes.xy"
    donor.save(str(donor_path))

    target = ImageProject.from_file(BASE)
    with pytest.raises(ValueError, match="donor track must be pristine"):
        target.set_preset(2, str(donor_path), donor_track=2)


def test_spec_to_xy_image_reproduces_whitney_probe():
    import subprocess, sys, tempfile, os
    spec = Path("specs/midi-to-xy/Whitney Houston - I Wanna Dance With Somebody song.json")
    if not spec.exists():
        pytest.skip(f"local spec fixture is not tracked: {spec}")
    out = os.path.join(tempfile.mkdtemp(), "w.xy")
    subprocess.run(
        [sys.executable, "tools/spec_to_xy_image.py",
         str(spec),
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


def test_rotate_pattern_moves_notes_plocks_components_and_flags_together():
    p = ImageProject.from_file(BASE)
    p.set_pattern_steps(1, 4)
    p.add_note(1, step=1, note=60, velocity=90, gate=120)
    p.add_note(1, step=4, note=64, velocity=91, gate=240)
    p.set_plock(1, 1, "param1", 0x1111)
    p.set_plock(1, 4, "param1", 0x4444)
    p.set_step_component(1, 1, "pulse", 7)
    p.set_step_component(1, 4, "hold", 8)

    base = p.pattern_start(1)
    inactive_start = base + p.TRK_STEPCOMP + 4 * 16
    inactive_before = bytes(p.image[inactive_start : inactive_start + 16])
    p.rotate_pattern(1, 1)

    note_start = base + OFF_NOTE_COUNT + 1
    notes = [
        bytes(p.image[note_start + i * 12 : note_start + (i + 1) * 12])
        for i in range(2)
    ]
    assert [(int.from_bytes(note[:4], "little"), note[8]) for note in notes] == [
        (0, 64),
        (480, 60),
    ]
    assert int.from_bytes(
        p.image[base + p.TRK_PLOCK + 2 : base + p.TRK_PLOCK + 4], "little"
    ) == 0x4444
    assert int.from_bytes(
        p.image[base + p.TRK_PLOCK + 86 : base + p.TRK_PLOCK + 88], "little"
    ) == 0x1111
    assert p.image[base + p.PLOCK_STEP_FLAG] == 1
    assert p.image[base + p.PLOCK_STEP_FLAG + 8] == 1
    assert p.image[base + p.TRK_STEPCOMP : base + p.TRK_STEPCOMP + 2] == b"\x02\x00"
    assert p.image[base + p.TRK_STEPCOMP + 3] == 8
    assert p.image[
        base + p.TRK_STEPCOMP + 16 : base + p.TRK_STEPCOMP + 18
    ] == b"\x01\x00"
    assert p.image[base + p.TRK_STEPCOMP + 18] == 7
    assert bytes(p.image[inactive_start : inactive_start + 16]) == inactive_before


def test_plock_carry_curve_matches_firmware_sequence_shift() -> None:
    """Firmware 1.1.25 keeps sparse p-lock carry cells during rotation."""
    arranged = build_arrangement(
        BASE,
        {1: [[], {"steps": 8, "notes": [{"step": 7, "note": 69}]}]},
    )
    p = ImageProject.from_bytes(arranged)
    p.set_plock(1, 7, "param1", 0x7000, pattern=2)

    base = p.pattern_start(1, 2)

    def param1(step: int) -> int:
        cell = base + p.TRK_PLOCK + (step - 1) * 84 + 2
        return int.from_bytes(p.image[cell : cell + 2], "little")

    assert param1(6) == 0x6FFF
    assert param1(7) == 0x7000

    p.rotate_pattern(1, -1, pattern=2)

    assert param1(5) == 0x6FFF
    assert param1(6) == 0x7000
    assert param1(7) == 0x7000
    assert p.image[base + p.PLOCK_STEP_FLAG + 5 * 8] == 1
    assert p.image[base + p.PLOCK_STEP_FLAG + 6 * 8] == 0
    current = base + p.PLOCK_CURRENT + 2
    assert p.image[current : current + 2] == b"\x00\x00"


def test_step_one_plock_uses_current_boundary_without_wrap_carry() -> None:
    """A Step 1 lock starts at the UI boundary, not the pattern's last row."""
    arranged = build_arrangement(
        BASE,
        {3: [{"steps": 8, "notes": [{"step": 1, "note": 48}]}] * 2},
    )
    p = ImageProject.from_bytes(arranged)
    for pattern in (1, 2):
        p.set_plock(3, 1, "param1", 0x1000, pattern=pattern)

    source = p.pattern_start(3, 1)
    source_current = source + p.PLOCK_CURRENT + 2
    source_last = source + p.TRK_PLOCK + 7 * 84 + 2
    assert p.image[source_current : source_current + 2] == b"\x00\x10"
    assert p.image[source_last : source_last + 2] == b"\x00\x00"

    p.rotate_pattern(3, 1, pattern=2)
    shifted = p.pattern_start(3, 2)
    shifted_current = shifted + p.PLOCK_CURRENT + 2

    def param1(step: int) -> int:
        cell = shifted + p.TRK_PLOCK + (step - 1) * 84 + 2
        return int.from_bytes(p.image[cell : cell + 2], "little")

    assert param1(1) == 0x1000
    assert param1(2) == 0x1000
    assert param1(8) == 0
    assert p.image[shifted_current : shifted_current + 2] == b"\x00\x00"


def test_rotate_pattern_preserves_armed_zero_over_retained_cell() -> None:
    p = ImageProject.from_file(BASE)
    p.set_pattern_steps(1, 4)
    p.set_plock(1, 1, "param2", 0)

    base = p.pattern_start(1)
    destination_row = base + p.TRK_PLOCK + 84
    param1 = destination_row + p.PLOCK_PARAMS["param1"]
    param2 = destination_row + p.PLOCK_PARAMS["param2"]
    p.image[param1 : param1 + 2] = (0x1110).to_bytes(2, "little")
    p.image[param2 : param2 + 2] = (0x2221).to_bytes(2, "little")

    p.rotate_pattern(1, 1)

    assert p.image[param1 : param1 + 2] == b"\x10\x11"
    assert p.image[param2 : param2 + 2] == b"\x00\x00"
    assert p.image[base + p.PLOCK_STEP_MASK + 8] == 0x02


def test_rotate_pattern_supports_clones_and_negative_steps():
    arranged = build_arrangement(
        BASE,
        {1: [[{"step": 1, "note": 60}], [{"step": 2, "note": 67}]]},
    )
    p = ImageProject.from_bytes(arranged)
    p.set_plock(1, 2, "param2", 0x2222, pattern=2)
    p.set_step_component(1, 2, "random", 9, pattern=2)
    p.rotate_pattern(1, -1, pattern=2)

    base = p.pattern_start(1, 2)
    note = bytes(p.image[base + OFF_NOTE_COUNT + 1 : base + OFF_NOTE_COUNT + 13])
    assert int.from_bytes(note[:4], "little") == 0
    assert int.from_bytes(
        p.image[base + p.TRK_PLOCK : base + p.TRK_PLOCK + 2], "little"
    ) == 0
    assert int.from_bytes(
        p.image[base + p.TRK_PLOCK + 4 : base + p.TRK_PLOCK + 6], "little"
    ) == 0x2222
    assert p.image[base + p.TRK_STEPCOMP : base + p.TRK_STEPCOMP + 2] == b"\x40\x00"


def test_m2_shift_current_lanes_match_cc_map_capture():
    cap = _decoded(real("unnamed 122.xy"))
    p = ImageProject.from_file(BASE)
    p.set_m2_shift(5, play_mode=_track_u32(cap, 5, 0x3887))
    p.set_m2_shift(6, portamento=_track_u32(cap, 6, 0x388B))
    p.set_m2_shift(7, pitch_bend_range=_track_u32(cap, 7, 0x388F))
    p.set_m2_shift(8, engine_volume=_track_u32(cap, 8, 0x3893))
    ours = _decoded(p.to_bytes())

    assert _track_u32(ours, 5, 0x3887) == _track_u32(cap, 5, 0x3887) == 0x7FFFFFFF
    assert _track_u32(ours, 6, 0x388B) == _track_u32(cap, 6, 0x388B) == 0x7FFFFFFF
    assert _track_u32(ours, 7, 0x388F) == _track_u32(cap, 7, 0x388F) == 0x7FFFFFFF
    assert _track_u32(ours, 8, 0x3893) == _track_u32(cap, 8, 0x3893) == 0x7FFFFFFF


def test_send_current_lanes_match_cc_map_capture():
    cap = _decoded(real("unnamed 123.xy"))
    p = ImageProject.from_file(BASE)
    p.set_sends(5, ext=_track_u32(cap, 5, 0x38A7))
    p.set_sends(6, tape=_track_u32(cap, 6, 0x38AB))
    p.set_sends(7, fx1=_track_u32(cap, 7, 0x38AF))
    p.set_sends(8, fx2=_track_u32(cap, 8, 0x38B3))
    ours = _decoded(p.to_bytes())

    assert _track_u32(ours, 5, 0x38A7) == _track_u32(cap, 5, 0x38A7) == 0x7FFFFFFF
    assert _track_u32(ours, 6, 0x38AB) == _track_u32(cap, 6, 0x38AB) == 0x7FFFFFFF
    assert _track_u32(ours, 7, 0x38AF) == _track_u32(cap, 7, 0x38AF) == 0x7FFFFFFF
    assert _track_u32(ours, 8, 0x38B3) == _track_u32(cap, 8, 0x38B3) == 0x7FFFFFFF


def test_lfo_current_lanes_and_mix_lanes_match_cc_map_capture():
    cap = _decoded(real("unnamed 124.xy"))
    p = ImageProject.from_file(BASE)
    p.set_lfo_current(1, cc40=_track_u32(cap, 1, 0x38B7))
    p.set_lfo_current(2, cc41=_track_u32(cap, 2, 0x38BB))
    p.set_track_mix(3, volume=_track_u32(cap, 3, 0x38FB))
    p.set_track_mix(5, pan=_track_u32(cap, 5, 0x38F7))
    ours = _decoded(p.to_bytes())

    assert _track_u32(ours, 1, 0x38B7) == _track_u32(cap, 1, 0x38B7) == 0x7FFFFFFF
    assert _track_u32(ours, 2, 0x38BB) == _track_u32(cap, 2, 0x38BB) == 0x7FFFFFFF
    assert _track_u32(ours, 3, 0x38FB) == _track_u32(cap, 3, 0x38FB) == 0x7FFFFFFF
    assert _track_u32(ours, 5, 0x38F7) == _track_u32(cap, 5, 0x38F7) == 0x7FFFFFFF


def test_track_mix_can_write_non_max_volume_capture():
    cap = _decoded(real("unnamed 99.xy"))
    p = ImageProject.from_file(BASE)
    p.set_track_mix(
        3,
        pan=_track_u32(cap, 3, 0x38F7),
        volume=_track_u32(cap, 3, 0x38FB),
    )
    ours = _decoded(p.to_bytes())

    assert _track_u32(ours, 3, 0x38F7) == 0x7FFFFFFF
    assert _track_u32(ours, 3, 0x38FB) == 0x64C99326
    assert _track_u32(ours, 3, 0x38FB) == _track_u32(cap, 3, 0x38FB)


def test_current_lane_setters_reject_out_of_range_u32_values():
    p = ImageProject.from_file(BASE)
    with pytest.raises(ValueError):
        p.set_track_mix(3, volume=-1)
    with pytest.raises(ValueError):
        p.set_sends(3, fx1=0x1_0000_0000)
    with pytest.raises(TypeError):
        p.set_lfo_current(3, cc40=True)


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
    per-step masks + master) matching unnamed 35's param1 automation."""
    from xy.rle import decode_project
    T3 = 0xD79 + 2 * 17876
    _, cap = decode_project(real("unnamed 35.xy"))
    vals = {k + 1: int.from_bytes(cap[T3 + 0x2A0 + k * 84 + 2:T3 + 0x2A0 + k * 84 + 4], "little")
            for k in range(16)}
    p = ImageProject.from_file(BASE)
    p.automate_param(3, "param1", vals)
    _, ours = decode_project(p.to_bytes())
    # Value lane, per-step masks, and master flag must match the capture.
    for k in range(16):
        cell = T3 + 0x2A0 + k * 84 + 2
        assert ours[cell:cell + 2] == cap[cell:cell + 2]
        assert ours[T3 + 0x2C4E + k * 8] == cap[T3 + 0x2C4E + k * 8] == 1
    assert ours[T3 + 0x304E] == cap[T3 + 0x304E] == 1


def test_set_plock_arms_lane_mask_and_master():
    from xy.rle import decode_project
    p = ImageProject.from_file(BASE)
    p.set_plock(3, 5, "cutoff", 20000)
    _, img = decode_project(p.to_bytes())
    T3 = 0xD79 + 2 * 17876
    assert img[T3 + 0x2A0 + 4 * 84 + 34:T3 + 0x2A0 + 4 * 84 + 36] == (20000).to_bytes(2, "little")
    assert img[T3 + 0x2C4E + 4 * 8 : T3 + 0x2C4E + 4 * 8 + 8] == (
        1 << 16
    ).to_bytes(8, "little")  # step 5 cutoff lane mask
    assert img[T3 + 0x304E] == 1            # master
