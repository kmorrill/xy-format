# Mission 3 — Drum pan vs fade

> **Status:** captured · Firmware **1.1.4**

Pin pan vs fade bytes in the drum voice table. T1, drum kit **`pp`**, no pattern notes. Pad: leftmost low F / kick → **voice 23**, MIDI key **53**.

## Rules

- **Re-open `d0` baseline** before each variant (may chain fade sweep from same baseline).
- Change **one pad / one knob** per file. Same pad (v23) for d1–d3.

## Capture procedure — pan + initial fade

1. **`d0`** → `d0-baseline-pp.xy` — T1 drum `pp`, all voice defaults.
2. Re-open **d0** → voice 23 → pan hard **left** → `d1-v23-pan-hard-left.xy`.
3. Re-open **d0** → same pad → pan hard **right** → `d2-v23-pan-hard-right.xy`.
4. Re-open **d0** → fade UI values → `d3-v23-fade-<ui>.xy`.

| PC filename | On-device | Action |
| --- | --- | --- |
| `d0-baseline-pp.xy` | d0 | baseline |
| `d1-v23-pan-hard-left.xy` | d1 | pan L |
| `d2-v23-pan-hard-right.xy` | d2 | pan R |
| `d3-v23-fade-27.xy` | d3-27 | fade UI 27 |
| `d3-v23-fade-63.xy` | d3-63 | fade UI 63 |
| `d3-v23-fade-99.xy` | d3 | fade UI 99 (max) |

### Fade fine sweep (optional)

Re-open **d0** between captures unless deriving from adjacent UI values.

| On-device | PC filename | Fade UI |
| --- | --- | --- |
| `d3-01` … `d3-14` | `d3-v23-fade-01.xy` … `14` | 1–14 |
| `d3-44` … `d3-47` | `d3-v23-fade-44.xy` … `47` | 44–47 |

## Results

| PC filename | UI | Decoded |
| --- | --- | --- |
| `d0-baseline-pp.xy` | — | pan 0 @ v23 `+0x06`; fade 0 @ v22 `+0x7C` |
| `d1-v23-pan-hard-left.xy` | pan L | v23 `+0x06` = **−100** |
| `d2-v23-pan-hard-right.xy` | pan R | v23 `+0x06` = **+100** |
| `d3-v23-fade-01`…`14.xy` | 1–14 | v22 `+0x7C` = `ui × 0x0147AF00` |
| `d3-v23-fade-27/63/99.xy` | 27/63/99 | same field; legacy byte0=`0xFF` on some |
| `d3-v23-fade-44`…`47.xy` | 44–47 | linear encoding confirmed |

**Pan** on edited voice `+0x06`. **Fade** on **preceding** voice `+0x7C`: `ui × 0x0147AF00` (max `0x7FFFFFFF`).

Log: `docs/logs/2026-06-12_drum_pan_fade_inspection.md`  
Tests: `tests/test_drum_pan_fade_inspection.py`
