# Bar menu probe (Scene 1 · Track 1 · Pattern 1)

> **Status:** todo · Firmware **1.1.4**
> **ID:** BAR · checklist §4 gaps (quantization, default length, per-track groove, p-lock shape)
> **Baseline:** `bar0.xy` — fresh project (`hdr0` / `prjconf0` equivalent)

## Scope

**First pass:** Scene **1**, Track **1**, Pattern **1** only. Open the **Bar** menu for T1 while P1 is active.

**Skip (already mapped):** number of bars (`track+0x01`), track scale (`track+0x06`).

**Do not add pattern notes** unless you need them to reach the bar page (blank pattern is fine).

## Checklist targets

| Row | UI control | Default | Files |
| --- | --- | --- | --- |
| `[ ]` Per-track quantization | Quantization 0–100 | **100** | `bar-q-*` |
| `[ ]` Default step length | Length 0–100 | **50** | `bar-l-*` |
| `[ ]` Per-track groove override | Groove −99…+99 | **0** | `bar-g*` (full LUT) |
| `[ ]` P-lock smoothing/shape | Interpolation (no numeric UI) | mid unknown | `bar-s-*` |

## Rules

1. Every file starts as a copy of **`bar0.xy`**; on device: open → change **one** bar-menu field → **Save** (overwrite).
2. Stay on **Scene 1 / T1 / P1** for all Phase A captures.
3. Re-copy **`bar0.xy` from PC** before each isolated row (same workflow as PCFG/HDR).
4. Do **not** change bars count, track scale, tempo, or project-config fields.
5. Record **UI values** (and encoder click counts for `bar-s-*`) in **Results** — append only.

## Workflow

1. MTP all `bar*.xy` to device.
2. Recommended order: **`bar0`** → quantization → length → groove LUT → p-lock shape.
3. Groove LUT is large — batch MTP in alphabetical chunks if needed.

---

## Capture procedure — baseline

| PC / device name | Bar menu state |
| --- | --- |
| `bar0` | Quantization **100**, Length **50**, Groove **0**, p-lock shape **factory default** |

---

## Capture procedure — Quantization

Bar menu → **Quantization**. Default **100** on `bar0`. Re-copy `bar0` before each row.

| PC filename | Procedure |
| --- | --- |
| `bar-q-000.xy` | Set UI to **0** |
| `bar-q-001.xy` | Set UI to **1** |
| `bar-q-002.xy` | Set UI to **2** |
| `bar-q-098.xy` | Set UI to **98** |
| `bar-q-099.xy` | Set UI to **99** |

`bar0.xy` already covers quantization UI **100** (`0xFF`). Numeric UI controls
use numeric filenames; min/max-relative names are reserved for controls without
a numeric display.

---

## Capture procedure — Length (default step length)

Bar menu → **Length**. Default **50** on `bar0`. Re-copy `bar0` before each row.

| PC filename | Procedure |
| --- | --- |
| `bar-l-000.xy` | Set UI to **0** |
| `bar-l-001.xy` | Set UI to **1** |
| `bar-l-002.xy` | Set UI to **2** |
| `bar-l-048.xy` | Set UI to **48** |
| `bar-l-049.xy` | Set UI to **49** |
| `bar-l-051.xy` | Set UI to **51** (renamed from the old `bar-q-max.xy`; bytes prove this is length, not quantization) |
| `bar-l-052.xy` | Set UI to **52** |
| `bar-l-053.xy` | Set UI to **53** |
| `bar-l-098.xy` | Set UI to **98** |
| `bar-l-099.xy` | Set UI to **99** |
| `bar-l-100.xy` | Set UI to **100** |

---

## Capture procedure — Per-track groove (full UI LUT)

Bar menu → **Groove** (per-track swing override — **not** global tempo groove type @ `0x03`).

Default **0** on `bar0`. UI uses a **non-uniform** step table (not linear). Capture **every** listed value; negatives mirror positives.

### Positive values (43 steps + zero)

| PC filename | Set groove UI to |
| --- | --- |
| `bar-g0.xy` | **0** (same as `bar0` — optional confirm save) |
| `bar-gpXXX.xy` | Set groove UI to **+XXX** |
| `bar-gnXXX.xy` | Set groove UI to **-XXX** |

i did a limited sweep, since doing everything is too cumbersome.

