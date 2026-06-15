"""Sampler project-state captures from 2026-06-15."""

from __future__ import annotations

import json
import wave
from pathlib import Path

from xy.image_writer import ImageProject


ROOT = Path(__file__).resolve().parents[1]
CAPTURE_DIR = ROOT / "src" / "sampler-project-state" / "2026-06-15"
PRESET_DIR = CAPTURE_DIR / "presets" / "smp_default_2026-06-15.preset"
UNIQUE_PRESET_DIR = CAPTURE_DIR / "presets" / "t7-map-unique.preset"


def _project(name: str) -> ImageProject:
    return ImageProject.from_file(str(CAPTURE_DIR / name))


def _u32(project: ImageProject, track: int, rel: int) -> int:
    start = project.track_start(track)
    return int.from_bytes(project.image[start + rel : start + rel + 4], "little")


def _q16(project: ImageProject, track: int, rel: int) -> int:
    return _u32(project, track, rel) >> 16


def _cstr(data: bytes) -> str:
    return data.split(b"\x00", 1)[0].decode("utf-8")


def _preset_label(project: ImageProject, track: int) -> str:
    start = project.track_start(track)
    return _cstr(bytes(project.image[start + 0x453F : start + 0x456F]))


def _slot_path(project: ImageProject, track: int) -> str:
    start = project.track_start(track)
    return _cstr(bytes(project.image[start + 0x395F : start + 0x39BF]))


def _wav_frame_count() -> int:
    with wave.open(str(PRESET_DIR / "unnamed1-c4-0.wav"), "rb") as wav:
        return wav.getnframes()


def _preset_region() -> dict:
    return json.loads((PRESET_DIR / "patch.json").read_text())["regions"][0]


def _unique_preset() -> dict:
    return json.loads((UNIQUE_PRESET_DIR / "patch.json").read_text())


def test_tonal_sampler_default_load_writes_preslot_window_and_sample_path() -> None:
    project = _project("smp02_t7_sample_loaded_default.xy")
    start = project.track_start(7)
    region = _preset_region()

    assert project.image[start + 0x14] == 0x02
    assert _preset_label(project, 7) == "/"
    assert _slot_path(project, 7) == "/fat32/samples/user/unnamed1-c4-0.wav"
    assert _u32(project, 7, 0x393F) == _wav_frame_count() == region["framecount"]
    assert _u32(project, 7, 0x3943) == 0
    assert _u32(project, 7, 0x3947) == region["sample.end"]
    assert _u32(project, 7, 0x394B) == region["loop.start"]
    assert _u32(project, 7, 0x394F) == region["loop.end"]
    assert _u32(project, 7, 0x3953) == 0x2698
    assert bytes(project.image[start + 0x3957 : start + 0x395F]) == bytes.fromhex(
        "3c 00 3c 80 00 00 00 00"
    )


def test_saving_sampler_preset_repoints_project_path_to_preset_folder() -> None:
    project = _project("smp03_t7_sample_loaded_saved_preset.xy")

    assert _preset_label(project, 7) == "snapshot/2026-06-15 (1)"
    assert _slot_path(project, 7) == (
        "/fat32/presets/snapshot/2026-06-15 (1).preset/unnamed1-c4-0.wav"
    )
    assert _u32(project, 7, 0x3953) == 0


def test_reloading_saved_sampler_preset_preserves_project_sample_window() -> None:
    saved = _project("smp03_t7_sample_loaded_saved_preset.xy")
    reloaded = _project("smp04_reload_saved_preset_fresh_project.xy")

    for rel in (0x393F, 0x3943, 0x3947, 0x394B, 0x394F, 0x3953):
        assert _u32(reloaded, 7, rel) == _u32(saved, 7, rel)
    assert _slot_path(reloaded, 7) == _slot_path(saved, 7)


def test_loop_edit_moves_only_preslot_window_values() -> None:
    before = _project("smp04_reload_saved_preset_fresh_project.xy")
    changed = _project("smp06_project_loop_only.xy")

    assert _slot_path(changed, 7) == _slot_path(before, 7)
    assert _u32(changed, 7, 0x3943) == 0x1F65
    assert _u32(changed, 7, 0x3947) == 0x175F1
    assert _u32(changed, 7, 0x394B) == 0x7F4A
    assert _u32(changed, 7, 0x394F) == 0x128BF


