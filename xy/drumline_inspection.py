"""Read OS 1.2.0 Drumline (engine 0x04) voices and M2 controls from a decoded image.

Drumline reuses the drum sampler's 24 x 128-byte voice table at track +0x3957
(see ``drum_sample_inspection.py``) without sample paths. Voice ``v`` (key
53 + v) is easiest to read as a 128-byte record that starts 0x12 bytes before
its table slot, at track +0x3945 + 0x80 * v:

    +0x00/+0x04/+0x08/+0x0C  the model's four parameters, u32 0..0x8000
    +0x10                    voice random, u16 0..0x8000
    +0x12                    (play mode << 4) | model   (= table slot +0x00)
    +0x14                    trigger key                 (= slot +0x02)
    +0x15                    sampler play-mode byte; Drumline ignores it
    +0x17                    volume, signed dB           (= slot +0x05)
    +0x18                    pan, signed -100..+100      (= slot +0x06)

So a voice's parameters live in the tail of the previous table slot, and voice
1's live in the 0x12 bytes before the table.

Drumline's M2 page (funk / attack / random / length) reuses the amp-envelope
ADSR words at track +0x3877..+0x3886, as u32 0..0x7FFFFFFF.

Evidence: device readings of all 24 voices of ``drumline/atom``, tool-authored
single-field probes loaded on OS 1.2.0, and device-saved captures in
``src/one-off-changes-from-default/firmware-1.2.0/drumline-params/``. See
``docs/workflows/drumline_param_capture_checklist_1.2.0.md``.
"""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project

DRUMLINE_ENGINE_ID = 0x04
ENGINE_ID_OFFSET = 0x14
PRESET_PATH_OFFSET = 0x453F
PRESET_PATH_MAX = 48

DRUMLINE_RECORD_OFFSET = 0x3945
DRUMLINE_RECORD_SIZE = 0x80
DRUMLINE_VOICE_COUNT = 24
DRUMLINE_FIRST_KEY = 53

REC_PARAMS = (0x00, 0x04, 0x08, 0x0C)
REC_RANDOM = 0x10
REC_MODEL_MODE = 0x12
REC_KEY = 0x14
REC_SAMPLER_PLAY_MODE = 0x15
REC_VOLUME_DB = 0x17
REC_PAN = 0x18

PARAM_FULL_SCALE = 0x8000  # display 100

M2_OFFSETS = {"funk": 0x3877, "attack": 0x387B, "random": 0x387F, "length": 0x3883}
M2_FULL_SCALE = 0x7FFFFFFF

# Low nibble of record +0x12. Zap (7) is not in TE's published list, but the
# firmware shows and plays it.
MODELS: dict[int, tuple[str, tuple[str, str, str, str]]] = {
    0x0: ("kick", ("pitch", "length", "punch", "tone")),
    0x1: ("snare", ("pitch", "length", "snare", "punch")),
    0x2: ("hi-hat", ("pitch", "length", "era", "tone")),
    0x3: ("shaker", ("color", "length", "attack", "onset")),
    0x4: ("clap", ("tone", "length", "spread", "contour")),
    0x5: ("congas", ("pitch", "length", "slap", "mush")),
    0x6: ("resonator", ("pitch", "length", "mod", "feedback")),
    0x7: ("zap", ("pitch", "length", "fm", "feedback")),
    0x8: ("fm tom", ("pitch", "length", "sweep", "rate")),
    0x9: ("tambourine", ("tone", "length", "shake", "ring")),
    0xA: ("tune", ("pitch", "length", "tone", "strike")),
}

# High nibble of record +0x12, from a device-saved capture. The icons are
# certain; "key" vs "oneshot" for 0 and 1 is inferred from TE's mode list.
PLAY_MODES: dict[int, tuple[str, str]] = {
    0: ("→", "key"),
    1: ("→|", "oneshot"),
    2: ("→g", "mute group 1"),
    3: ("loop", "loop"),
    4: ("→2", "mute group 2"),
    5: ("→3", "mute group 3"),
}


def param_display(raw: int) -> int:
    """On-screen 0..100 value; the device truncates rather than rounds."""
    return raw * 100 // PARAM_FULL_SCALE


def volume_display(volume_db: int) -> int:
    """On-screen volume for a stored dB value (0 dB shows as 59)."""
    return 59 + 2 * volume_db


