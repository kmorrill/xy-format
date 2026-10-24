"""Drumline (OS 1.2.0, engine 0x04) inspection against device readings and captures."""

from __future__ import annotations

from pathlib import Path

import pytest

from xy.drumline_inspection import (
    M2_FULL_SCALE,
    inspect_drumline_bytes,
    param_display,
    volume_display,
)

ROOT = Path(__file__).resolve().parents[1]
FACTORY = ROOT / "src" / "factory-preset-captures" / "firmware-1.2.0" / "batches"
PARAMS = ROOT / "src" / "one-off-changes-from-default" / "firmware-1.2.0" / "drumline-params"

# drumline/atom on Track 1, read key by key on an OP-XY running OS 1.2.0:
# key -> (model shown, (four parameter values shown)).
ATOM_SCREEN = {
    53: ("kick", (50, 50, 25, 0)),
    54: ("kick", (14, 85, 10, 14)),
    55: ("snare", (50, 50, 50, 25)),
    56: ("snare", (50, 35, 29, 79)),
    57: ("tune", (48, 25, 75, 75)),
    58: ("clap", (50, 40, 63, 50)),
    59: ("tambourine", (50, 55, 50, 75)),
    60: ("shaker", (50, 50, 50, 0)),
    61: ("hi-hat", (54, 36, 42, 79)),
    62: ("hi-hat", (25, 25, 25, 50)),
    63: ("hi-hat", (50, 62, 50, 50)),
    64: ("fm tom", (85, 24, 57, 78)),
    65: ("fm tom", (37, 68, 68, 50)),
    66: ("hi-hat", (75, 81, 50, 50)),
    67: ("fm tom", (50, 62, 66, 50)),
    68: ("hi-hat", (75, 90, 25, 69)),
    69: ("fm tom", (62, 53, 64, 50)),
    70: ("resonator", (75, 25, 37, 50)),
    71: ("congas", (50, 50, 50, 50)),
    72: ("congas", (75, 43, 50, 50)),
    73: ("tune", (61, 56, 0, 50)),
    74: ("shaker", (62, 62, 68, 50)),
    75: ("resonator", (50, 62, 75, 50)),
    76: ("resonator", (75, 60, 62, 50)),
}

# Parameter labels read on the device for each model.
SCREEN_LABELS = {
    "kick": ("pitch", "length", "punch", "tone"),
    "snare": ("pitch", "length", "snare", "punch"),
    "hi-hat": ("pitch", "length", "era", "tone"),
    "shaker": ("color", "length", "attack", "onset"),
    "clap": ("tone", "length", "spread", "contour"),
    "congas": ("pitch", "length", "slap", "mush"),
    "resonator": ("pitch", "length", "mod", "feedback"),
    "fm tom": ("pitch", "length", "sweep", "rate"),
    "tambourine": ("tone", "length", "shake", "ring"),
    "tune": ("pitch", "length", "tone", "strike"),
}

# Shift page on atom: key -> (random, volume), pan 49 (centre) everywhere.
ATOM_SHIFT = {53: (0, 59), 54: (0, 55), 57: (0, 73), 66: (0, 51), 76: (10, 49)}


def _atom():
    return inspect_drumline_bytes((FACTORY / "drumline01.xy").read_bytes()).track(1)


def test_only_drumline_tracks_are_reported():
    project = inspect_drumline_bytes((FACTORY / "drumline01.xy").read_bytes())
    assert [t.track for t in project.tracks] == list(range(1, 9))
    assert project.track(1).preset_path == "drumline/atom"


@pytest.mark.parametrize("key", sorted(ATOM_SCREEN))
def test_atom_voice_matches_device_screen(key):
    model, shown = ATOM_SCREEN[key]
    voice = _atom().voice_for_key(key)
    assert voice.voice == key - 53
    assert voice.model_name == model
    assert voice.param_names == SCREEN_LABELS[model]
    assert voice.params_display == shown


@pytest.mark.parametrize("key", sorted(ATOM_SHIFT))
def test_atom_shift_page_matches_device(key):
    random_shown, volume_shown = ATOM_SHIFT[key]
    voice = _atom().voice_for_key(key)
    assert voice.random_display == random_shown
    assert voice.volume_display == volume_shown
    assert voice.pan == 0


def test_atom_play_mode_icons_match_device():
    atom = _atom()
    assert atom.voice_for_key(53).play_mode_icon == "→2"
    assert atom.voice_for_key(61).play_mode_icon == "→g"
    assert atom.voice_for_key(76).play_mode_icon == "loop"
    # The open/closed hats choke each other: all in mute group 1.
    assert {atom.voice_for_key(k).play_mode_name for k in (61, 62, 63)} == {"mute group 1"}


def test_we_will_c_fills_all_eight_tracks():
    project = inspect_drumline_bytes((FACTORY / "drumline02.xy").read_bytes())
    assert {t.preset_path for t in project.tracks} == {"drumline/we will c"}


def test_display_scaling():
    assert param_display(0x4000) == 50
    assert param_display(0x1333) == 14  # 14.9997 truncates
    assert param_display(0x7FFF) == 99
    assert param_display(0x8000) == 100
    assert volume_display(0) == 59
    assert volume_display(-5) == 49
    assert volume_display(7) == 73


def test_device_saved_play_modes_and_pan():
    track = inspect_drumline_bytes((PARAMS / "dlx_modes.xy").read_bytes()).track(1)
    icons = {k: track.voice_for_key(k).play_mode_icon for k in range(53, 59)}
    assert icons == {53: "→|", 54: "→", 55: "→g", 56: "→2", 57: "→3", 58: "loop"}
    assert track.voice_for_key(59).pan == -100
    assert track.voice_for_key(60).pan == 100
    # Changing the play mode on the device leaves the sampler byte alone.
    control = _atom()
    for key in range(53, 59):
        assert (
            track.voice_for_key(key).sampler_play_mode
            == control.voice_for_key(key).sampler_play_mode
        )


@pytest.mark.parametrize(
    "name,expected",
    [
        ("dla_ctrl.xy", {"funk": 0, "attack": 0, "random": 0, "length": 0x40000000}),
        ("dla_funk.xy", {"funk": M2_FULL_SCALE, "attack": 0, "random": 0, "length": 0x40000000}),
        ("dla_attack.xy", {"funk": 0, "attack": M2_FULL_SCALE, "random": 0, "length": 0x40000000}),
        ("dln_random_max.xy", {"funk": 0, "attack": 0, "random": M2_FULL_SCALE, "length": 0x40000000}),
        ("dla_length.xy", {"funk": 0, "attack": 0, "random": 0, "length": M2_FULL_SCALE}),
        ("dla_allmin.xy", {"funk": 0, "attack": 0, "random": 0, "length": 0}),
    ],
)
def test_m2_page_captures(name, expected):
    track = inspect_drumline_bytes((PARAMS / name).read_bytes()).track(1)
    assert track.m2 == expected


def test_m2_edit_leaves_voices_untouched():
    control = _atom()
    edited = inspect_drumline_bytes((PARAMS / "dla_funk.xy").read_bytes()).track(1)
    assert edited.voices == control.voices
    assert edited.m2_percent("funk") == 100
