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
OFF_BARS = 0x01
OFF_SCALE = 0x06
OFF_PRISTINE = 0x11   # u16: 8 = factory, 0 = edited (sticky)
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

    def set_bars(self, track: int, bars: int) -> None:
        s = self.track_start(track)
        self.image[s + OFF_BARS] = (bars & 0xF) << 4
        self.mark_edited(track)

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
#       sel[16] + mute[16] + flags); GLOBAL+0x6 = scene_count - 1
#   clones: a track with N patterns serializes leader struct (17,876 B,
#       count byte = N) followed by N-1 clone structs = pattern_struct[1:]
#   footer: 14 song slots [scene_count][scene_ids...][loop_off][00],
#       default 01 00 00 00
# Validated byte-exact against j05/j06 (tests/test_image_writer.py).

SCENE_SLOT0 = 0x95
SCENE_SLOT_SIZE = 33
GLOBAL_SCENE_COUNT = 0x6
FOOTER_SLOTS = 14
STRIDE = 17876


def _pattern_struct(base_struct: bytes, notes: list[dict]) -> bytes:
    """Build one pattern struct from the track's baseline struct."""
    st = bytearray(base_struct)
    if not notes:
        return bytes(st)
    max_step = max(n["step"] for n in notes)
    bars = min(4, max(1, (max_step + 15) // 16))
    st[OFF_BARS] = bars << 4
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
    track_patterns: dict[int, list[list[dict]]],
    *,
    scenes: list[dict[int, int]] | None = None,
    song_chain: list[int] | None = None,
    song_loop: bool = True,
) -> bytes:
    """Assemble a project image from scratch.

    track_patterns: 1-based track -> list of patterns, each a list of note
        dicts {step, note, velocity?, tick_offset?, gate_ticks?}.
    scenes: optional scene rows; scene k maps 1-based track -> 0-based
        pattern index (scene slots 1..n; slot 0 stays the live selection).
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
        g[GLOBAL_SCENE_COUNT] = len(scenes) - 1
        for k, row in enumerate(scenes, start=1):
            slot = SCENE_SLOT0 + k * SCENE_SLOT_SIZE
            if any(row.values()):
                for t, pat in row.items():
                    g[slot + t - 1] = pat
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
