"""Adapt OP-XY ``patch.json`` preset data into image-writer sound patches."""

from __future__ import annotations

import json
import os
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from .image_writer import ImageProject
from .sampler_sample_inspection import (
    encode_sampler_loop_crossfade_frames,
)

DRUM_MIDI_START = 53

ENGINE_IDS = {
    "sampler": 0x02,
    "drum": 0x03,
    "organ": 0x06,
    "epiano": 0x07,
    "prism": 0x12,
    "hardsync": 0x13,
    "dissolve": 0x14,
    "axis": 0x16,
    "wavetable": 0x1F,
    "simple": 0x20,
}

PLAYMODE_WORDS = {
    "poly": 0x15555555,
    "mono": 0x3FFFFFFF,
}

DRUM_PLAY_MODE_BYTES = {
    "gate": 0x00,
    "key": 0x01,
    "oneshot": 0x01,
    "group": 0x02,
    "loop": 0x03,
}

SAMPLER_LOOP_DISABLED_BIT = 0x40
SAMPLER_LOOP_ON_RELEASE_BIT = 0x80

LFO_TYPE_BYTES = {
    "tremolo": 0x00,
    "value": 0x01,
    "random": 0x02,
    "element": 0x03,
}

FX_TYPE_BYTES = {
    "z lowpass": 0x09,
    "svf": 0x0A,
    "ladder": 0x10,
    "z hipass": 0x11,
}


@dataclass(frozen=True)
class PatchJsonSoundPatchOptions:
    """Context for resolving preset-relative patch.json sample names."""

    preset_device_path: str | None = None
    preset_path: str | None = None


@dataclass(frozen=True)
class DrumPadPatch:
    path: str | None = None
    tune: int | None = None
    key_assignment: int | None = None
    play_mode: int | None = None
    direction: int | None = None
    pan: int | None = None
    start: int | None = None
    loop_start: int | None = None
    end: int | None = None
    gain: int | None = None
    fade: int | None = None


@dataclass(frozen=True)
class DrumKitPatch:
    preset_path: str | None = None
    pads: dict[int, DrumPadPatch] = field(default_factory=dict)


@dataclass(frozen=True)
class SamplerPatch:
    preset_path: str | None = None
    path: str | None = None
    framecount: int | None = None
    sample_start: int | None = None
    sample_end: int | None = None
    frame_count: int | None = None
    loop_start: int | None = None
    loop_end: int | None = None
    loop_crossfade: int | None = None
    loop_crossfade_raw: int | None = None
    root_key: int | None = None
    tune_cents: int | None = None
    tune_tenths: int | None = None
    loop_type: int | None = None
    gain: int | None = None
    direction: int | None = None


SoundPatch = DrumKitPatch | SamplerPatch


def sound_patch_from_patch_json(
    patch: dict[str, Any],
    options: PatchJsonSoundPatchOptions | None = None,
) -> SoundPatch:
    """Convert a patch.json object to a writable sound patch."""
    patch_type = _string_value(patch.get("type")).lower()
    regions = _region_array(patch.get("regions"))
    if patch_type == "drum":
        return drum_kit_patch_from_regions(regions, options or PatchJsonSoundPatchOptions())
    if patch_type == "sampler":
        return sampler_patch_from_region(_first_region(regions), options or PatchJsonSoundPatchOptions())
    raise ValueError(f'patch.json type "{patch_type or "unknown"}" cannot be written to a sound slot yet')


def sound_patch_from_patch_json_text(
    text: str,
    options: PatchJsonSoundPatchOptions | None = None,
) -> SoundPatch:
    """Parse patch.json text and convert it to a writable sound patch."""
    return sound_patch_from_patch_json(_parse_patch_json_text(text), options)


def sound_patch_from_patch_json_file(
    path: str | os.PathLike[str],
    options: PatchJsonSoundPatchOptions | None = None,
) -> SoundPatch:
    """Read a patch.json file and convert it to a writable sound patch."""
    return sound_patch_from_patch_json_text(Path(path).read_text(encoding="utf-8"), options)


def drum_kit_patch_from_patch_json(
    patch: dict[str, Any],
    options: PatchJsonSoundPatchOptions | None = None,
) -> DrumKitPatch:
    return drum_kit_patch_from_regions(
        _region_array(patch.get("regions")),
        options or PatchJsonSoundPatchOptions(),
    )


def sampler_patch_from_patch_json(
    patch: dict[str, Any],
    options: PatchJsonSoundPatchOptions | None = None,
) -> SamplerPatch:
    return sampler_patch_from_region(
        _first_region(_region_array(patch.get("regions"))),
        options or PatchJsonSoundPatchOptions(),
    )


