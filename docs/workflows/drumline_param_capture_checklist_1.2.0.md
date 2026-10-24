# OP-XY Drumline synth parameter capture checklist — OS 1.2.0

Goal: map every Drumline voice and track parameter to bytes in the decoded
track struct, so projects can read and restore Drumline sounds instead of only
copying opaque donor bytes.

Status: **done (2026-10-16)**. Part A was read on the device. Part B was replaced by tool-authored probes plus a few device saves. The results are below and in `docs/format/decoded_image_map.md` → Drumline. The "desk analysis" section is the original pre-session guess; it is superseded by the corrections that follow it.
filled in afterwards from the saved files.

## What the bytes already show (desk analysis, 2026-10-16)

Drumline is engine `0x04`. Its sounds live in the same 24-slot voice table as
the drum sampler: track+0x3957, 128 bytes per voice, one voice per key from
MIDI note 53 (voice 1) to 76 (voice 24). The sample-path area is empty.

| slot byte | atom range | current guess |
|---|---|---|
| `+0x00` | `0x11`–`0x40` | pitch / tune |
| `+0x02` | 53–76 | trigger key (known) |
| `+0x03` | 1–4 | **drum type?** (voices 1–2 = 4, 9–11 = 2, 24 = 3, rest = 1) |
| `+0x05` | −5 to +7 | pan, fine tune, or a type variant |
| `+0x6E`, `+0x72`, `+0x76`, `+0x7A` | 0–100 % | **four voice parameters**, stored as `value / 32768` |
| `+0x7E` | mostly 0 | possible fifth parameter (only voice 23 is non-zero) |

There are also track-level values at track+0x3946..0x3952 (atom: 50 %, 50 %,
25 %, 0 %) and engine/envelope cells at +0x387D..+0x38E6. These are probably
M1–M4 and the shared Drumline controls.

## Setup

1. The OP-XY is on OS 1.2.0. Leave the USB audio mode on whatever you normally
   use, and note it here: ______
2. **New project.** Load `drumline/atom` on **Track 1**. Change nothing else.
3. Save it as **`dl00_base`**.
4. Every capture below is `dl00_base` plus **exactly one change**. Reopen
   `dl00_base` before each change, so changes don't build up.
5. If a step isn't possible on the device, skip it and write why.
6. Copy every file, unchanged, into
   `src/one-off-changes-from-default/firmware-1.2.0/drumline-params/`.

## Part A: read the screen, no saving (≈10 min)

On Track 1 (atom), play each key below and read its voice screen. Record the
drum type and every parameter's **name and displayed value, exactly as
shown**. The predicted percentages are what is stored, so if the display
matches them we've decoded the voice table without saving anything.

| voice | key (MIDI) | stored type `+03` | predicted P1 / P2 / P3 / P4 | drum type shown | P1 name = value | P2 name = value | P3 name = value | P4 name = value | other fields shown |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 53 | 4 | 50 / 50 / 25 / 0 | bass drum ✅ | pitch = 50 ✅ | length = 50 ✅ | punch = 25 ✅ | tone = 0 ✅ | |
| 2 | 54 | 4 | 15 / 85 / 10 / 15 | | | | | | |
| 3 | 55 | 1 | 50 / 50 / 50 / 25 | | | | | | |
| 9 | 61 | 2 | 55 / 37 / 43 / 79 | | | | | | |
| 24 | 76 | 3 | 75 / 61 / 63 / 50 | | | | | | |

**Correction (voice 1 reading, 2026-10-16):** each voice record starts
**0x12 bytes before** the key byte, at track+0x3945 + 0x80 × (v − 1). The
first four u32 fields (`value / 32768 × 100`) are the voice's four
on-screen parameters. Voice 1 matched exactly: pitch 50, length 50, punch 25,
tone 0. Within a record: `+0x10` is a possible fifth field, `+0x12` is unknown
(`0x40` on kick voices), `+0x14` is the key, `+0x15` is the type/mode (1–4),
and `+0x17` is signed. The table above uses the corrected predictions.

