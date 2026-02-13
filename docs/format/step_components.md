# Step Components

## Single-Step Model (Validated)
- Components serialize into a slot table within active track bodies.
- Empty sentinel in common drum/synth captures: `FF 00 00`.
- Header packs step and component bank bitmasks.
- Standard component param block format (most types): `00 <type_id> <param> 00 00`.

## Allocation Marker
- Component activation requires updating an allocation byte/marker.
- Working formula (known caveats for random-mode variants):
  - `alloc = 0xF7 - step_0 * 0x10 - component_global_index`
- Wrong allocation bytes are crash-prone.

## Multi-Step Stream Model (unnamed 118/119)
- Full 16-step component captures use a contiguous variable-length block stream.
- This replaces the simpler isolated single-step slot assumptions.
- Block sizes vary by type (observed 4B, 6B, 8B, 9B, 10B).
- Bank-2 type `0x20` is confirmed as a distinct 14th component type.

## Authoring Recipe (Current)
1. Activate track body layout correctly.
2. Insert component payload at correct component-region position.
3. Update allocation marker.
4. Preserve unrelated body bytes and preamble semantics.

## Validation Status
- Multiple component types are device-verified.
- Some type-specific repeat/sub-parameter semantics remain open.

## Detailed Notes
- Legacy deep notes: `docs/step_component_notes.md`
- Historical section dump: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
