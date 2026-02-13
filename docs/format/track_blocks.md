# Track Blocks

## Block Discovery
- Track signature: `00 00 01 03 ff 00 fc 00`.
- Baseline file (`unnamed 1.xy`) has 16 track-block starts at:
  - `0x0080, 0x07AC, 0x0EB0, 0x1057, 0x1245, 0x13EC, 0x15A1, 0x176B, 0x1A5D, 0x1BBA, 0x1D17, 0x1E28, 0x1F85, 0x20D9, 0x222A, 0x2388`.

## Core Fields
- Type byte at `block+0x09` governs `0x05` (padding-present) vs `0x07` (padding-removed) body layout.
- Engine ID lives in the body (`type-05`: `body[0x0D]`, `type-07`: `body[0x0B]`).
- Pointer table and activation masks occupy early block space and change when parameters are touched.

## Engine Families (Track 1 sweep)
- Axis/Dissolve/Hardsync: shared pointer-table skeleton with `'  N'` marker when no preset string is present.
- Drum/Sampler/Multisampler: sampler-style lattice (`0x01000040`-style repeats).
- Prism/Simple/Wavetable: 7F-heavy pointer families.
- EPiano/Organ/MIDI: distinct specialized layouts.

## Preset String Region
- Track 1 preset strings appear near absolute `0x1040` in baseline captures.
- Example baseline contains null-terminated `"bass"` and `"/shoulder"` slices.
- Selecting "No preset" wipes this region to mostly `0x00/0xFF` padding.

## Subsystem Details
- P-lock encoding: `docs/format/plocks.md`
- Mod routing/automation slab: `docs/format/mod_routing.md`
- Event payloads appended to track bodies: `docs/format/events.md`

## Notes
For full byte-level per-engine tables and historical experiments, see `docs/logs/2026-02-13_agents_legacy_snapshot.md`.
