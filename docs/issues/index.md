# Issues Index

## Active
- Crash handling protocol and artifacts: `docs/workflows/crash_capture.md`

## Resolved by the 2026-06-09 serialization-model breakthrough
See `docs/state_of_understanding.md` and `docs/format/record_structure.md`.
- **Sparse multi-pattern topology crash**: `docs/issues/sparse_topology_stability.md`
  — incoherent writer state, not sparseness; device-confirmed fix.
- **Pointer-tail / pointer-21 decode**: `docs/issues/pointer_tail_decoding.md`
  — the "pointer" tails were RLE'd note records + performance-lane slabs;
  both decode in image space (`docs/format/decoded_image_map.md`).
- **Preamble byte[0] state machine**: `docs/issues/preamble_state_machine.md`
  — the byte was a record-tail RLE artifact; the whole state machine
  dissolved (`docs/format/record_structure.md` §1, §3).
- Writer type/padding misalignment (`0x05`/`0x07`) — was the `+0x11`
  pristine flag's RLE shadow.
- Multi-track preamble propagation / `num_patterns > 0` crashes — RLE/
  state-coherence artifacts.

## Cleanup / Follow-up Candidates
- Confirm/fix `find_track_handles()` assumptions wherever still referenced.
- Confirm and remove any stale writer triple-write patterns if still present in code.
