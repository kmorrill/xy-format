"""Read mixer volume fields from decoded project images (P2-D probes)."""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import GLOBAL_ACTIVE_SCENE, ImageProject, SCENE_SLOT0, SCENE_SLOT_SIZE

SCENE_MUTE_OFFSET = 16  # within 33-byte scene slot
SCENE_MUTE_VALUE = 2  # device-confirmed muted byte (nonzero)
SCENE_FLAG_OFFSET = 32  # within 33-byte scene slot
SCENE_SLOT_PRESENT_VALUE = 1  # observed/writer value for populated scene rows
from .rle import decode_project

TRACK_MIX_VOL_U32_OFFSET = 0x38FB
TRACK_MIX_VOL_BYTE_OFFSET = 0x38FE
GLOBAL_MASTER_VOL_U32_OFFSET = 0x91
GLOBAL_MASTER_VOL_BYTE_OFFSET = 0x94
MIX_VOL_BYTE_MAX = 0x7F
MIX_VOL_U32_MAX = 0x7FFFFFFF


@dataclass(frozen=True)
class TrackMixVolume:
    track: int
    vol_byte: int
    vol_u32: int

    @property
    def vol_ui(self) -> int:
        """Approximate device UI 0..100 from stored byte (0..0x7F)."""
        return round(self.vol_byte * 100 / MIX_VOL_BYTE_MAX)


@dataclass(frozen=True)
class SceneVolumeInspection:
    active_scene_raw: int
    active_song_raw: int
    master_vol_byte: int
    master_vol_u32: int
    track_volumes: tuple[TrackMixVolume, ...]
    scene_flags: tuple[int, ...]

    @property
    def master_vol_ui(self) -> int:
        return round(self.master_vol_byte * 100 / MIX_VOL_BYTE_MAX)

    @property
    def present_scene_slots(self) -> tuple[int, ...]:
        """0-based scene slot indices whose flag byte is nonzero."""
        return tuple(slot for slot, flag in enumerate(self.scene_flags) if flag != 0)

    @property
    def present_scene_count(self) -> int:
        """Count of populated scene rows inferred from scene slot flags."""
        return len(self.present_scene_slots)

    @property
    def active_scene_ordinal(self) -> int:
        return self.active_scene_raw + 1

    @property
    def active_song_ordinal(self) -> int:
        if self.active_song_raw == 0x10:
            return 1
        return self.active_song_raw + 1


def mix_vol_byte_from_u32(u32: int) -> int:
    return (u32 >> 24) & 0xFF


def encode_mix_vol_byte(vol_byte: int) -> int:
    if vol_byte <= 0:
        return 0
    if vol_byte >= MIX_VOL_BYTE_MAX:
        return MIX_VOL_U32_MAX
    return (vol_byte & 0xFF) << 24


def scene_volume_storage_track(scene: int, track: int) -> int:
    """Map (scene, track) to the struct that stores that scene's mix volume.

  Validated on P2-D ``s0b`` captures for scene 1 T1 (→ T1) and scene 2 T1
  (→ T2). Full 16×scene matrix is not closed."""
    if scene < 1 or track < 1:
        raise ValueError("scene and track are 1-based")
    return track + (scene - 1)


def inspect_scene_volumes_bytes(data: bytes) -> SceneVolumeInspection:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return inspect_scene_volumes(project)


