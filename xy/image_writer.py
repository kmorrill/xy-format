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

SIG_RE = re.compile(rb"\x00\x00\x00[\x00-\x0f]\xff\x00\xfc\x00", re.S)

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

    def _rescan(self) -> None:
        self._starts = [m.start() - 3 for m in SIG_RE.finditer(self.image)]

    def track_start(self, track: int) -> int:
        """1-based track number -> struct base offset (header byte 0)."""
        return self._starts[track - 1]

    # --- field edits -----------------------------------------------------
    def mark_edited(self, track: int) -> None:
        s = self.track_start(track)
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
            tick.to_bytes(4, "little")
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
                self.image[off : off + 4] = val.to_bytes(4, "little")

    # --- per-track sound / engine (track-relative offsets) ----------------
    TRK_SCALE = 0x06
    TRK_ENGINE = 0x14
    TRK_M4_PAGE = 0x20
    TRK_FILTER_TYPE = 0x21
    TRK_FILTER_ON = 0x25
    TRK_PARAMS = 0x3857     # 4 engine params, u32 each
    TRK_STEPCOMP = 0x3057   # 16 B per step
    TRK_PLOCK = 0x2A0       # 84 B per step row, u16 cells
    # encoded track-scale byte (0x01=½× .. 0x0E=16×); pass raw for others.
    SCALE_BYTES = {0.5: 0x01, 1: 0x03, 2: 0x05, 16: 0x0E}

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

    def set_engine(self, track: int, engine_id: int) -> None:
        self.image[self.track_start(track) + self.TRK_ENGINE] = engine_id & 0xFF
        self.mark_edited(track)

    def set_engine_param(self, track: int, index: int, value: int) -> None:
        """index 1..4; value is the device's internal (fixed-point) u32."""
        o = self.track_start(track) + self.TRK_PARAMS + (index - 1) * 4
        self.image[o : o + 4] = value.to_bytes(4, "little")
        self.mark_edited(track)

    def set_filter(self, track: int, *, type: int | None = None, enabled: bool | None = None) -> None:
        s = self.track_start(track)
        if type is not None:
            self.image[s + self.TRK_FILTER_TYPE] = type & 0xFF
        if enabled is not None:
            self.image[s + self.TRK_FILTER_ON] = 1 if enabled else 0
        self.mark_edited(track)

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
    DRUM_TABLE = 0x3957
    DRUM_SLOT = 0x80
    DRUM_TUNE = 0x00       # u8 root note, default 0x3c, ±48 semitones
    DRUM_PLAY_MODE = 0x03  # u8: 1=key, 2=oneshot, 3=mute group, 4=loop
    DRUM_DIRECTION = 0x07  # u8: 0=forward, 1=backward
    DRUM_START = 0x68      # u32 sample start, default 0
    DRUM_LOOP_START = 0x6C  # u32 candidate sample loop-start lane, default 0
    DRUM_END = 0x70        # u32 sample end, default 0xFFFFFFFF
    DRUM_PAN = 0x06        # signed byte pan (−100..+100 observed on device)
    DRUM_GAIN = 0x7C       # u32 sample gain / loop-crossfade, default 0 (max 0x7FFFFFFF)

    def set_drum_voice(
        self,
        track: int,
        voice: int,
        *,
        tune: int | None = None,
        play_mode: int | None = None,
        direction: int | None = None,
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

        s = self.track_start(track) + self.DRUM_TABLE + voice * self.DRUM_SLOT
        if tune is not None:
            self.image[s + self.DRUM_TUNE] = (0x3C + tune) & 0xFF
        if play_mode is not None:
            self.image[s + self.DRUM_PLAY_MODE] = play_mode
        if direction is not None:
            self.image[s + self.DRUM_DIRECTION] = 1 if direction else 0
        if pan is not None:
            self.image[s + self.DRUM_PAN] = pan & 0xFF
        if fade is not None:
            storage = drum_fade_storage_voice(voice)
            if storage < 0:
                raise ValueError(f"fade storage voice for drum voice {voice} is invalid")
            gain_s = self.track_start(track) + self.DRUM_TABLE + storage * self.DRUM_SLOT
            encoded = encode_drum_fade_ui(fade)
            self.image[gain_s + self.DRUM_GAIN : gain_s + self.DRUM_GAIN + 4] = encoded.to_bytes(
                4, "little"
            )
        if start is not None:
            self.image[s + self.DRUM_START : s + self.DRUM_START + 4] = start.to_bytes(4, "little")
        if loop_start is not None:
            self.image[
                s + self.DRUM_LOOP_START : s + self.DRUM_LOOP_START + 4
            ] = loop_start.to_bytes(4, "little")
        if end is not None:
            self.image[s + self.DRUM_END : s + self.DRUM_END + 4] = end.to_bytes(4, "little")
        if gain is not None:
            self.image[s + self.DRUM_GAIN : s + self.DRUM_GAIN + 4] = gain.to_bytes(4, "little")
        self.mark_edited(track)

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
        _, dimg = decode_project(open(donor_path, "rb").read())
        dstarts = [m.start() - 3 for m in SIG_RE.finditer(dimg)]
        ds = dstarts[donor_track - 1]
        donor = dimg[ds : ds + 17876]
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
STRIDE = 17876


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
        recs += tick.to_bytes(4, "little") + gate.to_bytes(4, "little")
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
