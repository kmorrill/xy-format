"""Read master saturator fields from decoded project images (P2-G)."""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project
from .scene_volume_inspection import MIX_VOL_BYTE_MAX

# 4-byte LE u32 groups; level byte @ u32_start + 3 (same family as static mixer).
GLOBAL_SAT_GAIN_U32_OFFSET = 0x75
GLOBAL_SAT_GAIN_BYTE_OFFSET = 0x78
GLOBAL_SAT_CLIP_U32_OFFSET = 0x79
GLOBAL_SAT_CLIP_BYTE_OFFSET = 0x7C
GLOBAL_SAT_TONE_U32_OFFSET = 0x7D
GLOBAL_SAT_TONE_BYTE_OFFSET = 0x80
GLOBAL_SAT_MIX_U32_OFFSET = 0x81
GLOBAL_SAT_MIX_BYTE_OFFSET = 0x84

SAT_BYTE_MIN = 0
SAT_BYTE_MAX = 0x7F
SAT_GAIN_DEFAULT = 0x19
SAT_CLIP_DEFAULT = 0x19
SAT_TONE_DEFAULT = 0x40
SAT_MIX_DEFAULT = 0x00
SAT_U32_MIN = 0x00000000
SAT_U32_MAX = 0x7FFFFFFF
SAT_GAIN_DEFAULT_U32 = 0x1999999A
SAT_CLIP_DEFAULT_U32 = 0x1999999A
SAT_TONE_DEFAULT_U32 = 0x40000000
SAT_MIX_DEFAULT_U32 = 0x00000000


@dataclass(frozen=True)
class SaturatorBand:
    byte: int
    u32: int

    @property
    def ui(self) -> int:
        return round(self.byte * 100 / MIX_VOL_BYTE_MAX)


@dataclass(frozen=True)
class MasterSaturator:
    gain: SaturatorBand
    clip: SaturatorBand
    tone: SaturatorBand
    mix: SaturatorBand


def _read_band(img: bytes, byte_offset: int) -> SaturatorBand:
    u32_offset = byte_offset - 3
    u32 = int.from_bytes(img[u32_offset : u32_offset + 4], "little")
    return SaturatorBand(byte=img[byte_offset], u32=u32)


def read_master_saturator(project: ImageProject) -> MasterSaturator:
    img = project.image
    return MasterSaturator(
        gain=_read_band(img, GLOBAL_SAT_GAIN_BYTE_OFFSET),
        clip=_read_band(img, GLOBAL_SAT_CLIP_BYTE_OFFSET),
        tone=_read_band(img, GLOBAL_SAT_TONE_BYTE_OFFSET),
        mix=_read_band(img, GLOBAL_SAT_MIX_BYTE_OFFSET),
    )


def inspect_master_saturator(project: ImageProject) -> MasterSaturator:
    return read_master_saturator(project)


def inspect_master_saturator_bytes(data: bytes) -> MasterSaturator:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return read_master_saturator(project)
