# Project config (start menu) probe

> **Status:** in progress · Firmware **1.1.4**
> **ID:** PCFG (project settings from start-menu **Project config**)
> **Goal:** Pin bytes for global transpose, scene length, time signature, groove type, per-track voice allocation (T1–T8), and MIDI channel map (T1–T16)
> **Baseline:** `prjconf0.xy` — fresh project, all defaults

## Known from corpus (expect same region)


| Field                | Offset                             | Prior evidence                                    |
| -------------------- | ---------------------------------- | ------------------------------------------------- |
| Groove type          | global `0x03`                      | `unnamed_11`–`12`, `42`, `44`–`47` (tempo screen) |
| MIDI channel / track | global `0x55`–`0x64` (1 byte × 16) | `unnamed_41`, `unnamed_54`                        |
| Tempo BPM            | global `0x00`                      | `unnamed_4`, `5` — **do not change** in this pack |


**Open:** global transpose, scene length mode, time signature (project config tempo page), voice pool (T1–T8 auto/1–8, 24 voices total).

## Rules

1. Each file is a **copy of `prjconf0.xy`** — same on-device project name as PC filename (without `.xy`).
2. Open the file on device → change **only** the field in the table → **Save** (overwrite; no Save As).
3. Prefer **re-copy `prjconf0.xy` from PC** over the previous variant when isolation matters (same as re-open baseline).
4. Do **not** add pattern notes, change presets, or touch BPM unless the row says so.
5. Record actual UI values in the **Results** table after save (append only — do not delete capture rows).

## Workflow

1. MTP all `prjconf*.xy` to device project folder.
2. Work **alphabetically** (filenames sort in a sensible order on device).
3. After each edit: save on device → MTP back to PC → overwrite the matching file here.
4. When a section is done, say **done** + section name for analysis.

---

## Capture procedure — baseline


| PC / on-device name | Action                                                 |
| ------------------- | ------------------------------------------------------ |
| `prjconf0`          | Fresh project saved once — all project-config defaults |


---

## Capture procedure — General

### Global transpose (encoding sweep)

Default **0**. Range **−24 … +24**. Re-copy `prjconf0` before each row.


| PC filename         | Set global transpose |
| ------------------- | -------------------- |
| `prjconf-g-xm24.xy` | **−24**              |
| `prjconf-g-xm01.xy` | **−1**               |
| `prjconf-g-xp01.xy` | **+1**               |
| `prjconf-g-xp24.xy` | **+24**              |


(`prjconf0` = **0**.)

### Scene length

Default **longest**. Re-copy `prjconf0` before each row.


| PC filename               | Set scene length   |
| ------------------------- | ------------------ |
| `prjconf-g-slen-short.xy` | **Shortest**       |
| `prjconf-g-slen-tsig.xy`  | **Time signature** |


---

## Capture procedure — Tempo (project config page)

Do **not** change BPM. Re-copy `prjconf0` before each row.

### Time signature

Default **4/4** on baseline.


| PC filename            | Signature |
| ---------------------- | --------- |
| `prjconf-t-sig-34.xy`  | **3/4**   |
| `prjconf-t-sig-54.xy`  | **5/4**   |
| `prjconf-t-sig-68.xy`  | **6/8**   |
| `prjconf-t-sig-78.xy`  | **7/8**   |
| `prjconf-t-sig-128.xy` | **12/8**  |


### Groove type

Same enum as tempo screen (`0x03` in corpus). Default on fresh project is likely **shuffle** — confirm on `prjconf0`. Capture every **other** type; add `prjconf-t-grv-shuffle.xy` only if baseline is not shuffle.

Guide order (index hypothesis 0…10):


