"""Read the short preset identity string at track struct +0x453F.

Format: ``<category>/<preset-name>`` null-padded (e.g. ``drum/pp``,
``wind/nt-accord``, ``bass/nt-106 bass``). Engine swap without choosing a
preset can leave ``/`` alone. See ``docs/format/decoded_image_map.md`` and
device fixtures in ``src/preset-probes/2026-06-preset-path/``.
"""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project

PRESET_PATH_OFFSET = 0x453F
PRESET_PATH_MAX = 64
ENGINE_ID_OFFSET = 0x14


@dataclass(frozen=True)
class TrackPresetPath:
    track: int
    engine_id: int
    path: str


@dataclass(frozen=True)
class ProjectPresetPaths:
    tracks: tuple[TrackPresetPath, ...]


def inspect_preset_paths_bytes(data: bytes) -> ProjectPresetPaths:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return inspect_preset_paths(project)


def inspect_preset_paths(project: ImageProject) -> ProjectPresetPaths:
    tracks: list[TrackPresetPath] = []
    for track in range(1, len(project._starts) + 1):
        start = project.track_start(track)
        tracks.append(
            TrackPresetPath(
                track=track,
                engine_id=project.image[start + ENGINE_ID_OFFSET],
                path=_read_preset_path(project.image, start),
            )
        )
    return ProjectPresetPaths(tracks=tuple(tracks))


def _read_preset_path(image: bytearray, track_start: int) -> str:
    raw = image[track_start + PRESET_PATH_OFFSET : track_start + PRESET_PATH_OFFSET + PRESET_PATH_MAX]
    end = raw.find(0)
    if end < 0:
        end = len(raw)
    return raw[:end].decode("latin1", errors="replace").strip()
