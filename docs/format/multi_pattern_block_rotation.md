# Multi-Pattern Block Rotation

## Core Mechanism
Multiple patterns are represented by cloning/inserting track blocks inline, while keeping total top-level block slots at 16.
Displaced blocks are absorbed into trailing overflow packing (notably around block 15/16 regions in known captures).

## Preamble Semantics (Current)
- Leader preamble byte[0] is track-specific (e.g., `0x09` for activated leaders).
- Clone preamble byte[0] depends on the track slot:
  - T2, T5, T6, T7: `0x64` (standard propagation)
  - T3 (unactivated): `0x86` (default slot preamble)
  - T4 (EPiano): `0x2E` (exempt from 0x64, like T5 in single-pattern)
  - T1, T8: mix of `0x63`/`0x64` (possibly automation-dependent)
- `0x64` propagation has family-specific behavior; low-byte chains like `0x2E` can be exempt.

## Descriptor Strategy
- Two encoding schemes: Scheme A (T3+-only, gap/maxslot pairs, fully cracked)
  and Scheme B (T1/T2 involved, per-topology lookup).
- v56 and v57 at offsets 0x56-0x57 are **independent bytes** (T1/T2 max_slot),
  NOT a u16 LE pair.
- See `docs/format/descriptor_encoding.md` for complete encoding rules.

## Known-Good Writing Guidance
- Use `strict` strategy (default). Supports:
  - **Scheme B lookup**: T1, T1+T2, T1+T3, T1+T4, T1+T2+T3, T3, T4, T7
  - **Scheme A encoder**: any T3+-only combination (T5, T6, T8, T3+T7, etc.)
- v56/v57 set as independent per-track bytes (T1 and T2 max_slot respectively).
- For non-last patterns, derive from full-body donor before activation/insertion, then apply required tail trim.
- Mutate only target pattern bodies/preambles and keep unrelated descriptor/overflow bytes unchanged.
- See `docs/format/descriptor_encoding.md` for the full encoding reference.

## n110: 9-Pattern × 8-Track Clone Body Analysis

`src/unnamed 110.xy` → `n110_9pat_8track_notes.xy`: 9 patterns on all 8 tracks,
1 MIDI note per pattern (via MIDI harness), T3 empty (MIDI channel not set).

**Key findings:**
- 80 track signatures (8 tracks × 9 patterns + 8 aux)
- Descriptor: `v56=08, v57=08, insert=06 00 00 16 01 00 00` (matches j06)
- **Clone bodies are byte-identical to leaders except for the note byte.**
  On 5 tracks (T2, T4, T5, T6, T7), leaders and clones differ by exactly 1 byte.
- Event offset within the body is **stable** across all 9 patterns per track.
- All activated clones are type 0x07 (same as leader). T3 clones are type 0x05 (empty).
- P9 (last clone) is 1-2 bytes longer than other blocks on every track.
- Flag 0x03 (automation-follows) appeared randomly on some T1/T8 patterns —
  recording artifact from MIDI harness, not structural.
- **Authoring strategy confirmed**: copy leader body, change only the note byte(s).

## j06/j07 and 105b Era Findings
- `j06/j07` confirms large-topology stability for specific descriptor variant and addressing map.
- `105b` confirms non-T1 leader-note serialization branch requirements.
- v7 diagnostics confirm prior crash root cause was T3 leader insertion offset, not merely leader activation density.

## Deep History
- Legacy early model (`unnamed 102-105`) and later scaffold findings are preserved in:
  - `docs/logs/2026-02-12_multipattern_breakthrough.md`
  - `docs/logs/2026-02-13_agents_legacy_snapshot.md`