Also record:

- How do you get to a voice's screen (key hold, shift, page)? ______
- Are there several pages per voice? List every page and field: ______
- **Track level, M1–M4** on Track 1: names = values: ______
- The full list of drum types the type selector offers, in order: ______

## Part A results (2026-10-16, atom, all 24 keys read on the device)

All 96 parameter values match the stored fields. The display **truncates**
`value / 32768 × 100`, so 29.998 shows as 29.

**Model = low nibble of record `+0x12`** (record v = track+0x3945 + 0x80 × (v − 1)):

| nibble | model | P1 / P2 / P3 / P4 | atom keys |
|---|---|---|---|
| 0 | kick | pitch / length / punch / tone | 53, 54 |
| 1 | snare | pitch / length / snare / punch | 55, 56 |
| 2 | hi-hat | pitch / length / era / tone | 61–63, 66, 68 |
| 3 | shaker | color / length / attack / onset | 60, 74 |
| 4 | clap | tone / length / spread / contour | 58 |
| 5 | congas | pitch / length / slap / mush | 71, 72 |
| 6 | resonator | pitch / length / mod / feedback | 70, 75, 76 |
| 7 | **zap** (hidden; not in TE's list) | pitch / length / fm / feedback | none (probe `dlz_model7`) |
| 8 | fm tom | pitch / length / sweep / rate | 64, 65, 67, 69 |
| 9 | tambourine | tone / length / shake / ring | 59 |
| A | tune | pitch / length / tone / strike | 57, 73 |

Key 57's image looks like a tom, but its nibble is `A` and its parameter
names match tune.

Still open:

- **High nibble of `+0x12`** always equals byte `+0x15` (1–4). Kicks are 4,
  the hi-hats at keys 61–63 are 2, the hi-hats at 66 and 68 are 1, and key 76
  is 3. It may be a choke group or play mode.
- **`+0x17`** is signed (−5 to +7).
- **`+0x10..+0x11`** is non-zero only on key 76.

Part B (`dl09`–`dl13`) targets these.

## Probe results: files written by our tools, loaded on the device (2026-10-16)

We edited `drumline01.xy` byte-for-byte, uploaded the files over MTP, opened
them on the OP-XY, and read the screen at key 53 or listened at the hi-hats.
All of them loaded on OS 1.2.0.

| probe | change | result |
|---|---|---|
| `dla_ctrl` | none | kick 50 / 50 / 25 / 0 ✓ |
| `dlb_order` | P1–P4 = 0x1000 / 0x2000 / 0x3000 / 0x5000 | 12 / 25 / 37 / 62 ✓ (order = pitch, length, punch, tone) |
| `dlc_p1_0` | P1 = 0 | pitch 0 ✓ |
| `dld_p1_7fff` | P1 = 0x7FFF | pitch 99 ✓ (display = floor(v × 100 / 32768); 100 = 0x8000) |
| `dle_snare` | `+0x12` 0x40 → 0x41 | snare, with the snare's labels ✓ |
| `dlj_hat_b15` | key 63 `+0x15` 2 → 1 | still choked by key 61: `+0x15` is **not** the choke group |
| `dlk_hat_hi` | key 63 `+0x12` 0x22 → 0x12 | choke removed: **high nibble of `+0x12` is the choke group** |
| `dll_66_grp2` | key 66 `+0x12` 0x12 → 0x22 and `+0x15` 1 → 2 | key 66 now choked by 61 ✓ |

On the unmodified preset, the open hat on 63 is choked by 61. The hats on 66
and 68 ring over each other and over 63.

| `dlh_b17_7` | key 53 `+0x17` 0 → 7 | USB audio (8 ch, ch 1): exactly **+7.00 dB** on all 4 hits, f0 unchanged (48.4 Hz); after the gain is removed the residual is −94.8 dB, so it is pure gain. **`+0x17` = voice level in dB, signed int8.** |

| `dli_f10` | key 53 `+0x10` 0 → 0x0D1E (10.2 %) | USB audio: control hits are bit-identical, but these vary hit to hit (±0.1 dB, f0 52.3–52.4 Hz). The residual is mostly below 100 Hz and follows the body decay. **Likely a per-hit random variation (humanise) amount, u16 Q15.** Tentative (E1); confirm with a 100 % probe. |

| `dlz_model7` | key 53 `+0x12` 0x40 → 0x47 | Loads without a crash and plays a distinct, deterministic sound (−7.4 dB, f0 51.8 Hz). Screen: **"zap"**, a hidden model not in TE's list, labelled pitch / length / fm / feedback. |

**Shift page (per voice, found on `dlz_model7`):** model name, then **random / pan / volume**.
Key 53 reads random 0, pan 49, volume 59. Random is probably `+0x10`.
Volume relates to `+0x17` (dB), but the display mapping is still open.
The pan byte is not yet found.

**Shift-page readings (`dla_ctrl` keys 53/54/57/66/76, `dlh` k53, `dli` k53):**

- **random = `+0x10`**: key 76 and `dli` read 10, everything else 0.
- **volume display = 59 + 2 × `+0x17` (dB)**: 0 → 59, −2 → 55, +7 → 73,
  −4 → 51, −5 → 49 (5 of 5 points).
- **pan** reads 49 (centre) on every atom voice. Its byte is not yet found.
- Key 76 shows a **loop** play-mode icon and retriggers while held.
- The OP-XY offers 6 play modes, with icons loop, →g, →2, →3, →| and →.
  TE documents them as key, oneshot, mute group 1/2/3 and loop.

**Device-saved `dlx_modes.xy`** (play modes set on keys 53–58, pan on 59/60)
is authoritative:

| play mode (high nibble of `+0x12`) | icon | meaning |
|---|---|---|
| 0 | → | key (play while held), probable |
| 1 | →\| | oneshot, probable; the factory default for most voices |
| 2 | →g | mute group 1 (atom hats 61–63 choke each other) |
| 3 | loop | loop |
| 4 | →2 | mute group 2 (atom kicks) |
| 5 | →3 | mute group 3 |

- **Pan = `+0x18`**, signed int8, −100 (full left) … +100 (full right),
  0 = centre (shown as 49).
- **`+0x15` is not a play-mode mirror.** The device left it unchanged when
  the play mode changed. Its meaning is unknown; preserve it.
- `dlo_b13` / `dlp_b16` (value 16 written to `+0x13` / `+0x16`) had no visible
  effect.
- `dlq_rand100`: random shows 99, but eight MIDI-triggered hits were
  bit-identical to the control. Per-voice random alone does not vary the
  sound. It probably scales the track-wide M2 *random* amount, which is
  untested. The small hit-to-hit variation seen with `dli_f10` is
  unexplained.

**Track M2 page (Drumline layout: funk / attack / random / length).** It is
drawn as an envelope graphic with no numeric readout, so it is mapped from
min/max device saves.

- **M2 random = track `+0x387F`**, u32 LE, full scale (`0x7FFFFFFF` = max;
  atom = 0). Source: `dln_random_max.xy`, which is `dlq_rand100` saved on the
  device with M2 random at max. That save also cleared the pristine flag
  (track `+0x11` 8 → 0).
- **Full M2 map** (device saves `dla_funk`, `dla_attack`, `dla_length` and
  `dla_allmin`, each from `dla_ctrl`). Drumline reuses the amp-envelope ADSR
  slots:

  | track offset | ADSR slot | Drumline M2 | atom |
  |---|---|---|---|
  | `+0x3877` | attack | funk | 0 |
  | `+0x387B` | decay | attack | 0 |
  | `+0x387F` | sustain | random | 0 |
  | `+0x3883` | release | length | `0x40000000` |

  Each is u32 LE, 0 … `0x7FFFFFFF`. Each capture changed only its own word;
  `dla_allmin` changed only length (→ 0).
- USB audio at M2 random max: pitch, length and level vary heavily on every
  hit, for every voice, including voice random 0.

**Rule: `+0x12` = (play mode << 4) | model.** This corrects the earlier
"choke group" reading: choke is the mute-group play mode. Seen so far:
3 = loop (key 76), 2 = a mute group (hats 61–63), and 1 and 4 are not yet
identified. `+0x15` mirrors the play mode.

Official reference: https://teenage.engineering/guides/op-xy/synth-engines#drumline Group 1 means no choke;
atom's hi-hat group is 2. Groups 3 and 4 appear, but their behaviour has not
been tested. `+0x15` mirrors the group in every factory voice. Its purpose is
unknown, so writers should keep it equal to the group.

## Part B: single-change captures (≈30 min)

Unless noted, change **voice 1 (key 53)**. "Min" and "max" mean turn the
encoder to its end stop. If P1–P4 turn out not to be the first four on-screen
parameters, use the screen order and note it.

| file | change (from `dl00_base`) | value shown after | target bytes |
|---|---|---|---|
| `dl01_p1_min` | voice 1, P1 → min | | `+0x6E` scale, low end |
| `dl02_p1_max` | voice 1, P1 → max | | `+0x6E` high end |
| `dl03_p2_min` | voice 1, P2 → min | | `+0x72` |
| `dl04_p2_max` | voice 1, P2 → max | | `+0x72` |
| `dl05_p3_min` | voice 1, P3 → min | | `+0x76` |
| `dl06_p3_max` | voice 1, P3 → max | | `+0x76` |
| `dl07_p4_min` | voice 1, P4 → min | | `+0x7A` |
| `dl08_p4_max` | voice 1, P4 → max | | `+0x7A` |
| `dl09_type_next` | voice 1, drum type → next type | | `+0x03`? Does the whole slot change? |
| `dl10_type_prev` | voice 1, drum type → previous type | | `+0x03` |
| `dl11_pitch_up1` | voice 1, pitch / tune +1 step | | `+0x00`? |
| `dl12_pitch_max` | voice 1, pitch / tune → max | | `+0x00` range |
| `dl13_other` | voice 1, any remaining voice field (pan / level / decay), +1 step | | `+0x05`? |
| `dl14_v2_p1_max` | **voice 2 (key 54)**, P1 → max | | confirms the 128-byte voice stride |
| `dl15_v24_p1_max` | **voice 24 (key 76)**, P1 → max | | voice 24's slot overlaps the preset name |
| `dl16_m1` | track M1, +5 steps | | track+0x3946? |
| `dl17_m2` | track M2, +5 steps | | |
| `dl18_m3` | track M3, +5 steps | | |
| `dl19_m4` | track M4, +5 steps | | |
| `dl20_resave` | no change, save again | — | control: shows save-only churn |

If a voice has more than four parameters, or more than one page, add
`dl13b_…`, `dl13c_…` and so on (one change per file), keeping alphabetical
order.

## Optional: unlock 1.2.0 writes (≈5 min)

These two help the separate write-validation plan
(`docs/logs/2026-10-16_os_1_2_0_layout_diff.md`):

- `a_blank`: new project, save immediately.
- `b_t1_note`: new project, one C4 note on Track 1 step 1, save.

## After the session

Send me the filled-in tables and the files. I'll then:

1. Run `decoded_diff.py dl00_base.xy <each>` and pin each field: offset,
   scaling, range and default.
2. Turn the results into a read-only Drumline voice inspector, with tests
   against these captures.
3. Update `decoded_image_map.md` and `spatial_coverage_ledger.md`, with
   evidence tiers.
4. Leave writing Drumline parameters gated until 1.2.0 writes pass on
   hardware.
