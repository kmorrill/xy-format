from pathlib import Path

import pytest

from xy.image_writer import ImageProject
from xy.project_config_inspection import (
    GLOBAL_GROOVE_TYPE_OFFSET,
    GLOBAL_MIDI_CHANNEL_OFFSET,
    GLOBAL_SCENE_LENGTH_OFFSET,
    GLOBAL_TIME_SIGNATURE_OFFSET,
    GLOBAL_TRANSPOSE_OFFSET,
    GLOBAL_VOICE_ALLOCATION_OFFSET,
    inspect_project_config,
)
from xy.rle import decode_project


PROBES = Path("src/project-config-probes/2026-06-project-config")
BASELINE = PROBES / "prjconf0.xy"
HEADER_PROBES = Path("src/project-config-probes/2026-06-global-header")


def _config(filename: str):
    return inspect_project_config(PROBES / filename)


def _decoded(filename: str) -> bytes:
    return decode_project((PROBES / filename).read_bytes())[1]


def _header_config(filename: str):
    return inspect_project_config(HEADER_PROBES / filename)


def _header_decoded(filename: str) -> bytes:
    return decode_project((HEADER_PROBES / filename).read_bytes())[1]


def test_project_config_baseline_defaults() -> None:
    config = inspect_project_config(BASELINE)

    assert config.transpose_semitones == 0
    assert config.scene_length_raw == 0
    assert config.scene_length == "longest"
    assert config.time_signature_raw == 0x11
    assert config.time_signature == "4/4"
    assert config.groove_type_raw == 0
    assert config.groove_type == "shuffle"
    assert config.groove_amount_raw == 0
    assert config.groove_amount == 0
    assert config.click_volume_raw == 0xA8
    assert config.metronome_enabled
    assert config.active_scene_ordinal == 1
    assert config.active_song_ordinal == 1
    assert config.voice_allocations == (None,) * 8
    assert config.midi_channels == (None,) * 16


@pytest.mark.parametrize(
    "filename,expected",
    [
        ("prjconf-g-xm24.xy", -24),
        ("prjconf-g-xm01.xy", -1),
        ("prjconf-g-xp01.xy", 1),
        ("prjconf-g-xp24.xy", 24),
    ],
)
def test_global_transpose_signed_i8(filename: str, expected: int) -> None:
    assert _config(filename).transpose_semitones == expected


@pytest.mark.parametrize(
    "filename,raw,label",
    [
        ("prjconf-g-slen-short.xy", 1, "shortest"),
        ("prjconf-g-slen-tsig.xy", 2, "time-signature"),
    ],
)
def test_scene_length_mode(filename: str, raw: int, label: str) -> None:
    config = _config(filename)
    assert config.scene_length_raw == raw
    assert config.scene_length == label


@pytest.mark.parametrize(
    "filename,raw,label",
    [
        ("prjconf-t-sig-34.xy", 0x10, "3/4"),
        ("prjconf-t-sig-54.xy", 0x12, "5/4"),
        ("prjconf-t-sig-68.xy", 0x13, "6/8"),
        ("prjconf-t-sig-78.xy", 0x14, "7/8"),
        ("prjconf-t-sig-128.xy", 0x15, "12/8"),
    ],
)
def test_time_signature_enum(filename: str, raw: int, label: str) -> None:
    config = _config(filename)
    assert config.time_signature_raw == raw
    assert config.time_signature == label


@pytest.mark.parametrize(
    "filename,raw,label",
    [
        ("prjconf-t-grv-half.xy", 1, "half-shuffle"),
        ("prjconf-t-grv-danish.xy", 2, "danish"),
        ("prjconf-t-grv-bombora.xy", 3, "bombora"),
        ("prjconf-t-grv-wobbly.xy", 4, "wobbly"),
        ("prjconf-t-grv-gaussian.xy", 5, "gaussian"),
        ("prjconf-t-grv-accents.xy", 6, "accents"),
        ("prjconf-t-grv-island.xy", 7, "island-nod"),
        ("prjconf-t-grv-disfunk.xy", 8, "disfunk"),
        ("prjconf-t-grv-roll.xy", 9, "roll-over"),
        ("prjconf-t-grv-prophetic.xy", 10, "prophetic"),
    ],
)
def test_project_config_groove_enum(filename: str, raw: int, label: str) -> None:
    config = _config(filename)
    assert config.groove_type_raw == raw
    assert config.groove_type == label


@pytest.mark.parametrize("track", range(1, 9))
def test_voice_allocation_track_offsets(track: int) -> None:
    config = _config(f"prjconf-v-t{track}-v1.xy")
    expected = [None] * 8
    expected[track - 1] = 1
    assert list(config.voice_allocations) == expected


@pytest.mark.parametrize(
    "filename,expected",
    [
        ("prjconf-v-t1-v2.xy", (2, None, None, None, None, None, None, None)),
        ("prjconf-v-t1-v4.xy", (4, None, None, None, None, None, None, None)),
        ("prjconf-v-t1-v8.xy", (8, None, None, None, None, None, None, None)),
        ("prjconf-v-poly-888.xy", (8, 8, 8, None, None, None, None, None)),
        ("prjconf-v-mix-1234.xy", (1, 2, 3, 4, None, None, None, None)),
    ],
)
def test_voice_allocation_values(filename: str, expected: tuple[int | None, ...]) -> None:
    assert _config(filename).voice_allocations == expected


@pytest.mark.parametrize("track", range(1, 17))
def test_midi_channel_track_offsets(track: int) -> None:
    config = _config(f"prjconf-m-t{track:02d}-ch{track:02d}.xy")
    expected = [None] * 16
    expected[track - 1] = track
    assert list(config.midi_channels) == expected


