# M4 base — App-required preset growth (T1–T4 × P1–P9)

> **Status:** captured · Firmware **1.1.4**

36 files. Tracks 1–4 × patterns P1–P9, drum presets `pp`…`xx`.

## Capture procedure

- Create presets `pp`, `qq`, `rr`, `ss`, `tt`, `uu`, `vv`, `ww`, `xx` (1–9, all identical).
- New project → rename **`a1-t1-p1`** (A1 = track 1 pattern growth).
- Save As: **`a2-t2-p1`**, **`a3-t3-p1`**, **`a4-t4-p1`** (tracks 2–4, still empty).
- Switch back to **`a1-t1-p1`**.
- T1: preset **`pp`** (drum kit), add 1 note on step 1 → save.
- Save As: **`a1-t1-p2`** → pattern 2, preset **`qq`**, one note step 1 (now P1+P2).
- Repeat through P9 for T1, then repeat P1–P9 on **`a2-t2-*`**, **`a3-t3-*`**, **`a4-t4-*`**.

There may be manual errors — check projects for accuracy.

## Known issue (P8/P9)

Sometimes on patterns P8/P9 the kick drum is silent (keyboard too). Suspect presets **`ww`** / **`xx`**, or a device limit/bug.

### Analysis follow-up (optional captures)

| PC filename | Purpose |
| --- | --- |
| `a1-t1-p8-kickonly.xy` | P8, one kick note only |
| `a1-t1-p9-kickonly.xy` | P9, one kick note only |

Dev: diff `a1-t1-p7.xy` vs `p8.xy` vs `p9.xy`; extend `test_project_inspection.py` to all `a*-t*-p1`…`p8`.

Log: `docs/logs/2026-06-09_app_preset_probe_inspection.md`  
Tests: `tests/test_project_inspection.py`
