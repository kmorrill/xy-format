"""Scene record encoding/decoding for OP-XY .xy files.

Scene overrides are stored as variable-length records in the pre-track region,
between the pattern descriptor (at ~0x57) and the handle table (first FF 00 00
sequence).

Record structure (confirmed via device testing, file 14 capture):
  - Records are terminated by 01 00 00 (3-byte tail)
  - Records are separated by a single 00 byte delimiter
  - The first record in the region has NO 00 delimiter prefix
  - Record body: [01] [pattern_enc] [00 00] [track_tag] [01 00 00]
  - Track tag: 0x1E - track_1based (confirmed for T3=0x1B, T4=0x1A)
  - Pattern encoding: variable-length (P2=01 or 01 00, P3=02)

T1 preamble formula (CORRECTED from file 14):
  - T1_preamble[0] = 0xD6 - (record_count + 1) * 0x21
  - record_count = number of records in scene region
  - NOT driven by pre[0x0F] ordinal (which can differ from record count)

This module only emits corpus-validated byte patterns (conservative approach).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, List, Mapping, Optional, Sequence, Tuple

from .container import XYProject


# ── Track tag formula ────────────────────────────────────────────────

TAG_BASE = 0x1E

# Confirmed by device testing
TAG_MAP = {
    0x1D: 1,
    0x1C: 2,
    0x1B: 3,
    0x1A: 4,
    0x19: 5,
    0x18: 6,
    0x17: 7,
    0x16: 8,
}

TAG_MAP_REVERSE = {v: k for k, v in TAG_MAP.items()}

SCENE_FORMAT_TAG_RECORDS = "tag_records"
SCENE_FORMAT_MATRIX_RECORDS = "matrix_records"
SCENE_FORMAT_ALT_RECORDS = "alt_records"
SCENE_FORMAT_NONE = "none"

_ALT_RECORD_TAIL = b"\x00\x00\x16\x01"


def track_tag(track_1based: int) -> int:
    """Compute the scene record track tag byte for a 1-based track number.

    Formula: tag = 0x1E - track_1based
    Confirmed for T3 (0x1B) and T4 (0x1A) by device testing.
    """
    if not 1 <= track_1based <= 8:
        raise ValueError(f"track must be 1-8, got {track_1based}")
    return TAG_BASE - track_1based


def tag_to_track(tag: int) -> int:
    """Decode a track tag byte to 1-based track number.

    Returns track_1based = 0x1E - tag.
    """
    if tag not in TAG_MAP:
        raise ValueError(f"unknown track tag 0x{tag:02X}")
    return TAG_MAP[tag]


# ── Pattern encoding ─────────────────────────────────────────────────

# Confirmed by device testing:
#   P2 (0-based index 1) = 01 00 (2 bytes)
#   P3 (0-based index 2) = 02    (1 byte)
# P1 (0-based index 0) has not been observed in scene records (it's the default).

_PATTERN_ENCODE = {
    1: b"\x01\x00",  # P2 (2 bytes)
    2: b"\x02",       # P3 (1 byte)
}

_PATTERN_DECODE = {
    b"\x01\x00": 1,
    b"\x02": 2,
}


def encode_pattern(pattern_0based: int) -> bytes:
    """Encode a 0-based pattern index into scene record bytes.

    Only confirmed values: 1 (P2) and 2 (P3).
    """
    if pattern_0based not in _PATTERN_ENCODE:
        raise ValueError(
            f"pattern index {pattern_0based} not yet confirmed; "
            f"known: {list(_PATTERN_ENCODE.keys())}"
        )
    return _PATTERN_ENCODE[pattern_0based]


def decode_pattern(data: bytes, offset: int) -> Tuple[int, int]:
    """Decode variable-length pattern field at offset.

    Returns (pattern_0based, bytes_consumed).
    Tries 2-byte form first (01 00), then 1-byte form.
    """
    # Try 2-byte form first
    if offset + 2 <= len(data):
        chunk = data[offset : offset + 2]
        if chunk in _PATTERN_DECODE:
            return _PATTERN_DECODE[chunk], 2

    # Try 1-byte form
    if offset + 1 <= len(data):
        chunk = data[offset : offset + 1]
        if chunk in _PATTERN_DECODE:
            return _PATTERN_DECODE[chunk], 1

    raise ValueError(
        f"unknown pattern encoding at offset {offset}: "
        f"{data[offset:offset+3].hex(' ')}"
    )


# ── Data types ────────────────────────────────────────────────────────

@dataclass(frozen=True)
class SceneOverride:
    """A single track→pattern override within a scene record."""
    track: int  # 1-based track number
    pattern: int  # 0-based pattern index


@dataclass(frozen=True)
class SceneRecord:
    """A parsed scene record with its raw bytes."""
    overrides: Tuple[SceneOverride, ...]
    raw: bytes


@dataclass(frozen=True)
class MatrixSceneVector:
    """Decoded matrix-form scene vector for T1..T8."""
    patterns: Tuple[int, ...]  # 0-based pattern index per track (len=8)
    widths: Tuple[int, ...]  # byte width used per track token (1 or 2)
    raw: bytes


# ── Known record forms (corpus-validated byte patterns) ───────────────

# These are complete record byte sequences observed in device exports.
# Each maps (track, pattern) → exact bytes.

@dataclass(frozen=True)
class RecordForm:
    """A known-good record form with its byte pattern and semantics."""
    raw: bytes
    overrides: Tuple[SceneOverride, ...]
    source: str  # corpus file where observed

# Single-override forms
_FORM_T3_P2_8B = RecordForm(
    raw=bytes([0x00, 0x01, 0x00, 0x00, 0x1B, 0x01, 0x00, 0x00]),
    overrides=(SceneOverride(track=3, pattern=1),),
    source="04_scene_s2_t3p2",
)

_FORM_T4_P3_9B = RecordForm(
    raw=bytes([0x00, 0x01, 0x02, 0x00, 0x00, 0x1A, 0x01, 0x00, 0x00]),
    overrides=(SceneOverride(track=4, pattern=2),),
    source="07_scene_s3_t4p3",
)

_FORM_T4_P2_COMPACT_8B = RecordForm(
    raw=bytes([0x01, 0x01, 0x00, 0x00, 0x1A, 0x01, 0x00, 0x00]),
    overrides=(SceneOverride(track=4, pattern=1),),
    source="12_scene_s2_t3p1",
)

_FORM_T4_P3_COMPACT_8B = RecordForm(
    raw=bytes([0x01, 0x02, 0x00, 0x00, 0x1A, 0x01, 0x00, 0x00]),
    overrides=(SceneOverride(track=4, pattern=2),),
    source="14scene-s2t4p3",
)

# Dual-override form (both T3 and T4 → P2 in same record)
_FORM_T3T4_P2_DUAL_10B = RecordForm(
    raw=bytes([0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x1A, 0x01, 0x00, 0x00]),
    overrides=(SceneOverride(track=3, pattern=1), SceneOverride(track=4, pattern=1)),
    source="05_scene_s2_t4p2",
)

_FORM_T4_P2_10B = RecordForm(
    raw=bytes([0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x1A, 0x01, 0x00, 0x00]),
    overrides=(SceneOverride(track=4, pattern=1),),
    source="09_scene_s3_t4p2_from06",
)

# Lookup by raw bytes
KNOWN_FORMS = {
    _FORM_T3_P2_8B.raw: _FORM_T3_P2_8B,
    _FORM_T4_P3_9B.raw: _FORM_T4_P3_9B,
    _FORM_T4_P2_COMPACT_8B.raw: _FORM_T4_P2_COMPACT_8B,
    _FORM_T4_P3_COMPACT_8B.raw: _FORM_T4_P3_COMPACT_8B,
    _FORM_T3T4_P2_DUAL_10B.raw: _FORM_T3T4_P2_DUAL_10B,
}

# Lookup by (track, pattern) for single-override emission
_SINGLE_OVERRIDE_FORMS = {
    (3, 1): _FORM_T3_P2_8B,      # T3→P2, 8B
    (4, 2): _FORM_T4_P3_9B,      # T4→P3, 9B
    (4, 1): _FORM_T4_P2_COMPACT_8B,  # T4→P2, 8B compact
}


def encode_scene_record(track: int, pattern: int) -> bytes:
    """Emit a known-good scene record for a single track→pattern override.

    Only emits corpus-validated byte patterns. Raises ValueError if the
    requested combination has not been observed in device exports.

    Args:
        track: 1-based track number
        pattern: 0-based pattern index
    """
    key = (track, pattern)
    if key not in _SINGLE_OVERRIDE_FORMS:
        raise ValueError(
            f"no corpus-validated record form for T{track}→P{pattern+1}; "
            f"known: {[(f'T{t}→P{p+1}') for t, p in _SINGLE_OVERRIDE_FORMS]}"
        )
    return _SINGLE_OVERRIDE_FORMS[key].raw


def encode_scene_record_general(
    track: int,
    pattern: int,
    *,
    is_first: bool = False,
) -> bytes:
    """Emit a scene record for any T1-T8 × P2-P9 override.

    Generalized encoder based on corpus-validated patterns. Uses the
    tag formula (0x1E - track_1based) for any track and the structural
    pattern encoding observed in the corpus.

    Compact form (is_first=True, no separator):
        [01] [pattern_0based] [00 00] [tag] [01 00 00]   (8 bytes)
        Confirmed: file 12 (T4→P2), file 14 (T4→P3)

    Standard form (is_first=False, 00 separator):
        [00] [01] [pattern_enc] [00 00] [tag] [01 00 00]
        P2:  pattern_enc = 01 00 (2 bytes) → 10 bytes total
        P3+: pattern_enc = pattern_0based (1 byte) → 9 bytes total
        Confirmed: file 05/09 (T4→P2, 10B), file 07 S3 (T4→P3, 9B)

    v3-A1 device test confirmed: the 8B P2 form (without explicit
    pattern_enc) crashes for T4. The 10B form with full 2-byte P2
    encoding (01 00) is required for non-first P2 records.

    Args:
        track: 1-based track number (1-8)
        pattern: 0-based pattern index (1-8, i.e. P2-P9)
        is_first: True for the first record in the region (compact form)

    Returns:
        Encoded record bytes (8, 9, or 10 bytes).
    """
    if not 1 <= track <= 8:
        raise ValueError(f"track must be 1-8, got {track}")
    if not 1 <= pattern <= 8:
        raise ValueError(
            f"pattern must be 1-8 (P2-P9), got {pattern}; "
            "P1 (index 0) is the default and not encoded in scene records"
        )

    tag = track_tag(track)

    if is_first:
        # Compact: [01] [pattern_0based] [00 00] [tag] [01 00 00]
        return bytes([0x01, pattern, 0x00, 0x00, tag, 0x01, 0x00, 0x00])
    else:
        if pattern == 1:
            # P2: [00] [01] [01 00] [00 00] [tag] [01 00 00]  (10B)
            # Uses full 2-byte pattern encoding (01 00) for P2.
            # Corpus: files 05, 09, 11 all use this 10B form for T4→P2.
            # v3-A1 confirmed: 8B P2 form crashes for T4.
            return bytes([0x00, 0x01, 0x01, 0x00, 0x00, 0x00, tag, 0x01, 0x00, 0x00])
        else:
            # P3+: [00] [01] [pattern_0based] [00 00] [tag] [01 00 00]  (9B)
            return bytes([0x00, 0x01, pattern, 0x00, 0x00, tag, 0x01, 0x00, 0x00])


# ── Scene region finding and parsing ──────────────────────────────────

def _find_handle_table_start(pre_track: bytes) -> int:
    for i in range(0x50, len(pre_track) - 2):
        if pre_track[i : i + 3] == b"\xff\x00\x00":
            return i
    raise ValueError("handle table not found in pre-track data")


def _find_descriptor_start(pre_track: bytes, ht_start: int) -> Optional[int]:
    for i in range(0x50, ht_start):
        if pre_track[i] == 0x1E:
            return i
    return None


def _split_alt_records(region: bytes) -> Tuple[List[bytes], bytes]:
    """Split no-descriptor scene region by the `00 00 16 01` tail marker."""
    records: List[bytes] = []
    pos = 0
    while pos < len(region):
        idx = region.find(_ALT_RECORD_TAIL, pos)
        if idx < 0:
            break
        rec_end = idx + len(_ALT_RECORD_TAIL)
        records.append(region[pos:rec_end])
        pos = rec_end
    return records, region[pos:]


def _decode_matrix_payload(payload: bytes) -> Optional[Tuple[Tuple[int, ...], Tuple[int, ...]]]:
    """Decode matrix payload into 8 track pattern indices + token widths.

    Pattern token forms:
      - 1 byte: `value` for 0..8
      - 2 bytes: `01 00` for value 1 (observed in `unnamed 156`)
    """
    target = 8

    def dfs(index: int, values: List[int], widths: List[int]) -> Optional[Tuple[Tuple[int, ...], Tuple[int, ...]]]:
        remaining_slots = target - len(values)
        remaining_bytes = len(payload) - index
        if remaining_slots < 0:
            return None
        if remaining_slots == 0:
            if index == len(payload):
                return tuple(values), tuple(widths)
            return None
        if remaining_bytes < remaining_slots or remaining_bytes > remaining_slots * 2:
            return None
        if index >= len(payload):
            return None

        b = payload[index]
        if b > 8:
            return None

        # Long-form P2 token (01 00)
        if b == 1 and index + 1 < len(payload) and payload[index + 1] == 0:
            out = dfs(index + 2, values + [1], widths + [2])
            if out is not None:
                return out

        # Single-byte token
        return dfs(index + 1, values + [b], widths + [1])

    return dfs(0, [], [])


def _decode_matrix_record(raw: bytes) -> Optional[MatrixSceneVector]:
    if not raw.endswith(_ALT_RECORD_TAIL):
        return None
    decoded = _decode_matrix_payload(raw[: -len(_ALT_RECORD_TAIL)])
    if decoded is None:
        return None
    patterns, widths = decoded
    return MatrixSceneVector(patterns=patterns, widths=widths, raw=raw)


def encode_matrix_scene_vector(
    patterns: Sequence[int],
    *,
    widths_hint: Optional[Sequence[int]] = None,
) -> bytes:
    """Encode one matrix scene vector (T1..T8 pattern indices, 0-based)."""
    if len(patterns) != 8:
        raise ValueError(f"matrix scene vector must contain 8 tracks, got {len(patterns)}")
    if widths_hint is not None and len(widths_hint) != 8:
        raise ValueError(f"widths_hint must contain 8 entries, got {len(widths_hint)}")

    payload = bytearray()
    for i, pattern in enumerate(patterns):
        if not 0 <= pattern <= 8:
            raise ValueError(f"pattern index out of range at track {i + 1}: {pattern}")
        width = widths_hint[i] if widths_hint is not None else 1
        if pattern == 1 and width == 2:
            payload += b"\x01\x00"
        else:
            payload.append(pattern)
    return bytes(payload) + _ALT_RECORD_TAIL


def detect_scene_region_format(pre_track: bytes) -> str:
    """Return the pre-track scene encoding family for this project."""
    ht_start = _find_handle_table_start(pre_track)
    desc_start = _find_descriptor_start(pre_track, ht_start)
    if desc_start is not None:
        return SCENE_FORMAT_TAG_RECORDS

    region_start = pre_track.rfind(b"\x00\x00\x01\x40", 0, ht_start)
    if region_start >= 0:
        region_start += 4
    else:
        region_start = 0x50
    region = pre_track[region_start:ht_start]
    if not region:
        return SCENE_FORMAT_NONE
    records, _ = _split_alt_records(region)
    if not records:
        return SCENE_FORMAT_NONE
    if any(_decode_matrix_record(raw) is not None for raw in records):
        return SCENE_FORMAT_MATRIX_RECORDS
    return SCENE_FORMAT_ALT_RECORDS


def find_scene_region(pre_track: bytes) -> Tuple[int, int]:
    """Locate the scene record region within the pre-track data.

    Supports two known families:
    1. `tag_records`: descriptor-anchored region (`desc+4 .. handle_table`).
    2. no-descriptor branch (`j06/bleez/156`): region starts after the final
       `00 00 01 40` anchor before the handle table.
    """
    ht_start = _find_handle_table_start(pre_track)
    desc_start = _find_descriptor_start(pre_track, ht_start)
    if desc_start is not None:
        return desc_start + 4, ht_start

    anchor = pre_track.rfind(b"\x00\x00\x01\x40", 0, ht_start)
    if anchor >= 0:
        return anchor + 4, ht_start
    return 0x50, ht_start


def decode_scene_region(pre_track: bytes) -> List[SceneRecord]:
    """Parse all scene records from the pre-track data.

    Scene records sit between the descriptor (+4 bytes) and the handle
    table. Each record ends with [track_tag] 01 00 00 where track_tag
    is a valid tag byte (0x16-0x1D). Records after the first are
    preceded by a single 00 delimiter byte.

    Structure: [record1][00 record2][00 record3]...

    File 14 device capture confirmed: first record has no 00 prefix,
    subsequent records do. The [tag] 01 00 00 pattern is the reliable
    record boundary (plain 01 00 00 can appear mid-record).
    """
    start, end = find_scene_region(pre_track)
    region = pre_track[start:end]
    if not region:
        return []

    fmt = detect_scene_region_format(pre_track)
    if fmt == SCENE_FORMAT_TAG_RECORDS:
        # Find record boundaries by scanning for [tag] 01 00 00 where tag
        # is a valid track tag byte. Each such occurrence marks the end of
        # a record at position + 4.
        tail = b"\x01\x00\x00"
        record_ends = []
        i = 0
        while i < len(region) - 3:
            if region[i] in TAG_MAP and region[i + 1 : i + 4] == tail:
                record_ends.append(i + 4)
                i += 4
            else:
                i += 1

        records = []
        prev_end = 0
        for rec_end in record_ends:
            raw = region[prev_end:rec_end]
            records.append(_parse_known_record(raw))
            prev_end = rec_end
        return records

    # no-descriptor families (`j06`/`bleez`/`156`) split by `00 00 16 01`
    raw_records, _ = _split_alt_records(region)
    records: List[SceneRecord] = []
    for raw in raw_records:
        matrix = _decode_matrix_record(raw)
        if matrix is not None:
            overrides = tuple(
                SceneOverride(track=i + 1, pattern=pat)
                for i, pat in enumerate(matrix.patterns)
            )
            records.append(SceneRecord(overrides=overrides, raw=raw))
        else:
            # Keep undecoded forms opaque for round-trip safety.
            records.append(SceneRecord(overrides=tuple(), raw=raw))
    return records


def _parse_known_record(raw: bytes) -> SceneRecord:
    """Try to match raw bytes against known record forms, then structural parse."""
    if raw in KNOWN_FORMS:
        form = KNOWN_FORMS[raw]
        return SceneRecord(overrides=form.overrides, raw=raw)

    # Structural parse: record body ends with [00 00] [tag] [01 00 00]
    # The tag is at raw[-4] (4th byte from end, before the 01 00 00 tail)
    if len(raw) >= 7 and raw[-3:] == b"\x01\x00\x00" and raw[-5:-4] == b"\x00":
        tag_byte = raw[-4]
        if tag_byte in TAG_MAP:
            track = TAG_MAP[tag_byte]
            # Try to decode pattern from the prefix bytes
            # Strip leading 00 delimiter if present
            body = raw
            if body[0] == 0x00:
                body = body[1:]
            # Body structure: [01] [pattern_enc] [00 00] [tag] [01 00 00]
            # pattern_enc is between byte 1 and the 00 00 tag tail
            pattern = -1
            if len(body) >= 7 and body[0] == 0x01:
                pat_bytes = body[1:-6]  # Between initial 01 and 00 00 tag 01 00 00
                if pat_bytes == b"":
                    # No explicit pattern bytes — seen in T3→P2 (8B form)
                    pattern = -1
                elif pat_bytes == b"\x02":
                    pattern = 2
                elif pat_bytes == b"\x01\x00":
                    pattern = 1
                elif pat_bytes == b"\x01":
                    pattern = 1
            return SceneRecord(
                overrides=(SceneOverride(track=track, pattern=pattern),),
                raw=raw,
            )

    # Fallback: extract any track tags found
    overrides = []
    for i, b in enumerate(raw):
        if b in TAG_MAP:
            overrides.append(SceneOverride(track=TAG_MAP[b], pattern=-1))

    return SceneRecord(overrides=tuple(overrides), raw=raw)


def describe_record(record: SceneRecord) -> str:
    """Human-readable description of a scene record."""
    hex_str = " ".join(f"{b:02x}" for b in record.raw)
    size = len(record.raw)

    if record.overrides:
        parts = []
        for ov in record.overrides:
            if ov.pattern >= 0:
                parts.append(f"T{ov.track}→P{ov.pattern + 1}")
            else:
                parts.append(f"T{ov.track}→P?")
        desc = " + ".join(parts)
        return f"[{hex_str}] -> {desc} ({size}B)"
    else:
        return f"[{hex_str}] ({size}B)"


def decode_matrix_scene_vectors(pre_track: bytes) -> Tuple[List[MatrixSceneVector], bytes]:
    """Decode matrix vectors (`unnamed 156` family) and return trailing bytes."""
    if detect_scene_region_format(pre_track) != SCENE_FORMAT_MATRIX_RECORDS:
        return [], b""
    start, end = find_scene_region(pre_track)
    region = pre_track[start:end]
    raw_records, trailing = _split_alt_records(region)
    vectors: List[MatrixSceneVector] = []
    for raw in raw_records:
        parsed = _decode_matrix_record(raw)
        if parsed is not None:
            vectors.append(parsed)
    return vectors, trailing


def _valid_t16_scene_list(t16_body: bytes) -> Optional[List[int]]:
    count, ids = read_t16_scene_list(t16_body)
    if count <= 0 or count > 96:
        return None
    if len(ids) != count:
        return None
    if any(scene_id < 0 or scene_id > 98 for scene_id in ids):
        return None
    return ids


def read_scene_assignments(project: XYProject) -> Dict[int, Dict[int, int]]:
    """Read per-scene per-track pattern assignments (1-based scene/pattern IDs)."""
    fmt = detect_scene_region_format(project.pre_track)

    if fmt == SCENE_FORMAT_MATRIX_RECORDS:
        start, end = find_scene_region(project.pre_track)
        raw_records, _ = _split_alt_records(project.pre_track[start:end])
        vectors, _ = decode_matrix_scene_vectors(project.pre_track)
        # Hybrid matrix-like families (for example bleez35) can contain a mix
        # of decodable full vectors plus opaque records. Returning a partial
        # scene map is misleading; treat these as unresolved for now.
        if len(vectors) != len(raw_records):
            return {}
        out: Dict[int, Dict[int, int]] = {}
        for scene_num, vec in enumerate(vectors, start=1):
            out[scene_num] = {
                track: (pattern + 1)
                for track, pattern in enumerate(vec.patterns, start=1)
            }
        return out

    if fmt != SCENE_FORMAT_TAG_RECORDS:
        # No fully decoded scene schema yet for this family (for example bleez/j06).
        return {}

    # Tag-record families express sparse overrides. Expand to full 8-track map.
    records = decode_scene_region(project.pre_track)
    ids = _valid_t16_scene_list(project.tracks[15].body)
    scene_count = len(ids) if ids is not None else max(1, len(records) + 1)
    assignments: Dict[int, Dict[int, int]] = {
        scene_num: {track: 1 for track in range(1, 9)}
        for scene_num in range(1, scene_count + 1)
    }

    # In this family records are ordered by non-default scene targets:
    # first record family entry targets Scene 2, then Scene 3, etc.
    for rec_idx, record in enumerate(records):
        scene_num = 2 + rec_idx
        if scene_num > scene_count:
            break
        for ov in record.overrides:
            if 1 <= ov.track <= 8 and ov.pattern >= 0:
                assignments[scene_num][ov.track] = ov.pattern + 1
    return assignments


# ── T1 preamble formula ──────────────────────────────────────────────

T1_PREAMBLE_BASE = 0xD6
T1_PREAMBLE_STEP = 0x21


def t1_preamble_for_ordinal(ordinal: int) -> int:
    """Compute T1 preamble byte[0] for a given scene ordinal.

    DEPRECATED name — use t1_preamble_for_record_count() instead.
    Kept for backward compatibility with probes that used ordinal-based math.

    Formula: T1_preamble[0] = 0xD6 - (ordinal + 1) * 0x21
    """
    return T1_PREAMBLE_BASE - (ordinal + 1) * T1_PREAMBLE_STEP


def t1_preamble_for_record_count(record_count: int) -> int:
    """Compute T1 preamble byte[0] from the number of scene records.

    Formula: T1_preamble[0] = 0xD6 - (record_count + 1) * 0x21

    The +1 accounts for the base scene setup (scenes existing at all).
    File 14 confirmed this is driven by record count, NOT pre[0x0F] ordinal.

    Confirmed values:
      0 records: 0xB5 (files 01-03, scenes exist but no overrides)
      1 record:  0x94 (files 04, 05, 11, 12)
      2 records: 0x73 (files 07, 09, 14)
      3 records: 0x52 (probe 5)
    """
    return T1_PREAMBLE_BASE - (record_count + 1) * T1_PREAMBLE_STEP


# ── T16 scene list ────────────────────────────────────────────────────

T16_SCENE_COUNT_OFFSET = 0x6E7
T16_SCENE_IDS_OFFSET = 0x6E8


def read_t16_scene_list(t16_body: bytes) -> Tuple[int, List[int]]:
    """Read scene count and IDs from Track 16 body.

    Returns (count, [scene_ids]).
    """
    if len(t16_body) <= T16_SCENE_COUNT_OFFSET:
        return 0, []
    count = t16_body[T16_SCENE_COUNT_OFFSET]
    ids = list(t16_body[T16_SCENE_IDS_OFFSET : T16_SCENE_IDS_OFFSET + count])
    return count, ids


def write_t16_scene_list(t16_body: bytes, scene_ids: List[int]) -> bytes:
    """Write scene count and IDs into Track 16 body.

    Replaces the existing scene list (count + IDs) with the new list.
    The count byte at 0x6E7 is set to len(scene_ids), and the IDs
    are written starting at 0x6E8, replacing old IDs and adjusting
    for any length change.

    Args:
        t16_body: Original Track 16 body bytes.
        scene_ids: List of 0-based scene IDs to write.

    Returns:
        New Track 16 body bytes with updated scene list.
    """
    if len(t16_body) <= T16_SCENE_COUNT_OFFSET:
        raise ValueError("T16 body too short for scene list")

    old_count = t16_body[T16_SCENE_COUNT_OFFSET]
    old_end = T16_SCENE_IDS_OFFSET + old_count
    new_count = len(scene_ids)

    result = bytearray(t16_body)
    result[T16_SCENE_COUNT_OFFSET] = new_count
    # Replace old IDs region with new IDs
    new_body = (
        bytes(result[:T16_SCENE_IDS_OFFSET])
        + bytes(scene_ids)
        + bytes(result[old_end:])
    )
    return new_body
