# Events

## Event Families
- `0x25`: common drum/grid event family (Track 1 constrained path).
- `0x21`: sequential/live family used heavily on synth slots and many preset paths.
- `0x2D`: observed engine-swap fallback family; safest known use is single-note payloads.
- Additional preset-native tags: `0x1C`, `0x1D`, `0x1E`, `0x1F`, `0x20`, `0x22`.

## 0x21 Sequential Structure (Validated)
- Header: `0x21 <count>`.
- First note at tick zero uses compact tick encoding and first-note flag.
- Subsequent notes use absolute tick fields.
- Gate supports two modes:
  - default token (`F0 00 00 01`)
  - explicit gate (`gate_u32_le + 00`)
- Step timing uses 480 ticks per 16th-note step (`1920 PPQN`).

## Pure-Append Authoring Recipe (Single Track)
1. Promote track type to active layout (`0x05` to `0x07`) with correct structural alignment.
2. Remove inactive padding if required by the target layout.
3. Append event payload at the pattern body tail.
4. Apply required preamble propagation semantics for adjacent blocks.

## 0x25 Hybrid/Pointer-Tail Cases
- Some multi-note captures store note payload partly in tail structures with pointers into `track+0x16xx`/`0x17xx` slabs.
- Inspector currently has known decode gaps for pointer-tail and pointer-21 slabs.
- Active issue: `docs/issues/pointer_tail_decoding.md`.

## Gate Reference
- 480 ticks = 1 step (16th).
- 960 ticks = 2 steps.
- 1920 ticks = 4 steps.
- 3840 ticks = 8 steps.

## Related
- Event-type choice rules: `docs/format/event_type_selection.md`
- Multi-pattern interaction: `docs/format/multi_pattern_block_rotation.md`
