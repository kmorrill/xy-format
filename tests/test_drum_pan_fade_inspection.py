from pathlib import Path

import pytest

from xy.drum_sample_inspection import (
    DRUM_FADE_STEP,
    DRUM_FADE_U32_MAX,
    decode_drum_fade_u32,
    drum_fade_storage_voice,
    encode_drum_fade_ui,
    inspect_drum_samples_bytes,
)
from xy.image_writer import ImageProject
from xy.rle import decode_project

ROOT = Path(__file__).resolve().parents[1]
PROBES = ROOT / "src" / "drum-sample-probes" / "2026-06-drum-pan-fade"
BASELINE = PROBES / "d0-baseline-pp.xy"
VOICE = 23  # low F kick pad on pp kit (key 53)
STORAGE_VOICE = drum_fade_storage_voice(VOICE)

FADE_CASES = [
    ("d3-v23-fade-01.xy", 1),
    ("d3-v23-fade-02.xy", 2),
    ("d3-v23-fade-03.xy", 3),
    ("d3-v23-fade-04.xy", 4),
    ("d3-v23-fade-05.xy", 5),
    ("d3-v23-fade-06.xy", 6),
    ("d3-v23-fade-07.xy", 7),
    ("d3-v23-fade-08.xy", 8),
    ("d3-v23-fade-09.xy", 9),
    ("d3-v23-fade-10.xy", 10),
    ("d3-v23-fade-11.xy", 11),
    ("d3-v23-fade-12.xy", 12),
    ("d3-v23-fade-13.xy", 13),
    ("d3-v23-fade-14.xy", 14),
    ("d3-v23-fade-27.xy", 27),
    ("d3-v23-fade-44.xy", 44),
    ("d3-v23-fade-45.xy", 45),
    ("d3-v23-fade-46.xy", 46),
    ("d3-v23-fade-47.xy", 47),
    ("d3-v23-fade-63.xy", 63),
    ("d3-v23-fade-99.xy", 99),
]


def _voice(path: Path, voice: int = VOICE):
    inspection = inspect_drum_samples_bytes(path.read_bytes())
    track = next(t for t in inspection.tracks if t.track == 1)
    return track.voices[voice]


def _storage_voice(path: Path):
    return _voice(path, voice=STORAGE_VOICE)


def test_baseline_voice23_is_neutral_pan() -> None:
    voice = _voice(BASELINE)
    assert voice.key_assignment == 53
    assert voice.pan == 0
    assert voice.loop_fade_ui == 0
    assert _storage_voice(BASELINE).fade_ui == 0


def test_pan_hard_left_and_right_are_isolated_on_voice23() -> None:
    baseline = _voice(BASELINE)
    left = _voice(PROBES / "d1-v23-pan-hard-left.xy")
    right = _voice(PROBES / "d2-v23-pan-hard-right.xy")

    assert left.pan == -100
    assert right.pan == 100

    before = inspect_drum_samples_bytes(BASELINE.read_bytes()).tracks[0].voices
    after = inspect_drum_samples_bytes((PROBES / "d1-v23-pan-hard-left.xy").read_bytes()).tracks[0].voices
    for other, b, a in zip(range(24), before, after):
        if other == VOICE:
            continue
        assert a.pan == b.pan


@pytest.mark.parametrize("filename,ui", FADE_CASES)
def test_fade_ui_decodes_from_storage_voice(filename: str, ui: int) -> None:
    path = PROBES / filename
    storage = _storage_voice(path)
    edited = _voice(path)
    assert storage.fade_ui == ui
    assert edited.loop_fade_ui == ui
    assert decode_drum_fade_u32(storage.slot_gain_u32) == ui


@pytest.mark.parametrize("filename,ui", FADE_CASES)
def test_fade_linear_encoding_matches_fine_grained_captures(filename: str, ui: int) -> None:
    storage = _storage_voice(PROBES / filename)
    assert decode_drum_fade_u32(storage.slot_gain_u32) == ui
    # Legacy 27/63/99 captures set byte0=0xFF; 2026-06 fine sweep uses ui*STEP exactly.
    if ui not in {27, 63, 99}:
        assert storage.slot_gain_u32 == encode_drum_fade_ui(ui)


def test_fade_ui_only_changes_storage_voice_slot_gain() -> None:
    _, base_img = decode_project(BASELINE.read_bytes())
    _, var_img = decode_project((PROBES / "d3-v23-fade-05.xy").read_bytes())
    project = ImageProject.from_file(str(BASELINE))
    gain_off = (
        project.track_start(1)
        + ImageProject.DRUM_TABLE
        + STORAGE_VOICE * ImageProject.DRUM_SLOT
        + ImageProject.DRUM_GAIN
    )
    outside = [
        i
        for i in range(len(base_img))
        if base_img[i] != var_img[i] and not (gain_off <= i < gain_off + 4)
    ]
    assert not outside


def test_set_drum_voice_pan_reproduces_left_capture() -> None:
    project = ImageProject.from_file(str(BASELINE))
    project.set_drum_voice(1, VOICE, pan=-100)
    assert _voice_from_project(project).pan == -100


def test_set_drum_voice_fade_reproduces_linear_encoding() -> None:
    project = ImageProject.from_file(str(BASELINE))
    project.set_drum_voice(1, VOICE, fade=5)
    storage = next(t for t in inspect_drum_samples_bytes(project.to_bytes()).tracks if t.track == 1).voices[
        STORAGE_VOICE
    ]
    assert storage.slot_gain_u32 == encode_drum_fade_ui(5)
    assert storage.fade_ui == 5


def test_set_drum_voice_fade_max() -> None:
    project = ImageProject.from_file(str(BASELINE))
    project.set_drum_voice(1, VOICE, fade=99)
    storage = next(t for t in inspect_drum_samples_bytes(project.to_bytes()).tracks if t.track == 1).voices[
        STORAGE_VOICE
    ]
    assert storage.slot_gain_u32 == DRUM_FADE_U32_MAX


def _voice_from_project(project: ImageProject):
    inspection = inspect_drum_samples_bytes(project.to_bytes())
    return next(t for t in inspection.tracks if t.track == 1).voices[VOICE]


def test_set_drum_voice_pan_matches_device_bytes() -> None:
    project = ImageProject.from_file(str(BASELINE))
    project.set_drum_voice(1, VOICE, pan=-100)
    _, ours = decode_project(project.to_bytes())
    _, cap = decode_project((PROBES / "d1-v23-pan-hard-left.xy").read_bytes())
    off = ImageProject.from_file(str(BASELINE)).track_start(1) + 0x3957 + VOICE * 0x80 + 0x06
    assert ours[off] == cap[off]


def test_encode_decode_roundtrip() -> None:
    for ui in [0, 1, 14, 44, 47, 98, 99]:
        u32 = encode_drum_fade_ui(ui)
        assert decode_drum_fade_u32(u32) == ui
    assert encode_drum_fade_ui(5) == 5 * DRUM_FADE_STEP
