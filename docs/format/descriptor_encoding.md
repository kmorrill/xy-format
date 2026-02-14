# Pre-Track Descriptor Encoding

## Overview

When a project has multiple patterns on any track, a **descriptor** is inserted
into the pre-track region (between the global header and the first track block).
The descriptor tells the firmware which tracks have extra patterns and how to
navigate the block rotation layout.

This document is the authoritative reference, superseding the earlier
`pretrack_pattern_directory.md` (which is retained for legacy context).

## Structure

The descriptor occupies a variable-length region starting at offset **0x56**
in the pre-track, immediately before the 36-byte handle table (12 × 3-byte
entries, `FF 00 00` = unused).

```
Offset 0x56:  [v56]          T1 max_slot (pattern_count - 1; 0 if single)
Offset 0x57:  [v57]          T2 max_slot (pattern_count - 1; 0 if single)
Offset 0x58+: [body]         T3-T8 encoding (variable length)
              [token]        Last-track token (1 byte, >= 0x16)
              [0x01]         Constant marker
              [0x00 0x00]    Sentinel / terminator
              [FF 00 00 …]  Handle table begins
```

### Key facts

- **v56 and v57 are independent bytes**, NOT a u16 LE pair.
- The **token** identifies the highest-numbered multi-pattern track:
  `token = 0x1E - track_1based` (T1→0x1D, T2→0x1C, T3→0x1B, … T8→0x16).
- Token `0x1E` is a special **short form** (see below).
- The `[0x00 0x00]` sentinel marks the end of the descriptor and the start
  of the handle table.
- Total descriptor length = 2 (v56/v57) + body_len + 2 (token + marker) + 2 (sentinel).

## Encoding Schemes

The body@0x58 encoding depends on whether T1/T2 are among the multi-pattern
tracks.

### Scheme A: T3+ Only (v56=0, v57=0)

When only T3-T8 tracks have multiple patterns, the body uses **gap/maxslot
pairs**:

```
body = [gap₁ maxslot₁] [gap₂ maxslot₂] … [0x00 0x00]
```

- **gap** = `track_1based - 3` (T3→0, T4→1, T5→2, T6→3, T7→4, T8→5)
- **maxslot** = `pattern_count - 1` (always ≥ 1 for listed tracks)
- **`[0x00 0x00]`** terminates the pair list (gap=0 + maxslot=0 = invalid entry)

The firmware reads pairs until it encounters `[0x00 0x00]`, then reads the
token.

**Confirmed specimens:**

