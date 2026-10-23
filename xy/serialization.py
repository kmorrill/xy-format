"""Count-driven, lossless layout reader for firmware format 9.19.

Offsets in REGION_LAYOUT use the historical leader-relative coordinate system
(count byte at +0). Pattern bodies start at +1; clones have no count byte.
Unknown spans are preserved, not interpreted as padding. No signature search
or backward footer search is used. Acceptance here is structural, not hardware
validation. See docs/format/preset_json.md for evidence and limitations.
"""
from __future__ import annotations

from dataclasses import dataclass

GLOBAL_SIZE = 0xD79
SCENE_BASE = 0x95
SCENE_SIZE = 33
SCENE_SLOTS = 100
NOTE_COUNT_OFFSET = 0x456F
TAIL_SIZE = 96
TRACKS = 16
SONGS = 14

# Exhaustive fixed body partition. Names describe boundaries, not full semantics.
REGION_LAYOUT = (
    (0x001, 0x013, 'timing_and_edit_state'),
    (0x013, 0x026, 'engine_and_page_config'),
    (0x026, 0x24E, 'opaque_track_config'),
    (0x24E, 0x174E, 'plock_steps_1_64'),
    (0x174E, 0x2C4E, 'plock_steps_65_128'),
    (0x2C4E, 0x2E4E, 'plock_masks_1_64'),
    (0x2E4E, 0x304E, 'plock_masks_65_128'),
    (0x304E, 0x3056, 'plock_aggregate_mask'),
    (0x3056, 0x3057, 'automation_state'),
    (0x3057, 0x3457, 'step_components_1_64'),
    (0x3457, 0x3857, 'step_components_65_128'),
    (0x3857, 0x3877, 'engine_parameter_block'),
    (0x3877, 0x3897, 'amp_parameter_block'),
    (0x3897, 0x38B7, 'filter_parameter_block'),
    (0x38B7, 0x38D7, 'lfo_parameter_block'),
    (0x38D7, 0x38F7, 'filter_envelope_block'),
    (0x38F7, 0x393F, 'routing_and_mixer'),
    (0x393F, 0x453F, 'sample_slots'),
    (0x453F, 0x456F, 'preset_path'),
)


class LayoutError(ValueError):
    """The image cannot be walked using this firmware-derived schema."""


@dataclass(frozen=True)
class Span:
    name: str
    start: int
    end: int
    track: int | None = None
    pattern: int | None = None


@dataclass(frozen=True)
class Pattern:
    track: int
    number: int
    start: int  # actual body start, after the leader's count byte
    end: int
    note_count: int
    lane_counts: tuple[int, ...]

    @property
    def origin(self) -> int:
        """Virtual leader origin: add existing +0x offsets even for clones."""
        return self.start - 1


@dataclass(frozen=True)
class Layout:
    image: bytes
    spans: tuple[Span, ...]
    patterns: tuple[Pattern, ...]
    pattern_counts: tuple[int, ...]
    footer_start: int

    def pattern(self, track: int, pattern: int = 1) -> Pattern:
        for item in self.patterns:
            if (item.track, item.number) == (track, pattern):
                return item
        raise ValueError(f'no track {track} pattern {pattern}')

    def reassemble(self) -> bytes:
        """Losslessly preserve all known and opaque spans (not semantic writing)."""
        return b''.join(self.image[span.start:span.end] for span in self.spans)


def parse_image(image: bytes, *, allow_trailing: bool = False) -> Layout:
    """Walk format 9.19. EOF checking is stricter than the firmware loader.

    All lane entries are consumed even beyond the runtime capacities (128 for
    PB/MW/AT, 32 for sustain). No firmware normalization is applied here.
    """
    image = bytes(image)
    spans: list[Span] = []
    patterns: list[Pattern] = []
    counts = []
    pos = 0

    def take(size: int, name: str, track=None, pattern=None) -> int:
        nonlocal pos
        start = pos
        if size < 0 or pos + size > len(image):
            raise LayoutError(f'{name} at 0x{pos:x}: need {size} bytes, '
                              f'have {len(image) - pos}')
        pos += size
        spans.append(Span(name, start, pos, track, pattern))
        return start

    # Partition the global area too; gaps are explicitly opaque.
    for start, end, name in (
        (0, 2, 'tempo'), (2, 3, 'opaque_global_02'), (3, 4, 'groove'),
        (4, 5, 'click'), (5, 6, 'opaque_global_05'),
        (6, 8, 'scene_song_state'), (8, 0x55, 'opaque_global_config'),
        (0x55, 0x65, 'midi_channels'), (0x65, 0x95, 'global_parameter_words'),
    ):
        assert pos == start
        take(end - start, name)
    for scene in range(SCENE_SLOTS):
        take(SCENE_SIZE, f'scene_slot_{scene}')
    assert pos == GLOBAL_SIZE

    for track in range(1, TRACKS + 1):
        count_at = take(1, 'pattern_count', track)
        count = image[count_at]
        if not 1 <= count <= 16:
            raise LayoutError(f'track {track} pattern count {count} at 0x{count_at:x}; expected 1..16')
        counts.append(count)
        for pattern in range(1, count + 1):
            start = pos
            for a, b, name in REGION_LAYOUT:
                assert pos == start + a - 1
                take(b - a, name, track, pattern)
            npos = take(1, 'note_count', track, pattern)
            notes = image[npos]
            if notes > 120:
                raise LayoutError(f'track {track} pattern {pattern}: note count {notes} exceeds 120')
            take(notes * 12, 'notes', track, pattern)
            lanes = []
            for name in ('pitchbend', 'modwheel', 'aftertouch', 'sustain'):
                cpos = take(1, name + '_count', track, pattern)
                c = image[cpos]
                lanes.append(c)
                # Every item is tick:u16,value:i16 (including the first).
                take(c * 4, name + '_payload', track, pattern)
            take(48, 'tuning', track, pattern)
            take(48, 'opaque_tail_48', track, pattern)
            patterns.append(Pattern(track, pattern, start, pos, notes, tuple(lanes)))
    footer_start = pos
    for song in range(1, SONGS + 1):
        cpos = take(1, f'song_{song}_count')
        count = image[cpos]
        if not 0 <= count <= 96:
            raise LayoutError(f'song {song}: scene count {count} outside 0..96 at 0x{cpos:x}')
        take(count, f'song_{song}_scenes')
        take(2, f'song_{song}_loop_raw')
    if pos != len(image) and allow_trailing:
        take(len(image) - pos, 'trailing_bytes')
    if pos != len(image):
        raise LayoutError(f'{len(image) - pos} trailing bytes at 0x{pos:x}')
    return Layout(image, tuple(spans), tuple(patterns), tuple(counts), footer_start)