def inspect_scene_volumes(project: ImageProject) -> SceneVolumeInspection:
    img = project.image
    master_u32 = int.from_bytes(
        img[GLOBAL_MASTER_VOL_U32_OFFSET : GLOBAL_MASTER_VOL_U32_OFFSET + 4],
        "little",
    )
    tracks: list[TrackMixVolume] = []
    for track in range(1, 17):
        base = project.track_start(track)
        u32 = int.from_bytes(
            img[base + TRACK_MIX_VOL_U32_OFFSET : base + TRACK_MIX_VOL_U32_OFFSET + 4],
            "little",
        )
        tracks.append(
            TrackMixVolume(
                track=track,
                vol_byte=img[base + TRACK_MIX_VOL_BYTE_OFFSET],
                vol_u32=u32,
            )
        )
    return SceneVolumeInspection(
        active_scene_raw=img[GLOBAL_ACTIVE_SCENE],
        active_song_raw=img[GLOBAL_ACTIVE_SCENE + 1],
        master_vol_byte=img[GLOBAL_MASTER_VOL_BYTE_OFFSET],
        master_vol_u32=master_u32,
        track_volumes=tuple(tracks),
        scene_flags=tuple(
            img[SCENE_SLOT0 + slot * SCENE_SLOT_SIZE + SCENE_FLAG_OFFSET]
            for slot in range(9)
        ),
    )


def read_scene_track_volume(
    project: ImageProject, scene: int, track: int
) -> TrackMixVolume:
    storage = scene_volume_storage_track(scene, track)
    if storage > 16:
        raise ValueError(f"no storage track for scene={scene} track={track}")
    base = project.track_start(storage)
    img = project.image
    u32 = int.from_bytes(
        img[base + TRACK_MIX_VOL_U32_OFFSET : base + TRACK_MIX_VOL_U32_OFFSET + 4],
        "little",
    )
    return TrackMixVolume(
        track=track,
        vol_byte=img[base + TRACK_MIX_VOL_BYTE_OFFSET],
        vol_u32=u32,
    )


def scene_mute_storage_slot(scene: int) -> int:
    """Map 1-based scene ordinal to the 0-based scene slot holding mute bytes.

    Validated on P2-E (firmware 1.1.4): scene 1 on a single-scene project
    uses slot 0; on a multi-scene project scene *N* uses slot *N − 1* (same
    row as that scene's pattern selection — slot 0 = scene 1 / live row).
    """
    if scene < 1:
        raise ValueError("scene is 1-based")
    return scene - 1


def read_scene_slot_pattern_sel(project: ImageProject, scene_slot: int) -> tuple[int, ...]:
    """Pattern index (0-based) per track for a scene slot (0 = live / scene 1 on single-scene)."""
    slot = SCENE_SLOT0 + scene_slot * SCENE_SLOT_SIZE
    return tuple(project.image[slot + t] for t in range(16))


def read_scene_slot_mute_bytes(project: ImageProject, scene_slot: int) -> tuple[int, ...]:
    """Raw mute bytes for 16 tracks in a scene slot (0 = unmuted, 2 = muted)."""
    slot = SCENE_SLOT0 + scene_slot * SCENE_SLOT_SIZE
    base = slot + SCENE_MUTE_OFFSET
    return tuple(project.image[base + t] for t in range(16))


def read_scene_slot_flag(project: ImageProject, scene_slot: int) -> int:
    """Raw scene slot flag byte at slot+32.

    Device fixtures and ``build_arrangement`` use value 1 when a scene row is
    populated/present; empty trailing rows read as 0.
    """
    slot = SCENE_SLOT0 + scene_slot * SCENE_SLOT_SIZE
    return project.image[slot + SCENE_FLAG_OFFSET]


def is_scene_slot_present(project: ImageProject, scene_slot: int) -> bool:
    """Whether a scene slot is marked populated by the slot flag byte."""
    return read_scene_slot_flag(project, scene_slot) != 0


def read_present_scene_slots(project: ImageProject, max_slots: int = 9) -> tuple[int, ...]:
    """0-based scene slot indices whose flag byte is nonzero."""
    return tuple(slot for slot in range(max_slots) if is_scene_slot_present(project, slot))


def read_scene_muted_tracks(project: ImageProject, scene_slot: int) -> tuple[int, ...]:
    """1-based track numbers muted in ``scene_slot``."""
    return tuple(
        t + 1
        for t, value in enumerate(read_scene_slot_mute_bytes(project, scene_slot))
        if value != 0
    )