def apply_sound_patch(
    project: ImageProject,
    track: int,
    patch: SoundPatch,
    *,
    pattern: int = 1,
) -> None:
    """Apply a converted sound patch to a track/pattern sound slot."""
    if isinstance(patch, DrumKitPatch):
        if patch.preset_path is not None:
            project.set_preset_path(track, patch.preset_path, pattern=pattern)
        for voice, pad in patch.pads.items():
            project.set_drum_voice(
                track,
                voice,
                pattern=pattern,
                path=pad.path,
                tune=pad.tune,
                key_assignment=pad.key_assignment,
                play_mode=pad.play_mode,
                direction=pad.direction,
                pan=pad.pan,
                start=pad.start,
                loop_start=pad.loop_start,
                end=pad.end,
                gain=pad.gain,
                fade=pad.fade,
            )
        return

    project.set_sampler_sample_edit(
        track,
        pattern=pattern,
        preset_path=patch.preset_path,
        path=patch.path,
        framecount=patch.framecount,
        sample_start=patch.sample_start,
        sample_end=patch.sample_end,
        loop_start=patch.loop_start,
        loop_end=patch.loop_end,
        loop_crossfade=patch.loop_crossfade,
        loop_crossfade_raw=patch.loop_crossfade_raw,
        root_key=patch.root_key,
        tune_cents=patch.tune_cents,
        tune_tenths=patch.tune_tenths,
        loop_type=patch.loop_type,
        gain=patch.gain,
        direction=patch.direction,
    )


def apply_patch_json_sound(
    project: ImageProject,
    track: int,
    patch_json: dict[str, Any],
    options: PatchJsonSoundPatchOptions | None = None,
    *,
    pattern: int = 1,
) -> SoundPatch:
    """Convert and apply a patch.json object, returning the intermediate patch."""
    patch = sound_patch_from_patch_json(patch_json, options)
    apply_patch_json_confirmed_sound_state(project, track, patch_json, pattern=pattern)
    apply_sound_patch(project, track, patch, pattern=pattern)
    return patch


def apply_patch_json_text(
    project: ImageProject,
    track: int,
    text: str,
    options: PatchJsonSoundPatchOptions | None = None,
    *,
    pattern: int = 1,
) -> SoundPatch:
    """Parse patch.json text and apply it to a track/pattern sound slot."""
    patch_json = _parse_patch_json_text(text)
    patch = sound_patch_from_patch_json(patch_json, options)
    apply_patch_json_confirmed_sound_state(project, track, patch_json, pattern=pattern)
    apply_sound_patch(project, track, patch, pattern=pattern)
    return patch


def apply_patch_json_file(
    project: ImageProject,
    track: int,
    path: str | os.PathLike[str],
    options: PatchJsonSoundPatchOptions | None = None,
    *,
    pattern: int = 1,
) -> SoundPatch:
    """Read a patch.json file and apply it to a track/pattern sound slot."""
    patch_json = _parse_patch_json_text(Path(path).read_text(encoding="utf-8"))
    patch = sound_patch_from_patch_json(patch_json, options)
    apply_patch_json_confirmed_sound_state(project, track, patch_json, pattern=pattern)
    apply_sound_patch(project, track, patch, pattern=pattern)
    return patch


