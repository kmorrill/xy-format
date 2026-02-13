# AGENTS: OP-XY Reverse Engineering

## Mission
- Decode the `.xy` project format so we can parse, edit, and eventually write valid projects off-device.
- Keep stable format knowledge in `docs/format/*` and historical findings in `docs/logs/*`.
- Prefer byte-accurate, device-validated rules over heuristics.
- Preserve unknown bytes for round-trip safety until decoded.

## Repo Map
- Docs index: `docs/index.md`
- Manual breakdown text: `docs/OP-XY_project_breakdown.txt`
- One-off corpus + UI deltas: `src/one-off-changes-from-default/op-xy_project_change_log.md`
- Workflow docs: `docs/workflows/`
- Tool docs: `docs/tools/`
- Stable reference limits: `docs/reference/opxy_limits.md`
- MIDI CC reference: `docs/reference/opxy_midi_cc_map.md`
- Format reference (canonical): `docs/format/`
- Engineering implementation notes: `docs/engineering/`
- Crash catalog: `docs/debug/crashes.md`
- Active issues: `docs/issues/index.md`
- MIDI CC/p-lock discovery log: `docs/logs/2026-02-13_midi_cc_plock_discovery.md`
- Prior long-form notebook snapshot: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
- Current roadmap: `docs/roadmap.md`

## Operating Norms
- Keep generated device test filenames short and sortable.
- When proposing multiple files to test, the intended test order must match alphabetical filename order.
- Use prefixes like `a_`, `b_`, `c_` or `01_`, `02_`, `03_`.
- Record device outcomes with `python tools/corpus_lab.py record <file.xy> <pass|crash|untested> --note "..."`.
- Add new stable findings to the relevant file in `docs/format/*`; add dated narrative/debugging context to `docs/logs/*`.
- Every device crash must be captured with artifact + metadata + follow-up pass file using `docs/workflows/crash_capture.md`.
- Add or update the corresponding entry in `docs/debug/crashes.md` for every crash and every verified fix.
- Do not grow this file with chronology; keep this file as index + operating rules.

## Current Known-Safe Authoring Rules
- Multi-pattern writing: use scaffold-driven `strict` mode; treat descriptor bytes as topology-specific, not synthesized.
- For multi-pattern leader writes, activate/append in full-body space first; trim only where the validated branch requires it.
- Event types are preset-driven with slot constraints; Track 1 remains constrained to `0x25` in known-good authoring paths.
- Type transitions (`0x05` -> `0x07`) must preserve structural alignment rules (no stale padding).

## Top 3 Next Actions
1. Complete pointer-tail / pointer-21 decode so inspector can emit trustworthy `step` and `gate` for all event forms.
2. Consolidate remaining open descriptor/handle questions for non-`T1` topologies and expand scaffold captures.
3. Continue promoting stable findings from logs into canonical subsystem docs (`header`, `events`, `pretrack`, `track_blocks`).

## How To Run The Workflow
- Device naming: `docs/workflows/device_test_naming.md`
- Inspector sweep: `docs/workflows/inspector_sweep.md`
- Corpus index/query: `docs/tools/corpus_lab.md`
- Two-file structural diffs: `docs/tools/corpus_compare.md`
- Inspector usage: `docs/tools/inspect_xy.md`
- Header reader usage: `docs/tools/read_xy_header.md`
- Crash capture protocol: `docs/workflows/crash_capture.md`
