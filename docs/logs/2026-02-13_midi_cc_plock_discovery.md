# 2026-02-13: MIDI CC → P-Lock Discovery

Canonical summaries now live in `docs/reference/opxy_midi_cc_map.md` and `docs/format/plocks.md`.
This file is the chronological experiment log.

## Breakthrough: External MIDI CCs Stored as P-Locks via Hold-Record

Previous experiments (unnamed 95-100) sent MIDI CCs during clock-synced recording and found they were NOT stored in the .xy file. Today we discovered that **hold-record mode** (holding the record button while sending CCs) DOES store them as p-lock data.

### Method
1. Fresh project on OP-XY, MIDI channels 1-8 mapped to tracks 1-8
2. Hold record button on device (NOT clock-synced — no MIDI Start/Stop)
3. Send CC ramps (0→127 over 16 steps) via `tools/midi_harness.py`
4. Export .xy file and diff against baseline

### Corpus Files
- **unnamed 120**: CC32 (filter cutoff) ramp on T3 only. First confirmation.
- **unnamed 121**: `cc_map_1a` — 8 tracks simultaneously:
  - T1=CC12(Param1), T2=CC13(Param2), T3=CC14(Param3), T4=CC15(Param4)
  - T5=CC20(AmpAttack), T6=CC21(AmpDecay), T7=CC22(AmpSustain), T8=CC23(AmpRelease)

### Results: unnamed 120 (single track)

T3 (Prism) gained +179 bytes, type 0x05→0x07. P-lock table at standard location after config tail. param_id = **0xD0** for CC32 filter cutoff. 12 steps captured (steps 3-14, offset due to no clock sync). Values map linearly: `stored = (cc/127) * 32767`.

### Results: unnamed 121 (8-track)

All 8 instrument tracks received p-lock data:

| Track | Engine | CC | Parameter | param_id | Size delta | Type change |
|-------|--------|----|-----------|----------|------------|-------------|
| T1 | Drum (0x03) | CC12 | Param 1 | **0x09** | +350B | 0x05→0x05 |
| T2 | Drum (0x03) | CC13 | Param 2 | **0x5E** | +120B | 0x05→0x05 |
| T3 | Prism (0x12) | CC14 | Param 3 | **0x60** | +115B | 0x05→0x07 |
| T4 | EPiano (0x07) | CC15 | Param 4 | **0x62** | +112B | 0x05→0x07 |
| T5 | Dissolve (0x14) | CC20 | Amp Attack | **0x6C** | +120B | 0x05→0x07 |
| T6 | Hardsync (0x13) | CC21 | Amp Decay | **0x6E** | +113B | 0x05→0x07 |
| T7 | Axis (0x16) | CC22 | Amp Sustain | **0x70** | +112B | 0x05→0x07 |
| T8 | Multi (0x1E) | CC23 | Amp Release | **0x72** | +112B | 0x05→0x07 |

**Pattern in IDs**: CC20-23 (Amp ADSR) map to sequential param_ids 0x6C, 0x6E, 0x70, 0x72 — incrementing by 2. This holds across completely different engines, suggesting param_ids are **universal** (not per-engine).

### T1 Drum Anomaly: 18-byte Entries

T1 Drum uses a different entry format from all other tracks:

**Standard (T2-T8)**: `[param_id] [val_lo] [val_hi] 00 00` (5 bytes)
**T1 Drum**: 18-byte entries with constant 16-byte suffix:
```
[val_lo] [val_hi] [00 40 00 40 00 40 00 40 00 00 0a ff 7f e8 03 00 00 3a]
```
First entry has param_id (0x09) as byte 0 instead of val_lo.

The ramp values are identical to T2's — same CC→stored formula. The extra bytes are constant per entry and may represent per-drum-key parameter context (T1 has 24 drum keys).

T1 also stayed type 0x05 (no transition to 0x07) and grew by +350B (vs ~112-120B for others). The extra bytes at the end contain sample path strings (`content/samples/conga/lc boop.wav`), suggesting CC12 Param 1 on Drum may trigger sample table updates.

T2 Drum (also engine 0x03) uses standard 5-byte entries and grew by only +120B. Why T1 differs from T2 is unknown.

### Value Encoding (confirmed)

