# OS 1.2.0 decoded-layout diff and write-validation plan

Date: 2026-10-16

OP-XY OS 1.2.0 adds the Drumline drum synth engine, a dynamic track filter
with drive, a per-preset detune setting, multi-channel USB audio, and improved
bootloader security. Device-saved projects use container header
`ddccbbaa09140786`: header byte 5 is `0x14` and byte 6 is `0x07`.

This log records what the first 1.2.0 captures show about the decoded image,
and the device evidence still needed before authored 1.2.0 projects can be
treated as safe.

## Fixtures compared

| key | file | header | decoded |
|---|---|---|---:|
| old | `src/one-off-changes-from-default/unnamed 1.xy` | `09130386` | 289,521 |
| 1.1.21 | `src/factory-preset-captures/firmware-1.1.21/batches/fp01.xy`, `fp02.xy` | `09130686` | 289,521 |
| 1.2.0 | `src/factory-preset-captures/firmware-1.2.0/batches/drumline01.xy`, `drumline02.xy` | `09140786` | 289,521 |

There is no blank 1.2.0 project yet. The Drumline captures stand in for one.
Each was saved once from a fresh blank project with only Tracks 1–8
reassigned, so the global header, Tracks 9–16 and the footer are effectively
blank-project state.

All five files re-encode byte-exact with `xy/rle.py`.

## Results

Controls: two captures from the same firmware differ only in the reassigned
Tracks 1–8. Neither firmware shows any global, Track 9–16 or footer
differences between its two captures.

1.1.21 → 1.2.0, outside the reassigned tracks:

| region | 1.1.21 | 1.2.0 | `09130386` | notes |
|---|---|---|---|---|
| global `0x3D..0x44` (8 B) | `fe × 8` | `00 × 8` | `00 00 ff 01 00 ff 00 00` | Inside opaque `global.pre_scene_cluster` (`0x08..0x54`), just before the T1–T8 voice allocation at `0x4D`. Eight bytes suggests a T1–T8 array. Meaning unknown (E0). |
| T9–T16 `+0x38F2`, `+0x38F6` | `0x40` | `0x00` | `0x00` | Already documented as a project-config save side effect. 1.2.0 fresh projects match the old fresh baseline, so this is not a 1.2.0 change. |

No other byte differs. In particular:

- Track 1 still starts at 3,449, with the same 17,876-byte track stride and
  16 leaders.
- The footer is still the 56-byte, 14-slot song table.
- Drumline is engine ID `0x04` at track+0x14. No other corpus file uses that
  value. Like every earlier engine swap, it is a size-preserving in-place
  substitution.

Conclusion: on blank-project evidence, family `0x14` uses the `0x13` decoded
topology. `xy/image_writer.py` now maps `0x14` explicitly, where it
previously fell back to `TRACK_BASE0`, which happened to be the same value.

Filter drive and detune cannot show up in these fixtures, because neither was
edited. They probably occupy currently-zero opaque track bytes, which
image-based edits already preserve.

## Device validation plan

Device: OP-XY on OS 1.2.0. Filenames sort in test order. Record every result
with `python tools/corpus_lab.py record <file> <pass|crash|untested> --note "..."`
and follow `docs/workflows/crash_capture.md` for any crash.

### Phase 1: device-authored captures

Each capture starts from **New project**, makes only the listed change, and
saves once.

| file | change | what it answers |
|---|---|---|
| `a_blank.xy` | nothing | True 1.2.0 blank baseline. What is the value of `0x3D..0x44`? |
| `b_t1_note.xy` | T1, step 1, one C4 note | Is the note vector unchanged? Byte-exact writer replication target. |
| `c_t1_2pat.xy` | add pattern 2 on T1 | Is pattern struct growth still 17,876 B? |
| `d_song.xy` | scene 2; song 1 = scenes 1,2 | Are the footer and scene slab unchanged? |
| `e_plock.xy` | T1, one p-lock on step 1 | Is the p-lock lane layout unchanged? |
| `f_usb8ch.xy` | USB audio `8 ch`, save | Is the USB mode project-scoped? Does `0x3D..0x44` move? |
| `g_drive.xy` | T1 filter drive, one detent | Where is the filter-drive field? |
| `h_detune.xy` | T1 preset detune, one detent | Where is the detune field? |
| `i_resave_old.xy` | load a 1.1.21 project, save unchanged | How does the firmware migrate older projects? |

**Gate 1 (desk):** the image writer, starting from `a_blank.xy`, reproduces
`b_`, `c_`, `d_` and `e_` byte-exact.

### Phase 2: authored files loaded on the device

Generate these from `a_blank.xy` and keep header `09140786`.

| file | content |
|---|---|
| `01_note.xy` | Writer replica of `b_t1_note.xy`. Must be byte-identical before loading. |
| `02_arrange.xy` | `spec_to_xy_image.py` multi-track, multi-pattern, scenes and song chain, with p-locks |
| `03_drumline.xy` | Drumline donor on T1 with a 16-step pattern |
| `j_old_hdr_drumline.xy` | `09130386` baseline with a Drumline (`0x04`) donor track |

`j_` tests whether a pre-1.2.0 header can carry the new engine on 1.2.0. Until
it passes, newer-family donors should not be spliced into older-family
projects.

A file passes (evidence tier **E3**) when it:

1. loads without an assert;
2. plays as expected;
3. after saving on the device and pulling it back, decodes with only known UI
   and pristine-flag changes.
