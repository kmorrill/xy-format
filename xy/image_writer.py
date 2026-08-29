"""Author .xy files by editing the decoded RAM image (the firmware's way).

Strategy (see docs/format/decoded_image_map.md): decode a known-good file
to its RAM image, apply edits exactly as the firmware would (set fields,
splice count-prefixed vector elements, maintain invariants), then
RLE-encode canonically. No scaffolds, no byte transplants, no "event
types" — the legacy type bytes were zero-run extension counts.

Validation standard: byte-exact replication of device-saved corpus files
(see tests/test_image_writer.py).
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field

from xy.rle import decode_project, encode_project

SIG_RE = re.compile(rb"\x00\x00\x00[\x00-\x10]\xff\x00\xfc\x00", re.S)

TRACK_BASE0 = 0x0D79
TRACK_BASE_BY_FIRMWARE = {
    0x0E: 3933,
    0x0F: 3933,
    0x10: 3433,
    0x11: 3433,
    0x13: 3449,
}
TRACK_STRIDE = 17876
TRACK_COUNT = 16
MAX_PATTERNS_PER_TRACK = 16

# track-struct relative offsets (docs/format/decoded_image_map.md)
OFF_PATTERN_STEPS = 0x01
OFF_BARS = OFF_PATTERN_STEPS  # compatibility alias: whole bars are steps/16
OFF_SCALE = 0x06
OFF_QUANTIZATION = 0x07
OFF_TRACK_GROOVE = 0x08
OFF_PRISTINE = 0x11   # u16: 8 = factory, 0 = edited (sticky)
OFF_PLOCK_SHAPE = 0x3056
OFF_NOTE_COUNT = 0x456F
NOTE_SIZE = 12

STEP_TICKS = 480


def track_base_from_header(header: bytes) -> int:
    """Return the decoded Track 1 offset for a known firmware family."""

    if len(header) < 6:
        return TRACK_BASE0
    return TRACK_BASE_BY_FIRMWARE.get(header[5], TRACK_BASE0)


def pattern_starts_from_image(
    image: bytes | bytearray, track_base: int = TRACK_BASE0
) -> list[int]:
    """Return decoded-image starts for every physical pattern struct.

    Track discovery used to key off bytes inside the Bar region. Those bytes
    are legitimate user state, so authored Bar edits can erase the signature.
    The decoded image has a firmware-dependent Track 1 base. Each ordinary
    pattern struct has a fixed base size, and the note vector extends its
    containing pattern by 12 bytes per note.
    """

    starts: list[int] = []
    pos = track_base
    for _ in range(TRACK_COUNT):
        if pos < 0 or pos + TRACK_STRIDE > len(image):
            return []
        pattern_count = image[pos]
        if not 1 <= pattern_count <= MAX_PATTERNS_PER_TRACK:
            pattern_count = 1
        starts.append(pos)
        if pos + OFF_NOTE_COUNT >= len(image):
            return []
        note_count = image[pos + OFF_NOTE_COUNT]
        if note_count > 120:
            return []
        pos += TRACK_STRIDE + note_count * NOTE_SIZE
        for _pattern in range(1, pattern_count):
            clone_start = pos - 1
            if clone_start + OFF_NOTE_COUNT >= len(image):
                return []
            starts.append(clone_start)
            note_count = image[clone_start + OFF_NOTE_COUNT]
            if note_count > 120:
                return []
            pos = clone_start + TRACK_STRIDE + note_count * NOTE_SIZE
    return starts


def leader_starts_from_image(
    image: bytes | bytearray, track_base: int = TRACK_BASE0
) -> list[int]:
    """Return the 16 decoded-image logical track leader starts."""

    leaders: list[int] = []
    pos = track_base
    for _ in range(TRACK_COUNT):
        if pos < 0 or pos + TRACK_STRIDE > len(image):
            return []
        leaders.append(pos)
        pattern_count = image[pos]
        if not 1 <= pattern_count <= MAX_PATTERNS_PER_TRACK:
            pattern_count = 1
        if pos + OFF_NOTE_COUNT >= len(image):
            return []
        note_count = image[pos + OFF_NOTE_COUNT]
        if note_count > 120:
            return []
        pos += TRACK_STRIDE + note_count * NOTE_SIZE
        for _pattern in range(1, pattern_count):
            clone_start = pos - 1
            if clone_start + OFF_NOTE_COUNT >= len(image):
                return []
            note_count = image[clone_start + OFF_NOTE_COUNT]
            if note_count > 120:
                return []
            pos = clone_start + TRACK_STRIDE + note_count * NOTE_SIZE
    return leaders


@dataclass
class ImageProject:
    header: bytes
    image: bytearray
    _starts: list[int] = field(default_factory=list)

    @classmethod
    def from_file(cls, path: str) -> "ImageProject":
        header, image = decode_project(open(path, "rb").read())
        p = cls(header, bytearray(image))
        p._rescan()
        return p

    @classmethod
    def from_bytes(cls, data: bytes) -> "ImageProject":
        header, image = decode_project(data)
        p = cls(header, bytearray(image))
        p._rescan()
        return p

    def _rescan(self) -> None:
        starts = leader_starts_from_image(
            self.image, track_base_from_header(self.header)
        )
        if starts:
            self._starts = starts
            return
        self._starts = [m.start() - 3 for m in SIG_RE.finditer(self.image)]

    def track_start(self, track: int) -> int:
        """1-based track number -> struct base offset (header byte 0)."""
        return self._starts[track - 1]

    def pattern_start(self, track: int, pattern: int = 1) -> int:
        """1-based track/pattern -> physical pattern struct base offset."""
        if not 1 <= track <= TRACK_COUNT:
            raise ValueError("track must be 1..16")
        if not 1 <= pattern <= MAX_PATTERNS_PER_TRACK:
            raise ValueError(f"pattern must be 1..{MAX_PATTERNS_PER_TRACK}")
        starts = pattern_starts_from_image(
            self.image, track_base_from_header(self.header)
        )
        if not starts:
            raise ValueError("could not locate pattern structs")
        index = 0
        for current_track in range(1, TRACK_COUNT + 1):
            if index >= len(starts):
                raise ValueError("pattern struct table ended early")
            leader = starts[index]
            count = self.image[leader]
            if not 1 <= count <= MAX_PATTERNS_PER_TRACK:
                count = 1
            if current_track == track:
                if pattern > count:
                    raise ValueError(f"track {track} only has {count} pattern(s)")
                return starts[index + pattern - 1]
            index += count
        raise ValueError("track must be 1..16")

    # --- field edits -----------------------------------------------------
    def mark_edited(self, track: int) -> None:
        s = self.track_start(track)
        self.image[s + OFF_PRISTINE : s + OFF_PRISTINE + 2] = b"\x00\x00"

    def mark_pattern_edited(self, track: int, pattern: int = 1) -> None:
        s = self.pattern_start(track, pattern)
        self.image[s + OFF_PRISTINE : s + OFF_PRISTINE + 2] = b"\x00\x00"

    def set_pattern_steps(self, track: int, steps: int) -> None:
        """Set the played pattern length in sequencer steps (1..64).

        Device captures validate both whole-bar values 16/32/48/64 and
        final-bar partial lengths: ``steps = (bar_count - 1) * 16 + last_bar``.
        """
        if not 1 <= steps <= 64:
            raise ValueError("pattern length must be 1..64 steps")
        s = self.track_start(track)
        self.image[s + OFF_PATTERN_STEPS] = steps & 0xFF
        self.mark_edited(track)

    def set_bars(self, track: int, bars: int) -> None:
        if not 1 <= bars <= 4:
            raise ValueError("bar count must be 1..4")
        self.set_pattern_steps(track, bars * 16)

    def set_default_step_length_ticks(self, track: int, ticks: int) -> None:
        if not 0 <= ticks <= STEP_TICKS:
            raise ValueError("default step length must be 0..480 ticks")
        s = self.track_start(track)
        self.image[s + OFF_PATTERN_STEPS + 1 : s + OFF_PATTERN_STEPS + 3] = (
            ticks.to_bytes(2, "little")
        )
        self.mark_edited(track)

    def set_track_quantization_raw(self, track: int, raw: int) -> None:
        if not 0 <= raw <= 0xFF:
            raise ValueError("quantization raw value must be 0..255")
        s = self.track_start(track)
        self.image[s + OFF_QUANTIZATION] = raw
        self.mark_edited(track)

    def set_track_quantization_ui(self, track: int, ui_value: int) -> None:
        from .bar_menu_inspection import encode_track_quantization_ui

        self.set_track_quantization_raw(track, encode_track_quantization_ui(ui_value))

    def set_track_groove_raw(self, track: int, raw: int) -> None:
        if not 0 <= raw <= 0xFF:
            raise ValueError("track groove raw value must be 0..255")
        s = self.track_start(track)
        self.image[s + OFF_TRACK_GROOVE] = raw
        self.mark_edited(track)

    def set_track_groove_ui(self, track: int, ui_value: int) -> None:
        from .bar_menu_inspection import encode_track_groove_ui

        self.set_track_groove_raw(track, encode_track_groove_ui(ui_value))

    def set_plock_shape_raw(self, track: int, raw: int) -> None:
        if not 0 <= raw <= 0xFF:
            raise ValueError("p-lock shape raw value must be 0..255")
        s = self.track_start(track)
        self.image[s + OFF_PLOCK_SHAPE] = raw

    # --- note vector -----------------------------------------------------
    def note_count(self, track: int) -> int:
        return self.image[self.track_start(track) + OFF_NOTE_COUNT]

    def add_note(
        self,
        track: int,
        *,
        step: int | None = None,
        tick: int | None = None,
        note: int,
        velocity: int = 100,
        gate: int = 240,
    ) -> None:
        """Append a note record (firmware order: ascending tick, appended
        after existing records). ``step`` is 1-based grid position."""
        if tick is None:
            if step is None:
                raise ValueError("need step or tick")
            tick = (step - 1) * STEP_TICKS
        s = self.track_start(track)
        cpos = s + OFF_NOTE_COUNT
        count = self.image[cpos]
        if count >= 120:
            raise ValueError("pattern note limit reached")
        rec = (
            tick.to_bytes(4, "little", signed=True)
            + gate.to_bytes(4, "little")
            + bytes([note & 0x7F, velocity & 0x7F, 0, 0])
        )
        insert_at = cpos + 1 + count * NOTE_SIZE
        self.image[cpos] = count + 1
        self.image[insert_at:insert_at] = rec
        self.mark_edited(track)
        self._rescan()

    # --- global project settings (decoded_image_map.md §Global Header) ----
    GLOBAL_TEMPO = 0x00     # u16 LE, tenths of BPM
    GLOBAL_GROOVE_AMOUNT = 0x02  # signed i8 groove amount
    GLOBAL_GROOVE = 0x03    # u8 groove type
    GLOBAL_CLICK = 0x04     # u8 metronome/click volume
    GLOBAL_ACTIVE_SCENE = 0x06  # zero-based active scene slot
    GLOBAL_ACTIVE_SONG = 0x07  # zero-based song slot; 0x10 is fresh Song 1 sentinel
    GLOBAL_SCENE_LENGTH = 0x08  # u8: 0=longest, 1=shortest, 2=time signature
    GLOBAL_TRANSPOSE = 0x1B  # signed i8, semitones -24..+24
    GLOBAL_TIME_SIGNATURE = 0x1C  # u8 enum, 0x11=4/4
    GLOBAL_VOICES = 0x4D  # per-track voice allocation T1..T8, 0=auto
    GLOBAL_MIDI = 0x55      # per-track channel array (T1=0x55 .. T16=0x64)
    GLOBAL_EQ = (0x68, 0x6C, 0x70)  # master EQ low/mid/high, u32 each (default 0x40)
    GLOBAL_MASTER_PERC = 0x85
    GLOBAL_MASTER_MELODY = 0x89
    GLOBAL_MASTER_COMP = 0x8D
    GLOBAL_MASTER_VOL = 0x91
    GLOBAL_SAT_GAIN = 0x75
    GLOBAL_SAT_CLIP = 0x79
    GLOBAL_SAT_TONE = 0x7D
    GLOBAL_SAT_MIX = 0x81
    SONG_SLOT_COUNT = 14
    SONG_MAX_CHAIN = 96

    @staticmethod
    def _u32(value: int, *, where: str = "value") -> bytes:
        if not isinstance(value, int) or isinstance(value, bool):
            raise TypeError(f"{where} must be an integer")
        if not 0 <= value <= 0xFFFFFFFF:
            raise ValueError(f"{where} must be a u32")
        return value.to_bytes(4, "little")

    def set_tempo(self, bpm: float) -> None:
        v = round(bpm * 10)
        self.image[self.GLOBAL_TEMPO : self.GLOBAL_TEMPO + 2] = v.to_bytes(2, "little")

    def set_groove(self, groove_type: int) -> None:
        self.image[self.GLOBAL_GROOVE] = groove_type & 0xFF

    def set_groove_amount(self, amount: int) -> None:
        from .project_config_inspection import encode_groove_amount

        self.image[self.GLOBAL_GROOVE_AMOUNT] = encode_groove_amount(amount)

    def set_click_volume(self, volume: int) -> None:
        self.image[self.GLOBAL_CLICK] = volume & 0xFF

    def set_active_scene(self, scene: int) -> None:
        if not 1 <= scene <= 99:
            raise ValueError("active scene must be 1..99")
        self.image[self.GLOBAL_ACTIVE_SCENE] = scene - 1

    def set_active_song(self, song: int) -> None:
        if not 1 <= song <= 14:
            raise ValueError("active song must be 1..14")
        self.image[self.GLOBAL_ACTIVE_SONG] = song - 1

    def _footer_start(self) -> int:
        patterns = pattern_starts_from_image(
            self.image, track_base_from_header(self.header)
        )
        if not patterns:
            raise ValueError("could not locate song footer after Track 16")
        last = patterns[-1]
        return last + TRACK_STRIDE + self.image[last + OFF_NOTE_COUNT] * NOTE_SIZE

    def _song_slot_length_at(self, offset: int) -> int:
        if not 0 <= offset < len(self.image):
            raise ValueError("song footer ends before the requested slot")
        count = self.image[offset]
        length = 1 + count + 2
        if count > self.SONG_MAX_CHAIN or offset + length > len(self.image):
            raise ValueError("song footer slot is not structurally valid")
        return length

    def _song_slot_offset(self, song: int) -> int:
        if not 1 <= song <= self.SONG_SLOT_COUNT:
            raise ValueError(f"song must be 1..{self.SONG_SLOT_COUNT}")
        offset = self._footer_start()
        for _ in range(1, song):
            offset += self._song_slot_length_at(offset)
        self._song_slot_length_at(offset)
        return offset

    def get_song_chain(self, song: int = 1) -> tuple[list[int], bool]:
        """Return a 0-based scene chain and loop state for one song slot."""
        offset = self._song_slot_offset(song)
        count = self.image[offset]
        chain = list(self.image[offset + 1 : offset + 1 + count])
        return chain, self.image[offset + 1 + count] == 0

    def set_song_chain(
        self, song: int, scene_chain: list[int], *, loop: bool = True
    ) -> None:
        """Rewrite any of the 14 variable-length song footer slots."""
        if len(scene_chain) > self.SONG_MAX_CHAIN:
            raise ValueError(
                f"OP-XY songs support at most {self.SONG_MAX_CHAIN} scenes"
            )
        if any(not 0 <= scene < 99 for scene in scene_chain):
            raise ValueError("song scene ids must be 0..98")
        offset = self._song_slot_offset(song)
        old_length = self._song_slot_length_at(offset)
        slot = bytes([len(scene_chain), *scene_chain, 0 if loop else 1, 0])
        self.image[offset : offset + old_length] = slot
        self._rescan()

    def set_scene_length_mode(self, mode: int) -> None:
        if mode not in (0, 1, 2):
            raise ValueError("scene length mode must be 0=longest, 1=shortest, 2=time signature")
        self.image[self.GLOBAL_SCENE_LENGTH] = mode

    def set_project_transpose(self, semitones: int) -> None:
        from .project_config_inspection import encode_transpose

        self.image[self.GLOBAL_TRANSPOSE] = encode_transpose(semitones)

    def set_time_signature(self, raw: int) -> None:
        if raw not in range(0x10, 0x16):
            raise ValueError("time signature raw enum must be 0x10..0x15")
        self.image[self.GLOBAL_TIME_SIGNATURE] = raw

    def set_voice_allocation(self, track: int, voices: int | None) -> None:
        from .project_config_inspection import encode_voice_allocation

        if not 1 <= track <= 8:
            raise ValueError("voice allocation track must be 1..8")
        self.image[self.GLOBAL_VOICES + track - 1] = encode_voice_allocation(voices)

    def set_midi_channel(self, track: int, channel: int | None) -> None:
        """channel 1..16, or None = off (0xFF)."""
        self.image[self.GLOBAL_MIDI + track - 1] = 0xFF if channel is None else (channel - 1) & 0xFF

    def set_master_eq(self, low: int | None = None, mid: int | None = None, high: int | None = None) -> None:
        for off, val in zip(self.GLOBAL_EQ, (low, mid, high)):
            if val is not None:
                self.image[off : off + 4] = self._u32(val, where="master EQ value")

    @staticmethod
    def _encode_mix_u32_from_byte(byte: int, *, min_u32: int = 0) -> int:
        if not 0 <= byte <= 0x7F:
            raise ValueError("mix byte must be in 0..0x7F")
        if byte == 0:
            return min_u32
        if byte == 0x7F:
            return 0x7FFFFFFF
        return byte << 24

    def _set_global_u32(self, offset: int, value: int) -> None:
        if not 0 <= value <= 0xFFFFFFFF:
            raise ValueError("u32 value must be in 0..0xFFFFFFFF")
        self.image[offset : offset + 4] = value.to_bytes(4, "little")

    def _set_track_u32(self, track: int, offset: int, value: int) -> None:
        if not 0 <= value <= 0xFFFFFFFF:
            raise ValueError("u32 value must be in 0..0xFFFFFFFF")
        s = self.track_start(track)
        self.image[s + offset : s + offset + 4] = value.to_bytes(4, "little")
        self.mark_edited(track)

    def set_track_volume_raw(self, track: int, value: int) -> None:
        self._set_track_u32(track, 0x38FB, value)

    def set_track_pan_raw(self, track: int, value: int) -> None:
        self._set_track_u32(track, 0x38F7, value)

    def set_track_send_fx1_raw(self, track: int, value: int) -> None:
        self._set_track_u32(track, 0x38AF, value)

    def set_track_send_fx2_raw(self, track: int, value: int) -> None:
        self._set_track_u32(track, 0x38B3, value)

    def set_track_send_ext_raw(self, track: int, value: int) -> None:
        """Set source-track send to T13 External Audio aux output."""
        self._set_track_u32(track, 0x38A7, value)

    def set_track_send_tape_raw(self, track: int, value: int) -> None:
        """Set source-track send to T14 Tape."""
        self._set_track_u32(track, 0x38AB, value)

    def set_track_volume_byte(self, track: int, byte: int) -> None:
        self.set_track_volume_raw(track, self._encode_mix_u32_from_byte(byte))

    def set_track_pan_byte(self, track: int, byte: int) -> None:
        self.set_track_pan_raw(track, self._encode_mix_u32_from_byte(byte))

    def set_track_send_fx1_byte(self, track: int, byte: int) -> None:
        self.set_track_send_fx1_raw(track, self._encode_mix_u32_from_byte(byte))

    def set_track_send_fx2_byte(self, track: int, byte: int) -> None:
        self.set_track_send_fx2_raw(track, self._encode_mix_u32_from_byte(byte))

    def set_track_send_ext_byte(self, track: int, byte: int) -> None:
        self.set_track_send_ext_raw(track, self._encode_mix_u32_from_byte(byte))

    def set_track_send_tape_byte(self, track: int, byte: int) -> None:
        self.set_track_send_tape_raw(track, self._encode_mix_u32_from_byte(byte))

    def set_master_percussion_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_MASTER_PERC, value)

    def set_master_melody_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_MASTER_MELODY, value)

    def set_master_compressor_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_MASTER_COMP, value)

    def set_master_volume_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_MASTER_VOL, value)

    def set_master_percussion_byte(self, byte: int) -> None:
        self.set_master_percussion_raw(self._encode_mix_u32_from_byte(byte, min_u32=0x00A3D70A))

    def set_master_melody_byte(self, byte: int) -> None:
        self.set_master_melody_raw(self._encode_mix_u32_from_byte(byte, min_u32=0x00A3D70A))

    def set_master_compressor_byte(self, byte: int) -> None:
        self.set_master_compressor_raw(self._encode_mix_u32_from_byte(byte, min_u32=0x00A3D70A))

    def set_master_volume_byte(self, byte: int) -> None:
        self.set_master_volume_raw(self._encode_mix_u32_from_byte(byte, min_u32=0x00A3D70A))

    def set_master_saturator_gain_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_SAT_GAIN, value)

    def set_master_saturator_clip_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_SAT_CLIP, value)

    def set_master_saturator_tone_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_SAT_TONE, value)

    def set_master_saturator_mix_raw(self, value: int) -> None:
        self._set_global_u32(self.GLOBAL_SAT_MIX, value)

    def set_master_saturator_gain_byte(self, byte: int) -> None:
        self.set_master_saturator_gain_raw(self._encode_mix_u32_from_byte(byte))

    def set_master_saturator_clip_byte(self, byte: int) -> None:
        self.set_master_saturator_clip_raw(self._encode_mix_u32_from_byte(byte))

    def set_master_saturator_tone_byte(self, byte: int) -> None:
        self.set_master_saturator_tone_raw(self._encode_mix_u32_from_byte(byte))

    def set_master_saturator_mix_byte(self, byte: int) -> None:
        self.set_master_saturator_mix_raw(self._encode_mix_u32_from_byte(byte))

    # --- per-track sound / engine (track-relative offsets) ----------------
    TRK_SCALE = 0x06
    TRK_ENGINE = 0x14
    TRK_LFO_TYPE = 0x1C
    TRK_M4_PAGE = 0x20
    TRK_LFO_ON = TRK_M4_PAGE
    TRK_FILTER_TYPE = 0x21
    TRK_FILTER_ON = 0x25
    TRK_PARAMS = 0x3857     # 8 engine params, u32 each
    TRK_AMP_ENV = {
        "attack": 0x3877,
        "decay": 0x387B,
        "sustain": 0x387F,
        "release": 0x3883,
    }
    TRK_M2_SHIFT = {
        "play_mode": 0x3887,          # CC28 current lane
        "portamento": 0x388B,         # CC29 current lane
        "pitch_bend_range": 0x388F,   # CC30 current lane
        "engine_volume": 0x3893,      # CC31 current lane
    }
    TRK_FX_PARAMS = (0x3897, 0x389B, 0x389F, 0x38A3, 0x38A7, 0x38AB, 0x38AF, 0x38B3)
    TRK_LFO_PARAMS = (0x38B7, 0x38BB, 0x38BF, 0x38C3, 0x38C7, 0x38CB, 0x38CF, 0x38D3)
    TRK_SENDS = {
        "ext": 0x38A7,    # CC36 current lane
        "tape": 0x38AB,   # CC37 current lane; inferred by lane order
        "fx1": 0x38AF,    # CC38 current lane
        "fx2": 0x38B3,    # CC39 current lane
    }
    TRK_FILTER_KNOBS = {
        "cutoff": 0x3897,
        "resonance": 0x389B,
        "env_amount": 0x389F,
        "key_tracking": 0x38A3,
    }
    TRK_LFO_CURRENT = {
        "cc40": 0x38B7,
        "cc41": 0x38BB,
    }
    TRK_FILTER_ENV = {
        "attack": 0x38D7,
        "decay": 0x38DB,
        "sustain": 0x38DF,
        "release": 0x38E3,
    }
    TRK_MODULATION = {
        "modwheel_target": 0x38FF,
        "modwheel_amount": 0x3903,
        "aftertouch_target": 0x3907,
        "aftertouch_amount": 0x390B,
        "pitchbend_target": 0x390F,
        "pitchbend_amount": 0x3913,
        "velocity_sensitivity": 0x3917,
        "portamento_type": 0x391B,
        "tuning_scale": 0x391F,
        "width": 0x3923,
        "tuning_root": 0x392B,
        "highpass": 0x392F,
        "velocity_target": 0x3933,
        "velocity_amount": 0x3937,
    }
    TRK_MIX = {
        "pan": 0x38F7,     # CC10 current lane
        "volume": 0x38FB,  # CC7 current lane
    }
    TRK_MIDI_CC_TABLE = 0x3877
    TRK_AUX_FILTER = 0x3897
    TRK_AUX_LFO = 0x38B7
    TRK_STEPCOMP = 0x3057   # 16 B per step
    TRK_PLOCK = 0x2A0       # 84 B per step row, u16 cells
    # encoded track-scale byte (0x01=½× .. 0x0E=16×); pass raw for others.
    SCALE_BYTES = {0.5: 0x01, 1: 0x03, 2: 0x05, 16: 0x0E}
    EXTERNAL_AUDIO_SOURCES = {
        "mic": 0x00000000,
        "headset": 0x1FFFFFFE,
        "hp": 0x1FFFFFFE,
        "line": 0x46666662,
        "usb-c": 0x5FFFFFFA,
        "usbc": 0x5FFFFFFA,
        "main": 0x79999992,
    }
    FX_TYPES = {
        "delay": 0x00,
        "reverb": 0x05,
        "chorus": 0x0C,
        "phaser": 0x0D,
        "distortion": 0x0E,
        "lofi": 0x0F,
    }
    AUX_LFO_DEST_GENERIC = {
        "syn": 0x00000000,
        "filter": 0x4AAAAAA9,
        "amp": 0x75555553,
    }
    AUX_LFO_DEST_T11 = {
        "off": 0x00000000,
        "cc1": 0x3AAAAAA7,
        "cc2": 0x7AAAAAA3,
    }
    AUX_LFO_PARAM_DEST = {
        1: 0x07FFFFFF,
        2: 0x27FFFFFD,
        3: 0x47FFFFFB,
        4: 0x77FFFFF8,
    }

    STEP_COMPONENTS = {
        "pulse": 0, "hold": 1, "multiply": 2, "velocity": 3, "ramp_up": 4,
        "ramp_down": 5, "random": 6, "portamento": 7, "bend": 8, "tonality": 9,
        "jump": 10, "param": 11, "conditional_a": 12, "conditional_b": 13,
    }
    # p-lock param -> byte offset within the 84-byte row (= 2 * column).
    PLOCK_PARAMS = {
        "volume": 0, "param1": 2, "param2": 4, "param3": 6, "param4": 8,
        "amp_attack": 18, "amp_decay": 20, "amp_sustain": 22, "amp_release": 24,
        "poly": 26, "portamento": 28, "pitch_bend": 30, "engine_volume": 32,
        "cutoff": 34, "resonance": 36, "filter_env_amount": 38, "key_tracking": 40,
        "send_ext": 42, "send_tape": 44, "send_fx1": 46, "send_fx2": 48,
        "lfo_param": 50, "lfo_dest": 52,
        "filter_env_attack": 66, "filter_env_decay": 68,
        "filter_env_sustain": 70, "filter_env_release": 72, "pan": 82,
    }

    def set_track_scale(self, track: int, scale) -> None:
        """scale: 0.5/1/2/16 (known) or a raw encoded byte."""
        b = self.SCALE_BYTES.get(scale, scale)
        self.image[self.track_start(track) + self.TRK_SCALE] = b & 0xFF
        self.mark_edited(track)

    def set_engine(self, track: int, engine_id: int, *, pattern: int = 1) -> None:
        s = self.pattern_start(track, pattern)
        self.image[s + self.TRK_ENGINE] = engine_id & 0xFF
        self.mark_pattern_edited(track, pattern)

    @staticmethod
    def _q16(value: int) -> int:
        if not isinstance(value, int) or isinstance(value, bool):
            raise TypeError("q16 value must be an integer")
        if not 0 <= value <= 0x7FFF:
            raise ValueError("q16 value must be in 0..0x7FFF")
        return value << 16

    def set_engine_param(self, track: int, index: int, value: int, *, pattern: int = 1) -> None:
        """index 1..8; value is the device's internal (fixed-point) u32."""
        if not 1 <= index <= 8:
            raise ValueError("engine param index must be 1..8")
        o = self.pattern_start(track, pattern) + self.TRK_PARAMS + (index - 1) * 4
        self.image[o : o + 4] = self._u32(value, where=f"track {track} engine param {index}")
        self.mark_pattern_edited(track, pattern)

    def set_engine_param_q16(
        self,
        track: int,
        index: int,
        value: int,
        *,
        pattern: int = 1,
    ) -> None:
        """Set a patch.json-style q16 engine param value (0..0x7FFF)."""
        self.set_engine_param(track, index, self._q16(value), pattern=pattern)

    def set_engine_params(
        self,
        track: int,
        *,
        param1: int | None = None,
        param2: int | None = None,
        param3: int | None = None,
        param4: int | None = None,
        param5: int | None = None,
        param6: int | None = None,
        param7: int | None = None,
        param8: int | None = None,
        pattern: int = 1,
    ) -> None:
        for index, value in enumerate(
            (param1, param2, param3, param4, param5, param6, param7, param8),
            start=1,
        ):
            if value is not None:
                self.set_engine_param(track, index, value, pattern=pattern)

    def _write_track_u32(
        self,
        track: int,
        offset: int,
        value: int,
        *,
        where: str,
        pattern: int = 1,
    ) -> None:
        o = self.pattern_start(track, pattern) + offset
        self.image[o : o + 4] = self._u32(value, where=where)
        self.mark_pattern_edited(track, pattern)

    def set_m2_shift(
        self,
        track: int,
        *,
        play_mode: int | None = None,
        portamento: int | None = None,
        pitch_bend_range: int | None = None,
        engine_volume: int | None = None,
        pattern: int = 1,
    ) -> None:
        """Set M2 shift/current lanes.

        Values are raw device u32 lanes. Captures pin these as CC28-31:
        play/poly mode, portamento, pitch-bend range, and preset/engine
        volume. Exact UI enum scaling for play/bend is still being decoded.
        """
        values = {
            "play_mode": play_mode,
            "portamento": portamento,
            "pitch_bend_range": pitch_bend_range,
            "engine_volume": engine_volume,
        }
        for name, value in values.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_M2_SHIFT[name],
                    value,
                    where=f"track {track} M2 {name}",
                    pattern=pattern,
                )

    def set_amp_envelope(
        self,
        track: int,
        *,
        attack: int | None = None,
        decay: int | None = None,
        sustain: int | None = None,
        release: int | None = None,
        pattern: int = 1,
    ) -> None:
        """Set M2 amp envelope ADSR current lanes."""
        for name, value in {
            "attack": attack,
            "decay": decay,
            "sustain": sustain,
            "release": release,
        }.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_AMP_ENV[name],
                    value,
                    where=f"track {track} amp envelope {name}",
                    pattern=pattern,
                )

    def set_filter_knobs(
        self,
        track: int,
        *,
        cutoff: int | None = None,
        resonance: int | None = None,
        env_amount: int | None = None,
        key_tracking: int | None = None,
    ) -> None:
        """Set M3 filter knob current lanes."""
        for name, value in {
            "cutoff": cutoff,
            "resonance": resonance,
            "env_amount": env_amount,
            "key_tracking": key_tracking,
        }.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_FILTER_KNOBS[name],
                    value,
                    where=f"track {track} filter {name}",
                )

    def set_sends(
        self,
        track: int,
        *,
        ext: int | None = None,
        tape: int | None = None,
        fx1: int | None = None,
        fx2: int | None = None,
    ) -> None:
        """Set static/current send levels for ext, tape, FX I, and FX II."""
        for name, value in {"ext": ext, "tape": tape, "fx1": fx1, "fx2": fx2}.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_SENDS[name],
                    value,
                    where=f"track {track} send {name}",
                )

    def set_lfo_current(
        self,
        track: int,
        *,
        cc40: int | None = None,
        cc41: int | None = None,
    ) -> None:
        """Set the two pinned M4/LFO current-value lanes.

        The CC-map capture labels these as CC40/CC41; their UI labels depend
        on track/LFO type, so the writer keeps the neutral CC lane names.
        """
        for name, value in {"cc40": cc40, "cc41": cc41}.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_LFO_CURRENT[name],
                    value,
                    where=f"track {track} LFO current {name}",
                )

    def set_filter_envelope(
        self,
        track: int,
        *,
        attack: int | None = None,
        decay: int | None = None,
        sustain: int | None = None,
        release: int | None = None,
        pattern: int = 1,
    ) -> None:
        """Set filter envelope ADSR current lanes."""
        for name, value in {
            "attack": attack,
            "decay": decay,
            "sustain": sustain,
            "release": release,
        }.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_FILTER_ENV[name],
                    value,
                    where=f"track {track} filter envelope {name}",
                    pattern=pattern,
                )

    def set_fx_state(
        self,
        track: int,
        *,
        type: int | None = None,
        active: bool | None = None,
        params: list[int] | tuple[int, ...] | None = None,
        pattern: int = 1,
    ) -> None:
        """Set preset-local FX header and q16 params confirmed by the corpus."""
        if type is not None or active is not None:
            self.set_filter(track, type=type, enabled=active, pattern=pattern)
        if params is not None:
            if len(params) > len(self.TRK_FX_PARAMS):
                raise ValueError("FX params must contain at most 8 values")
            for index, value in enumerate(params):
                raw = 0x7FFFFFFF if index == 5 else self._q16(value)
                self._write_track_u32(
                    track,
                    self.TRK_FX_PARAMS[index],
                    raw,
                    where=f"track {track} FX param {index + 1}",
                    pattern=pattern,
                )

    def set_lfo_state(
        self,
        track: int,
        *,
        type: int | None = None,
        active: bool | None = None,
        params: list[int] | tuple[int, ...] | None = None,
        pattern: int = 1,
    ) -> None:
        """Set preset-local LFO header and q16 params confirmed by the corpus."""
        s = self.pattern_start(track, pattern)
        if type is not None:
            self.image[s + self.TRK_LFO_TYPE] = type & 0xFF
        if active is not None:
            self.image[s + self.TRK_LFO_ON] = 1 if active else 0
        if type is not None or active is not None:
            self.mark_pattern_edited(track, pattern)
        if params is not None:
            if len(params) > len(self.TRK_LFO_PARAMS):
                raise ValueError("LFO params must contain at most 8 values")
            for index, value in enumerate(params):
                self._write_track_u32(
                    track,
                    self.TRK_LFO_PARAMS[index],
                    self._q16(value),
                    where=f"track {track} LFO param {index + 1}",
                    pattern=pattern,
                )

    def set_patch_modulation_state(
        self,
        track: int,
        *,
        modwheel_target: int | None = None,
        modwheel_amount: int | None = None,
        aftertouch_target: int | None = None,
        aftertouch_amount: int | None = None,
        pitchbend_target: int | None = None,
        pitchbend_amount: int | None = None,
        velocity_sensitivity: int | None = None,
        portamento_type: int | None = None,
        tuning_scale: int | None = None,
        width: int | None = None,
        tuning_root: int | None = None,
        highpass: int | None = None,
        velocity_target: int | None = None,
        velocity_amount: int | None = None,
        pattern: int = 1,
    ) -> None:
        """Set confirmed patch.json q16 modulation/settings lanes."""
        values = {
            "modwheel_target": modwheel_target,
            "modwheel_amount": modwheel_amount,
            "aftertouch_target": aftertouch_target,
            "aftertouch_amount": aftertouch_amount,
            "pitchbend_target": pitchbend_target,
            "pitchbend_amount": pitchbend_amount,
            "velocity_sensitivity": velocity_sensitivity,
            "portamento_type": portamento_type,
            "tuning_scale": tuning_scale,
            "width": width,
            "tuning_root": tuning_root,
            "highpass": highpass,
            "velocity_target": velocity_target,
            "velocity_amount": velocity_amount,
        }
        for name, value in values.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_MODULATION[name],
                    self._q16(value),
                    where=f"track {track} patch {name}",
                    pattern=pattern,
                )

    def set_track_mix(
        self,
        track: int,
        *,
        pan: int | None = None,
        volume: int | None = None,
    ) -> None:
        """Set static/current mixer pan and volume lanes."""
        for name, value in {"pan": pan, "volume": volume}.items():
            if value is not None:
                self._write_track_u32(
                    track,
                    self.TRK_MIX[name],
                    value,
                    where=f"track {track} mix {name}",
                )

    def set_brain_route_mask(self, mask: int) -> None:
        """Set T9 Brain route mask (`bit0=T1` … `bit7=T8`)."""
        if not 0 <= mask <= 0xFF:
            raise ValueError("Brain route mask must be u8")
        self.image[self.track_start(9) + 0x09] = mask
        self.mark_edited(9)

    def set_brain_routes(self, tracks: list[int] | tuple[int, ...] | set[int]) -> None:
        """Set T9 Brain routed instrument tracks from 1-based T1..T8 numbers."""
        mask = 0
        for track in tracks:
            if not 1 <= track <= 8:
                raise ValueError("Brain routes must be instrument tracks 1..8")
            mask |= 1 << (track - 1)
        self.set_brain_route_mask(mask)

    def set_external_midi_m1_raw(
        self,
        *,
        channel: int | None = None,
        bank: int | None = None,
        program: int | None = None,
    ) -> None:
        """Set confirmed T11 M1 raw words. Bucket boundaries are not implied."""
        if channel is not None:
            self.set_engine_param(11, 1, channel)
        if bank is not None:
            self.set_engine_param(11, 2, bank)
        if program is not None:
            self.set_engine_param(11, 3, program)

    def set_external_midi_cc_word(self, slot: int, value: int) -> None:
        """Set one raw T11 CC-table word (slot 1..8).

        The table location is confirmed; exact number/message/on-state ownership
        is still partial, so this stays a raw-word API.
        """
        if not 1 <= slot <= 8:
            raise ValueError("External MIDI CC slot must be 1..8")
        self._set_track_u32(11, self.TRK_MIDI_CC_TABLE + (slot - 1) * 4, value)

    def set_external_audio_m1_raw(
        self,
        *,
        source: int | None = None,
        drive: int | None = None,
        level: int | None = None,
        mix: int | None = None,
    ) -> None:
        """Set confirmed T13 External Audio M1 raw words."""
        if source is not None:
            self.set_engine_param(13, 1, source)
        if drive is not None:
            self.set_engine_param(13, 2, drive)
        if mix is not None:
            self.set_engine_param(13, 4, mix)
        if level is not None:
            self.set_track_volume_raw(13, level)

    def set_external_audio_source(self, source: str) -> None:
        """Set T13 input source from captured labels: mic/headset/line/usb-c/main."""
        try:
            raw = self.EXTERNAL_AUDIO_SOURCES[source.lower()]
        except KeyError as exc:
            valid = ", ".join(sorted(self.EXTERNAL_AUDIO_SOURCES))
            raise ValueError(f"unknown external-audio source {source!r}; expected one of {valid}") from exc
        self.set_external_audio_m1_raw(source=raw)

    def set_tape_m1_raw(
        self,
        *,
        pitch: int | None = None,
        speed: int | None = None,
        length: int | None = None,
        mix: int | None = None,
    ) -> None:
        """Set confirmed T14 Tape M1 raw words."""
        for index, value in enumerate((pitch, speed, length, mix), start=1):
            if value is not None:
                self.set_engine_param(14, index, value)

    def set_aux_filter_raw(
        self,
        track: int,
        *,
        hpf: int | None = None,
        param2: int | None = None,
        param3: int | None = None,
        lpf: int | None = None,
        enable: bool = True,
    ) -> None:
        """Set shared aux M3 filter raw words on T13-T16."""
        if track not in range(13, 17):
            raise ValueError("aux filter is confirmed for tracks 13..16")
        for index, value in enumerate((hpf, param2, param3, lpf)):
            if value is not None:
                self._set_track_u32(track, self.TRK_AUX_FILTER + index * 4, value)
        if enable:
            self.image[self.track_start(track) + self.TRK_FILTER_ON] = 1
            self.mark_edited(track)

    def set_aux_lfo_raw(
        self,
        track: int,
        *,
        speed: int | None = None,
        amount: int | None = None,
        destination: int | None = None,
        param_dest: int | None = None,
        enable: bool = True,
    ) -> None:
        """Set shared aux M4 LFO raw words on T9-T16.

        Device-authored detents are known for T13 generic destinations and T11
        MIDI destinations; bucket boundaries are deliberately not encoded here.
        """
        if track not in range(9, 17):
            raise ValueError("aux LFO is confirmed for tracks 9..16")
        for index, value in enumerate((speed, amount, destination, param_dest)):
            if value is not None:
                self._set_track_u32(track, self.TRK_AUX_LFO + index * 4, value)
        if enable:
            self.image[self.track_start(track) + self.TRK_M4_PAGE] = 1
            self.mark_edited(track)

    def set_aux_lfo_destination(self, track: int, destination: str) -> None:
        """Set the captured aux LFO destination label for T11 or generic aux tracks."""
        key = destination.lower()
        table = self.AUX_LFO_DEST_T11 if track == 11 else self.AUX_LFO_DEST_GENERIC
        try:
            raw = table[key]
        except KeyError as exc:
            valid = ", ".join(sorted(table))
            raise ValueError(f"unknown aux LFO destination {destination!r}; expected one of {valid}") from exc
        self.set_aux_lfo_raw(track, destination=raw)

    def set_aux_lfo_param_dest(self, track: int, param: int) -> None:
        """Set captured aux LFO parameter target 1..4."""
        try:
            raw = self.AUX_LFO_PARAM_DEST[param]
        except KeyError as exc:
            raise ValueError("aux LFO param target must be 1..4") from exc
        self.set_aux_lfo_raw(track, param_dest=raw)

    def set_fx_type(self, track: int, type_byte: int) -> None:
        """Set T15/T16 FX engine type byte."""
        if track not in (15, 16):
            raise ValueError("FX type setter is confirmed for tracks 15 and 16")
        self.set_engine(track, type_byte)

    def set_fx_type_name(self, track: int, name: str) -> None:
        """Set T15/T16 FX type from captured labels."""
        try:
            type_byte = self.FX_TYPES[name.lower()]
        except KeyError as exc:
            valid = ", ".join(sorted(self.FX_TYPES))
            raise ValueError(f"unknown FX type {name!r}; expected one of {valid}") from exc
        self.set_fx_type(track, type_byte)

    def set_filter(
        self,
        track: int,
        *,
        type: int | None = None,
        enabled: bool | None = None,
        pattern: int = 1,
    ) -> None:
        s = self.pattern_start(track, pattern)
        if type is not None:
            self.image[s + self.TRK_FILTER_TYPE] = type & 0xFF
        if enabled is not None:
            self.image[s + self.TRK_FILTER_ON] = 1 if enabled else 0
        self.mark_pattern_edited(track, pattern)

    def set_track_block(self, track: int, offset: int, data: bytes) -> None:
        """Generic in-place block write (envelopes/filter/mod-routing blocks
        at known offsets, see decoded_image_map.md). Length-preserving."""
        s = self.track_start(track) + offset
        self.image[s : s + len(data)] = data
        self.mark_edited(track)

    def set_step_component(self, track: int, step: int, component: str, value: int) -> None:
        """Enable a step component (1-based step) and set its value byte."""
        bit = self.STEP_COMPONENTS[component]
        s = self.track_start(track) + self.TRK_STEPCOMP + (step - 1) * 16
        mask = int.from_bytes(self.image[s : s + 2], "little") | (1 << bit)
        self.image[s : s + 2] = mask.to_bytes(2, "little")
        self.image[s + 2 + bit] = value & 0xFF
        self.mark_edited(track)

    def clear_step_components(self, track: int, step: int) -> None:
        s = self.track_start(track) + self.TRK_STEPCOMP + (step - 1) * 16
        self.image[s : s + 16] = b"\x00" * 16
        self.mark_edited(track)

    # Automation requires more than the value cell: the firmware reads a
    # per-step "this step has automation" flag (GLOBAL per step, not per
    # param — confirmed across unnamed 35 param1 and plock_drum_t2 param2)
    # and a per-track master flag, or the value lane is inert.
    PLOCK_STEP_FLAG = 0x2C4E   # +8*(step-1), value 0x01
    PLOCK_MASTER = 0x304E      # 0x01 once per automated track

    def set_plock(self, track: int, step: int, param: str, value: int) -> None:
        """Lock `param` to `value` (u16) on `step` (1-based). Also arms the
        per-step + master automation flags so the lock actually plays."""
        s = self.track_start(track)
        off = self.PLOCK_PARAMS[param]
        cell = s + self.TRK_PLOCK + (step - 1) * 84 + off
        self.image[cell : cell + 2] = (value & 0xFFFF).to_bytes(2, "little")
        self.image[s + self.PLOCK_STEP_FLAG + (step - 1) * 8] = 0x01
        self.image[s + self.PLOCK_MASTER] = 0x01
        self.mark_edited(track)

    def automate_param(self, track: int, param: str, step_values: dict[int, int]) -> None:
        """Automate `param` across steps. `step_values` maps 1-based step ->
        u16 value. Writes the value lane + per-step flags + master flag —
        the device automation structure (matches unnamed 35 / plock_drum_t2).
        Values are the device's internal fixed-point (e.g. 0..0x7FFF)."""
        for step, v in step_values.items():
            self.set_plock(track, step, param, v)

    # --- drum-voice parameters (decoded from device capture + manual) -----
    # 24 voice slots, 128 B each, at track+0x3957 (the drum sampler table).
    PRESET_PATH = 0x453F
    PRESET_PATH_MAX = 48
    DRUM_TABLE = 0x3957
    DRUM_SLOT = 0x80
    DRUM_TUNE = 0x00       # u8 root note, default 0x3c, ±48 semitones
    DRUM_KEY = 0x02        # u8 MIDI key assignment
    DRUM_PLAY_MODE = 0x03  # u8; preset corpus confirms patch.json oneshot = 1
    DRUM_DIRECTION = 0x07  # u8: 0=forward, 1=backward
    DRUM_PATH = 0x08       # 72 B latin-1 sample path
    DRUM_START = 0x68      # u32 sample start, default 0
    DRUM_LOOP_START = 0x6C  # u32 candidate sample loop-start lane, default 0
    DRUM_END = 0x70        # u32 sample end, default 0xFFFFFFFF
    DRUM_PAN = 0x06        # signed byte pan (−100..+100 observed on device)
    DRUM_GAIN = 0x7C       # u32 sample gain / loop-crossfade, default 0 (max 0x7FFFFFFF)
    SAMPLER_ENGINE = 0x02
    DRUM_ENGINE = 0x03
    SAMPLER_FRAMECOUNT = 0x393F
    SAMPLER_SAMPLE_START = 0x3943
    SAMPLER_SAMPLE_END = 0x3947
    SAMPLER_LOOP_START = 0x394B
    SAMPLER_LOOP_END = 0x394F
    SAMPLER_LOOP_CROSSFADE_RAW = 0x3953
    SAMPLER_LOOP_CROSSFADE = 0x3956
    SAMPLER_SLOT_TUNE = 0x00
    SAMPLER_SLOT_LOOP_TYPE = 0x03
    SAMPLER_SLOT_TUNE_AUX = 0x04
    SAMPLER_SLOT_GAIN = 0x05
    SAMPLER_SLOT_DIRECTION = 0x07
    SAMPLER_SLOT_PATH = 0x08

    @staticmethod
    def _latin1_bytes(value: str, max_len: int, *, where: str) -> bytes:
        raw = value.encode("latin1")
        if len(raw) >= max_len:
            raise ValueError(f"{where} must be shorter than {max_len} bytes")
        return raw + b"\x00" * (max_len - len(raw))

    def _write_latin1(self, offset: int, value: str, max_len: int, *, where: str) -> None:
        self.image[offset : offset + max_len] = self._latin1_bytes(value, max_len, where=where)

    def set_preset_path(self, track: int, path: str, *, pattern: int = 1) -> None:
        s = self.pattern_start(track, pattern)
        self._write_latin1(
            s + self.PRESET_PATH,
            path,
            self.PRESET_PATH_MAX,
            where=f"track {track} pattern {pattern} preset path",
        )
        self.mark_pattern_edited(track, pattern)

    def set_drum_voice(
        self,
        track: int,
        voice: int,
        *,
        pattern: int = 1,
        tune: int | None = None,
        play_mode: int | None = None,
        direction: int | None = None,
        key_assignment: int | None = None,
        path: str | None = None,
        pan: int | None = None,
        fade: int | None = None,
        start: int | None = None,
        loop_start: int | None = None,
        end: int | None = None,
        gain: int | None = None,
    ) -> None:
        """Set per-voice drum parameters (voice = 0..23). `tune` is in
        semitones (−48..+48). Device-decoded from `cap_drum_params.xy`.

        ``fade`` (0..99) is the pad loop-crossfade UI; it is stored on the
        **preceding** voice slot's +0x7C u32 (e.g. pad voice 23 → slot 22)."""
        from .drum_sample_inspection import drum_fade_storage_voice, encode_drum_fade_ui

        if not 0 <= voice < 24:
            raise ValueError("drum voice must be 0..23")
        base = self.pattern_start(track, pattern)
        self.image[base + self.TRK_ENGINE] = self.DRUM_ENGINE
        s = base + self.DRUM_TABLE + voice * self.DRUM_SLOT
        if tune is not None:
            self.image[s + self.DRUM_TUNE] = (0x3C + tune) & 0xFF
        if play_mode is not None:
            self.image[s + self.DRUM_PLAY_MODE] = play_mode
        if direction is not None:
            self.image[s + self.DRUM_DIRECTION] = 1 if direction else 0
        if key_assignment is not None:
            if not 0 <= key_assignment <= 0xFF:
                raise ValueError("drum key assignment must be 0..255")
            self.image[s + self.DRUM_KEY] = key_assignment
        if path is not None:
            self._write_latin1(
                s + self.DRUM_PATH,
                path,
                72,
                where=f"track {track} drum voice {voice} path",
            )
        if pan is not None:
            self.image[s + self.DRUM_PAN] = pan & 0xFF
        if fade is not None:
            storage = drum_fade_storage_voice(voice)
            if storage < 0:
                raise ValueError(f"fade storage voice for drum voice {voice} is invalid")
            gain_s = base + self.DRUM_TABLE + storage * self.DRUM_SLOT
            encoded = encode_drum_fade_ui(fade)
            self.image[gain_s + self.DRUM_GAIN : gain_s + self.DRUM_GAIN + 4] = encoded.to_bytes(
                4, "little"
            )
        if start is not None:
            self.image[s + self.DRUM_START : s + self.DRUM_START + 4] = self._u32(
                start,
                where=f"track {track} drum voice {voice} start",
            )
        if loop_start is not None:
            self.image[
                s + self.DRUM_LOOP_START : s + self.DRUM_LOOP_START + 4
            ] = self._u32(
                loop_start,
                where=f"track {track} drum voice {voice} loop_start",
            )
        if end is not None:
            self.image[s + self.DRUM_END : s + self.DRUM_END + 4] = self._u32(
                end,
                where=f"track {track} drum voice {voice} end",
            )
        if gain is not None:
            self.image[s + self.DRUM_GAIN : s + self.DRUM_GAIN + 4] = self._u32(
                gain,
                where=f"track {track} drum voice {voice} gain",
            )
        self.mark_pattern_edited(track, pattern)

    def set_sampler_sample_edit(
        self,
        track: int,
        *,
        pattern: int = 1,
        preset_path: str | None = None,
        path: str | None = None,
        framecount: int | None = None,
        sample_start: int | None = None,
        sample_end: int | None = None,
        loop_start: int | None = None,
        loop_end: int | None = None,
        loop_crossfade: int | None = None,
        loop_crossfade_raw: int | None = None,
        root_key: int | None = None,
        tune_cents: int | None = None,
        tune_tenths: int | None = None,
        loop_type: int | None = None,
        gain: int | None = None,
        direction: int | None = None,
    ) -> None:
        """Set confirmed one-shot Sampler sample-edit fields.

        Numeric point fields are raw u32/u8 storage values from the P2-B probes.
        ``root_key`` and ``tune_cents`` match patch.json preset loading;
        ``tune_tenths`` uses the direct sample-edit tune encoder.
        """
        from .sampler_sample_inspection import encode_sampler_tune_tenths

        s = self.pattern_start(track, pattern)
        self.image[s + self.TRK_ENGINE] = self.SAMPLER_ENGINE
        if preset_path is not None:
            self._write_latin1(
                s + self.PRESET_PATH,
                preset_path,
                self.PRESET_PATH_MAX,
                where=f"track {track} pattern {pattern} preset path",
            )

        def write_u32(rel: int, value: int) -> None:
            if not 0 <= value <= 0xFFFFFFFF:
                raise ValueError("sampler point value must be u32")
            self.image[s + rel : s + rel + 4] = value.to_bytes(4, "little")

        if framecount is not None:
            write_u32(self.SAMPLER_FRAMECOUNT, framecount)
        if sample_start is not None:
            write_u32(self.SAMPLER_SAMPLE_START, sample_start)
        if sample_end is not None:
            write_u32(self.SAMPLER_SAMPLE_END, sample_end)
        if loop_start is not None:
            write_u32(self.SAMPLER_LOOP_START, loop_start)
        if loop_end is not None:
            write_u32(self.SAMPLER_LOOP_END, loop_end)
        if loop_crossfade_raw is not None:
            write_u32(self.SAMPLER_LOOP_CROSSFADE_RAW, loop_crossfade_raw)
        elif loop_crossfade is not None:
            if not 0 <= loop_crossfade <= 0xFF:
                raise ValueError("sampler loop crossfade must be u8")
            write_u32(self.SAMPLER_LOOP_CROSSFADE_RAW, loop_crossfade << 24)

        slot = s + self.DRUM_TABLE
        if path is not None:
            self._write_latin1(
                slot + self.SAMPLER_SLOT_PATH,
                path,
                72,
                where=f"track {track} pattern {pattern} sampler path",
            )
        if root_key is not None:
            if not 0 <= root_key <= 0xFF:
                raise ValueError("sampler root key must be u8")
            self.image[slot + self.SAMPLER_SLOT_TUNE] = root_key
        if tune_cents is not None:
            if not -128 <= tune_cents <= 0xFF:
                raise ValueError("sampler patch tune cents must fit in a signed or unsigned byte")
            self.image[slot + self.SAMPLER_SLOT_TUNE_AUX] = tune_cents & 0xFF
        if tune_tenths is not None:
            tune_byte, tune_aux = encode_sampler_tune_tenths(tune_tenths)
            self.image[slot + self.SAMPLER_SLOT_TUNE] = tune_byte
            self.image[slot + self.SAMPLER_SLOT_TUNE_AUX] = tune_aux
        for offset, value, label in (
            (self.SAMPLER_SLOT_LOOP_TYPE, loop_type, "loop type"),
            (self.SAMPLER_SLOT_GAIN, gain, "gain"),
            (self.SAMPLER_SLOT_DIRECTION, direction, "direction"),
        ):
            if value is not None:
                if not 0 <= value <= 0xFF:
                    raise ValueError(f"sampler {label} must be u8")
                self.image[slot + offset] = value
        self.mark_pattern_edited(track, pattern)

    # --- preset / instrument assignment -----------------------------------
    # Loading a kit/preset copies the donor's preset-identity regions into
    # the target struct (validated: u116's T4/T7/T8 boop-kit loads are exact
    # donor copies of baseline T1 up to UI-session bytes). Regions exclude
    # the header, pristine flag, p-lock table, step components, and events.
    PRESET_REGIONS = ((0x13, 0x2A0), (0x3457, 0x456F), (0x4570, 17876))

    def set_preset(self, track: int, donor_path: str, donor_track: int) -> None:
        """Copy instrument identity (engine, params, samples, preset string,
        trailer) from a donor file's track. Donor track must be a pristine
        17,876-byte leader struct (no events)."""
        donor_header, dimg = decode_project(open(donor_path, "rb").read())
        dstarts = leader_starts_from_image(
            dimg, track_base_from_header(donor_header)
        )
        if not dstarts:
            dstarts = [m.start() - 3 for m in SIG_RE.finditer(dimg)]
        ds = dstarts[donor_track - 1]
        donor = dimg[ds : ds + 17876]
        if donor[0] != 1 or donor[OFF_NOTE_COUNT] != 0:
            raise ValueError(
                "set_preset donor track must be pristine: "
                f"track {donor_track} has pattern_count={donor[0]} "
                f"note_count={donor[OFF_NOTE_COUNT]}"
            )
        s = self.track_start(track)
        for a, b in self.PRESET_REGIONS:
            self.image[s + a : s + b] = donor[a:b]
        self._rescan()

    # --- output ----------------------------------------------------------
    def to_bytes(self) -> bytes:
        return encode_project(self.header, bytes(self.image))

    def save(self, path: str) -> None:
        open(path, "wb").write(self.to_bytes())


