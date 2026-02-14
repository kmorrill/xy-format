# P-Locks (Parameter Locks)

## Region Location
- P-lock region appears after engine-config tail bytes:
  - `40 1F 00 00 0C 40 1F 00 00`
- Exact offsets vary by engine/type; locate by signature, not fixed absolute offsets.
- Documented offsets (type-05): T1/T2/T3 = `body[0x26]`, T4 = `body[0x23]`, T5-T8 = `body[0x27]`.
- For type-07 bodies, subtract 2 from the type-05 offset.

## Core Encoding — Standard 5-Byte (T2-T8, Aux T9-T16)
- 48 entries total as 3 lanes x 16 steps.
- Empty entry: `FF 00 00` (3 bytes).
- Value entry: `[param_id] [val_lo] [val_hi] 00 00` (5 bytes per entry).
- First non-empty in a lane carries real `param_id`; follow-on entries use continuation marker `0x50`.
- Activation triggers type 0x05 → 0x07 transition.
- T2 with Drum engine (0x03) uses this standard 5-byte format, same as all other non-T1 tracks.

## Core Encoding — T1 Slot Only (18-Byte / 17-Byte)
- The T1 slot is special: it uses a **wider entry format** regardless of which engine is loaded.
  This is a property of the **slot**, not the engine — T2 Drum uses standard 5-byte entries above.
  - **Drum engine (0x03) on T1**: 18-byte entries
    - Empty: `FF 00 00` (3 bytes)
    - Header: `[param_id] [40 00 40 00 40 00 40 00 00 0a ff 7f e8 03 00 00 3a]` (18 bytes)
    - Value: `[val_lo] [val_hi] [00 40 00 40 00 40 00 00 0a ff 7f e8 03 00 00 3a]` (18 bytes)
  - **Swapped engine (e.g. 0x06) on T1**: 11-byte header + 17-byte value entries (two-lane interleaved)
- T1 may stay type 0x05 even with p-lock data (observed: +350B growth without type change).
- T1 param_ids are in a **separate address space** from synth tracks (see table below).

## T10 9-Byte Entry Format
- T10 (Punch-in aux) uses 9-byte entries instead of standard 5-byte:
  - Header: `[param_id] [initial_lo] [initial_hi] [00] [51] [meta_lo] [meta_hi] [00] [1c]` (9 bytes)
  - Value: `[val_lo] [val_hi] [00] [00] [31] [meta_lo] [meta_hi] [00] [1c]` (9 bytes)
  - Empty: `FF 00 00` (3 bytes, same)
- Header byte4=0x51 vs value byte4=0x31 (possibly header/continuation markers for second lane).
- Values correctly extracted from bytes 0-1 as u16 LE.
- Observed only on T10 with CC10 (Pan). Other aux tracks (T9, T11-T16) use standard 5-byte format.

## Value Mapping
- Value field: `u16 LE`, range `0..32767` (0x0000..0x7FFF).
- Formula: `stored = round((midi_cc_value / 127) * 32767)`.
- Inverse: `midi_cc = stored / 32767 * 127`.
- 0 = 0%, 32767 = 100%.

## Complete CC → param_id Table (MIDI Hold-Record)

### Synth Tracks (5-byte format, universal across engines)

param_ids are **universal** — the same CC maps to the same param_id regardless of engine type.
Verified across Prism, EPiano, Dissolve, Hardsync, Axis, Multisampler, and aux engines.

