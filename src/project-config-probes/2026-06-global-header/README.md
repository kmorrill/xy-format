# Global header gaps (checklist §2)

> **Status:** todo · Firmware **1.1.4**
> **ID:** HDR · closes checklist §2 partial/gap rows
> **Baseline:** `hdr0.xy` — copy of fresh `prjconf0.xy` (project-config defaults)

## Checklist targets


| Row                               | Goal                               | This pack                            |
| --------------------------------- | ---------------------------------- | ------------------------------------ |
| `[~]` Groove amount               | Encoder sweep → pin byte + scaling | Tempo screen, `hdr-grv-*`            |
| `[x]` Metronome click volume      | Verify corpus claim                | `hdr-mclk-volmin` + optional sweep   |
| `[~]` Metronome on/off            | Toggle vs volume @ `0x04`          | `hdr-mclk-off`, `hdr-mclk-on`        |
| `[~]` Active song/scene selection | `0x06` count, `0x07` ordinal       | `hdr-arr-*`                          |
| `[ ]` Internal display name       | Confirm filename-only              | § Display name (no capture required) |


## Prior knowledge (do not clobber)


| Offset      | Field                     | Evidence                                          |
| ----------- | ------------------------- | ------------------------------------------------- |
| `0x03`      | Groove **type**           | PCFG `prjconf-t-grv-*`                            |
| `0x04`      | Metronome **volume**      | `set_click_volume`, corpus `unnamed 10` (min vol) |
| `0x06`      | Active scene slot         | HDR arrange captures; prior writer name was stale |
| `0x07`      | Active song slot          | HDR arrange captures; `0x10` default sentinel     |
| `0x08`      | Scene length mode         | PCFG — **do not edit** in this pack               |
| `0x95+33×n` | Scene slot rows           | P2-D / P2-E                                       |


Legacy `docs/format/header.md` offsets (`0x0B` groove, `0x0C` amount) are **pre-RLE** — ignore; use decoded image @ `0x00+`.

Corpus `unnamed 48` / `49` = groove amount low/high (tempo screen). No byte-exact writer yet.

## Rules

1. Each file is a copy of `**hdr0.xy`** until you edit and save on device.
2. **One variable** per file (except optional layout rows marked below).
3. Re-copy `**hdr0.xy` from PC** before each isolated capture (same trick as PCFG).
4. Do **not** change project-config fields (transpose, MIDI map, scene length mode, etc.).
5. Do **not** add pattern notes unless a row says so.
6. Record **encoder click counts** and **on-screen values** in Results (append only).

## Workflow

1. MTP all `hdr*.xy` to device.
2. Work **alphabetically** by filename.
3. Edit → Save (overwrite) → MTP back when ready for analysis.

---

## Capture procedure — baseline


| PC / device name | Action                                                                                                                                          |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `hdr0`           | Fresh project (`prjconf0` equivalent): groove amount **0**, metronome **on**, default click volume, **1 scene**, scene **1** active, song **1** |


---

## Capture procedure — Groove amount (Tempo screen)

Open **Tempo** (BPM page), **not** Project config. Use the **groove amount** encoder (not groove type).

Default UI = **0** on `hdr0`. Re-copy `hdr0` before each row. Count **detents/clicks** from 0 unless at min/max.


| PC filename        | Procedure                                |
| ------------------ | ---------------------------------------- |
| `hdr-grv-l1.xy`    | From 0: **1 click left**                 |
| `hdr-grv-l2.xy`    | From 0: **2 clicks left**                |
| `hdr-grv-r1.xy`    | From 0: **1 click right**                |
| `hdr-grv-r2.xy`    | From 0: **2 clicks right**               |
| `hdr-grv-min.xy`   | Hold turn to **minimum** (note UI value) |
| `hdr-grv-minp1.xy` | From min: **+1 click**                   |
| `hdr-grv-minp2.xy` | From min: **+2 clicks**                  |
| `hdr-grv-max.xy`   | Hold turn to **maximum**                 |
| `hdr-grv-maxm1.xy` | From max: **−1 click**                   |
| `hdr-grv-maxm2.xy` | From max: **−2 clicks**                  |