| #   | Guide name   | PC filename                  |
| --- | ------------ | ---------------------------- |
| 0   | shuffle      | *(baseline?)*                |
| 1   | half shuffle | `prjconf-t-grv-half.xy`      |
| 2   | danish       | `prjconf-t-grv-danish.xy`    |
| 3   | bombora      | `prjconf-t-grv-bombora.xy`   |
| 4   | wobbly       | `prjconf-t-grv-wobbly.xy`    |
| 5   | gaussian     | `prjconf-t-grv-gaussian.xy`  |
| 6   | accents      | `prjconf-t-grv-accents.xy`   |
| 7   | island nod   | `prjconf-t-grv-island.xy`    |
| 8   | disfunk      | `prjconf-t-grv-disfunk.xy`   |
| 9   | roll over    | `prjconf-t-grv-roll.xy`      |
| 10  | prophetic    | `prjconf-t-grv-prophetic.xy` |


Corpus names used hyphens (`dis-funk`, `half-shuffle`) — note UI spelling in Results.

---

## Capture procedure — Voices (T1–T8)

Per track: **auto** or fixed count **1–8**. Default **all auto**. Max **24 voices** project-wide.

### Phase A — one track, voices = 1 (layout isolation)

Re-copy `prjconf0` before each file. Set **only** that track; leave others **auto**.


| PC filename          | Change     |
| -------------------- | ---------- |
| `prjconf-v-t1-v1.xy` | T1 → **1** |
| `prjconf-v-t2-v1.xy` | T2 → **1** |
| `prjconf-v-t3-v1.xy` | T3 → **1** |
| `prjconf-v-t4-v1.xy` | T4 → **1** |
| `prjconf-v-t5-v1.xy` | T5 → **1** |
| `prjconf-v-t6-v1.xy` | T6 → **1** |
| `prjconf-v-t7-v1.xy` | T7 → **1** |
| `prjconf-v-t8-v1.xy` | T8 → **1** |


### Phase B — T1 encoding sweep

Re-copy `prjconf0` before each. **Only T1** changes; others auto.


| PC filename          | T1 voices |
| -------------------- | --------- |
| `prjconf-v-t1-v2.xy` | **2**     |
| `prjconf-v-t1-v4.xy` | **4**     |
| `prjconf-v-t1-v8.xy` | **8**     |


### Phase C — polyphony cap

Re-copy `prjconf0`. Set T1=**8**, T2=**8**, T3=**8** (sum **24**); T4–T8 **auto**.


| PC filename             | Change                   |
| ----------------------- | ------------------------ |
| `prjconf-v-poly-888.xy` | T1/T2/T3 = 8 voices each |


### Phase D — optional layout (multi-track, after Phase A)

Re-copy `prjconf0`. Several tracks in one save — use only to confirm packing after singles are decoded.


| PC filename             | Change                                                      |
| ----------------------- | ----------------------------------------------------------- |
| `prjconf-v-mix-1234.xy` | T1=1, T2=2, T3=3, T4=4 (others auto)                        |
| `prjconf-v-mix-8888.xy` | T1–T4 = 8 each (32 requested — note if device clamps to 24) |

prjconf-v-mix-8888 was not captured since the device clamps to 24 voices. Delete this one from the plan and the fixtures.


---

## Capture procedure — MIDI (T1–T16)

Per track: **off** or **ch 1–16**. Default **all off**. Corpus: `0x55` + (track−1).

### Phase A — one channel per track (full map)

Re-copy `prjconf0` before each. **Only** listed track gets a channel; all others **off**.