def apply_patch_json_confirmed_sound_state(
    project: ImageProject,
    track: int,
    patch_json: dict[str, Any],
    *,
    pattern: int = 1,
) -> None:
    """Write confirmed non-region patch.json sound-state fields.

    This is deliberately narrower than full synth preset loading: it writes
    fields whose patch.json value has a confirmed project-image lane, but it
    does not claim to synthesize opaque engine tails or multi-zone sampler
    structures.
    """

    patch_type = _string_value(patch_json.get("type")).lower()
    if patch_type in ENGINE_IDS:
        project.set_engine(track, ENGINE_IDS[patch_type], pattern=pattern)

    engine = _dict_value(patch_json.get("engine"))
    params = _integer_array(engine.get("params"), limit=8)
    for index, value in enumerate(params, start=1):
        project.set_engine_param_q16(track, index, value, pattern=pattern)

    playmode = _string_value(engine.get("playmode")).lower()
    if playmode:
        try:
            project.set_m2_shift(track, play_mode=PLAYMODE_WORDS[playmode], pattern=pattern)
        except KeyError as exc:
            raise ValueError(f'engine playmode "{playmode}" is not mapped to a project word yet') from exc

    project.set_m2_shift(
        track,
        portamento=_optional_q16(engine.get("portamento.amount")),
        pitch_bend_range=_optional_q16(engine.get("bendrange")),
        engine_volume=_optional_q16(engine.get("volume")),
        pattern=pattern,
    )

    modulation = _dict_value(engine.get("modulation"))
    modwheel = _dict_value(modulation.get("modwheel"))
    aftertouch = _dict_value(modulation.get("aftertouch"))
    pitchbend = _dict_value(modulation.get("pitchbend"))
    velocity = _dict_value(modulation.get("velocity"))
    project.set_patch_modulation_state(
        track,
        modwheel_target=_integer_value(modwheel.get("target")),
        modwheel_amount=_integer_value(modwheel.get("amount")),
        aftertouch_target=_integer_value(aftertouch.get("target")),
        aftertouch_amount=_integer_value(aftertouch.get("amount")),
        pitchbend_target=_integer_value(pitchbend.get("target")),
        pitchbend_amount=_integer_value(pitchbend.get("amount")),
        velocity_sensitivity=_integer_value(engine.get("velocity.sensitivity")),
        portamento_type=_integer_value(engine.get("portamento.type")),
        tuning_scale=_integer_value(engine.get("tuning.scale")),
        width=_integer_value(engine.get("width")),
        tuning_root=_integer_value(engine.get("tuning.root")),
        highpass=_integer_value(engine.get("highpass")),
        velocity_target=_integer_value(velocity.get("target")),
        velocity_amount=_integer_value(velocity.get("amount")),
        pattern=pattern,
    )

    envelope = _dict_value(patch_json.get("envelope"))
    amp = _dict_value(envelope.get("amp"))
    project.set_amp_envelope(
        track,
        attack=_optional_q16(amp.get("attack")),
        decay=_optional_q16(amp.get("decay")),
        sustain=_optional_q16(amp.get("sustain")),
        release=_optional_q16(amp.get("release")),
        pattern=pattern,
    )
    filt = _dict_value(envelope.get("filter"))
    project.set_filter_envelope(
        track,
        attack=_optional_q16(filt.get("attack")),
        decay=_optional_q16(filt.get("decay")),
        sustain=_optional_q16(filt.get("sustain")),
        release=_optional_q16(filt.get("release")),
        pattern=pattern,
    )

    fx = _dict_value(patch_json.get("fx"))
    fx_type = _enum_value(fx.get("type"), FX_TYPE_BYTES, "FX type")
    fx_params = _integer_array(fx.get("params"), limit=8)
    project.set_fx_state(
        track,
        type=fx_type,
        active=_boolean_value(fx.get("active")),
        params=fx_params or None,
        pattern=pattern,
    )

    lfo = _dict_value(patch_json.get("lfo"))
    lfo_type = _enum_value(lfo.get("type"), LFO_TYPE_BYTES, "LFO type")
    lfo_params = _integer_array(lfo.get("params"), limit=8)
    project.set_lfo_state(
        track,
        type=lfo_type,
        active=_boolean_value(lfo.get("active")),
        params=lfo_params or None,
        pattern=pattern,
    )


def drum_kit_patch_from_regions(
    regions: list[dict[str, Any]],
    options: PatchJsonSoundPatchOptions,
) -> DrumKitPatch:
    pads: dict[int, DrumPadPatch] = {}
    for region in regions:
        hikey = _integer_value(region.get("hikey"))
        if hikey is None:
            continue
        voice = hikey - DRUM_MIDI_START
        if voice < 0 or voice >= 24:
            continue
        transpose = _integer_value(region.get("transpose"))
        sample_end = _integer_value(region.get("sample.end"))
        pads[voice] = DrumPadPatch(
            path=_sample_path(region, options),
            tune=transpose if transpose is not None else _integer_value(region.get("tune")),
            key_assignment=hikey,
            play_mode=_drum_play_mode(region.get("playmode")),
            direction=1 if _boolean_value(region.get("reverse")) else 0,
            pan=_integer_value(region.get("pan")),
            start=_integer_value(region.get("sample.start")),
            end=sample_end if sample_end is not None else _integer_value(region.get("framecount")),
            gain=_integer_value(region.get("gain")),
            fade=_integer_value(region.get("fade.out")),
        )
    return DrumKitPatch(preset_path=_preset_path(options), pads=pads)


