# Multi-Pattern Block Rotation

## Core Mechanism
Multiple patterns are represented by cloning/inserting track blocks inline, while keeping total top-level block slots at 16.
Displaced blocks are absorbed into trailing overflow packing (notably around block 15/16 regions in known captures).

## Preamble Semantics (Current)
- Leader preamble byte[1] tracks pattern count.
- Clone blocks use `byte0=0x00` and carry propagation behavior in byte[1].
- `0x64` propagation has family-specific behavior; low-byte chains like `0x2E` can be exempt.

## Descriptor Strategy
- Do not assume one fixed descriptor insertion offset or one universal blob shape.
- Treat pre-track descriptor bytes as topology/scaffold-specific data.
- Preserve scaffold descriptor bytes verbatim in writer paths.

## Known-Good Writing Guidance
- Prefer `strict` strategy with validated topology sets (`T1`, `T1+T3`).
- For non-last patterns, derive from full-body donor before activation/insertion, then apply required tail trim.
- Mutate only target pattern bodies/preambles and keep unrelated descriptor/overflow bytes unchanged.

## j06/j07 and 105b Era Findings
- `j06/j07` confirms large-topology stability for specific descriptor variant and addressing map.
- `105b` confirms non-T1 leader-note serialization branch requirements.
- v7 diagnostics confirm prior crash root cause was T3 leader insertion offset, not merely leader activation density.

## Deep History
- Legacy early model (`unnamed 102-105`) and later scaffold findings are preserved in:
  - `docs/logs/2026-02-12_multipattern_breakthrough.md`
  - `docs/logs/2026-02-13_agents_legacy_snapshot.md`
