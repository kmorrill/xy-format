# 2026-06-13 — Bar menu inspection

Fixture pack: `src/bar-menu-probes/2026-06-bar-menu/`
Related final-bar length pack: `src/bar-menu-probes/2026-06-bar-length/`

Firmware 1.1.4 probe pack targeting checklist §4 bar-menu gaps for Scene 1,
Track 1, Pattern 1.

## Decoded fields

| Field | Track offset | Encoding | Fixtures |
| --- | --- | --- | --- |
| Default step length | `+0x02` | u16 LE ticks; baseline `240` (UI 50), min capture `4`, max `480`; one detent near center = 4 ticks | `bar-l-*` |
| Pattern/final-bar length | `+0x01` | total active sequencer steps: `(bar_count - 1) * 16 + final_bar_steps` | BAR-LEN |
| Quantization | `+0x07` | raw byte; UI 0/1/2/25/50/75/98/99/100 captured as `00/04/07/41/81/C0/FC/FE/FF`; exact scaling still treated as partial | `bar-q-*` |
| Per-track groove override | `+0x08` | raw signed index byte: storage is `3 * index` into the hand-written UI sequence, saturated to signed i8 at ±99 (`7F`/`81`) | `bar-g*` |
| P-lock interpolation/shape | `+0x3056` | raw byte; default/min `0x00`, min+1/+2 `0x04`/`0x08`, max-side `0xF7`/`0xFB`/`0xFF` | `bar-s-*` |

Most quantization, length, and groove edits also clear the T1 pristine flag at
`+0x11` (`08 00 -> 00 00`). Shape edits do not in this pack.

## Notes

The old `bar-q-max.xy` was renamed to `bar-l-051.xy`: quantization is already
max/default in `bar0`, and that capture changes length to `244` ticks while
leaving quantization `0xFF`.

`bar-gp002.xy` is superseded by `bar-gp002-redo.xy`: the old file stores
`0x09`, same as `bar-gp007.xy`, while the redo stores `0x03` and confirms UI
+2 as index +1.

These fields overlap the old track-signature bytes used by the historical
scanner. `xy/bar_menu_inspection.py` reads the baseline-shape BAR pack by
canonical decoded-image base/stride instead of signature scanning.

## Code

- Read API: `xy/bar_menu_inspection.py`
- Writer setters: `ImageProject.set_default_step_length_ticks`,
  `set_track_quantization_raw`, `set_track_groove_raw`,
  `set_track_groove_ui`, `set_plock_shape_raw`
- Human report: `[Bar Menu]` in `tools/inspect_xy.py`
- Tests: `tests/test_bar_menu_inspection.py`