# --- arrangement assembly (multi-pattern / scenes / songs) ----------------
#
# Decoded-image facts used here (docs/format/decoded_image_map.md):
#   scenes array: 33-byte slots at GLOBAL+0x95 (slot 0 = live selection;
#       sel[16] + mute[16] + flags); GLOBAL+0x06 = active scene slot
#   clones: a track with N patterns serializes leader struct (17,876 B,
#       count byte = N) followed by N-1 clone structs = pattern_struct[1:]
#   footer: 14 song slots [scene_count][scene_ids...][loop_off][00],
#       default 01 00 00 00
# Validated byte-exact against j05/j06 (tests/test_image_writer.py).

SCENE_SLOT0 = 0x95
SCENE_SLOT_SIZE = 33
GLOBAL_ACTIVE_SCENE = 0x6
GLOBAL_SCENE_COUNT = GLOBAL_ACTIVE_SCENE  # legacy alias; this byte is active scene, not count
FOOTER_SLOTS = 14
STRIDE = TRACK_STRIDE


def _pattern_payload(pattern) -> tuple[list[dict], int | None]:
    """Accept either a plain note list or {'notes': [...], 'steps': N}."""
    if isinstance(pattern, dict):
        notes = pattern.get("notes", [])
        steps = pattern.get("steps")
        if steps is None and pattern.get("bars") is not None:
            steps = int(pattern["bars"]) * 16
        return notes, steps
    return pattern, None


