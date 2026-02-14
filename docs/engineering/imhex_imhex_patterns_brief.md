# ImHex + ImHex Patterns Brief

## Goal
Use ImHex and its pattern language to speed up OP-XY `.xy` format decoding, especially for pointer-tail and descriptor-heavy regions where plain text diffs are slow to interpret.

This brief is a planning document only. It does not imply immediate tool adoption.

## Why This Fits Current Repo Needs

### Problem Shape in This Repo
- We already have strong scripted tooling (`inspect_xy.py`, `corpus_lab.py`, `corpus_compare.py`) for structural summaries and indexed diffs.
- The remaining hard work is byte-level interpretation of partially known areas:
  - Pointer-tail and pointer-21 slabs (`track+0x16xx` and related ladders).
  - Topology-dependent descriptor insertion and handle-table boundaries.
  - Cases where writer changes shift offsets and make raw side-by-side diff noisy.
- Crash classes show that tiny structural mistakes are high impact:
  - `num_patterns > 0` assertions from alignment and preamble errors.
  - `fixed_vector` overflow from wrong event family/shape assumptions.

### Why ImHex Specifically
- Visual region overlays make "known vs unknown" boundaries explicit.
- Pattern declarations let us encode current facts without pretending everything is decoded.
- Fast iterative inspection works well for reverse engineering:
  - edit pattern
  - reload file
  - inspect decoded fields and raw bytes together
  - compare against corpus annotations and device behavior
- Good fit for promoting knowledge from `docs/logs/*` into stable structured definitions.

## What ImHex + Patterns Would Add

### 1) Pattern-Backed Visual Decode
- Represent known header and track fields as typed structures.
- Keep unknown fields as raw bytes to preserve safety assumptions.
- Label offsets and field names directly on the byte view.

### 2) Targeted Pointer-Tail Analysis
- Define the ladder fields and candidate node records in a reusable pattern module.
- Toggle between raw view and parsed candidates when validating step/gate hypotheses.
- Highlight unresolved records instead of silently skipping them.

### 3) Better Shift/Alignment Triage
- During descriptor/preamble experiments, quickly see which block boundaries moved and which values remained stable.
- Reduce time spent doing manual offset arithmetic from hex dumps.

### 4) Faster Knowledge Transfer
- Pattern files become executable documentation that can be reviewed alongside `docs/format/*`.
- New contributors can inspect files visually before touching parser code.

## Proposed Pilot Scope

### Scope Boundaries
- Read-only analysis workflow.
- No writer changes.
- No replacement of current Python inspection pipeline.

### Pilot Inputs
- Baseline and one-off corpus files in `src/one-off-changes-from-default/`.
- Known problematic cases:
  - pointer-tail / pointer-21 files (`unnamed 38`, `39`, `65`, `80`, `87`)
  - multi-pattern descriptor variants (`unnamed 6`, `7`, `105`, `105b`, `j06`, `j07`)

### Pilot Deliverables
1. Initial pattern pack covering:
  - Header fields
  - Pre-track region with descriptor and handle-table framing
  - Track block signature, preamble, type-dependent engine position
  - Event headers and known stable parts
2. Pointer-tail exploratory pattern module:
  - pointer words
  - candidate tail entry records
  - unresolved slabs flagged as raw regions
3. One short workflow doc:
  - how to open corpus files
  - how to apply pattern modules
  - how to export findings back into repo docs/tests

### Suggested Repository Layout (if adopted)
- `tools/imhex/patterns/opxy_header.hexpat`
- `tools/imhex/patterns/opxy_pretrack.hexpat`
- `tools/imhex/patterns/opxy_track_blocks.hexpat`
- `tools/imhex/patterns/opxy_events.hexpat`
- `tools/imhex/patterns/opxy_pointer_tail_experimental.hexpat`
- `docs/tools/imhex.md` (usage guide)

### Example Pattern Skeleton (Illustrative)
```c
// Illustrative structure only; exact syntax/fields may differ.
struct XYHeader {
    u32 magic;
    u32 version_word;
    u16 tempo_tenths;
    u8 groove_flags;
    u8 groove_type;
    u8 groove_amount;
    u8 metronome_level;
};

struct TrackPreamble {
    u8 pre0;
    u8 pattern_count_or_chain;
    u8 pattern_length_byte;
    u8 pre3;
};
```

## Integration with Existing Workflow

### Keep Current Source of Truth
- Canonical stable behavior remains in `docs/format/*`.
- Narrative and hypotheses remain in `docs/logs/*`.
- Python parser/writer/test suite remains authoritative for automation and CI.

### Use ImHex as an Analyst Accelerator
- Use ImHex to validate or reject byte-layout hypotheses faster.
- Promote only device-validated findings into parser logic and tests.

## Decision Gates and Success Criteria

### Success Criteria
- Pointer-tail sessions produce clearer, faster step/gate hypotheses with fewer manual offset errors.
- Descriptor investigations require less ad-hoc hex dump scripting.
- At least one unresolved issue gets materially narrowed by pattern-backed visual evidence.

### Failure Criteria
- Pattern maintenance overhead exceeds analysis value.
- Findings are not reproducible in scripted tools/tests.
- Team still relies primarily on manual hex arithmetic despite having patterns.

### Risks and Mitigations
- Risk: patterns encode guesses as facts.
  - Mitigation: separate `stable` and `experimental` pattern files; mark unknowns explicitly.
- Risk: drift between pattern files and Python parser.
  - Mitigation: require doc/test update whenever pattern knowledge is promoted.
- Risk: adoption friction.
  - Mitigation: start with a narrow pilot focused on pointer-tail and descriptor hotspots.

### Recommendation
- Run a bounded pilot centered on pointer-tail/pointer-21 decode support.
- Keep scope read-only and evidence-focused.
- Continue using existing Python tools for corpus indexing, compare reports, and regression tests.
