"""Read one-shot Sampler engine sample-edit fields (P2-B probes).

Sampler (engine ``0x02``) stores sample path in voice-0 of the shared
24×128 B table @ ``track+0x3957``. Start/end/loop points live in a
**per-track** header immediately before that table (``0x3943``–``0x3956``),
not at drum offsets ``+0x68`` / ``+0x70`` inside the slot.

Firmware 1.1.4; validated on ``nt-acidic`` one-shot captures ``g0``–``g14``.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Literal

from .image_writer import ImageProject
from .rle import decode_project

SAMPLER_ENGINE_ID = 0x02
ENGINE_ID_OFFSET = 0x14

# Per-track sample header (before voice table)
TRACK_SAMPLE_START_U16 = 0x3943
TRACK_SAMPLE_END_U16 = 0x3947
TRACK_LOOP_START_U16 = 0x394B
TRACK_LOOP_END_U16 = 0x394F
TRACK_LOOP_CROSSFADE_U8 = 0x3956

VOICE_TABLE_OFFSET = 0x3957
VOICE_SLOT_SIZE = 0x80
SLOT_TUNE = 0x00
SLOT_TUNE_AUX = 0x04
SLOT_LOOP_TYPE = 0x03
SLOT_GAIN = 0x05
SLOT_DIRECTION = 0x07
SLOT_PATH = 0x08

SamplerLoopType = Literal["infinite", "off", "until_release", "unknown"]

LOOP_TYPE_INFINITE = 0x80
LOOP_TYPE_OFF = 0x40
LOOP_TYPE_UNTIL_RELEASE = 0x00


@dataclass(frozen=True)
class SamplerSampleEdit:
    """Decoded sample-edit screen for Sampler engine track (voice 0)."""

    track: int
    engine_id: int
    path: str
    sample_start: int
    sample_end: int
    loop_start: int
    loop_end: int
    loop_crossfade: int
    tune_byte: int
    tune_aux_byte: int
    loop_type_byte: int
    gain: int
    direction: int

    @property
    def loop_type(self) -> SamplerLoopType:
        if self.loop_type_byte == LOOP_TYPE_INFINITE:
            return "infinite"
        if self.loop_type_byte == LOOP_TYPE_OFF:
            return "off"
        if self.loop_type_byte == LOOP_TYPE_UNTIL_RELEASE:
            return "until_release"
        return "unknown"

    @property
    def loop_crossfade_percent(self) -> int:
        """Approximate UI percent; 96 stored ≈ 75% on device (×100/128)."""
        return round(self.loop_crossfade * 100 / 128)

    @property
    def direction_label(self) -> str:
        return "backward" if self.direction else "forward"


@dataclass(frozen=True)
class ProjectSamplerSamples:
    tracks: tuple[SamplerSampleEdit, ...]


def _u16_le(img: bytes, offset: int) -> int:
    return img[offset] | (img[offset + 1] << 8)


def _read_path(slot: bytes) -> str:
    raw = slot[SLOT_PATH : SLOT_PATH + 72]
    end = raw.find(0)
    if end < 0:
        end = len(raw)
    return raw[:end].decode("latin1", errors="replace").strip()


def read_sampler_sample_edit(project: ImageProject, track: int = 1) -> SamplerSampleEdit:
    """Read sample-edit fields for a Sampler-engine track."""
    base = project.track_start(track)
    img = project.image
    engine_id = img[base + ENGINE_ID_OFFSET]
    if engine_id != SAMPLER_ENGINE_ID:
        raise ValueError(f"track {track} engine is 0x{engine_id:02X}, not Sampler (0x02)")

    slot_base = base + VOICE_TABLE_OFFSET
    slot = img[slot_base : slot_base + VOICE_SLOT_SIZE]

    return SamplerSampleEdit(
        track=track,
        engine_id=engine_id,
        path=_read_path(slot),
        sample_start=_u16_le(img, base + TRACK_SAMPLE_START_U16),
        sample_end=_u16_le(img, base + TRACK_SAMPLE_END_U16),
        loop_start=_u16_le(img, base + TRACK_LOOP_START_U16),
        loop_end=_u16_le(img, base + TRACK_LOOP_END_U16),
        loop_crossfade=img[base + TRACK_LOOP_CROSSFADE_U8],
        tune_byte=slot[SLOT_TUNE],
        tune_aux_byte=slot[SLOT_TUNE_AUX],
        loop_type_byte=slot[SLOT_LOOP_TYPE],
        gain=slot[SLOT_GAIN],
        direction=slot[SLOT_DIRECTION],
    )


def inspect_sampler_samples(project: ImageProject) -> ProjectSamplerSamples:
    tracks: list[SamplerSampleEdit] = []
    for track in range(1, len(project._starts) + 1):
        if project.image[project.track_start(track) + ENGINE_ID_OFFSET] != SAMPLER_ENGINE_ID:
            continue
        tracks.append(read_sampler_sample_edit(project, track))
    return ProjectSamplerSamples(tracks=tuple(tracks))


def inspect_sampler_samples_bytes(data: bytes) -> ProjectSamplerSamples:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return inspect_sampler_samples(project)