The exact range of values attainable on the device is
```
ids = [2,4,7,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,53,56,58,60,63,65,67,70,72,75,77,79,82,84,86,89,91,93,96,98,99]
```
those, and zero ("-"), and all negative counterparts.

---

## Capture procedure — P-lock interpolation shape

Bar menu → **p-lock interpolation / shape** (no numeric readout). Re-copy `bar0` before each row. Count **encoder clicks from default**.

| PC filename | Procedure |
| --- | --- |
| `bar-s-min.xy` | Turn shape to **minimum** (count clicks from default) |
| `bar-s-minp1.xy` | From min: **+1 click** |
| `bar-s-minp2.xy` | From min: **+2 clicks** |
| `bar-s-max.xy` | Turn shape to **maximum** |
| `bar-s-maxm1.xy` | From max: **−1 click** |
| `bar-s-maxm2.xy` | From max: **−2 clicks** |

Record click counts and any visible icon/curve change in Results.

---

## Phase B — cross-context spot checks (later)

After T1/P1 decode, add **separate** files (do not block Phase A):

| Probe | Intent |
| --- | --- |
| Scene 2, T1, P1 — set groove **+14** | Same byte as `bar-gp014`? |
| Scene 1, T2, P1 — set length **0** | Per-track length storage |
| Scene 1, T1, P2 — set quantization **0** | Per-pattern vs per-track |

Create new filenames when ready (e.g. `bar-x-s2-gp014.xy`).

---

## File count

| Block | Files |
| --- | ---: |
| Baseline `bar0` | 1 |
| Quantization sweep | 5 captured (`bar0` covers UI 100) |
| Length sweep | 11 captured |
| Groove LUT | 19 captured (limited sweep) |
| P-lock shape | 6 |
| **Total in this pack** | **42 `.xy` files** |

(`bar-g0` duplicates `bar0` defaults — included for LUT completeness.)

---

## Results

### Baseline (`bar0`)

| Field | UI | Byte(s) @ track offset | Status |
| --- | --- | --- | --- |
| Quantization | 100 | `+0x07 = FF` | raw byte pinned; UI scaling partial |
| Length | 50 | `+0x02 = F0 00` (`240` ticks) | decoded |
| Groove | 0 | `+0x08 = 00` | decoded index model; old `bar-gp002` superseded by redo |
| P-lock shape | default | `+0x3056 = 00` | decoded raw storage |

### Groove LUT decode

`TRACK+0x08` stores the per-track groove override as an index into the
hand-written UI sequence above. Raw signed storage is `3 * index`, where
index 0 = groove UI 0, index +1 = UI +2, index +2 = UI +4, index +3 = UI +7,
and so on. Negative values mirror the same index table. The extrema saturate
at signed i8 limits: UI +99 stores `0x7F`; UI -99 stores `0x81`.
`bar-gp002.xy` stores `0x09`, matching index +3 / UI +7, and is superseded by
`bar-gp002-redo.xy` (`0x03`, index +1 / UI +2).

| PC filename | UI groove | Index | Stored raw |
| --- | --- | --- | --- |
| `bar-g0.xy` | 0 | 0 | `00` |
| `bar-gn002.xy` | -2 | -1 | `FD` |
| `bar-gn004.xy` | -4 | -2 | `FA` |
| `bar-gn007.xy` | -7 | -3 | `F7` |
| `bar-gn009.xy` | -9 | -4 | `F4` |
| `bar-gn011.xy` | -11 | -5 | `F1` |
| `bar-gp002.xy` | +2 intended, decodes +7 | +3 | `09` |
| `bar-gp002-redo.xy` | +2 | +1 | `03` |
| `bar-gp004.xy` | +4 | +2 | `06` |
| `bar-gp007.xy` | +7 | +3 | `09` |
| `bar-gp009.xy` | +9 | +4 | `0C` |
| `bar-gp011.xy` | +11 | +5 | `0F` |
| `bar-gp014.xy` | +14 | +6 | `12` |
| `bar-gp016.xy` | +16 | +7 | `15` |
| `bar-gp018.xy` | +18 | +8 | `18` |
| `bar-gp051.xy` | +51 | +22 | `42` |
| `bar-gp053.xy` | +53 | +23 | `45` |
| `bar-gp056.xy` | +56 | +24 | `48` |
| `bar-gp058.xy` | +58 | +25 | `4B` |
| `bar-gp060.xy` | +60 | +26 | `4E` |
| `bar-gp084-redo.xy` | +84 | +36 | `6C` |
| `bar-gp086-redo.xy` | +86 | +37 | `6F` |
| `bar-gp089-redo.xy` | +89 | +38 | `72` |
| `bar-gp091-redo.xy` | +91 | +39 | `75` |
| `bar-gp093-redo.xy` | +93 | +40 | `78` |
| `bar-gp096-redo.xy` | +96 | +41 | `7B` |
| `bar-gp099-redo.xy` | +99 | +43 | `7F` |
| `bar-gn079-redo.xy` | -79 | -34 | `9A` |
| `bar-gn082-redo.xy` | -82 | -35 | `97` |
| `bar-gn084-redo.xy` | -84 | -36 | `94` |
| `bar-gn086-redo.xy` | -86 | -37 | `91` |
| `bar-gn089-redo.xy` | -89 | -38 | `8E` |
| `bar-gn091-redo.xy` | -91 | -39 | `8B` |
| `bar-gn093-redo.xy` | -93 | -40 | `88` |
| `bar-gn096-redo.xy` | -96 | -41 | `85` |
| `bar-gn099-redo.xy` | -99 | -43 | `81` |