| param_id | CC | Parameter | Verified engines | Source |
|----------|-----|-----------|-----------------|--------|
| 0x5C | CC12 | Param 1 | Prism, aux-0x00, aux-0x05 | unnamed 121, 126 |
| 0x5E | CC13 | Param 2 | Drum (T2) | unnamed 121 |
| 0x60 | CC14 | Param 3 | Prism | unnamed 121 |
| 0x62 | CC15 | Param 4 | EPiano | unnamed 121 |
| — | — | — | *gap 0x64-0x6A (4 params, CC16-19?)* | — |
| 0x6C | CC20 | Amp Attack | Dissolve | unnamed 121 |
| 0x6E | CC21 | Amp Decay | Hardsync | unnamed 121 |
| 0x70 | CC22 | Amp Sustain | Axis | unnamed 121 |
| 0x72 | CC23 | Amp Release | Multisampler | unnamed 121 |
| 0x74 | CC28 | Flt Env Amount | Dissolve | unnamed 122 |
| 0x76 | CC29 | Flt Resonance | Hardsync | unnamed 122 |
| 0x78 | CC30 | Flt Key Track | Axis | unnamed 122 |
| 0x7A | CC31 | Flt Velocity | Multisampler | unnamed 122 |
| 0x7C | CC32 | Flt Cutoff | Prism (grid-entered) | unnamed 115 |
| 0x7E | CC33 | Flt Type | Drum (T2) | unnamed 123 |
| 0x80 | CC34 | LFO Rate | Prism | unnamed 123 |
| 0x82 | CC35 | LFO Depth | EPiano | unnamed 123 |
| 0x84 | CC36 | LFO Dest | Dissolve | unnamed 123 |
| 0x86 | CC37 | LFO Wave | Hardsync | unnamed 123 |
| 0x88 | CC38 | LFO Sync | Axis | unnamed 123 |
| 0x8A | CC39 | LFO Phase | Multisampler | unnamed 123 |
| 0x8C | CC40 | LFO Param | Prism (T12 aux) | unnamed 126 |
| 0x8E | CC41 | LFO Key Sync | Drum (T2) | unnamed 124 |
| — | — | — | *gap 0x90-0x9A* | — |
| 0x9C | CC24 | Flt Attack | *(predicted, CC24 = 0x9E-2)* | — |
| 0x9E | CC25 | Flt Decay | aux-0x06 (T2 swapped) | unnamed 122 |
| 0xA0 | CC26 | Flt Sustain | Prism | unnamed 122 |
| 0xA2 | CC27 | Flt Release | EPiano | unnamed 122 |
| — | — | — | *gap 0xA4-0xAA* | — |
| 0xAC | CC10 | Pan | Dissolve | unnamed 124 |
| 0xAE | CC7 | Volume | Prism, aux-Prism | unnamed 124, 126 |

### T1 Slot param_ids (separate address space)

| param_id | CC | Parameter | Engine | Source |
|----------|-----|-----------|--------|--------|
| 0x09 | CC12 | Param 1 | Drum (0x03) | unnamed 121 |
| 0x20 | CC24 | Flt Attack | Engine 0x06 (swapped) | unnamed 122 |
| 0x2C | CC32 | Flt Cutoff | Drum (0x03) | unnamed 123 |
| 0x3A | CC40 | LFO Param | Drum (0x03) | unnamed 124 |

### T10 Slot param_ids (9-byte format)

| param_id | CC | Parameter | Engine | Source |
|----------|-----|-----------|--------|--------|
| 0x39 | CC10 | Pan | Prism (0x12) | unnamed 126 |

### Grid-Entered param_ids (may differ from MIDI-recorded)

| param_id | CC | Parameter | Engine | Source |
|----------|-----|-----------|--------|--------|
| 0x08 | — | Macro 1 / Synth Param 1 | Prism | unnamed 35 |
| 0x7C | CC32 | Flt Cutoff | Prism | unnamed 115 |

### MIDI-Recorded param_ids (via hold-record CC capture)

| param_id | CC | Parameter | Engine | Source |
|----------|-----|-----------|--------|--------|
| 0xD0 | CC32 | Flt Cutoff | Prism (T3) | unnamed 120 |

**Note:** CC32 (Filter Cutoff) has param_id 0x7C when grid-entered (unnamed 115) vs 0xD0 when MIDI hold-recorded (unnamed 120). The main synth table above uses 0x7C (grid-entered ID). All other entries in the main table come from MIDI recording but happen to match the sequential 0x5C-0xAE range, suggesting the 0xD0 for CC32 may be an anomaly or the first MIDI-recorded CC32 (unnamed 120) used a different code path than later experiments.

## Sequential Pattern Analysis