def test_midi_channel_alternate_and_full_map() -> None:
    assert _config("prjconf-m-t03-ch08.xy").midi_channels[2] == 8
    assert _config("prjconf-m-all-ch1-16.xy").midi_channels == tuple(range(1, 17))


@pytest.mark.parametrize(
    "filename,raw,signed",
    [
        ("hdr-grv-l1.xy", 0xFE, -2),
        ("hdr-grv-l2.xy", 0xFC, -4),
        ("hdr-grv-r1.xy", 0x02, 2),
        ("hdr-grv-r2.xy", 0x04, 4),
        ("hdr-grv-min.xy", 0x81, -127),
        ("hdr-grv-minp1.xy", 0x82, -126),
        ("hdr-grv-minp2.xy", 0x84, -124),
        ("hdr-grv-max.xy", 0x7F, 127),
        ("hdr-grv-maxm1.xy", 0x7E, 126),
        ("hdr-grv-maxm2.xy", 0x7C, 124),
    ],
)
def test_groove_amount_signed_i8(filename: str, raw: int, signed: int) -> None:
    config = _header_config(filename)
    assert config.groove_amount_raw == raw
    assert config.groove_amount == signed


@pytest.mark.parametrize(
    "filename,volume,enabled",
    [
        ("hdr-mclk-volmin.xy", 0x00, False),
        ("hdr-mclk-off.xy", 0x00, False),
        ("hdr-mclk-off-volmin.xy", 0x00, False),
        ("hdr-mclk-on.xy", 0xA8, True),
        ("hdr-mclk-volmid.xy", 0xA8, True),
        ("hdr-mclk-volmax.xy", 0xFF, True),
    ],
)
def test_metronome_volume_and_toggle_share_click_volume_byte(
    filename: str, volume: int, enabled: bool
) -> None:
    config = _header_config(filename)
    assert config.click_volume_raw == volume
    assert config.metronome_enabled is enabled


def test_active_scene_and_song_selectors() -> None:
    assert _header_config("hdr-arr-nsc2.xy").active_scene_ordinal == 1
    assert _header_config("hdr-arr-act2.xy").active_scene_ordinal == 2
    assert _header_config("hdr-arr-nsc3.xy").active_scene_ordinal == 1
    assert _header_config("hdr-arr-act3.xy").active_scene_ordinal == 3
    assert _header_config("hdr-arr-song1.xy").active_song_ordinal == 1
    assert _header_config("hdr-arr-song2.xy").active_song_ordinal == 2


def test_adding_scenes_does_not_change_active_scene_selector() -> None:
    nsc2 = _header_decoded("hdr-arr-nsc2.xy")
    nsc3 = _header_decoded("hdr-arr-nsc3.xy")
    assert nsc2[0x06] == nsc3[0x06] == 0


def test_project_display_name_is_not_stored_in_decoded_image() -> None:
    image = _header_decoded("hdr0.xy")
    for text in (b"hdr0", b"2026-06-global-header", b"MyProbeName"):
        assert text not in image


def test_project_config_setters_write_decoded_bytes() -> None:
    project = ImageProject.from_file(str(BASELINE))

    project.set_scene_length_mode(2)
    project.set_project_transpose(-24)
    project.set_time_signature(0x15)
    project.set_groove(10)
    project.set_groove_amount(-4)
    project.set_click_volume(0)
    project.set_active_scene(3)
    project.set_active_song(2)
    project.set_voice_allocation(1, 8)
    project.set_voice_allocation(2, None)
    project.set_midi_channel(3, 8)

    image = project.image
    assert image[GLOBAL_SCENE_LENGTH_OFFSET] == 2
    assert image[GLOBAL_TRANSPOSE_OFFSET] == 0xE8
    assert image[GLOBAL_TIME_SIGNATURE_OFFSET] == 0x15
    assert image[GLOBAL_GROOVE_TYPE_OFFSET] == 10
    assert image[0x02] == 0xFC
    assert image[0x04] == 0
    assert image[0x06] == 2
    assert image[0x07] == 1
    assert image[GLOBAL_VOICE_ALLOCATION_OFFSET] == 8
    assert image[GLOBAL_VOICE_ALLOCATION_OFFSET + 1] == 0
    assert image[GLOBAL_MIDI_CHANNEL_OFFSET + 2] == 7


def test_project_config_captures_only_change_config_bytes_plus_save_noise() -> None:
    baseline = _decoded("prjconf0.xy")
    allowed_common = {
        start + rel
        for start in ImageProject.from_file(str(BASELINE))._starts[8:16]
        for rel in (0x38F2, 0x38F6)
    }
    config_window = {
        0x02,
        0x04,
        0x06,
        0x07,
        GLOBAL_GROOVE_TYPE_OFFSET,
        GLOBAL_SCENE_LENGTH_OFFSET,
        GLOBAL_TRANSPOSE_OFFSET,
        GLOBAL_TIME_SIGNATURE_OFFSET,
        *range(GLOBAL_VOICE_ALLOCATION_OFFSET, GLOBAL_VOICE_ALLOCATION_OFFSET + 8),
        *range(GLOBAL_MIDI_CHANNEL_OFFSET, GLOBAL_MIDI_CHANNEL_OFFSET + 16),
    }

    for path in sorted(PROBES.glob("prjconf-*.xy")):
        image = _decoded(path.name)
        diffs = {offset for offset, (before, after) in enumerate(zip(baseline, image)) if before != after}
        assert diffs - allowed_common <= config_window, path.name
