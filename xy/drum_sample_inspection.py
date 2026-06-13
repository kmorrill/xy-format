"""Read drum-sampler voice sample paths and per-voice edit params from a decoded project image.

Drum voices are 24 slots × 128 bytes at track struct +0x3957 (see
``docs/format/decoded_image_map.md``). This module reads from the decoded RAM
image (via ``ImageProject``), not from scaffold logical-entry bodies.
"""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project

DRUM_ENGINE_ID = 0x03
DRUM_TABLE_OFFSET = 0x3957
DRUM_SLOT_SIZE = 0x80
DRUM_TUNE_OFFSET = 0x00
DRUM_KEY_OFFSET = 0x02
DRUM_PLAY_MODE_OFFSET = 0x03
DRUM_PAN_OFFSET = 0x06
DRUM_DIRECTION_OFFSET = 0x07
DRUM_PATH_OFFSET = 0x08
DRUM_START_OFFSET = 0x68
DRUM_LOOP_START_OFFSET = 0x6C
DRUM_END_OFFSET = 0x70
DRUM_GAIN_OFFSET = 0x7C
DRUM_VOICE_COUNT = 24
DRUM_TUNE_CENTER = 0x3C
ENGINE_ID_OFFSET = 0x14
# Loop-crossfade UI 0..99 → u32 at preceding voice slot +0x7C (M3 probes).
DRUM_FADE_STEP = 0x0147AF00
DRUM_FADE_HI_SCALE = DRUM_FADE_STEP >> 8  # 0x0147AF
DRUM_FADE_U32_MAX = 0x7FFFFFFF
DRUM_FADE_UI_MAX = 99


def encode_drum_fade_ui(ui: int) -> int:
    """Encode drum pad loop-crossfade UI (0..99) to device u32 @ slot+0x7C."""
    if ui <= 0:
        return 0
    if ui >= DRUM_FADE_UI_MAX:
        return DRUM_FADE_U32_MAX
    return ui * DRUM_FADE_STEP


def decode_drum_fade_u32(u32: int) -> int:
    """Decode loop-crossfade u32 back to UI 0..99."""
    if u32 <= 0:
        return 0
    if u32 >= DRUM_FADE_U32_MAX:
        return DRUM_FADE_UI_MAX
    return (u32 >> 8) // DRUM_FADE_HI_SCALE


def drum_fade_storage_voice(edited_voice: int) -> int:
    """Pad fade edited on *edited_voice* is stored on the previous slot (v23→v22)."""
    return edited_voice - 1


def decode_drum_tune_semitones(tune_byte: int) -> int:
    """Decode drum tune byte @ slot+0x00 to semitones from center (0x3C)."""
    return tune_byte - DRUM_TUNE_CENTER


@dataclass(frozen=True)
class DrumVoiceSample:
    voice: int
    path: str
    tune: int
    key_assignment: int
    play_mode: int
    direction: int  # 0=forward, 1=backward @ slot+0x07
    pan: int  # signed byte @ slot+0x06 (device ±100)
    start: int  # u32 @ slot+0x68
    loop_start: int  # u32 @ slot+0x6C (candidate loop-start lane)
    end: int  # u32 @ slot+0x70
    slot_gain_u32: int  # u32 @ slot+0x7C (gain knob; also fade storage for next pad)
    loop_fade_ui: int  # loop-crossfade for this pad (decoded from preceding slot +0x7C)

    @property
    def tune_semitones(self) -> int:
        return decode_drum_tune_semitones(self.tune)

    @property
    def direction_label(self) -> str:
        return "backward" if self.direction else "forward"

    @property
    def gain_u32(self) -> int:
        """Sample gain u32 on this pad's slot +0x7C (shares offset with next pad's fade storage)."""
        return self.slot_gain_u32

    @property
    def fade_ui(self) -> int:
        """Loop-crossfade UI decoded from this slot's +0x7C u32 (fade storage for the *next* pad)."""
        return decode_drum_fade_u32(self.slot_gain_u32)


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
    raw_slots: list[bytes] = []
    for voice in range(DRUM_VOICE_COUNT):
        raw_slots.append(
            project.image[base + voice * DRUM_SLOT_SIZE : base + (voice + 1) * DRUM_SLOT_SIZE]
        )

    voices: list[DrumVoiceSample] = []
    for voice, slot in enumerate(raw_slots):
        slot_gain_u32 = int.from_bytes(
            slot[DRUM_GAIN_OFFSET : DRUM_GAIN_OFFSET + 4], "little"
        )
        if voice == 0:
            loop_fade_ui = 0
        else:
            prev_gain = int.from_bytes(
                raw_slots[voice - 1][DRUM_GAIN_OFFSET : DRUM_GAIN_OFFSET + 4], "little"
            )
            loop_fade_ui = decode_drum_fade_u32(prev_gain)
        voices.append(
            DrumVoiceSample(
                voice=voice,
                path=_read_path(slot),
                tune=slot[DRUM_TUNE_OFFSET],
                key_assignment=slot[DRUM_KEY_OFFSET],
                play_mode=slot[DRUM_PLAY_MODE_OFFSET],
                direction=slot[DRUM_DIRECTION_OFFSET],
                pan=_signed_byte(slot[DRUM_PAN_OFFSET]),
                start=int.from_bytes(
                    slot[DRUM_START_OFFSET : DRUM_START_OFFSET + 4], "little"
                ),
                loop_start=int.from_bytes(
                    slot[DRUM_LOOP_START_OFFSET : DRUM_LOOP_START_OFFSET + 4],
                    "little",
                ),
                end=int.from_bytes(slot[DRUM_END_OFFSET : DRUM_END_OFFSET + 4], "little"),
                slot_gain_u32=slot_gain_u32,
                loop_fade_ui=loop_fade_ui,
            )
        )
    return tuple(voices)


def _signed_byte(value: int) -> int:
    return value if value < 128 else value - 256


def _read_path(slot: bytes) -> str:
    raw = slot[DRUM_PATH_OFFSET : DRUM_PATH_OFFSET + 72]
    end = raw.find(0)
    if end < 0:
        end = len(raw)
    return raw[:end].decode("latin1", errors="replace").strip()
