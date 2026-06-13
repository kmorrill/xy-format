# P2-B — One-shot sampler sample-edit inspection

**Date:** 2026-06-12  
**Firmware:** 1.1.4  
**Fixtures:** `src/sampler-probes/2026-06-oneshot/` (`g0.xy`–`g14.xy`)
**Operator README:** `src/sampler-probes/2026-06-oneshot/README.md`

## Summary

Sampler engine (`0x02`) stores the **sample path** in voice-0 of the shared
24×128 B table @ `track+0x3957` (same anchor as drum kits). **Start, end, loop
points, and loop crossfade** live in a per-track header **before** that table
(`track+0x3943`…`+0x3956`) — not at drum offsets `slot+0x68` / `+0x70`.

Preset used: **`nt-acidic`** (`8faux8/nt-acidic`).

## Field map (track-relative)

| Offset | Field | Encoding | Probes |
| --- | --- | --- | --- |
| `+0x3943` | sample start | u16 LE | `g3` → `0x17C4` |
| `+0x3947` | sample end | u16 LE | `g4` → `0x76B1` |
| `+0x394B` | loop start | u16 LE | `g5` → `0x4D1A` |
| `+0x394F` | loop end | u16 LE | `g6` → `0x78AC` (end @ `+0x3947` unchanged) |
| `+0x3956` | loop crossfade | u8; `96` ≈ 75% UI (`×100/128`) | `g11` |
| `+0x3957` | tune | u8 | `g1` → `0xFF` min |
| `+0x395B` | tune aux | u8 | `g2` → `0x5A` max (with tune `0`) |
| `+0x395A` | loop type | u8 | `g12` `0x40` off · `g13` `0x00` until-release · `g0`/`g14` `0x80` infinite |
| `+0x395C` | gain | u8 | `g8` `0xE2` min · `g9` `0x14` max |
| `+0x395E` | direction | u8 | `g7` → `1` backward |
| `+0x395F`… | sample path | string @ slot+`0x08` | `g0` |

**Tune** (`g-tune-*` sweep, re-open `g-tune-0` baseline):

| UI | `+0x3957` | `+0x395B` |
| --- | --- | --- |
| `+0.00` … `+N×0.10` | `0x3C` | `N×10` |
| `-N×0.10` | `0x3D` | `100−N×10` |
| min (`g1`) | `0xFF` | `0` |
| max (`g2`) | `0x00` | `0x5A` (`609` tenths) |

`decode_sampler_tune_tenths()` / `.tune_ui` on `SamplerSampleEdit`.

**Loop type** is separate from loop start/end (shift+light-grey encoder). When
loop end equals sample end, behaviour matches “loop off” on device.

## API

`xy/sampler_sample_inspection.py`:

- `read_sampler_sample_edit(project, track=1)` — `.tune_ui` / `.tune_tenths`
- `decode_sampler_tune_tenths(tune_byte, tune_aux_byte)`
- `encode_sampler_tune_tenths(tenths)`
- `inspect_sampler_samples(project)` / `inspect_sampler_samples_bytes(data)`

## Related

- Drum table (engine `0x03`): same `+0x3957` anchor, different header layout
- `docs/format/decoded_image_map.md` § sample table
