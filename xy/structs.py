from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable, Iterator, List, Sequence


TRACK_SIGNATURE_HEAD = b"\x00\x00\x01"
TRACK_SIGNATURE_TAIL = b"\xff\x00\xfc\x00"
STEP_TICKS = 480
SENTINEL_BYTES = b"\x8A\x01\x10\xF0\x00\x00\x01\x03\xFF\x00\xFC\x00"


def swap_u16(value: int) -> int:
    """Return the little-endian interpretation of `value` that was stored big-endian."""

    return ((value & 0xFF) << 8) | ((value >> 8) & 0xFF)


@dataclass(frozen=True)
class TrackHandle:
    track: int
    slot: int
    aux: int

    def is_unused(self) -> bool:
        return (self.slot, self.aux) in {
            (0x00FF, 0xFF00),
            (0xFF00, 0x00FF),
        }

    def slot_le(self) -> int:
        """Return the slot word interpreted as little-endian."""

        return swap_u16(self.slot)

    def aux_le(self) -> int:
        """Return the aux word interpreted as little-endian."""

        return swap_u16(self.aux)

    def slot_offset(self) -> int:
        """Return the byte offset of the slot descriptor within the project file."""

        slot_index = self.slot_le()
        if slot_index == 0:
            raise ValueError(f"track {self.track} does not reference a slot descriptor")
        return slot_index * 0x10


@dataclass
class SlotDescriptor:
    slot: int
    offset: int
    raw: bytes


def pattern_max_slot(data: bytes) -> int:
    return int.from_bytes(data[0x56:0x58], "little", signed=False)


def find_track_handles(data: bytes) -> List[TrackHandle]:
    handles: List[TrackHandle] = []
    base = 0x58
    for idx in range(16):
        off = base + idx * 4
        if off + 4 > len(data):
            break
        slot = int.from_bytes(data[off : off + 2], "big")
        aux = int.from_bytes(data[off + 2 : off + 4], "big")
        handles.append(TrackHandle(track=idx + 1, slot=slot, aux=aux))
    return handles


def is_probable_track_start(data: bytes, signature_offset: int) -> bool:
    """Heuristically verify that `signature_offset` marks a real track block."""

    head_len = len(TRACK_SIGNATURE_HEAD)
    tail_len = len(TRACK_SIGNATURE_TAIL)

    if signature_offset < 4:
        return False
    if signature_offset + head_len + 1 + tail_len > len(data):
        return False
    if data[signature_offset : signature_offset + head_len] != TRACK_SIGNATURE_HEAD:
        return False

    variant_pos = signature_offset + head_len
    tail_pos = variant_pos + 1
    tail_end = tail_pos + tail_len
    if data[tail_pos:tail_end] != TRACK_SIGNATURE_TAIL:
        return False

    pointer_word = int.from_bytes(data[signature_offset - 4 : signature_offset], "little")
    if (pointer_word & 0xFF00_0000) != 0xF000_0000:
        return False
    if pointer_word & 0x0000_FFFF == 0:
        return False

    return True


def find_track_blocks(data: bytes) -> List[int]:
    offsets: List[int] = []
    start = 0
    head = TRACK_SIGNATURE_HEAD
    tail = TRACK_SIGNATURE_TAIL
    data_len = len(data)

    while start < data_len - len(head) - len(tail):
        idx = data.find(head, start)
        if idx == -1 or idx + len(head) + len(tail) > data_len:
            break

        if not is_probable_track_start(data, idx):
            start = idx + 1
            continue

        offsets.append(idx)
        if len(offsets) == 16:
            break
        start = idx + len(head) + 1 + len(tail)

    return offsets


def parse_pointer_words(data: bytes, block_offset: int) -> List[int] | None:
    base = block_offset + 8
    end = base + 32
    if end > len(data):
        return None
    return [
        int.from_bytes(data[offset : offset + 2], "little")
        for offset in range(base, end, 2)
    ]


def iter_slot_descriptors(
    data: bytes, slots: Iterable[int], max_len: int | None = None
) -> Iterator[SlotDescriptor]:
    seen: set[int] = set()
    for slot in slots:
        if slot in seen or slot <= 0:
            continue
        offset = slot * 0x10
        if max_len is not None and offset + 0x10 > max_len:
            continue
        if offset + 0x10 > len(data):
            continue
        seen.add(slot)
        yield SlotDescriptor(slot=slot, offset=offset, raw=data[offset : offset + 0x10])


def find_track_payload_window(
    data: bytes, block_offset: int, search_span: int = 0x900
) -> tuple[int, int] | None:
    """Locate the pattern payload window (sentinel or event blob) inside a track."""

    start = block_offset
    end = min(len(data), block_offset + search_span)
    idx = data.find(SENTINEL_BYTES, start, end)
    if idx == -1:
        return None
    return idx, idx + len(SENTINEL_BYTES)
