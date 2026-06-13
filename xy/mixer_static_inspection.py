"""Read static (non-p-lock) mixer fields from decoded project images (P2-A)."""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project
from .scene_volume_inspection import (
    GLOBAL_MASTER_VOL_BYTE_OFFSET,
    GLOBAL_MASTER_VOL_U32_OFFSET,
    MIX_VOL_BYTE_MAX,
    MIX_VOL_U32_MAX,
    TrackMixVolume,
    encode_mix_vol_byte,
    mix_vol_byte_from_u32,
)

# T1 mix page — 4-byte LE groups; value byte is @ u32_start+3 (same as track vol).
TRACK_MIX_PAN_U32_OFFSET = 0x38F7
TRACK_MIX_PAN_BYTE_OFFSET = 0x38FA
TRACK_SEND_FX1_U32_OFFSET = 0x38AF
TRACK_SEND_FX1_BYTE_OFFSET = 0x38B2
TRACK_SEND_FX2_U32_OFFSET = 0x38B3
TRACK_SEND_FX2_BYTE_OFFSET = 0x38B6

GLOBAL_MASTER_PERC_U32_OFFSET = 0x85
GLOBAL_MASTER_PERC_BYTE_OFFSET = 0x88
GLOBAL_MASTER_MELODY_U32_OFFSET = 0x89
GLOBAL_MASTER_MELODY_BYTE_OFFSET = 0x8C
GLOBAL_MASTER_COMP_U32_OFFSET = 0x8D
GLOBAL_MASTER_COMP_BYTE_OFFSET = 0x90

PAN_BYTE_CENTER = 0x40
MIX_U32_MIN = 0x00000000
MIX_U32_MAX = 0x7FFFFFFF
MASTER_GROUP_MIN_U32 = 0x00A3D70A


@dataclass(frozen=True)
class MixField:
    byte: int
    u32: int

    @property
    def ui(self) -> int:
        return round(self.byte * 100 / MIX_VOL_BYTE_MAX)


@dataclass(frozen=True)
class TrackStaticMixer:
    track: int
    volume: MixField
    pan: MixField
    send_fx1: MixField
    send_fx2: MixField


@dataclass(frozen=True)
class MasterStaticMixer:
    percussion: MixField
    melody: MixField
    compressor: MixField
    master: MixField


@dataclass(frozen=True)
class ProjectStaticMixer:
    tracks: tuple[TrackStaticMixer, ...]
    master: MasterStaticMixer


def _read_mix_field(img: bytes, byte_offset: int) -> MixField:
    u32_offset = byte_offset - 3
    u32 = int.from_bytes(img[u32_offset : u32_offset + 4], "little")
    return MixField(byte=img[byte_offset], u32=u32)


def inspect_static_mixer_bytes(data: bytes) -> ProjectStaticMixer:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return inspect_static_mixer(project)


def inspect_static_mixer(project: ImageProject) -> ProjectStaticMixer:
    img = project.image
    tracks: list[TrackStaticMixer] = []
    for track in range(1, 17):
        base = project.track_start(track)
        vol_u32 = int.from_bytes(
            img[base + 0x38FB : base + 0x38FB + 4], "little"
        )
        tracks.append(
            TrackStaticMixer(
                track=track,
                volume=MixField(
                    byte=img[base + 0x38FE],
                    u32=vol_u32,
                ),
                pan=_read_mix_field(img, base + TRACK_MIX_PAN_BYTE_OFFSET),
                send_fx1=_read_mix_field(img, base + TRACK_SEND_FX1_BYTE_OFFSET),
                send_fx2=_read_mix_field(img, base + TRACK_SEND_FX2_BYTE_OFFSET),
            )
        )
    master = MasterStaticMixer(
        percussion=_read_mix_field(img, GLOBAL_MASTER_PERC_BYTE_OFFSET),
        melody=_read_mix_field(img, GLOBAL_MASTER_MELODY_BYTE_OFFSET),
        compressor=_read_mix_field(img, GLOBAL_MASTER_COMP_BYTE_OFFSET),
        master=_read_mix_field(img, GLOBAL_MASTER_VOL_BYTE_OFFSET),
    )
    return ProjectStaticMixer(tracks=tuple(tracks), master=master)


def track_volume(project: ImageProject, track: int) -> TrackMixVolume:
    """Compatibility helper; volume field matches P2-D scene probes."""
    row = inspect_static_mixer(project).tracks[track - 1]
    return TrackMixVolume(track=track, vol_byte=row.volume.byte, vol_u32=row.volume.u32)
