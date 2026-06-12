# P2-B — One-shot sampler slot internals

> **Status:** captured · Firmware **1.1.4**

Map sample table fields (path, start, loop, end, tune, gain, …). T1 = **Sampler** (`0x02`), preset **`nt-acidic`**.

## Rules

- Re-open **`g0` baseline** before each variant.
- **One sample-edit field** per file on the sample edit screen.
- No pattern notes unless needed to hear changes.

## Capture procedure

1. T1 Sampler → load preset (`nt-acidic`) → save as `g0.xy`.
2. Re-open g0 → one edit per file:

| PC / device file | Sample edit | Notes |
| --- | --- | --- |
| `g0.xy` | — | baseline |
| `g1.xy` | Tune → min | UI −195.00 (tenths: −1950) |
| `g2.xy` | Tune → max | UI +60.9 (tenths: 609); created from g1 |
| `g3.xy` | Start → non-zero | |
| `g4.xy` | End → shorten | |
| `g5.xy` | Loop start moved | towards sample start |
| `g6.xy` | Loop end moved | towards sample start |
| `g7.xy` | Direction backward | |
| `g8.xy` | Gain min | |
| `g9.xy` | Gain max | |
| `g10.xy` | Loop crossfade min | same as baseline |
| `g11.xy` | Loop crossfade max | UI 75% |
| `g12.xy` | Loop type off | shift+light-grey encoder |
| `g13.xy` | Loop type regular (until release) | |
| `g14.xy` | Loop type infinite | same sample fields as g0 |

Loop-type encoder cycles: infinite → off → until-release.

### Tune sweep (re-open `g-tune-0` before each)

Filename = **tenths from +0.00** (`1` → UI `+0.10`, `neg2` → `-0.20`).

| File | UI tune |
| --- | --- |
| `g-tune-0.xy` | `+0.00` |
| `g-tune-1.xy` … `g-tune-4.xy` | `+0.10` … `+0.40` |
| `g-tune-neg1.xy` … `g-tune-neg5.xy` | `-0.10` … `-0.50` |

## Results

| File | Storage | Decoded |
| --- | --- | --- |
| `g0.xy` | baseline | start `0`, end `0x7DF4`, loop `0x6EC5`…`0x7DF4`, tune `0x3C`, type `0x80` infinite |
| `g1.xy` | `track+0x3957` | tune `0xFF` |
| `g2.xy` | `+0x3957`, `+0x395B` | tune `0x00`, aux `0x5A` |
| `g3.xy` | `+0x3943` u16 | `0x17C4` |
| `g4.xy` | `+0x3947`, `+0x394F` | end/loop end `0x76B1` |
| `g5.xy` | `+0x394B` u16 | `0x4D1A` |
| `g6.xy` | `+0x394F` u16 | loop end `0x78AC` |
| `g7.xy` | `slot+0x07` | direction `1` |
| `g8.xy` / `g9.xy` | `slot+0x05` | gain min/max |
| `g10.xy` | — | byte-identical to g0 |
| `g11.xy` | `+0x3956` | crossfade `96` (≈75%) |
| `g12`–`g14.xy` | `slot+0x03` | loop type off / until-release / infinite |

Sampler start/end/loop @ `track+0x3943`…`+0x3956` (not drum `slot+0x68`).

**Tune encoding:** positive tenths → aux `N×10`; negative → `0x3D` + `100−N×10`.

Log: `docs/logs/2026-06-12_sampler_oneshot_inspection.md`  
Tests: `tests/test_sampler_sample_inspection.py`  
API: `xy/sampler_sample_inspection.py`