| PC filename             | Change          |
| ----------------------- | --------------- |
| `prjconf-m-t01-ch01.xy` | T1 → **ch 1**   |
| `prjconf-m-t02-ch02.xy` | T2 → **ch 2**   |
| `prjconf-m-t03-ch03.xy` | T3 → **ch 3**   |
| `prjconf-m-t04-ch04.xy` | T4 → **ch 4**   |
| `prjconf-m-t05-ch05.xy` | T5 → **ch 5**   |
| `prjconf-m-t06-ch06.xy` | T6 → **ch 6**   |
| `prjconf-m-t07-ch07.xy` | T7 → **ch 7**   |
| `prjconf-m-t08-ch08.xy` | T8 → **ch 8**   |
| `prjconf-m-t09-ch09.xy` | T9 → **ch 9**   |
| `prjconf-m-t10-ch10.xy` | T10 → **ch 10** |
| `prjconf-m-t11-ch11.xy` | T11 → **ch 11** |
| `prjconf-m-t12-ch12.xy` | T12 → **ch 12** |
| `prjconf-m-t13-ch13.xy` | T13 → **ch 13** |
| `prjconf-m-t14-ch14.xy` | T14 → **ch 14** |
| `prjconf-m-t15-ch15.xy` | T15 → **ch 15** |
| `prjconf-m-t16-ch16.xy` | T16 → **ch 16** |


### Phase B — optional encoding (off vs on)

Re-copy `prjconf0`.


| PC filename               | Change                                                   |
| ------------------------- | -------------------------------------------------------- |
| `prjconf-m-t03-ch08.xy`   | T3 → **ch 8** (matches corpus `unnamed_54`)              |
| `prjconf-m-all-ch1-16.xy` | T*n* → **ch *n*** for all 16 (single file — layout only) |


---

## Suggested capture order

1. `prjconf0` (confirm defaults)
2. General → Tempo sig → Groove
3. Voices Phase A → B → C
4. MIDI Phase A (batch by MTP)
5. Optional Phase D / MIDI Phase B

**File count:** 1 baseline + 52 variants = **53** `.xy` files
(`prjconf-v-mix-8888.xy` was not captured because the device clamps at 24 voices).

---

## Results

Decoded in `xy/project_config_inspection.py`; see
`docs/logs/2026-06-13_project_config_inspection.md`.

### Baseline (`prjconf0`)


| Field            | UI value | Byte(s) @ offset | Status |
| ---------------- | -------- | ---------------- | ------ |
| Global transpose | 0        | `0x00` @ `0x1B` | ✅ |
| Scene length     | longest  | `0x00` @ `0x08` | ✅ |
| Time signature   | 4/4      | `0x11` @ `0x1C` | ✅ |
| Groove           | shuffle  | `0x00` @ `0x03` | ✅ |
| Voices T1–T8     | all auto | `00 00 00 00 00 00 00 00` @ `0x4D`–`0x54` | ✅ |
| MIDI T1–T16      | all off  | `FF` ×16 @ `0x55`–`0x64` | ✅ |


### General / Tempo / Voices / MIDI


| Capture group | Status | Decoded | Notes |
| ------------- | ------ | ------- | ----- |
| `prjconf-g-x*.xy` | ✅ | `0x1B` signed i8: −24=`E8`, −1=`FF`, +1=`01`, +24=`18` | range endpoints pinned |
| `prjconf-g-slen-*.xy` | ✅ | `0x08`: `01` shortest, `02` time signature | baseline `00` longest |
| `prjconf-t-sig-*.xy` | ✅ | `0x1C`: `10` 3/4, `11` 4/4, `12` 5/4, `13` 6/8, `14` 7/8, `15` 12/8 | baseline 4/4 |
| `prjconf-t-grv-*.xy` | ✅ | `0x03`: `00`–`0A` in guide order | baseline shuffle |
| `prjconf-v-*.xy` | ✅ | `0x4D`–`0x54`: T1–T8, `0` auto / `1`–`8` fixed | `poly-888` confirms multi-track packing |
| `prjconf-m-*.xy` | ✅ | `0x55`–`0x64`: T1–T16, `FF` off / raw+1 channel | `all-ch1-16` confirms full map |

Every variant also sets T9–T16 track-relative `+0x38F2/+0x38F6` from
`00` to `40`. That repeated delta is treated as save-side/UI noise, not the
edited project-config field.


---

## After capture

Promoted to `xy-format-fork/src/app-project-config-probes/` and covered by
`tests/test_project_config_inspection.py`.
