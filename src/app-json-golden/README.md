# P1-A — JSON export golden files (dev-generated)

> **Status:** todo

| | |
| --- | --- |
| **ID** | P1-A |
| **Type** | Software-only — **no device captures** |
| **Goal** | Lock `project_to_json` output when inspection fields are exported |

## Procedure (dev machine)

1. Pick representative `.xy` inputs (already in repo):

   | Source file | Why |
   | --- | --- |
   | `app-preset-probes/2026-06-app-required/a1-t1-p9.xy` | 9 drum presets, multi-pattern |
   | `app-preset-probes/2026-06-phase-b/b1-t1eng3bar1.xy` | Non-drum preset fragment |
   | `app-sample-probes/2026-06-sample-paths/c1-pad01-lowf-v23-chi-box.xy` | Family C drum path |
   | `app-sample-probes/archive-round0-nt-z-fx/c0-pad01-….xy` | Family B path |
   | `src/one-off-changes-from-default/unnamed 1.xy` | Minimal baseline |

2. Run export (once implemented): `project_to_json` → save as `<stem>.expected.json` beside a `manifest.yaml` listing source `.xy`.

3. Test: `tests/test_project_to_json_inspection_export.py` — byte-stable JSON compare (or semantic diff).

## Expected contents

| File | Source `.xy` |
| --- | --- |
| `a1-t1-p9.expected.json` | `app-preset-probes/2026-06-app-required/a1-t1-p9.xy` |
| `b1-t1eng3bar1.expected.json` | `app-preset-probes/2026-06-phase-b/b1-t1eng3bar1.xy` |
| `c1-pad01-lowf-v23-chi-box.expected.json` | `app-sample-probes/2026-06-sample-paths/c1-pad01-lowf-v23-chi-box.xy` |
| `c0-pad01-nt-z-fx.expected.json` | `app-sample-probes/archive-round0-nt-z-fx/c0-pad01-….xy` |
| `unnamed-1.expected.json` | `src/one-off-changes-from-default/unnamed 1.xy` |
| `manifest.yaml` | Lists source paths + schema version |

⬜ Pending implementation of inspection fields in `xy/project_to_json.py`.
