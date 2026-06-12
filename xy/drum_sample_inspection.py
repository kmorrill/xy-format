"""Read drum-sampler voice sample paths from a decoded project image.

Drum voices are 24 slots × 128 bytes at track struct +0x3957; the sample
path string starts at slot +0x08 (see docs/format/decoded_image_map.md).
This module reads from the decoded RAM image (via ``ImageProject``), not
from scaffold logical-entry bodies, which are shorter track-block slices.
"""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project

DRUM_ENGINE_ID = 0x03
DRUM_TABLE_OFFSET = 0x3957
DRUM_SLOT_SIZE = 0x80
DRUM_PATH_OFFSET = 0x08
DRUM_VOICE_COUNT = 24
ENGINE_ID_OFFSET = 0x14


@dataclass(frozen=True)
class DrumVoiceSample:
    voice: int
    path: str
    tune: int
    key_assignment: int
    play_mode: int


@dataclass(frozen=True)
class DrumTrackSamples:
    track: int
    engine_id: int
    voices: tuple[DrumVoiceSample, ...]

    @property
    def assigned_paths(self) -> tuple[DrumVoiceSample, ...]:
        """Voices whose path is non-empty (typical kit has all 24 populated)."""
        return tuple(v for v in self.voices if v.path)


@dataclass(frozen=True)
class ProjectDrumSamples:
    tracks: tuple[DrumTrackSamples, ...]


def inspect_drum_samples_bytes(data: bytes) -> ProjectDrumSamples:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return inspect_drum_samples(project)


def inspect_drum_samples(project: ImageProject) -> ProjectDrumSamples:
    tracks: list[DrumTrackSamples] = []
    for track in range(1, len(project._starts) + 1):
        engine_id = project.image[project.track_start(track) + ENGINE_ID_OFFSET]
        if engine_id != DRUM_ENGINE_ID:
            continue
        tracks.append(
            DrumTrackSamples(
                track=track,
                engine_id=engine_id,
                voices=_read_voice_table(project, track),
            )
        )
    return ProjectDrumSamples(tracks=tuple(tracks))


def _read_voice_table(project: ImageProject, track: int) -> tuple[DrumVoiceSample, ...]:
    base = project.track_start(track) + DRUM_TABLE_OFFSET
    voices: list[DrumVoiceSample] = []
    for voice in range(DRUM_VOICE_COUNT):
        slot = project.image[base + voice * DRUM_SLOT_SIZE : base + (voice + 1) * DRUM_SLOT_SIZE]
        voices.append(
            DrumVoiceSample(
                voice=voice,
                path=_read_path(slot),
                tune=slot[0],
                key_assignment=slot[2],
                play_mode=slot[3],
            )
        )
    return tuple(voices)


def _read_path(slot: bytes) -> str:
    raw = slot[DRUM_PATH_OFFSET : DRUM_PATH_OFFSET + 72]
    end = raw.find(0)
    if end < 0:
        end = len(raw)
    return raw[:end].decode("latin1", errors="replace").strip()
