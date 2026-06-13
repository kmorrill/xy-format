"""Drum per-voice param read API — validated against cap_drum_params.xy."""

from pathlib import Path

import pytest

from xy.drum_sample_inspection import (
    decode_drum_tune_semitones,
    inspect_drum_samples_bytes,
)
from xy.image_writer import ImageProject

ROOT = Path(__file__).resolve().parents[1]
CAP = ROOT / "output" / "image-probes" / "cap_drum_params.xy"
BASELINE = ROOT / "src" / "one-off-changes-from-default" / "unnamed 1.xy"


def _voice(path: Path, voice: int):
    inspection = inspect_drum_samples_bytes(path.read_bytes())
    track = next(t for t in inspection.tracks if t.track == 1)
    return track.voices[voice]


def test_decode_drum_tune_semitones_center_and_extremes() -> None:
    assert decode_drum_tune_semitones(0x3C) == 0
    assert decode_drum_tune_semitones(0x6C) == +48
    assert decode_drum_tune_semitones(0x0C) == -48


@pytest.mark.parametrize(
    "voice,checks",
    [
        (5, {"start": 7171}),
        (7, {"tune_semitones": +48}),
        (9, {"tune_semitones": -48}),
        (10, {"loop_start": 0x1011, "end": 0x1F40}),
        (16, {"play_mode": 3}),
        (18, {"direction": 1, "direction_label": "backward"}),
        (20, {"gain_u32": 0x7FFFFFFF}),
    ],
)
def test_cap_drum_params_isolated_edits(voice: int, checks: dict) -> None:
    sample = _voice(CAP, voice)
    for field, expected in checks.items():
        assert getattr(sample, field) == expected


def test_cap_drum_params_defaults_unchanged_voices() -> None:
    base = _voice(BASELINE, 12)
    cap = _voice(CAP, 12)
    assert cap.tune_semitones == 0
    assert cap.play_mode == base.play_mode
    assert cap.direction == 0
    assert cap.start == 0
    assert cap.loop_start == 0
    assert cap.end == 0xFFFFFFFF
    assert cap.gain_u32 == 0


def test_set_drum_voice_roundtrip_through_read_api() -> None:
    project = ImageProject.from_file(str(BASELINE))
    project.set_drum_voice(1, 5, start=7171)
    project.set_drum_voice(1, 7, tune=+48)
    project.set_drum_voice(1, 9, tune=-48)
    project.set_drum_voice(1, 10, loop_start=0x1011, end=0x1F40)
    project.set_drum_voice(1, 16, play_mode=3)
    project.set_drum_voice(1, 18, direction=1)
    project.set_drum_voice(1, 20, gain=0x7FFFFFFF)

    v5 = _voice_from_project(project, 5)
    v7 = _voice_from_project(project, 7)
    v9 = _voice_from_project(project, 9)
    v10 = _voice_from_project(project, 10)
    v16 = _voice_from_project(project, 16)
    v18 = _voice_from_project(project, 18)
    v20 = _voice_from_project(project, 20)

    assert v5.start == 7171
    assert v7.tune_semitones == +48
    assert v9.tune_semitones == -48
    assert v10.loop_start == 0x1011
    assert v10.end == 0x1F40
    assert v16.play_mode == 3
    assert v18.direction == 1
    assert v20.gain_u32 == 0x7FFFFFFF


def _voice_from_project(project: ImageProject, voice: int):
    inspection = inspect_drum_samples_bytes(project.to_bytes())
    return next(t for t in inspection.tracks if t.track == 1).voices[voice]
