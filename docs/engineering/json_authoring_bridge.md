# JSON Authoring Bridge (op-xy-live -> xy-format)

This repo now has a JSON-to-`.xy` compile path via:
- `xy/json_build_spec.py`
- `tools/build_xy_from_json.py`

## Inspiration Taken From `op-xy-live`
- Pattern-oriented JSON payloads are easy for coding agents to edit.
- `toConfig()`/`dumpSystemState()` style snapshots are useful as an LLM-facing contract.
- Keep JSON human-readable and shallow enough for quick iterative edits.

## Intentional Differences
- `op-xy-live` JSON surfaces describe live MIDI/runtime behavior.
- `xy-format` JSON spec describes an offline file build request that compiles to binary `.xy`.
- The compiler is constrained to existing known-safe writer paths, not arbitrary synthesis.

## Current JSON Contract Scope
- `multi_pattern` mode only:
  - one-pattern form (all listed tracks have `patterns` length `1`) maps to `append_notes_to_tracks`.
  - multi-pattern form (all listed tracks have `patterns` length `>=2`) maps to `build_multi_pattern_project`.
  - pass through `descriptor_strategy` (`strict` or `heuristic_v1`) for multi-pattern form.
- Optional header patch:
  - `tempo_tenths`, `groove_type`, `groove_amount`, `metronome_level`.

## Guardrails
- Spec versioned (`version: 1`).
- Strong range checks for track/note/timing fields.
- Output re-parsed through `XYProject` for structural round-trip sanity.

## Near-Term Extensions
- Add optional event-type override only where backed by preset evidence.
- Add step-component/p-lock sections once pointer-tail decode reaches stable coverage.
- Add scaffold presets so agents can select topology-safe templates by name.
