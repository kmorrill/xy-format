"""Read master EQ (bass/mid/treble) from decoded project images (P2-F)."""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project

# Global header — 4-byte LE fields; level byte is @ field start (not +3 like mixer).
GLOBAL_PREFIX_U32_OFFSET = 0x64  # default 0xFF; purpose open (not saturator gain)
GLOBAL_EQ_BLEND_U32_OFFSET = 0x74  # default 0x40; 4th EQ UI ("power") does not write here on 1.1.4
EQ_BLEND_BYTE_DEFAULT = 0x40
GLOBAL_EQ_LOW_U32_OFFSET = 0x68
GLOBAL_EQ_MID_U32_OFFSET = 0x6C
GLOBAL_EQ_HIGH_U32_OFFSET = 0x70
GLOBAL_EQ_OFFSETS = (
    GLOBAL_EQ_LOW_U32_OFFSET,
    GLOBAL_EQ_MID_U32_OFFSET,
    GLOBAL_EQ_HIGH_U32_OFFSET,
)

EQ_BYTE_DEFAULT = 0x40
EQ_BYTE_MIN = 0
EQ_BYTE_MAX = 0x7F
EQ_U32_DEFAULT = 0x00000040
EQ_U32_MIN = 0x00000000
EQ_U32_MAX = 0x0000007F
EQ_U32_MAX_WITH_TAIL = 0xFFFFFF7F
GLOBAL_PREFIX_DEFAULT_U32 = 0x000000FF
GLOBAL_PREFIX_SPILL_U32_MAX = 0xFFFFFFFF
EQ_BLEND_DEFAULT_U32 = 0x99999A40


@dataclass(frozen=True)
class MasterEqBand:
    byte: int
    u32: int

    @property
    def ui(self) -> int:
        """Approximate UI percent (0–100) from stored byte."""
        return round(self.byte * 100 / EQ_BYTE_MAX)


@dataclass(frozen=True)
class MasterEq:
    low: MasterEqBand
    mid: MasterEqBand
    high: MasterEqBand


def _read_eq_band(img: bytes, u32_offset: int) -> MasterEqBand:
    u32 = int.from_bytes(img[u32_offset : u32_offset + 4], "little")
    return MasterEqBand(byte=img[u32_offset], u32=u32)


def read_master_eq_blend(project: ImageProject) -> MasterEqBand:
    """Raw u32 @ ``0x74`` — not the live 4th EQ UI knob; see blend/power log."""
    return _read_eq_band(project.image, GLOBAL_EQ_BLEND_U32_OFFSET)


def read_master_eq(project: ImageProject) -> MasterEq:
    img = project.image
    return MasterEq(
        low=_read_eq_band(img, GLOBAL_EQ_LOW_U32_OFFSET),
        mid=_read_eq_band(img, GLOBAL_EQ_MID_U32_OFFSET),
        high=_read_eq_band(img, GLOBAL_EQ_HIGH_U32_OFFSET),
    )


def inspect_master_eq(project: ImageProject) -> MasterEq:
    return read_master_eq(project)


def inspect_master_eq_bytes(data: bytes) -> MasterEq:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return read_master_eq(project)
