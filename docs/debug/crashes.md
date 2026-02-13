# Crash Catalog

## Reporting Standard
- Follow `docs/workflows/crash_capture.md` for every crash.
- Every crash entry must include:
  - failing artifact path (`.xy`)
  - source/template reference
  - generation command/parameters
  - device/firmware context
  - assertion text and stack trace (if available)
  - follow-up artifact path(s) and pass/crash outcome

## Crash #1: `num_patterns > 0`
- Context: early writer-produced file with type/padding misalignment.
- Root cause: `0x05/0x07` transition without removing required padding.
- Status: resolved in writer alignment guidance.

## Crash #2: `fixed_vector.h:77 length < thesize`
- Context: incorrect multi-note event encoding in early attempts.
- Significance: parser progressed past structural checks, then failed in note-event vector handling.
- Status: mitigated by corrected event family usage and encoding rules.

## Crash #3: `num_patterns > 0` (later-site assertion)
- Context: two-track drum authoring with incorrect preamble propagation assumptions.
- Root cause: missing required adjacent-track preamble propagation in that path.
- Status: resolved with corrected propagation rule set.

## Notes
Full historical crash details, callouts, and screenshots references are preserved in `docs/logs/2026-02-13_agents_legacy_snapshot.md`.
