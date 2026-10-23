# AGENTS: OP-XY Reverse Engineering

## Mission
- Decode the `.xy` project format so we can parse, edit, and eventually write valid projects off-device.
- Keep stable format knowledge in `docs/format/*` and historical findings in `docs/logs/*`.
- Prefer byte-accurate, device-validated rules over heuristics.
- Preserve unknown bytes for round-trip safety until decoded.

## Repo Map
- Docs index: `docs/index.md`
- State of understanding (dated belief ledger — read before modeling work): `docs/state_of_understanding.md`
- Manual breakdown text: `docs/OP-XY_project_breakdown.txt`
- One-off corpus + UI deltas: `src/one-off-changes-from-default/op-xy_project_change_log.md`
- Workflow docs: `docs/workflows/`
- Tool docs: `docs/tools/`
- Stable reference limits: `docs/reference/opxy_limits.md`
- MIDI CC reference: `docs/reference/opxy_midi_cc_map.md`
- Format reference (canonical): `docs/format/`
- Firmware-derived grammar: `docs/format/serialization.md`
- Preset JSON and binary sound state: `docs/format/preset_json.md`
- Version migration chain: `docs/format/backward_compatibility.md`
- Spatial coverage ledger: `docs/format/spatial_coverage_ledger.md`
  (contiguous decoded-vs-opaque map of global, track, and sample-slot regions)
- Engineering implementation notes: `docs/engineering/`
- Companion musical-generation repo: `/Users/kevinmorrill/Documents/op-xy-live`
  - Use its `docs/op-xy-file-map-decoded-vs-mystery.md` for a worked generated-song file map.
  - Use its `docs/op-xy-project-sound-state-capture-plan.md` for sampler/preset project-state capture batches.
  - Keep byte-level format truth here; keep high-level track/preset/drum-generation abstractions there.
- Crash catalog: `docs/debug/crashes.md`
- Active issues: `docs/issues/index.md`
- MIDI CC/p-lock discovery log: `docs/logs/2026-02-13_midi_cc_plock_discovery.md`
- Prior long-form notebook snapshot: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
- **Roadmap (phases, missions, exit criteria): `docs/roadmap.md`**
- Parse & author checklist: `docs/parse_capability_checklist.md`
- Contributor inspection workflow: `docs/workflows/contributor_inspection_workflow.md`

## Operating Norms
- Keep generated device test filenames short and sortable.
- When proposing multiple files to test, the intended test order must match alphabetical filename order.
- Use prefixes like `a_`, `b_`, `c_` or `01_`, `02_`, `03_`.
- Record device outcomes with `python tools/corpus_lab.py record <file.xy> <pass|crash|untested> --note "..."`.
- Add new stable findings to the relevant file in `docs/format/*`; add dated narrative/debugging context to `docs/logs/*`.
- Every device crash must be captured with artifact + metadata + follow-up pass file using `docs/workflows/crash_capture.md`.
- Add or update the corresponding entry in `docs/debug/crashes.md` for every crash and every verified fix.
- Do not grow this file with chronology; keep this file as index + operating rules.

## The Model (firmware trace updated 2026-10-23)
- The `.xy` file is a serialized projection of runtime state, **byte-level
  RLE-compressed including the eight decoded header bytes** (two equal bytes
  → extension count). It contains little-endian scalars and count-prefixed
  vectors, not a byte-for-byte RAM dump. See `docs/format/serialization.md`.
- Codec `xy/rle.py` round-trips 245/246 corpus files byte-exact.
- Decoded field map: `docs/format/decoded_image_map.md` (global header,
  16 track structs, scene structs, song-table footer, drum-voice slots).
- Decoded spatial ledger: `docs/format/spatial_coverage_ledger.md` (which
  contiguous regions are decoded, partial, or still opaque).
- The whole "compositional serializer / descriptor scheme / preamble
  state machine / event type" apparatus was RLE artifacts; the full arc
  is in `docs/state_of_understanding.md`.

## Authoring Rules (device-verified)
- Author via the decoded image: `docs/engineering/authoring.md`
  (`xy/rle.py` + `xy/image_writer.py`). Decode baseline → edit fields/
  vectors → `encode_project`. No scaffolds, descriptors, event types,
  preamble propagation, or velocity nudge.
- A valid file is a **reachable machine state**: firmware both asserts and
  normalizes selected fields. Build coherent state; never invent byte layouts.
- Validation standard: replicate a device capture byte-exact, then
  device-test one authored file.

## Next Actions
1. Continue field polish on the decoded-image stack (`xy/image_writer.py`,
   `tools/spec_to_xy_image.py`, `tools/midi_to_xy.py`).
2. Finish minor field lookups (p-lock columns 13–18; drum pan vs fade at
   slot +0x05/+0x06) — corpus/optional-capture, non-blocking.
3. Consolidate `MEMORY.md` and keep old-model history confined to
   `docs/logs/*`.

## How To Run The Workflow
- Device naming: `docs/workflows/device_test_naming.md`
- Inspector sweep: `docs/workflows/inspector_sweep.md`
- Corpus index/query: `docs/tools/corpus_lab.md`
- Two-file structural diffs: `docs/tools/corpus_compare.md`
- Opaque-region variance index: `docs/tools/analyze_spatial_variance.md`
- Inspector usage: `docs/tools/inspect_xy.md`
- Header reader usage: `docs/tools/read_xy_header.md`
- Crash capture protocol: `docs/workflows/crash_capture.md`
