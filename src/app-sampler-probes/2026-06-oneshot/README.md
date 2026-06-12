# P2-B — One-shot sampler fixtures

> **Status:** captured (`g0`–`g14`)

**Capture procedure:**
[`user_probes/2026-06-sampler-oneshot/README.md`](../../../../user_probes/2026-06-sampler-oneshot/README.md)

15 files on device (`g0.xy`…`g14.xy`). Preset: **`nt-acidic`**.

| File | Field changed |
| --- | --- |
| `g0.xy` | baseline |
| `g1.xy` | tune min |
| `g2.xy` | tune max |
| `g3.xy` | start |
| `g4.xy` | end |
| `g5.xy` | loop start |
| `g6.xy` | loop end |
| `g7.xy` | direction backward |
| `g8.xy` | gain min |
| `g9.xy` | gain max |
| `g10.xy` | loop crossfade min (= baseline) |
| `g11.xy` | loop crossfade max (75% UI) |
| `g12.xy` | loop type off |
| `g13.xy` | loop type until-release |
| `g14.xy` | loop type infinite (= baseline fields) |

Log: `docs/logs/2026-06-12_sampler_oneshot_inspection.md`  
Tests: `tests/test_sampler_sample_inspection.py`  
API: `xy/sampler_sample_inspection.py`
