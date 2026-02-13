# Event Type Selection

## Primary Rule
Event type is preset-driven, not purely engine-driven or slot-driven.

## Confirmed Type Set
`0x1C`, `0x1D`, `0x1E`, `0x1F`, `0x20`, `0x21`, `0x22`, `0x25`, `0x2D`

## Key Constraints
- Track 1: known-safe path remains `0x25` only.
- Track 4 EPiano paths: `0x1F` validated.
- Track 6 Hardsync paths: `0x1E` validated.
- Track 7 Axis paths: `0x20` validated.
- Many other tracks/presets safely use `0x21`, but do not over-generalize without matching preset evidence.

## Proven Experiments
- Same preset on different slots can keep the same type.
- Same engine with different presets can produce different types.
- Engine-swap/no-preset states can produce fallback `0x2D`.

## Authoring Guidance
1. Prefer the event type observed in a device-authored file for the same preset.
2. For Track 1, keep `0x25` unless new device evidence proves otherwise.
3. Treat `0x2D` as constrained and risky for multi-note authoring.

## Evidence and History
See `docs/logs/2026-02-13_agents_legacy_snapshot.md` for full preset/type tables and test matrix.