| Specimen | Tracks | Body | Decoding |
|----------|--------|------|----------|
| m01 | T3×2 | `00 01 00 00` | gap=0(T3), slot=1, term |
| m02 | T4×2 | `01 01 00 00` | gap=1(T4), slot=1, term |
| m03 | T7×2 | `04 01 00 00` | gap=4(T7), slot=1, term |
| j04 | T4×2 | `01 01 00 00` | same as m02 (clone note doesn't change it) |

**Predicted (not yet captured):**

| Tracks | Predicted body |
|--------|----------------|
| T5×2 | `02 01 00 00` |
| T6×2 | `03 01 00 00` |
| T8×2 | `05 01 00 00` |
| T3+T7 | `00 01 04 01 00 00` |

**Encoder formula** (implemented in `project_builder.py`):

```python
body = b""
for track in sorted(multi_t3plus_tracks):
    gap = track - 3  # 1-based track number minus 3
    maxslot = pattern_counts[track] - 1
    body += bytes([gap, maxslot])
body += b"\x00\x00"  # terminator
```

#### Short Form (Leader Active)

When the leader pattern of a T3+ multi-pattern track contains notes, the
firmware uses a **short form** descriptor:

```
body = (empty)    token = 0x1E    marker = 0x01
```

Full var_0x56: `00 00 1E 01 00 00`

This was observed in j03 (T4×2, leader has notes) vs j04 (T4×2, only clone
has notes → normal form). The short form means "multi-patterns exist but the
firmware can detect the layout from the block data directly."

**Important**: We do NOT currently implement short form in our writer. All our
multi-pattern files use the normal form, which works regardless of activation
state.

### Scheme B: T1/T2 Involved (v56>0 or v57>0)

When T1 and/or T2 have multiple patterns, the body encodes T3+ track
information in a different format. The exact encoding rules are not fully
generalized, but all common topologies have device-verified descriptors.

**Verified specimens and their body@0x58:**

| Specimen | Topology | v56 | v57 | Body@0x58 |
|----------|----------|-----|-----|-----------|
| unnamed 6 | T1×2 | 01 | 00 | `00` |
| unnamed 7 | T1×3 | 02 | 00 | `00` |
| j05 | T2×3 | 00 | 02 | `00 00` |
| m05 | T1×2+T2×2 | 01 | 01 | `00 00 00` |
| unnamed 105 | T1×2+T3×2 | 01 | 00 | `01 00 00` |
| m09 | T1×2+T4×2 | 01 | 00 | `00 00 01 00 00` |

**Observed patterns in the body:**

For topologies with T3+ multi-pattern tracks:
- A multi-pattern T3+ track contributes `[maxslot] [00 00]` (3 bytes)
- A gap T3+ track (between T3 and the last multi T3+ track) contributes
  `[00 00]` (2 bytes)
- Verified: unnamed 105 (T3 multi, no gaps → `01 00 00`),
  m09 (T3 gap + T4 multi → `00 00 01 00 00`)

For topologies with NO T3+ multi-pattern tracks, the body is 1-3 zero bytes.
The exact rule is unclear but values are known:
- T1 only: `00` (1 byte)
- T2 only: `00 00` (2 bytes)
- T1+T2: `00 00 00` (3 bytes)

**9-pattern encoding** (j01, j06) uses run-count compression in the body
rather than per-track entries. This is not yet fully formalized and is beyond
the scope of 2-pattern authoring.

## Complete Descriptor Table

All verified descriptors from device captures, showing the full insert bytes
at 0x58 (body + token + marker) and the required v56/v57 values:

| Track Set | v56 | v57 | Insert@0x58 | Source |
|-----------|-----|-----|-------------|--------|
| {T1} | `max` | `00` | `00 1D 01 00 00` | unnamed 6/102/103 |
| {T2} | `00` | `max` | `00 00 1C 01 00 00` | j05 (extrapolated for ×2) |
| {T3} | `00` | `00` | `00 01 00 00 1B 01 00 00` | m01 |
| {T4} | `00` | `00` | `01 01 00 00 1A 01 00 00` | m02/j04 |
| {T7} | `00` | `00` | `04 01 00 00 17 01 00 00` | m03 |
| {T1,T2} | `max` | `max` | `00 00 00 1C 01 00 00` | m05 |
| {T1,T3} | `max` | `00` | `01 00 00 1B 01 00 00` | unnamed 105 |
| {T1,T4} | `max` | `00` | `00 00 01 00 00 1A 01 00 00` | m09 |
| {T1,T2,T3} | `max` | `max` | `01 00 00 1B 01 00 00` | m06 |

Where `max` = `pattern_count - 1` for that track.

## Remaining Unknowns

1. ~~**T1+T2+T3** (m06 experiment pending)~~ **CONFIRMED** by m06: v56=01,
   v57=01, insert@0x58 = `01 00 00 1B 01 00 00` — byte-perfect match to
   prediction. The Scheme B body for T3+ multi-tracks is `[maxslot 00 00]`
   regardless of whether T1/T2 are present. Added to `_STRICT_DESCRIPTORS`.

2. **Multi-entry Scheme A**: T3+T7 both with 2 patterns (no T1/T2). Predicted
   body `00 01 04 01 00 00` — high confidence from the single-entry pattern,
   but no device specimen yet.

3. **T5, T6, T8 single-track**: Gap values 2, 3, 5 predicted by formula,
   highly confident but not device-captured.

4. **Mixed pattern counts**: e.g., T1×2 + T3×3. Does v56 encode T1's max_slot
   independently from T3's? Almost certainly yes, but not tested.

5. **9-pattern run-count encoding**: j01/j06 suggest a run-length scheme for
   the T3+ body when many tracks share the same pattern count. Not relevant
   for 2-pattern authoring.

6. **Activation-dependent descriptor changes** in complex topologies (j02 vs
   j01): When leaders are active in multi-track 9-pattern cases, v56/v57
   values change. Not relevant for 2-pattern authoring where we always use
   the "blank leader" form.

## m06 Results (CONFIRMED)

m06 (T1+T2+T3, all ×2, blank) — `src/unnamed 109.xy` renamed to
`src/one-off-changes-from-default/m06_t1t2t3_2pat_blank.xy`:
- v56=01, v57=01, insert@0x58 = `01 00 00 1B 01 00 00` — **byte-perfect
  match** to prediction
- 19 track signatures (16 baseline + 3 clones: T1, T2, T3 each ×2)
- Confirms Scheme B body for T3+ multi-tracks uses `[maxslot 00 00]`
  identically whether T1-only or T1+T2 are present
- This validates a general Scheme B encoder for any combination of T1/T2/T3+
  tracks with 2 patterns

## Related

- Block rotation mechanics: `docs/format/multi_pattern_block_rotation.md`
- Experiment matrix: `docs/experiments/descriptor_matrix.md`
- Legacy model: `docs/format/pretrack_pattern_directory.md`