def test_unique_sampler_preset_alignment_maps_project_sound_state() -> None:
    project = _project("smp07_t7_unique_sampler_preset_loaded.xy")
    patch = _unique_preset()
    region = patch["regions"][0]

    assert _preset_label(project, 7) == "snapshot/t7-map-unique"
    assert _slot_path(project, 7) == (
        "/fat32/presets/snapshot/t7-map-unique.preset/unnamed1-c4-0.wav"
    )

    # Tonal sampler M1 values stay at centered defaults; sampler windows live
    # in the pre-slot sample block below, not in patch.json engine.params.
    for rel in range(0x3857, 0x3877, 4):
        assert _u32(project, 7, rel) == 0x40000000

    assert _q16(project, 7, 0x3877) == patch["envelope"]["amp"]["attack"]
    assert _q16(project, 7, 0x387B) == patch["envelope"]["amp"]["decay"]
    assert _q16(project, 7, 0x387F) == patch["envelope"]["amp"]["sustain"]
    assert _q16(project, 7, 0x3883) == patch["envelope"]["amp"]["release"]
    assert _u32(project, 7, 0x3887) == 0x15555555
    assert _q16(project, 7, 0x388B) == patch["engine"]["portamento.amount"]
    assert _q16(project, 7, 0x388F) == patch["engine"]["bendrange"]
    assert _q16(project, 7, 0x3893) == patch["engine"]["volume"]

    for index, rel in enumerate(range(0x3897, 0x38B7, 4)):
        if index == 5:
            assert _u32(project, 7, rel) == 0x7FFFFFFF
        else:
            assert _q16(project, 7, rel) == patch["fx"]["params"][index]

    for index, rel in enumerate(range(0x38B7, 0x38D7, 4)):
        assert _q16(project, 7, rel) == patch["lfo"]["params"][index]

    assert _q16(project, 7, 0x38D7) == patch["envelope"]["filter"]["attack"]
    assert _q16(project, 7, 0x38DB) == patch["envelope"]["filter"]["decay"]
    assert _q16(project, 7, 0x38DF) == patch["envelope"]["filter"]["sustain"]
    assert _q16(project, 7, 0x38E3) == patch["envelope"]["filter"]["release"]

    assert _q16(project, 7, 0x38FF) == patch["engine"]["modulation"]["modwheel"]["target"]
    assert _q16(project, 7, 0x3903) == patch["engine"]["modulation"]["modwheel"]["amount"]
    assert _q16(project, 7, 0x3907) == patch["engine"]["modulation"]["aftertouch"]["target"]
    assert _q16(project, 7, 0x390B) == patch["engine"]["modulation"]["aftertouch"]["amount"]
    assert _q16(project, 7, 0x390F) == patch["engine"]["modulation"]["pitchbend"]["target"]
    assert _q16(project, 7, 0x3913) == patch["engine"]["modulation"]["pitchbend"]["amount"]
    assert _q16(project, 7, 0x3917) == patch["engine"]["velocity.sensitivity"]
    assert _q16(project, 7, 0x391B) == patch["engine"]["portamento.type"]
    assert _q16(project, 7, 0x3923) == patch["engine"]["width"]
    assert _q16(project, 7, 0x392F) == patch["engine"]["highpass"]
    assert _q16(project, 7, 0x3933) == patch["engine"]["modulation"]["velocity"]["target"]
    assert _q16(project, 7, 0x3937) == patch["engine"]["modulation"]["velocity"]["amount"]

    assert _u32(project, 7, 0x393F) == region["framecount"]
    assert _u32(project, 7, 0x3943) == 0
    assert _u32(project, 7, 0x3947) == region["sample.end"]
    assert _u32(project, 7, 0x394B) == region["loop.start"]
    assert _u32(project, 7, 0x394F) == region["loop.end"]
    assert _u32(project, 7, 0x3953) == 0x02A73100