@dataclass(frozen=True)
class DrumlineVoice:
    voice: int  # 0-based
    key: int
    model: int
    play_mode: int
    params: tuple[int, int, int, int]  # raw u32, 0..0x8000
    random: int  # raw u16, 0..0x8000
    volume_db: int
    pan: int  # -100 (left) .. +100 (right)
    sampler_play_mode: int  # +0x15, preserved but not used by Drumline

    @property
    def model_name(self) -> str:
        return MODELS.get(self.model, (f"unknown {self.model:#x}", ()))[0]

    @property
    def param_names(self) -> tuple[str, ...]:
        return MODELS.get(self.model, ("", ("p1", "p2", "p3", "p4")))[1]

    @property
    def params_display(self) -> tuple[int, int, int, int]:
        return tuple(param_display(p) for p in self.params)  # type: ignore[return-value]

    @property
    def random_display(self) -> int:
        return param_display(self.random)

    @property
    def volume_display(self) -> int:
        return volume_display(self.volume_db)

    @property
    def play_mode_icon(self) -> str:
        return PLAY_MODES.get(self.play_mode, (f"?{self.play_mode}", ""))[0]

    @property
    def play_mode_name(self) -> str:
        return PLAY_MODES.get(self.play_mode, ("", f"unknown {self.play_mode}"))[1]


@dataclass(frozen=True)
class DrumlineTrack:
    track: int
    preset_path: str
    m2: dict[str, int]  # raw u32 per M2 control, 0..0x7FFFFFFF
    voices: tuple[DrumlineVoice, ...]

    def m2_percent(self, name: str) -> float:
        return self.m2[name] * 100 / M2_FULL_SCALE

    def voice_for_key(self, key: int) -> DrumlineVoice:
        return next(v for v in self.voices if v.key == key)


@dataclass(frozen=True)
class ProjectDrumline:
    tracks: tuple[DrumlineTrack, ...]

    def track(self, number: int) -> DrumlineTrack:
        return next(t for t in self.tracks if t.track == number)


def inspect_drumline_bytes(data: bytes) -> ProjectDrumline:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return inspect_drumline(project)


def inspect_drumline(project: ImageProject) -> ProjectDrumline:
    """Read every Drumline track's leader pattern."""
    tracks: list[DrumlineTrack] = []
    for track in range(1, len(project._starts) + 1):
        start = project.track_start(track)
        if project.image[start + ENGINE_ID_OFFSET] != DRUMLINE_ENGINE_ID:
            continue
        tracks.append(
            DrumlineTrack(
                track=track,
                preset_path=_read_cstring(
                    project.image, start + PRESET_PATH_OFFSET, PRESET_PATH_MAX
                ),
                m2={
                    name: _u32(project.image, start + off)
                    for name, off in M2_OFFSETS.items()
                },
                voices=tuple(_read_voice(project.image, start, v) for v in range(DRUMLINE_VOICE_COUNT)),
            )
        )
    return ProjectDrumline(tracks=tuple(tracks))


def _read_voice(image: bytes | bytearray, track_start: int, voice: int) -> DrumlineVoice:
    rec = track_start + DRUMLINE_RECORD_OFFSET + DRUMLINE_RECORD_SIZE * voice
    model_mode = image[rec + REC_MODEL_MODE]
    return DrumlineVoice(
        voice=voice,
        key=image[rec + REC_KEY],
        model=model_mode & 0x0F,
        play_mode=model_mode >> 4,
        params=tuple(_u32(image, rec + off) for off in REC_PARAMS),  # type: ignore[arg-type]
        random=int.from_bytes(image[rec + REC_RANDOM : rec + REC_RANDOM + 2], "little"),
        volume_db=_signed_byte(image[rec + REC_VOLUME_DB]),
        pan=_signed_byte(image[rec + REC_PAN]),
        sampler_play_mode=image[rec + REC_SAMPLER_PLAY_MODE],
    )


def _u32(image: bytes | bytearray, off: int) -> int:
    return int.from_bytes(image[off : off + 4], "little")


def _signed_byte(value: int) -> int:
    return value if value < 128 else value - 256


def _read_cstring(image: bytes | bytearray, off: int, size: int) -> str:
    raw = bytes(image[off : off + size])
    end = raw.find(0)
    return raw[: end if end >= 0 else size].decode("latin1", errors="replace")
