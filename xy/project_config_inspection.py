"""Read project-config menu fields from the decoded project image."""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path

from .image_writer import ImageProject

GLOBAL_GROOVE_TYPE_OFFSET = 0x03
GLOBAL_SCENE_LENGTH_OFFSET = 0x08
GLOBAL_TRANSPOSE_OFFSET = 0x1B
GLOBAL_TIME_SIGNATURE_OFFSET = 0x1C
GLOBAL_VOICE_ALLOCATION_OFFSET = 0x4D
GLOBAL_MIDI_CHANNEL_OFFSET = 0x55

VOICE_ALLOCATION_TRACKS = 8
MIDI_CHANNEL_TRACKS = 16

SCENE_LENGTH_NAMES = {
    0x00: "longest",
    0x01: "shortest",
    0x02: "time-signature",
}

TIME_SIGNATURE_NAMES = {
    0x10: "3/4",
    0x11: "4/4",
    0x12: "5/4",
    0x13: "6/8",
    0x14: "7/8",
    0x15: "12/8",
}

GROOVE_TYPE_NAMES = {
    0x00: "shuffle",
    0x01: "half-shuffle",
    0x02: "danish",
    0x03: "bombora",
    0x04: "wobbly",
    0x05: "gaussian",
    0x06: "accents",
    0x07: "island-nod",
    0x08: "disfunk",
    0x09: "roll-over",
    0x0A: "prophetic",
}


@dataclass(frozen=True)
class ProjectConfig:
    scene_length_raw: int
    transpose_semitones: int
    time_signature_raw: int
    groove_type_raw: int
    voice_allocations: tuple[int | None, ...]
    midi_channels: tuple[int | None, ...]

    @property
    def scene_length(self) -> str:
        return SCENE_LENGTH_NAMES.get(
            self.scene_length_raw, f"unknown-0x{self.scene_length_raw:02X}"
        )

    @property
    def time_signature(self) -> str:
        return TIME_SIGNATURE_NAMES.get(
            self.time_signature_raw, f"unknown-0x{self.time_signature_raw:02X}"
        )

    @property
    def groove_type(self) -> str:
        return GROOVE_TYPE_NAMES.get(
            self.groove_type_raw, f"unknown-0x{self.groove_type_raw:02X}"
        )


def decode_transpose(raw: int) -> int:
    """Decode the signed i8 project transpose field."""
    if raw >= 0x80:
        return raw - 0x100
    return raw


def encode_transpose(semitones: int) -> int:
    if not -24 <= semitones <= 24:
        raise ValueError("project transpose must be in -24..+24 semitones")
    return semitones & 0xFF


def decode_voice_allocation(raw: int) -> int | None:
    """Return fixed voice count, or None for auto."""
    return None if raw == 0 else raw


def encode_voice_allocation(voices: int | None) -> int:
    if voices is None:
        return 0
    if not 1 <= voices <= 8:
        raise ValueError("fixed voice allocation must be 1..8, or None for auto")
    return voices


def decode_midi_channel(raw: int) -> int | None:
    """Return MIDI channel 1..16, or None for off."""
    return None if raw == 0xFF else raw + 1


def encode_midi_channel(channel: int | None) -> int:
    if channel is None:
        return 0xFF
    if not 1 <= channel <= 16:
        raise ValueError("MIDI channel must be 1..16, or None for off")
    return channel - 1


def read_project_config(project: ImageProject) -> ProjectConfig:
    image = project.image
    voice_allocations = tuple(
        decode_voice_allocation(image[GLOBAL_VOICE_ALLOCATION_OFFSET + index])
        for index in range(VOICE_ALLOCATION_TRACKS)
    )
    midi_channels = tuple(
        decode_midi_channel(image[GLOBAL_MIDI_CHANNEL_OFFSET + index])
        for index in range(MIDI_CHANNEL_TRACKS)
    )
    return ProjectConfig(
        scene_length_raw=image[GLOBAL_SCENE_LENGTH_OFFSET],
        transpose_semitones=decode_transpose(image[GLOBAL_TRANSPOSE_OFFSET]),
        time_signature_raw=image[GLOBAL_TIME_SIGNATURE_OFFSET],
        groove_type_raw=image[GLOBAL_GROOVE_TYPE_OFFSET],
        voice_allocations=voice_allocations,
        midi_channels=midi_channels,
    )


def inspect_project_config(path: str | Path) -> ProjectConfig:
    return read_project_config(ImageProject.from_file(str(path)))


def inspect_project_config_bytes(data: bytes) -> ProjectConfig:
    from .rle import decode_project

    header, image = decode_project(data)
    return read_project_config(ImageProject(header=header, image=bytearray(image)))
