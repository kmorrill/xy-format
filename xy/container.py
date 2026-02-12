from __future__ import annotations

from dataclasses import dataclass
from typing import List

from .structs import find_track_blocks


MAGIC = b"\xDD\xCC\xBB\xAA"  # First 4 bytes; bytes 4-7 vary by firmware version
HEADER_SIZE = 0x18
PRE_TRACK_SIZE = 0x7C  # Baseline corpus value; actual size varies (121-233 bytes observed)
HANDLE_TABLE_OFFSET = 0x58
HANDLE_TABLE_ENTRIES = 9
MIN_PROJECT_SIZE = 0x80


@dataclass(frozen=True)
class XYHeader:
    raw: bytes
    tempo_tenths: int
    groove_type: int
    groove_flags: int
    groove_amount: int
    metronome_level: int
    field_0x0C: int
    field_0x10: int
    field_0x14: int

    @classmethod
    def from_bytes(cls, data: bytes) -> "XYHeader":
        if len(data) < HEADER_SIZE:
            raise ValueError(
                f"file too short for header ({len(data)} bytes, need {HEADER_SIZE})"
            )
        raw = data[:HEADER_SIZE]
        tempo_word = int.from_bytes(data[8:12], "little")
        tempo_tenths = tempo_word & 0xFFFF
        groove_flags = (tempo_word >> 16) & 0xFF
        groove_type = (tempo_word >> 24) & 0xFF

        groove_amount = data[0x0C]
        metronome_level = data[0x0D]

        field_0x0C = int.from_bytes(data[12:16], "little")
        field_0x10 = int.from_bytes(data[16:20], "little")
        field_0x14 = int.from_bytes(data[20:24], "little")
        return cls(
            raw=raw,
            tempo_tenths=tempo_tenths,
            groove_type=groove_type,
            groove_flags=groove_flags,
            groove_amount=groove_amount,
            metronome_level=metronome_level,
            field_0x0C=field_0x0C,
            field_0x10=field_0x10,
            field_0x14=field_0x14,
        )

    def to_bytes(self) -> bytes:
        raw = bytearray(self.raw)
        tempo_word = (
            (self.tempo_tenths & 0xFFFF)
            | ((self.groove_flags & 0xFF) << 16)
            | ((self.groove_type & 0xFF) << 24)
        )
        raw[8:12] = tempo_word.to_bytes(4, "little", signed=False)
        raw[0x0C] = self.groove_amount & 0xFF
        raw[0x0D] = self.metronome_level & 0xFF
        raw[12:16] = self.field_0x0C.to_bytes(4, "little", signed=False)
        raw[16:20] = self.field_0x10.to_bytes(4, "little", signed=False)
        raw[20:24] = self.field_0x14.to_bytes(4, "little", signed=False)
        return bytes(raw)


@dataclass(frozen=True)
class XYContainer:
    raw: bytes
    header: XYHeader

    @classmethod
    def from_bytes(cls, data: bytes, *, min_size: int = MIN_PROJECT_SIZE) -> "XYContainer":
        if len(data) < min_size:
            raise ValueError(
                f"file too short ({len(data)} bytes); minimum is {min_size}"
            )
        header = XYHeader.from_bytes(data)
        return cls(raw=data, header=header)

    def to_bytes(self) -> bytes:
        raw = bytearray(self.raw)
        raw[:HEADER_SIZE] = self.header.to_bytes()
        return bytes(raw)


@dataclass(frozen=True)
class TrackBlock:
    """A single track block including its 4-byte preamble pointer."""

    index: int  # 0-based track index
    preamble: bytes  # 4-byte LE pointer word preceding the signature
    body: bytes  # Everything from the signature start to the next preamble (or EOF)

    @property
    def preamble_word(self) -> int:
        return int.from_bytes(self.preamble, "little")

    @property
    def engine_id(self) -> int:
        """Engine ID byte.  Position depends on type byte:
        - type 0x05 (has padding): body[0x0D]
        - type 0x07 (no padding): body[0x0B]
        """
        if self.type_byte == 0x05:
            return self.body[0x0D]
        else:
            return self.body[0x0B]

    @property
    def type_byte(self) -> int:
        return self.body[9]

    @property
    def bar_count(self) -> int:
        """Number of bars (1-4).  Encoded in preamble byte 2 as bar_count << 4."""
        return self.preamble[2] >> 4

    @property
    def has_padding(self) -> bool:
        return self.type_byte == 0x05

    def to_bytes(self) -> bytes:
        return self.preamble + self.body


@dataclass(frozen=True)
class XYProject:
    """Full project file decomposed into header region + 16 track blocks.

    Round-trip guarantee: ``XYProject.from_bytes(data).to_bytes() == data``
    for every valid project file in the corpus.
    """

    pre_track: bytes  # Everything before the first track preamble (variable length)
    tracks: List[TrackBlock]  # Exactly 16 track blocks

    @classmethod
    def from_bytes(cls, data: bytes) -> "XYProject":
        if len(data) < MIN_PROJECT_SIZE:
            raise ValueError(f"file too short ({len(data)} bytes)")
        if data[:4] != MAGIC:
            raise ValueError(f"bad magic: {data[:8].hex()}")

        sig_offsets = find_track_blocks(data)
        if len(sig_offsets) != 16:
            raise ValueError(
                f"expected 16 track blocks, found {len(sig_offsets)}"
            )

        # The preamble is the 4 bytes immediately before each signature.
        preamble_offsets = [s - 4 for s in sig_offsets]

        pre_track = data[: preamble_offsets[0]]

        tracks: List[TrackBlock] = []
        for i in range(16):
            start = preamble_offsets[i]
            end = preamble_offsets[i + 1] if i + 1 < 16 else len(data)
            preamble = data[start : start + 4]
            body = data[start + 4 : end]
            tracks.append(TrackBlock(index=i, preamble=preamble, body=body))

        return cls(pre_track=pre_track, tracks=tracks)

    def to_bytes(self) -> bytes:
        parts = [self.pre_track]
        for track in self.tracks:
            parts.append(track.to_bytes())
        return b"".join(parts)