```
stored_u16le = round((midi_cc_value / 127) * 32767)
```

Verified values from unnamed 121 T2 ramp (14 captured steps):
```
CC  8 → stored  2064 (0x0810)
CC 16 → stored  4128 (0x1020)
CC 25 → stored  6450 (0x1932)
CC 33 → stored  8514 (0x2142)
CC 42 → stored 10836 (0x2A54)
CC 50 → stored 12900 (0x3264)
CC 59 → stored 15222 (0x3B76)
CC 67 → stored 17287 (0x4387)
CC 76 → stored 19609 (0x4C99)
CC 84 → stored 21673 (0x54A9)
CC 93 → stored 23995 (0x5DBB)
CC101 → stored 26059 (0x65CB)
CC110 → stored 28381 (0x6EDD)
CC118 → stored 30445 (0x76ED)
```

### Experiment Infrastructure

Added to `tools/midi_harness.py`:
- `cc_map_1a` through `cc_map_1d`: 4 experiments covering all synth CCs (CC7-41) across T1-T8
- `cc_map_2a` through `cc_map_2d`: 4 experiments covering aux track CCs on T9-T16
- Helper `_make_cc_map_plan()` builds sweep experiments from (channel, cc) pairs
- Also added `cc_with_pb_cutoff`, `cc_with_pb_param1`, `cc_with_at_cutoff`, `pb_control` for piggybacking tests

### Completed Experiments
- `cc_map_1a` → unnamed 121: CC12-15 + CC20-23 on T1-T8
- `cc_map_1b` → unnamed 122: CC24-31 on T1-T8 (T1/T2 changed to synth engines)
- `cc_map_1c` → unnamed 123: CC32-39 on T1-T8
- `cc_map_1d` → unnamed 124: CC40-41 + CC7/9/10 on T1-T5
- `cc_map_multi` → unnamed 125: 3 CCs on T3 simultaneously
- `cc_map_2a` → unnamed 126: aux T9-T16 (Vol/Pan/CC12/CC40 mix)

### Outstanding Experiments
- `cc_map_2b`: CC13-14 on aux tracks (needs rework — T9/T10/T12 have no CC13/14 functions)
- `cc_map_2c`: HP/LP cutoff + sends on aux (needs rework — T9-T12 have no CC32)
- `cc_map_2d`: More aux CCs — LP cutoff, FX sends, LFO on remaining tracks (needs rework)

### Analysis Results (2026-02-13)

**Key finding: param_ids are UNIVERSAL across engines.** The same MIDI CC maps to the
same param_id regardless of engine type. Verified for CC7, CC10, CC12-15, CC20-23,
CC25-31, CC33-41 across Prism, EPiano, Dissolve, Hardsync, Axis, Multisampler, and aux engines.

**Sequential pattern:** param_ids increment by 2, grouped by firmware functional area:
- 0x5C-0x62: Synth Params 1-4 (CC12-15)
- 0x6C-0x72: Amp ADSR (CC20-23)
- 0x74-0x7A: Filter Characteristics (CC28-31)
- 0x7C-0x8E: Filter Cutoff/Type + LFO (CC32-41)
- 0x9C-0xA2: Filter ADSR (CC24-27) — after LFO in firmware memory!
- 0xAC-0xAE: Mixer Pan/Volume (CC10, CC7)

**Three entry format variants discovered:**
1. Standard 5-byte (synth T2-T8, aux T9/T11-T16): `[id/0x50] [lo] [hi] 00 00`
2. T1 18-byte drum: `[id/lo] [hi/const] [16B suffix]` — T1 has its own param_id space
3. T10 9-byte: `[id/lo] [hi/lo] [00] [00] [marker] [meta_lo] [meta_hi] [00] [1c]`

**Anomalies:**
- CC32 has two different param_ids: 0x7C (grid-entered) vs 0xD0 (MIDI first recording)
- CC9 (Mute) did not produce p-lock data on EPiano T4
- T1 slot uses a separate param_id address space (0x09, 0x20, 0x2C, 0x3A)
- T10 Punch-in uses 9-byte entries while other aux tracks use 5-byte

Full table in `docs/format/plocks.md`. Extraction tool: `tools/extract_plocks.py`.
