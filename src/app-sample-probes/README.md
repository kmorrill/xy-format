# App sample probe fixtures

Device-authored `.xy` captures for read-only drum sample path inspection
(`xy/drum_sample_inspection.py`, `tests/test_drum_sample_inspection.py`).

## `2026-06-sample-paths/` (round 1, canonical)

Four files. Firmware 1.1.4, T1 drum kit `pp`, built-in `perc/chi *` samples on
pads 1–3. Full capture notes and path anatomy:
`docs/logs/2026-06-12_drum_sample_path_inspection.md`.

| File | Voice | Path |
|------|-------|------|
| `c1-baseline-pp.xy` | — | `pp.preset/unnamed-…` throughout |
| `c1-pad01-lowf-v23-chi-box.xy` | 23 (low F pad) | `content/samples/perc/chi box.wav` |
| `c1-pad02-v00-chi-cham.xy` | 0 | `content/samples/perc/chi cham.wav` |
| `c1-pad03-v01-chi-flet.xy` | 1 | `content/samples/perc/chi flet.wav` |

Raw working copies and operator README:
`opxy_mtp_manager/reference_material/user_probes/2026-06-sample-paths/`.
