# P1-A — JSON export golden files (dev-generated)

> **Status:** todo

| | |
| --- | --- |
| **ID** | P1-A |
| **Type** | Software-only — **no device captures** |
| **Goal** | Lock `project_to_json` output when inspection fields are exported |
| **Plan** | [`docs/workflows/phase_1_2_fixture_generation_plan.md`](../../docs/workflows/phase_1_2_fixture_generation_plan.md) § P1-A |

## Status

⬜ Pending implementation of inspection fields in `xy/project_to_json.py`.

## Expected contents

| File | Source `.xy` |
| --- | --- |
| `a1-t1-p9.expected.json` | `app-preset-probes/2026-06-app-required/a1-t1-p9.xy` |
| `b1-t1eng3bar1.expected.json` | `app-preset-probes/2026-06-phase-b/b1-t1eng3bar1.xy` |
| `c1-pad01-lowf-v23-chi-box.expected.json` | `app-sample-probes/2026-06-sample-paths/c1-pad01-lowf-v23-chi-box.xy` |
| `c0-pad01-nt-z-fx.expected.json` | `app-sample-probes/archive-round0-nt-z-fx/c0-pad01-….xy` |
| `unnamed-1.expected.json` | `src/one-off-changes-from-default/unnamed 1.xy` |
| `manifest.yaml` | Lists source paths + schema version |

## Test

`tests/test_project_to_json_inspection_export.py` (to be added).
