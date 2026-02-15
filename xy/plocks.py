"""Parameter-lock (p-lock) parsing helpers.

This module centralizes p-lock table decoding used by tests and tooling.
It currently supports:
  - locating the p-lock region from the config-tail signature
  - parsing standard 48-entry (3 lanes x 16) 5-byte tables
  - extracting first/continuation lane IDs and counts
  - reading T1 slot first param-id signature
  - reading T10 9-byte header + continuation records
  - compatibility wrappers for legacy extractor scripts
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Sequence


CONFIG_TAIL_SIG = bytes([0x40, 0x1F, 0x00, 0x00, 0x0C, 0x40, 0x1F, 0x00, 0x00])
EMPTY_ENTRY = b"\xff\x00\x00"
STANDARD_ENTRY_COUNT = 48
CONTINUATION_MARKER = 0x50

# Drum T1/T2 value suffix for the 18-byte format.
DRUM_SUFFIX = bytes(
    [0x00, 0x40, 0x00, 0x40, 0x00, 0x40, 0x00, 0x00, 0x0A, 0xFF, 0x7F, 0xE8, 0x03, 0x00, 0x00, 0x3A]
)


@dataclass(frozen=True)
class T10Header:
    param_id: int
    initial_value: int
    meta_lo: int
    meta_hi: int
    continuation_values: tuple[int, ...]

    @property
    def continuation_count(self) -> int:
        return len(self.continuation_values)


@dataclass(frozen=True)
class StandardSlot:
    offset: int
    size: int
    param_id: int | None
    value: int | None

    @property
    def is_empty(self) -> bool:
        return self.param_id is None


def find_plock_start(body: bytes) -> int | None:
    """Return p-lock table start offset, or None if signature is absent."""
    off = body.find(CONFIG_TAIL_SIG)
    if off < 0:
        return None
    return off + len(CONFIG_TAIL_SIG)


def parse_standard_table(
    body: bytes,
    *,
    start: int | None = None,
    entry_count: int = STANDARD_ENTRY_COUNT,
) -> tuple[list[tuple[int, int] | None], int]:
    """Parse standard 5-byte p-lock entries.

    Returns (entries, next_offset) where entries length is `entry_count`.
    Each entry is either None (FF 00 00) or (param_id, value_u16_le).
    """
    if start is None:
        start = find_plock_start(body)
    if start is None:
        raise ValueError("config tail signature not found")

    pos = start
    entries: list[tuple[int, int] | None] = []

    for _ in range(entry_count):
        if body[pos : pos + 3] == EMPTY_ENTRY:
            entries.append(None)
            pos += 3
            continue

        chunk = body[pos : pos + 5]
        if len(chunk) < 5 or chunk[3:5] != b"\x00\x00":
            raise ValueError(f"invalid 5-byte p-lock entry at 0x{pos:04X}")

        entries.append((chunk[0], int.from_bytes(chunk[1:3], "little")))
        pos += 5

    return entries, pos


def parse_standard_slots(
    body: bytes,
    *,
    start: int | None = None,
    entry_count: int = STANDARD_ENTRY_COUNT,
) -> tuple[list[StandardSlot], int]:
    """Parse standard p-lock entries and keep entry offsets/sizes."""
    if start is None:
        start = find_plock_start(body)
    if start is None:
        raise ValueError("config tail signature not found")

    pos = start
    slots: list[StandardSlot] = []

    for _ in range(entry_count):
        if body[pos : pos + 3] == EMPTY_ENTRY:
            slots.append(StandardSlot(offset=pos, size=3, param_id=None, value=None))
            pos += 3
            continue

        chunk = body[pos : pos + 5]
        if len(chunk) < 5 or chunk[3:5] != b"\x00\x00":
            raise ValueError(f"invalid 5-byte p-lock entry at 0x{pos:04X}")

        slots.append(
            StandardSlot(
                offset=pos,
                size=5,
                param_id=chunk[0],
                value=int.from_bytes(chunk[1:3], "little"),
            )
        )
        pos += 5

    return slots, pos


def list_standard_nonempty_values(
    body: bytes,
    *,
    start: int | None = None,
    entry_count: int = STANDARD_ENTRY_COUNT,
) -> list[tuple[int, int]]:
    """Return [(param_id, value)] for non-empty standard slots."""
    slots, _ = parse_standard_slots(body, start=start, entry_count=entry_count)
    out: list[tuple[int, int]] = []
    for slot in slots:
        if slot.param_id is None or slot.value is None:
            continue
        out.append((slot.param_id, slot.value))
    return out


def _validate_u16(value: int) -> int:
    if not isinstance(value, int) or isinstance(value, bool):
        raise ValueError("p-lock values must be integers")
    if not (0 <= value <= 0xFFFF):
        raise ValueError(f"p-lock value out of range: {value}")
    return value


def rewrite_standard_nonempty_values(
    body: bytes,
    values: Sequence[int],
    *,
    start: int | None = None,
    entry_count: int = STANDARD_ENTRY_COUNT,
) -> bytes:
    """Rewrite non-empty standard slot values in encounter order."""
    slots, _ = parse_standard_slots(body, start=start, entry_count=entry_count)
    buf = bytearray(body)
    vi = 0
    for slot in slots:
        if slot.param_id is None or slot.size != 5:
            continue
        if vi >= len(values):
            break
        val = _validate_u16(values[vi])
        buf[slot.offset + 1] = val & 0xFF
        buf[slot.offset + 2] = (val >> 8) & 0xFF
        vi += 1
    return bytes(buf)


def rewrite_standard_values_for_param_groups(
    body: bytes,
    groups: Sequence[tuple[set[int], Sequence[int]]],
    *,
    start: int | None = None,
    entry_count: int = STANDARD_ENTRY_COUNT,
) -> tuple[bytes, list[int]]:
    """Rewrite standard slot values for multiple param-id groups.

    Each group is (param_id_set, values). Values are consumed in encounter
    order across any slot whose param_id belongs to the corresponding set.
    Returns (new_body, consumed_counts_per_group).
    """
    slots, _ = parse_standard_slots(body, start=start, entry_count=entry_count)
    counters = [0 for _ in groups]
    buf = bytearray(body)

    for slot in slots:
        if slot.param_id is None or slot.size != 5:
            continue
        pid = slot.param_id
        for gi, (pid_set, values) in enumerate(groups):
            if pid not in pid_set:
                continue
            if counters[gi] >= len(values):
                break
            val = _validate_u16(values[counters[gi]])
            buf[slot.offset + 1] = val & 0xFF
            buf[slot.offset + 2] = (val >> 8) & 0xFF
            counters[gi] += 1
            break

    return bytes(buf), counters


def first_real_param_id(
    entries: Sequence[tuple[int, int] | None],
    *,
    skip_ids: Sequence[int] = (0x00, CONTINUATION_MARKER),
) -> int | None:
    """Return first non-empty param-id that is not a continuation marker."""
    skip = set(skip_ids)
    for entry in entries:
        if entry is None:
            continue
        pid, _value = entry
        if pid not in skip:
            return pid
    return None


def count_lane_values(
    entries: Sequence[tuple[int, int] | None],
    param_id: int,
    *,
    continuation_marker: int = CONTINUATION_MARKER,
) -> int:
    """Count values for one lane (header entry + continuation entries)."""
    return sum(
        1
        for entry in entries
        if entry is not None and entry[0] in (param_id, continuation_marker)
    )


def t1_first_param_id(body: bytes, *, start: int | None = None) -> int:
    """Return first non-empty param-id byte for T1 slot formats."""
    if start is None:
        start = find_plock_start(body)
    if start is None:
        raise ValueError("config tail signature not found")

    pos = start
    while body[pos : pos + 3] == EMPTY_ENTRY:
        pos += 3
    return body[pos]


def parse_t10_header(body: bytes, *, start: int | None = None) -> T10Header:
    """Parse T10 9-byte header + continuation records.

    Header format:
      [param_id][init_lo][init_hi][00][51][meta_lo][meta_hi][00][1c]
    Continuation format:
      [val_lo][val_hi][00][00][31][meta_lo][meta_hi][00][1c]
    """
    if start is None:
        start = find_plock_start(body)
    if start is None:
        raise ValueError("config tail signature not found")

    pos = start
    while body[pos : pos + 3] == EMPTY_ENTRY:
        pos += 3

    header = body[pos : pos + 9]
    if len(header) < 9:
        raise ValueError("T10 p-lock header truncated")
    if header[4] != 0x51 or header[8] != 0x1C:
        raise ValueError(f"unexpected T10 header markers at 0x{pos:04X}")

    pid = header[0]
    init = int.from_bytes(header[1:3], "little")
    meta_lo = header[5]
    meta_hi = header[6]
    pos += 9

    values: list[int] = []
    while pos + 9 <= len(body):
        chunk = body[pos : pos + 9]
        if (
            chunk[2:4] == b"\x00\x00"
            and chunk[4] == 0x31
            and chunk[5] == meta_lo
            and chunk[6] == meta_hi
            and chunk[8] == 0x1C
        ):
            values.append(int.from_bytes(chunk[0:2], "little"))
            pos += 9
            continue
        break

    return T10Header(
        param_id=pid,
        initial_value=init,
        meta_lo=meta_lo,
        meta_hi=meta_hi,
        continuation_values=tuple(values),
    )


# -----------------------------------------------------------------------------
# Legacy extractor-compatible wrappers
# -----------------------------------------------------------------------------

def extract_synth_plock_entries(
    body: bytes,
    start: int,
    verbose: bool = False,
) -> tuple[list[tuple[int, list[int]]], int]:
    """Extract grouped (param_id, values[]) entries for standard 5-byte format.

    This preserves the historical behavior expected by tools/extract_plocks.py.
    """
    entries: list[tuple[int, list[int]]] = []
    pos = start
    current_param: int | None = None
    current_values: list[int] = []
    total_entries = 0

    while pos < len(body) - 2:
        b0 = body[pos]

        if b0 == 0xFF:
            if body[pos + 1] == 0x00 and body[pos + 2] == 0x00:
                total_entries += 1
                pos += 3
                if total_entries > 55:
                    break
                continue
            break

        if pos + 4 >= len(body):
            break

        b1 = body[pos + 1]
        b2 = body[pos + 2]
        b3 = body[pos + 3]
        b4 = body[pos + 4]

        if b3 == 0x00 and b4 == 0x00:
            val = b1 | (b2 << 8)
            if b0 == CONTINUATION_MARKER:
                current_values.append(val)
            else:
                if current_param is not None:
                    entries.append((current_param, current_values))
                current_param = b0
                current_values = [val]
            total_entries += 1
            pos += 5
        else:
            if verbose:
                print(f"    [BREAK at 0x{pos:04X}] non-standard: {body[pos:pos+5].hex(' ')}")
            break

    if current_param is not None:
        entries.append((current_param, current_values))

    return entries, total_entries


def extract_drum_plock_entries(
    body: bytes,
    start: int,
    verbose: bool = False,
) -> tuple[list[tuple[int, list[int]]], int]:
    """Extract grouped (param_id, values[]) entries for T1/T2 drum 18-byte format."""
    entries: list[tuple[int, list[int]]] = []
    pos = start
    param_id: int | None = None
    values: list[int] = []
    total_entries = 0

    while pos < len(body) - 2:
        b0 = body[pos]

        if b0 == 0xFF:
            if body[pos + 1] == 0x00 and body[pos + 2] == 0x00:
                total_entries += 1
                pos += 3
                if total_entries > 55:
                    break
                continue
            break

        if pos + 17 >= len(body):
            break

        chunk = body[pos : pos + 18]

        if param_id is None:
            param_id = chunk[0]
            if verbose and chunk[1] == 0x40 and chunk[2] == 0x00:
                print(f"    Header @0x{pos:04X}: param_id=0x{param_id:02X} [{chunk.hex(' ')}]")
            pos += 18
            total_entries += 1
            continue

        val = chunk[0] | (chunk[1] << 8)
        if chunk[2:] != DRUM_SUFFIX and verbose:
            print(f"    [WARN] Suffix mismatch @0x{pos:04X}: {chunk.hex(' ')}")
        values.append(val)
        pos += 18
        total_entries += 1

    if param_id is not None:
        entries.append((param_id, values))

    return entries, total_entries