def _pattern_struct(base_struct: bytes, pattern) -> bytes:
    """Build one pattern struct from the track's baseline struct."""
    notes, explicit_steps = _pattern_payload(pattern)
    st = bytearray(base_struct)
    if explicit_steps is not None:
        if not 1 <= explicit_steps <= 64:
            raise ValueError("pattern length must be 1..64 steps")
        st[OFF_PATTERN_STEPS] = explicit_steps
        st[OFF_PRISTINE : OFF_PRISTINE + 2] = b"\x00\x00"
    if not notes:
        return bytes(st)
    max_step = max(n["step"] for n in notes)
    inferred_steps = min(64, max(16, ((max_step + 15) // 16) * 16))
    st[OFF_PATTERN_STEPS] = explicit_steps or inferred_steps
    st[OFF_PRISTINE : OFF_PRISTINE + 2] = b"\x00\x00"
    cpos = OFF_NOTE_COUNT
    recs = bytearray()
    for n in notes:
        if len(recs) // NOTE_SIZE >= 120:
            raise ValueError("pattern note limit exceeded")
        tick = (n["step"] - 1) * STEP_TICKS + n.get("tick_offset", 0)
        gate = n.get("gate_ticks", 240)
        recs += tick.to_bytes(4, "little", signed=True)
        recs += gate.to_bytes(4, "little")
        recs += bytes([n["note"] & 0x7F, n.get("velocity", 100) & 0x7F, 0, 0])
    st[cpos] = len(recs) // NOTE_SIZE
    st[cpos + 1 : cpos + 1] = recs
    return bytes(st)


def build_arrangement(
    base_path: str,
    track_patterns: dict[int, list[list[dict] | dict]],
    *,
    scenes: list[dict[int, int]] | None = None,
    scene_mutes: list[list[int]] | None = None,
    song_chain: list[int] | None = None,
    song_loop: bool = True,
) -> bytes:
    """Assemble a project image from scratch.

    track_patterns: 1-based track -> list of patterns. Each pattern may be
        either a list of note dicts {step, note, velocity?, tick_offset?,
        gate_ticks?}, or {"notes": [...], "steps": N} / {"notes": [...],
        "bars": N} to set the explicit pattern length.
    scenes: optional scene rows; scene k maps 1-based track -> 0-based
        pattern index (scene slots 1..n; slot 0 stays the live selection).
    scene_mutes: optional per-scene list of 1-based muted tracks (device
        mute value is 2; nonzero = muted, confirmed device-side).
    song_chain: optional list of 0-based scene ids for Song 1.
    """
    header, base = decode_project(open(base_path, "rb").read())
    starts = leader_starts_from_image(base, track_base_from_header(header))
    if not starts:
        starts = [m.start() - 3 for m in SIG_RE.finditer(base)]
    g = bytearray(base[: starts[0]])

    # live selection (slot 0): device sits on the last created pattern
    sel_written = False
    for t, pats in track_patterns.items():
        if len(pats) > 1:
            g[SCENE_SLOT0 + t - 1] = len(pats) - 1
            sel_written = True
    if sel_written:
        g[SCENE_SLOT0 + 32] = 1  # flags

    if scenes:
        # Legacy behavior: generated arrangements leave the active scene on the
        # last supplied scene, matching the byte-exact j05/j06 fixtures.
        g[GLOBAL_ACTIVE_SCENE] = len(scenes) - 1
        for k, row in enumerate(scenes, start=1):
            slot = SCENE_SLOT0 + k * SCENE_SLOT_SIZE
            mutes = scene_mutes[k - 1] if scene_mutes and k - 1 < len(scene_mutes) else []
            if any(row.values()) or mutes:
                for t, pat in row.items():
                    if not 1 <= t <= 16 or not 0 <= pat < MAX_PATTERNS_PER_TRACK:
                        raise ValueError(
                            "scene selection must be track 1..16, "
                            f"pattern 0..{MAX_PATTERNS_PER_TRACK - 1}"
                        )
                    g[slot + t - 1] = pat
                for t in mutes:
                    g[slot + 16 + t - 1] = 2  # device mute value
                g[slot + 32] = 1

    parts = [bytes(g)]
    for t in range(1, 17):
        s = starts[t - 1]
        tail = base[s + STRIDE :] if t == 16 else b""
        base_struct = base[s : s + STRIDE]
        pats = track_patterns.get(t)
        if not pats:
            parts.append(base_struct + tail)
            continue
        if len(pats) > MAX_PATTERNS_PER_TRACK:
            raise ValueError(
                f"OP-XY tracks support at most {MAX_PATTERNS_PER_TRACK} patterns"
            )
        structs = [_pattern_struct(base_struct, p) for p in pats]
        leader = bytearray(structs[0])
        leader[0] = len(pats)
        parts.append(bytes(leader) + b"".join(st[1:] for st in structs[1:]) + tail)
    image = bytearray(b"".join(parts))

    if song_chain:
        footer_start = len(image) - FOOTER_SLOTS * 4
        slot = bytes([len(song_chain)]) + bytes(song_chain) + bytes(
            [0 if song_loop else 1, 0]
        )
        image[footer_start : footer_start + 4] = slot

    return encode_project(header, bytes(image))