### Quant / length / shape

| PC filename | Status | UI | Decoded |
| --- | --- | --- | --- |
| `bar-q-000.xy` | decoded | quant 0 | `+0x07 = 00` |
| `bar-q-001.xy` | decoded | quant 1 | `+0x07 = 04` |
| `bar-q-002.xy` | decoded | quant 2 | `+0x07 = 07` |
| `bar-q-025-redo.xy` | decoded | quant 25 | `+0x07 = 41` |
| `bar-q-050-redo.xy` | decoded | quant 50 | `+0x07 = 81` |
| `bar-q-075-redo.xy` | decoded | quant 75 | `+0x07 = C0` |
| `bar-q-098.xy` | decoded | quant 98 | `+0x07 = FC` |
| `bar-q-099.xy` | decoded | quant 99 | `+0x07 = FE` |
| `bar0.xy` | baseline | quant 100 | `+0x07 = FF` |
| `bar-l-000.xy` | decoded | length 0 | `+0x02 = 04 00` (`4` ticks) |
| `bar-l-001.xy` | decoded | length 1 | `+0x02 = 08 00` (`8`) |
| `bar-l-002.xy` | decoded | length 2 | `+0x02 = 0C 00` (`12`) |
| `bar-l-048.xy` | decoded | length 48 | `+0x02 = E8 00` (`232`) |
| `bar-l-049.xy` | decoded | length 49 | `+0x02 = EC 00` (`236`) |
| `bar-l-051.xy` | decoded | length 51 | `+0x02 = F4 00` (`244`) |
| `bar-l-052.xy` | decoded | length 52 | `+0x02 = F8 00` (`248`) |
| `bar-l-053.xy` | decoded | length 53 | `+0x02 = FC 00` (`252`) |
| `bar-l-098.xy` | decoded | length 98 | `+0x02 = D8 01` (`472`) |
| `bar-l-099.xy` | decoded | length 99 | `+0x02 = DC 01` (`476`) |
| `bar-l-100.xy` | decoded | length 100 | `+0x02 = E0 01` (`480`) |
| `bar-s-min.xy` | decoded | min/default | `+0x3056 = 00` |
| `bar-s-minp1.xy` | decoded | min +1 | `+0x3056 = 04` |
| `bar-s-minp2.xy` | decoded | min +2 | `+0x3056 = 08` |
| `bar-s-maxm2.xy` | decoded | max -2 | `+0x3056 = F7` |
| `bar-s-maxm1.xy` | decoded | max -1 | `+0x3056 = FB` |
| `bar-s-max.xy` | decoded | max | `+0x3056 = FF` |

Most non-shape edits also flip the T1 pristine flag at `+0x11` from `08 00` to
`00 00`. Repeated T9-T16 `+0x38F2/+0x38F6` changes from `00` to `40` are the
same save-side noise seen in PCFG/HDR probes.

Implementation note: BAR offsets mutate the old signature range used by
`ImageProject._rescan()`, so `xy/bar_menu_inspection.py` reads these baseline
shape probes by canonical decoded-image track base/stride.

---

## After capture

Promoted to `xy-format-fork/src/bar-menu-probes/2026-06-bar-menu/`. Log:
`docs/logs/2026-06-13_bar_menu_inspection.md`.