**Analysis hint:** diff vs `hdr0` in `0x00–0x1A` only first; expect **not** `0x03` (type) or `0x08` (scene length). Prior guess cluster: `0x05`, `0x09`–`0x0E`.

---

## Capture procedure — Metronome

### A — Verify click volume (`[x]` checklist row)

Corpus already matches `set_click_volume(0)` @ `**0x04`** (`unnamed 10`). Confirm on device:


| PC filename          | Procedure                                                                        |
| -------------------- | -------------------------------------------------------------------------------- |
| `hdr-mclk-volmin.xy` | Metronome **on** → set click volume to **minimum** (same intent as `unnamed 10`) |


Optional if min alone differs from mid/max encoding:


| PC filename          | Procedure                                               |
| -------------------- | ------------------------------------------------------- |
| `hdr-mclk-volmid.xy` | Metronome on → volume **~50%** or a clearly mid UI tick |
| `hdr-mclk-volmax.xy` | Metronome on → volume **maximum**                       |


### B — Metronome on/off (`[~]` checklist row)

Prove toggle is **separate** from volume @ `0x04` (volume remembered when re-enabled).


| PC filename              | Procedure                                                                         |
| ------------------------ | --------------------------------------------------------------------------------- |
| `hdr-mclk-off.xy`        | Turn metronome **off** (leave volume knob at default — do not zero volume)        |
| `hdr-mclk-on.xy`         | Re-copy `hdr0` → turn metronome **on** (volume should still be default)           |
| `hdr-mclk-off-volmin.xy` | Set volume to **min** first → then toggle metronome **off** (both states stored?) |


Record whether UI shows last volume when toggling back on.

---

## Capture procedure — Active scene / song selection

Goal: isolate `**0x06`** (active scene slot) vs `**0x07**` (active song slot). Scene **slot data** lives @ `0x95` (33-byte rows) — see P2-D/P2-E.

Use **Arrange** view. Keep **one pattern** on T1 unless noted. No mutes/volume changes.

### Phase A — Scene count vs active scene


| PC filename       | Procedure                                                                                                             |
| ----------------- | --------------------------------------------------------------------------------------------------------------------- |
| `hdr-arr-sc1.xy`  | **1 scene** only (added t1 patterns 1-3 to differentiate scenes later, pattern n has kickdrum (low f) in step n)      |
| `hdr-arr-nsc2.xy` | copy hdr-arr-sc1.xy. Add **scene 2** (Arrange → +Scene -> t1 select pattern 2). Stay on **scene 1** LED. Save.        |
| `hdr-arr-act2.xy` | Re-copy `hdr-arr-nsc2.xy` from PC **or** re-open nsc2 baseline → switch to **scene 2** active → Save.                 |
| `hdr-arr-nsc3.xy` | Re-copy hdr-arr-`nsc2`.xy → create **3rd scene, select pattern 3** (scenes 1–3 now exist). Stay on **scene 1**. Save. |
| `hdr-arr-act3.xy` | Re-copy `hdr-arr-nsc3.xy` → switch active to **scene 3** → Save.                                                      |


**Expected:** `nsc2` vs `sc1` changes slot rows @ `0x95+33`, while `act2` vs `nsc2` should flip `**0x06`** with minimal slot diff.

### Phase B — Song selection (best effort)

If the UI exposes **Song 1 / Song 2 / …** in Arrange:


| PC filename        | Procedure                                                                              |
| ------------------ | -------------------------------------------------------------------------------------- |
| `hdr-arr-song1.xy` | **Song 1** selected (default on `hdr0`)                                                |
| `hdr-arr-song2.xy` | Re-copy `hdr0` → create or select **Song 2** in song list → Save before editing scenes |


