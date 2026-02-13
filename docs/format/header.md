# Header

## Canonical Offsets (Current)
- `0x08-0x09` (`u16 LE`): tempo in tenths of BPM.
- `0x0A` (`u8`): observed padding/unused (`0x00` in baseline captures).
- `0x0B` (`u8`): groove type enum (`0x00` straight, `0x08` dis-funk, `0x03` bombora).
- `0x0C` (`u8`): groove amount byte (often `0x00` baseline, `0xA8` in observed groove presets).
- `0x0D` (`u8`): metronome level byte.
- `0x10-0x17` (`u16` lanes): additional groove/metronome-related words (semantics still partial).
- `0x20` (`u32`): MIDI directory descriptor (`entry_size` + `entry_count` packed little-endian).

## Invariant vs Exception
- Invariant (most one-off corpus): offsets above are stable and can be read directly.
- Exception class: `unnamed 10.xy` (metronome mute anomaly) exhibits a 4-byte header-length change event in earlier notes. Treat as a special case until reproduced and fully isolated.

## MIDI Chunk Stub (Early)
- Baseline word at `0x20`: `0x0C000004` (4 entries, 12 bytes each).
- `unnamed 41.xy`: `0x0D000004`, indicating +1 byte per entry when project MIDI settings change.
- First descriptor delta (`0x24`) suggests the setting is encoded in descriptor field substitution, not broad file rewrites.

## EQ Packed Table (Header-Adjacent)
- A packed table starts at `0x24` in baseline captures.
- Entries appear as `<u16 value><u16 param_id>`.
- Observed IDs:
  - low/mid use `0x0040`
  - high uses `0x9A40`
- Neutral value observed as `0x0100`; 0 dB examples push to `0x0500`.

## Tooling
- Reader utility: `docs/tools/read_xy_header.md`
- Inspector workflow: `docs/workflows/inspector_sweep.md`
