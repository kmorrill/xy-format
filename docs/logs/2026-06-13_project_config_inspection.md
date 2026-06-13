# 2026-06-13 — Project config inspection

Fixture pack: `src/project-config-probes/2026-06-project-config/`

Source probe README status: firmware 1.1.4, fresh baseline `prjconf0.xy`.
The pack contains 52 one-variable or layout variants plus the baseline and
README.

## Decoded fields

All offsets are decoded-image global offsets:

| Field | Offset | Encoding | Fixtures |
| --- | --- | --- | --- |
| Groove type | `0x03` | enum `0..10`: shuffle, half-shuffle, danish, bombora, wobbly, gaussian, accents, island nod, disfunk, roll over, prophetic | `prjconf-t-grv-*` |
| Scene length | `0x08` | `0` longest, `1` shortest, `2` time signature | `prjconf-g-slen-*` |
| Global transpose | `0x1B` | signed i8 semitones, validated at −24, −1, +1, +24 | `prjconf-g-x*` |
| Time signature | `0x1C` | `0x10` 3/4, `0x11` 4/4, `0x12` 5/4, `0x13` 6/8, `0x14` 7/8, `0x15` 12/8 | `prjconf-t-sig-*` |
| Voice allocation | `0x4D–0x54` | T1–T8, `0` auto, `1`–`8` fixed voice count | `prjconf-v-*` |
| MIDI channel | `0x55–0x64` | T1–T16, `0xFF` off, `0x00`–`0x0F` = channels 1–16 | `prjconf-m-*` |

The baseline decodes as transpose 0, scene length `longest`, time signature
4/4, groove `shuffle`, T1–T8 voices all auto, and T1–T16 MIDI all off.

## Save-side noise

Every project-config variant also changes T9–T16 track-relative
`+0x38F2` and `+0x38F6` from `0x00` to `0x40`. This common change does not
track the edited project-config field and is treated as save-side/UI noise in
`tests/test_project_config_inspection.py`.

## Code

- Read API: `xy/project_config_inspection.py`
- Writer helpers: `ImageProject.set_scene_length_mode`,
  `set_project_transpose`, `set_time_signature`, `set_voice_allocation`
  plus existing `set_groove` and `set_midi_channel`
- Human report: `[Project Config]` in `tools/inspect_xy.py`
- Tests: `tests/test_project_config_inspection.py`,
  `tests/test_inspector_outputs.py`
