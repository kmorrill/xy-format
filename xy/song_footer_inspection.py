"""Inspection helpers for the 14 variable-length song footer slots."""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject


@dataclass(frozen=True)
class SongFooterSlot:
    song: int
    scene_chain: tuple[int, ...]
    loop: bool
    loop_raw: int
    reserved: int


def inspect_song_footer(project: ImageProject) -> tuple[SongFooterSlot, ...]:
    """Return every footer slot with scene IDs converted to 1-based UI values."""
    slots: list[SongFooterSlot] = []
    for song in range(1, project.SONG_SLOT_COUNT + 1):
        offset = project._song_slot_offset(song)
        count = project.image[offset]
        scene_chain, loop = project.get_song_chain(song)
        loop_offset = offset + 1 + count
        slots.append(
            SongFooterSlot(
                song=song,
                scene_chain=tuple(scene + 1 for scene in scene_chain),
                loop=loop,
                loop_raw=project.image[loop_offset],
                reserved=project.image[loop_offset + 1],
            )
        )
    return tuple(slots)
