"""Read Bar-menu track/pattern defaults from decoded project images."""

from __future__ import annotations

from dataclasses import dataclass

from .image_writer import ImageProject
from .rle import decode_project

TRACK_BASE0 = 0x0D79
TRACK_STRIDE = 0x45D4
TRACK_PATTERN_STEPS_OFFSET = 0x01
TRACK_DEFAULT_STEP_LENGTH_OFFSET = 0x02
TRACK_QUANTIZATION_OFFSET = 0x07
TRACK_GROOVE_OFFSET = 0x08
TRACK_PLOCK_SHAPE_OFFSET = 0x3056

TRACK_GROOVE_UI_SEQUENCE = (
2,4,7,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,53,56,58,60,63,65,67,70,72,75,77,79,82,84,86,89,91,93,96,98,99
)


def groove_index_for_ui_value(ui_value: int) -> int:
    if ui_value == 0:
        return 0
    sign = 1 if ui_value > 0 else -1
    try:
        index = TRACK_GROOVE_UI_SEQUENCE.index(abs(ui_value)) + 1
    except ValueError as exc:
        raise ValueError("groove UI value is not in the device sequence") from exc
    return sign * index


def encode_track_groove_ui(ui_value: int) -> int:
    index = groove_index_for_ui_value(ui_value)
    raw = index * 3
    if raw > 0x7F:
        raw = 0x7F
    if raw < -0x7F:
        raw = -0x7F
    return raw & 0xFF


@dataclass(frozen=True)
class TrackBarMenu:
    track: int
    pattern_steps: int
    default_step_length_ticks: int
    quantization_raw: int
    groove_raw: int
    plock_shape_raw: int

    @property
    def bar_count(self) -> int:
        return (self.pattern_steps + 15) // 16

    @property
    def final_bar_steps(self) -> int:
        remainder = self.pattern_steps % 16
        return remainder if remainder else 16

    @property
    def default_step_length_ui(self) -> int:
        """Best-effort device UI value for the captured 0..100 length control."""
        if self.default_step_length_ticks <= 12:
            return max(0, self.default_step_length_ticks // 4 - 1)
        return int((self.default_step_length_ticks * 100 / 480) + 0.5)

    @property
    def quantization_ui_approx(self) -> int:
        """Approximate UI percent; BAR probes pin the byte but not full scaling."""
        return round(self.quantization_raw * 100 / 255)

    @property
    def groove_signed_raw(self) -> int:
        if self.groove_raw >= 0x80:
            return self.groove_raw - 0x100
        return self.groove_raw

    @property
    def groove_index(self) -> int | None:
        signed = self.groove_signed_raw
        if signed == 0:
            return 0
        if signed == 0x7F:
            return len(TRACK_GROOVE_UI_SEQUENCE)
        if signed == -0x7F:
            return -len(TRACK_GROOVE_UI_SEQUENCE)
        if signed % 3 == 0:
            index = signed // 3
            if abs(index) <= len(TRACK_GROOVE_UI_SEQUENCE):
                return index
        return None

    @property
    def groove_ui_value(self) -> int | None:
        index = self.groove_index
        if index is None:
            return None
        if index == 0:
            return 0
        ui = TRACK_GROOVE_UI_SEQUENCE[abs(index) - 1]
        return ui if index > 0 else -ui

    @property
    def plock_shape_signed_raw(self) -> int:
        if self.plock_shape_raw >= 0x80:
            return self.plock_shape_raw - 0x100
        return self.plock_shape_raw


def read_track_bar_menu(project: ImageProject, track: int) -> TrackBarMenu:
    if not 1 <= track <= 16:
        raise ValueError("track must be 1..16")
    image = project.image
    # These BAR fields sit inside the byte range historically used as the track
    # signature, so signature scanning can miss edited tracks. BAR probes use
    # the fixed baseline-shape decoded image; use the canonical base/stride.
    base = TRACK_BASE0 + (track - 1) * TRACK_STRIDE
    return TrackBarMenu(
        track=track,
        pattern_steps=image[base + TRACK_PATTERN_STEPS_OFFSET],
        default_step_length_ticks=int.from_bytes(
            image[
                base
                + TRACK_DEFAULT_STEP_LENGTH_OFFSET : base
                + TRACK_DEFAULT_STEP_LENGTH_OFFSET
                + 2
            ],
            "little",
        ),
        quantization_raw=image[base + TRACK_QUANTIZATION_OFFSET],
        groove_raw=image[base + TRACK_GROOVE_OFFSET],
        plock_shape_raw=image[base + TRACK_PLOCK_SHAPE_OFFSET],
    )


def inspect_bar_menu_bytes(data: bytes, *, tracks: int = 8) -> tuple[TrackBarMenu, ...]:
    header, image = decode_project(data)
    project = ImageProject(header, bytearray(image))
    project._rescan()
    return tuple(read_track_bar_menu(project, track) for track in range(1, tracks + 1))
