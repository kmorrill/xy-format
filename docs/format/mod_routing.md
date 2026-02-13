# Mod Routing / Automation Slab

## Location (Track 1 captures)
- Primary routing slab: `block+0x0F70` through `block+0x101F`.
- Directory: 6 entries x 16 bytes.
- Payload rows: 8-byte records around `block+0x1000 + index*0x08`.

## Tentative Payload Layout (`u16` words)
1. Coarse amount (signed)
2. Fine/bias amount (signed)
3. Destination enum
4. Aux/flags slot word

## Observed Destination IDs
- `0x005F`: synth2
- `0xFF00`: lfo4
- `0x0000`: synth1 (also seen in contexts still being disambiguated)
- Additional observed values include `0x1ADF` and `0xDF00` in pitch-bend destination experiments.

## Status
- Structural location and mutation behavior are solid.
- Exact signed scaling and full destination map are still in progress.

## Related
- Performance-controller automation notes: see legacy snapshot `docs/logs/2026-02-13_agents_legacy_snapshot.md`.
