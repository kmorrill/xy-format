# Issues Index

## Active
- Pointer-tail and pointer-21 decode gaps: `docs/issues/pointer_tail_decoding.md`
- Preamble byte[0] state-machine + exception families: `docs/issues/preamble_state_machine.md`
- Remaining open questions captured in legacy notes: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
- Crash handling protocol and artifacts: `docs/workflows/crash_capture.md`

## Recently Resolved
- Writer type/padding misalignment (`0x05`/`0x07`) root cause.
- Early multi-track preamble propagation assumption that caused `num_patterns > 0` crashes.

## Cleanup / Follow-up Candidates
- Confirm/fix `find_track_handles()` assumptions wherever still referenced.
- Confirm and remove any stale writer triple-write patterns if still present in code.