If your firmware only shows songs after chaining scenes, add **one** scene to song 1 first, then duplicate song — note exact UI path in Results.

Also watch `**0x0F`–`0x11`** (coverage map “song/scene UI cluster”) and footer song table (last 56 B of image).

---

## Display name — checklist `[ ]`

**Hypothesis:** project name is **only** the `.xy` filename on disk; no ASCII name in the decoded image.

Verification (no device capture required unless you want proof):

1. Rename `hdr0.xy` → `MyProbeName.xy` on PC.
2. MTP to device — name appears in project list.
3. Optional: `python tools/analysis/decoded_diff.py` or hex search — string `MyProbeName` should **not** appear in decoded image.

Recommend closing checklist row as **external filename** if step 3 is clean.

---

## Suggested capture order

1. `hdr0` → groove amount sweep (`hdr-grv-`*)
2. Metronome A then B (`hdr-mclk-*`)
3. Arrange Phase A → Phase B if applicable

**File count:** 1 baseline + 23 variants = **24** `.xy` files.

---

## Results

Analysis promoted 2026-06-13. Baseline `hdr0.xy` decodes:

| Offset | Baseline | Meaning |
| --- | --- | --- |
| `0x02` | `00` | groove amount `0` |
| `0x04` | `A8` | click/metronome volume, default/on |
| `0x06` | `00` | active scene slot 1 |
| `0x07` | `10` | fresh/default Song 1 sentinel |

### Groove amount

All `hdr-grv-*` captures isolate `GLOBAL+0x02` as signed i8. One encoder click is 2 units:

| File | `0x02` | Decoded |
| --- | ---: | ---: |
| `hdr-grv-l1.xy` | `FE` | `-2` |
| `hdr-grv-l2.xy` | `FC` | `-4` |
| `hdr-grv-r1.xy` | `02` | `+2` |
| `hdr-grv-r2.xy` | `04` | `+4` |
| `hdr-grv-min.xy` | `81` | `-127` |
| `hdr-grv-minp1.xy` | `82` | `-126` |
| `hdr-grv-minp2.xy` | `84` | `-124` |
| `hdr-grv-max.xy` | `7F` | `+127` |
| `hdr-grv-maxm1.xy` | `7E` | `+126` |
| `hdr-grv-maxm2.xy` | `7C` | `+124` |

### Metronome

`GLOBAL+0x04` is the click-volume byte. `hdr-mclk-volmin.xy`,
`hdr-mclk-off.xy`, and `hdr-mclk-off-volmin.xy` all store `0x04=00`;
`hdr-mclk-volmax.xy` stores `0x04=FF`. `hdr-mclk-on.xy` matches baseline, and
`hdr-mclk-volmid.xy` did not differ from baseline. No independent on/off byte
moved in this probe set, so the read API reports `metronome_enabled` as
`click_volume_raw != 0`.

### Active scene and song

Same-branch arrange diffs show `GLOBAL+0x06` is active scene slot, zero-based:
`hdr-arr-act2.xy` differs from `hdr-arr-nsc2.xy` only at `0x06: 00 -> 01`,
and `hdr-arr-act3.xy` differs from `hdr-arr-nsc3.xy` only at `0x06: 00 -> 02`.

Adding scenes without switching them changes scene rows at `0x95 + 33*n`, not
`0x06`; present scene count is therefore derived from populated scene slot
flags. `hdr-arr-song2.xy` changes `GLOBAL+0x07` from the baseline `0x10`
sentinel to `0x01`, meaning active Song 2.

### Display name

ASCII searches of decoded images did not find `hdr0`,
`2026-06-global-header`, or a renamed `MyProbeName` token. The project display
name is treated as external filename metadata rather than a decoded-image
field.


---

## After capture

Promoted to `xy-format-fork/src/project-config-probes/2026-06-global-header/`.
Log: `docs/logs/2026-06-13_global_header_inspection.md`.