def sampler_patch_from_region(
    region: dict[str, Any],
    options: PatchJsonSoundPatchOptions,
) -> SamplerPatch:
    framecount = _integer_value(region.get("framecount"))
    sample_end = _integer_value(region.get("sample.end"))
    loop_crossfade = _integer_value(region.get("loop.crossfade"))
    return SamplerPatch(
        preset_path=_preset_path(options),
        path=_sample_path(region, options),
        framecount=framecount,
        sample_start=_integer_value(region.get("sample.start")),
        sample_end=sample_end if sample_end is not None else framecount,
        loop_start=_integer_value(region.get("loop.start")),
        loop_end=_integer_value(region.get("loop.end")),
        loop_crossfade=loop_crossfade,
        loop_crossfade_raw=_sampler_loop_crossfade_raw(loop_crossfade, framecount, sample_end),
        root_key=_integer_value(region.get("pitch.keycenter")),
        tune_cents=_integer_value(region.get("tune")),
        loop_type=_sampler_loop_type(region),
        gain=_integer_value(region.get("gain")),
        direction=1 if _boolean_value(region.get("reverse")) else 0,
    )


def _preset_path(options: PatchJsonSoundPatchOptions) -> str | None:
    if options.preset_path:
        return options.preset_path
    if not options.preset_device_path:
        return None
    match = re.search(r"/presets/([^/]+)/([^/]+)\.preset$", options.preset_device_path, re.I)
    if not match:
        return None
    return f"{match.group(1)}/{match.group(2)}"


def _sample_path(region: dict[str, Any], options: PatchJsonSoundPatchOptions) -> str | None:
    sample = _string_value(region.get("sample"))
    if not sample:
        return None
    # Firmware 8d4dcca0 tests for ANY slash, not just an absolute prefix.
    # content/... and <samples>/... are references, as are subdirectory paths.
    if not options.preset_device_path or "/" in sample:
        return sample
    return f"{options.preset_device_path.rstrip('/')}/{sample}"


def _sampler_loop_type(region: dict[str, Any]) -> int:
    value = 0
    if _boolean_value(region.get("loop.enabled")) is False:
        value |= SAMPLER_LOOP_DISABLED_BIT
    if _boolean_value(region.get("loop.onrelease")) is True:
        value |= SAMPLER_LOOP_ON_RELEASE_BIT
    return value


def _sampler_loop_crossfade_raw(
    loop_crossfade: int | None,
    frame_count: int | None,
    sample_end: int | None,
) -> int | None:
    if loop_crossfade is None:
        return None
    if loop_crossfade == 0:
        return 0
    denominator = frame_count if frame_count is not None else sample_end
    if denominator is None:
        raise ValueError("sampler loop.crossfade requires framecount or sample.end")
    return encode_sampler_loop_crossfade_frames(loop_crossfade, denominator)


def _drum_play_mode(value: Any) -> int | None:
    playmode = _string_value(value).lower()
    if playmode:
        try:
            return DRUM_PLAY_MODE_BYTES[playmode]
        except KeyError as exc:
            valid = ", ".join(sorted(DRUM_PLAY_MODE_BYTES))
            raise ValueError(
                f'unknown drum playmode "{playmode}"; expected one of {valid}'
            ) from exc
    if _integer_value(value) is not None:
        raise ValueError("numeric drum playmode values are not preserved by device preset loading")
    return None


def _first_region(regions: list[dict[str, Any]]) -> dict[str, Any]:
    if not regions:
        raise ValueError("patch.json has no sample regions")
    return regions[0]


def _region_array(value: Any) -> list[dict[str, Any]]:
    return [region for region in value if isinstance(region, dict)] if isinstance(value, list) else []


def _parse_patch_json_text(text: str) -> dict[str, Any]:
    data = json.loads(text)
    if not isinstance(data, dict):
        raise ValueError("patch.json root must be an object")
    return data


def _string_value(value: Any) -> str:
    return value if isinstance(value, str) else ""


def _dict_value(value: Any) -> dict[str, Any]:
    return value if isinstance(value, dict) else {}


def _number_value(value: Any) -> int | float | None:
    return value if isinstance(value, (int, float)) and not isinstance(value, bool) else None


def _integer_value(value: Any) -> int | None:
    number = _number_value(value)
    return None if number is None else round(number)


def _optional_q16(value: Any) -> int | None:
    integer = _integer_value(value)
    return None if integer is None else integer << 16


def _integer_array(value: Any, *, limit: int) -> list[int]:
    if not isinstance(value, list):
        return []
    values = [_integer_value(item) for item in value[:limit]]
    return [item for item in values if item is not None]


def _enum_value(value: Any, mapping: dict[str, int], label: str) -> int | None:
    name = _string_value(value).lower()
    if not name:
        numeric = _integer_value(value)
        return numeric
    try:
        return mapping[name]
    except KeyError as exc:
        valid = ", ".join(sorted(mapping))
        raise ValueError(f"unknown {label} {name!r}; expected one of {valid}") from exc


def _boolean_value(value: Any) -> bool | None:
    return value if isinstance(value, bool) else None