param_ids increment by 2 for each parameter, grouped by firmware functional area:

```
0x5C-0x62: Synth Params 1-4 (CC12-15)
0x64-0x6A: [unmapped — CC16-19 or reserved]
0x6C-0x72: Amp Envelope ADSR (CC20-23)
0x74-0x7A: Filter Characteristics (CC28-31: Env Amt, Res, Key Trk, Vel)
0x7C-0x7E: Filter Cutoff + Type (CC32-33)
0x80-0x8E: LFO Parameters (CC34-41: Rate, Depth, Dest, Wave, Sync, Phase, Param, KeySync)
0x90-0x9A: [unmapped — possibly FX or reserved]
0x9C-0xA2: Filter Envelope ADSR (CC24-27: Attack, Decay, Sustain, Release)
0xA4-0xAA: [unmapped — possibly more mixer params]
0xAC-0xAE: Mixer (CC10=Pan, CC7=Volume)
```

The internal ordering does NOT follow MIDI CC numbering — filter ADSR (CC24-27) appears
AFTER LFO (CC34-41) in the param_id address space. This reflects firmware's internal
parameter table layout.

### Continuation Markers
- `0x50`: standard continuation for 5-byte synth entries.
- `0x31`: continuation for T10 9-byte entries.
- `0x1E`: continuation for T1 swapped-engine 17-byte entries.

## Sentinel / Metadata Bytes
- Sentinel byte follows trailing empties in the p-lock region.
- Known baseline values: Prism T3 = `0xDE`, Drum T1/T2 = `0xDF`.
- Sentinel changes when p-locks present: filter cutoff = `0xCE`, macro 1 = `0xEC`.
- After the sentinel, a step-component directory (16 x 4B records) appears when p-locks exist.
- Entries [53-54] (past the main table) contain per-track metadata — observed as `[byte] [val_lo] [00] [00]` + `[byte] [00] [00]`.

## Recording Methods
- **Grid-entered**: hold step on device, turn knob. Produces p-lock data directly.
- **MIDI hold-record** (discovered 2026-02-13): hold record button on device, send MIDI CCs externally.
  - No clock sync needed — CC values land on whatever steps align with playback timing.
  - Values are stored in the standard p-lock table format.
  - Verified across all 8 instrument tracks simultaneously (unnamed 121).
  - Verified across 8 aux tracks (unnamed 126).
  - Previous clock-synced MIDI recording (unnamed 95-100) did NOT store CC data — hold-record mode is required.
  - Sending notes alongside CCs causes device to enter clock-synced recording mode, which suppresses CC capture. CC mapping experiments must be CC-only.

## Additional Structures
- Additional metadata bytes may appear before synth parameter slabs.
- Full byte-level examples live in `docs/logs/2026-02-13_agents_legacy_snapshot.md`.
- Shared parser helpers live in `xy/plocks.py` (`find_plock_start`, standard table decode, T1/T10 helpers).
- Shared authoring helpers also live in `xy/plocks.py` (`rewrite_standard_nonempty_values`, `rewrite_standard_values_for_param_groups`).
- Project-level writer helpers live in `xy/project_builder.py`:
  - `transplant_track(...)` for donor topology transplant
  - `rewrite_track_standard_plock_values(...)` for single-lane/non-empty-order rewrites
  - `rewrite_track_standard_plock_groups(...)` for multi-lane grouped rewrites
  - default guardrails enforce known-safe standard value floor `>= 256`

## Open Questions
- Why does CC32 have param_id 0x7C (grid) vs 0xD0 (MIDI)? Are these different address spaces?
- What parameters live in the gaps (0x64-0x6A, 0x90-0x9A, 0xA4-0xAA)?
- Why does T10 use 9-byte entries while all other aux tracks use 5-byte?
- What do the sentinel metadata entries [53-54] encode?
- CC9 (Mute) did not produce p-lock data on T4 EPiano — is mute stored differently?
- Does CC24 (Flt Attack) confirm predicted param_id 0x9C? (T1 data was in T1-specific format)
- Remaining aux CC experiments (cc_map_2b-2d) not yet completed.
