# Parse & Author Capability Checklist

Living checklist of what this repo can **read**, **write**, and **inspect** in
OP-XY `.xy` project files. Update when a field moves from guessed → decoded →
device-validated.

**Legend**

| Mark | Meaning |
| --- | --- |
| `[x]` | Implemented with tests or corpus/device validation |
| `[~]` | Partial — location or heuristic known; enums/scaling/edge cases open |
| `[ ]` | Not implemented or not pinned to stable offsets |

**Primary code paths**

| Layer | Read / inspect | Write |
| --- | --- | --- |
| Container + RLE | `xy/rle.py` (`decode_project`) | `xy/rle.py` (`encode_project`) |
| Legacy logical entries | `xy/scaffold_writer.py` (`extract_logical_entries`) | superseded for authoring |
| RAM image edits | `xy/image_writer.py` (`ImageProject`) | same |
| Arrangement assembly | `xy/image_writer.py` (`build_arrangement`) | same |
| Notes (single-pattern read) | `xy/note_reader.py`, `tools/inspect_xy.py` | `ImageProject.add_note` |
| P-locks | `xy/plocks.py` | `ImageProject.set_plock` |
| Step components | `xy/step_components.py` | `ImageProject.set_step_component` |
| JSON intent export | `xy/project_to_json.py` | `xy/json_build_spec.py` + profiles |
| Preset reference inference | `xy/project_inspection.py` | `ImageProject.set_preset` (donor copy) |
| Track preset path @ `+0x453F` | `xy/preset_path_inspection.py` | gap — donor `set_preset` only |
| Drum sample path read | `xy/drum_sample_inspection.py` | indirect via `set_preset`; no per-slot path API |
| Human report | `tools/inspect_xy.py` | — |

Detailed guide cross-reference: `docs/format/opxy_user_guide_save_audit.md`.
Field offsets: `docs/format/decoded_image_map.md`.
**Byte-region overview:** `docs/format/image_coverage_map.md`.

---

## 1. Container & file format

- [x] 8-byte file header (magic, payload length) — `xy/container.py`
- [x] Whole-file RLE decode/encode (245/246 corpus byte-exact) — `xy/rle.py`, `tests/test_rle.py`
- [x] Decoded RAM image as primary edit surface — `docs/format/record_structure.md`
- [~] Non-greedy RLE specimens (e.g. `bleez.xy`) — decode OK, re-encode may shrink — `docs/state_of_understanding.md`

## 2. Global / project header

- [x] Tempo (BPM, u16 tenths) — read: `tools/inspect_xy.py`; write: `ImageProject.set_tempo`
- [x] Groove type enum (subset named) — read/write: `set_groove`, `docs/format/header.md`
- [~] Groove amount — header bytes documented; not in image map — `docs/format/header.md`
- [x] Metronome click volume — `set_click_volume`
- [~] Metronome on/off — partial — `opxy_user_guide_save_audit.md` § Tempo
- [x] Per-track MIDI channel (T1–T16) — `set_midi_channel`, global `0x55–0x64`
- [x] Master EQ low/mid/high — device-validated min/default/max — `read_master_eq`,
  global `0x68/0x6C/0x70`, P2-F `eq0`–`eq6`
- [~] Active song/scene selection — global `0x06–0x07` touched; semantics incomplete — `opxy_user_guide_save_audit.md` § Arrange
- [ ] Project transpose — gap
- [ ] Time signature enum — gap
- [ ] Voice allocation / 24-voice priority — gap
- [ ] Internal project display name — gap

## 3. Pre-track topology & pattern directory

- [x] Multi-pattern descriptor / pre-track length — `docs/format/descriptor_encoding.md`
- [x] Pattern max slot, track handles, slot descriptors — `xy/structs.py`, `tools/inspect_xy.py`
- [x] Leader vs clone pattern structs (17,876 B) — `docs/format/multi_pattern_block_rotation.md`
- [x] Logical track/pattern entry extraction — `xy/scaffold_writer.py` (`extract_logical_entries`)

## 4. Sequencer: notes, timing, bars

- [x] Quantized note records (tick, gate, note, velocity, flags) — `xy/note_reader.py`
- [x] Event type 0x25 and preset-native families — `xy/note_events.py`, `docs/format/events.md`
- [x] 120-note pattern cap enforced on write — `ImageProject.add_note`
- [x] Bars per pattern (`bars << 4` @ track+`0x01`) — `set_bars`
- [x] Track scale byte (subset: 1/2, 1/2, 16 observed) — `set_track_scale`
- [~] Track scale full enum (3, 4, 6, 8) — partial — `opxy_user_guide_save_audit.md`
- [ ] Final-bar / partial-bar length — gap
- [ ] Per-track quantization amount — gap
- [ ] Default step length (persistent) — gap
- [ ] Per-track groove override — gap
- [ ] P-lock smoothing/shape — gap

## 5. Step components (14 types)

- [x] 16-byte slots, enabled mask, 14 value bytes — `xy/step_components.py`
- [x] Read/write pulse, hold, velocity, portamento, etc. — `set_step_component`, `STEP_COMPONENTS`
- [~] Complete user-facing value enum for every guide table column — partial — `docs/format/step_components.md`

## 6. Parameter locks

- [x] 64×84-byte table, 42 u16 columns — `xy/plocks.py`
- [x] Param name → column mapping (vol, params, ADSR, sends, LFO, pan, …) — `PLOCK_PARAMS`, `ImageProject.set_plock`
- [x] Automation across steps — `ImageProject.automate_param`
- [~] Static current-value offsets for mix params (vs p-lock-only) — partial — `opxy_user_guide_save_audit.md` § Mix

## 7. Instrument, engine, preset

- [x] Engine ID @ track+`0x14` — `set_engine`, `inspect_xy`
- [x] Engine M1 params (4× u32 @ `+0x3857`) — `set_engine_param`
- [x] Amp/filter envelope blocks — `set_track_block`, decoded map
- [x] Filter type/on @ `+0x21`, `+0x25` — `set_filter`
- [x] Filter knobs @ `+0x3897` — decoded map
- [x] Preset identity **write** via donor region copy — `ImageProject.set_preset`, `tests/test_image_writer.py`
- [x] Preset reference **read** (heuristic) per active pattern — `xy/project_inspection.py`, `tests/test_project_inspection.py`
- [x] Preset path structural **read** @ track `+0x453F` — `xy/preset_path_inspection.py`,
  `tests/test_preset_path_structural.py`, `src/app-preset-probes/2026-06-preset-path/`
- [~] Preset path **write** @ `+0x453F` — not exported in `project_to_json` yet
- [~] Play mode poly/mono/legato current value — partial
- [~] Portamento amount/type, bend range — partial
- [~] Preset volume / engine volume current value — partial
- [~] LFO type and M4 subfunctions — partial, `+0x38B7`, mod matrix `+0x3900`
- [x] Preset settings: high-pass, velocity sensitivity — decoded map
- [ ] Preset settings: tuning, root, transpose, width — gap
- [ ] Mod-routing destination enum + signed scaling — gap
- [ ] User `.preset` file format (filesystem) — outside `.xy`

## 8. Drum sampler (24 voices)

- [x] 24×128 B voice table @ track+`0x3957` — `set_drum_voice`, `tests/test_image_writer.py`
- [x] Sample path **read** @ slot+`0x08` — `xy/drum_sample_inspection.py`, device fixtures
  `src/app-sample-probes/2026-06-sample-paths/` + `archive-round0-nt-z-fx/`,
  `tests/test_drum_sample_inspection.py`, `tests/test_drum_sample_inspection_round0.py`
- [~] Sample path **write** — only as part of donor `set_preset` region copy; no
  `set_drum_voice_path()` yet — `docs/format/drum_sample_paths.md`
- [x] Tune, play mode, direction, start, end, gain — `set_drum_voice` (tune device-validated)
- [x] Pan read/write @ slot `+0x06` — device ±100, `tests/test_drum_pan_fade_inspection.py`
- [x] Fade / loop-crossfade @ preceding voice `+0x7C` — `fade_ui`, `encode_drum_fade_ui`,
  `set_drum_voice(..., fade=)`; v23 UI → v22 storage; 21 fade fixtures in
  `tests/test_drum_pan_fade_inspection.py`
- [ ] Drum slicing metadata / choke groups — gap

## 9. One-shot / multisampler slots

- [~] High-level sample table structure — partial — `docs/format/track_blocks.md`
- [x] One-shot loop/crossfade/tune/gain/direction per slot — P2-B `g0`–`g14`,
  `xy/sampler_sample_inspection.py` (header @ `+0x3943`, not drum `+0x68`) — gap
- [ ] Multisampler zone boundaries / root key — gap

## 10. Scenes, songs, arrangement

- [x] Scene slots: pattern sel[16] + mute[16] + flags — `build_arrangement`, `docs/format/scenes_songs.md`
- [x] Scene mute (device value 2) — scenes 1–8, slot `N−1` — `tests/test_scene_track_mute_inspection.py`, `scene_mute_storage_slot`, `read_scene_muted_tracks`
- [x] Song footer chain + loop word — `build_arrangement`
- [x] Multi-pattern clone assembly — `build_arrangement`
- [~] 14 song slots vs guide “9 songs” — partial reconciliation — `opxy_user_guide_save_audit.md`
- [x] Track mix volume **read** @ track+`0x38FE` (u32 @ `+0x38FB`) —
  `xy/scene_volume_inspection.py`, P2-D `s0b` fixtures; scene routing partial
- [x] Master mix volume **read** @ global+`0x94` — same module (`s5b`)
- [~] Scene-stored volumes **playback** — bytes differ per scene; operator
  heard global mix on 1.1.4 — needs chained capture retest

## 11. Mix, saturator, master

- [x] Master EQ — `xy/master_eq_inspection.py`, P2-F
- [x] Track static volume/pan/send FX1/FX2 **read** @ `+0x38FE`/`+0x38FA`/`+0x38B2`/`+0x38B6`
  — `xy/mixer_static_inspection.py`, P2-A f0–f24 (T1–T8 confirmed)
- [x] Master perc/melody/compressor/master **read** @ global `+0x88`/`+0x8C`/`+0x90`/`+0x94`
  — same module
- [x] Master saturator gain/clip/tone/mix — `read_master_saturator`, global
  `0x78`/`0x7C`/`0x80`/`0x84`, P2-G `sat0`–`sat8`

## 12. Auxiliary tracks (T9–T16)

- [~] Generic track struct, notes, p-locks — same as instrument tracks
- [ ] Brain (T9) settings / routing — gap
- [ ] Punch-in FX (T10) — gap
- [ ] External MIDI channel/bank/program/CC (T11) — gap
- [ ] External CV (T12), audio (T13), tape (T14) — gap
- [~] FX I/II (T15/T16) type enums and params — partial

## 13. Players (arpeggio / maestro / hold)

- [ ] Player enable/type per track — gap
- [ ] Arpeggio parameters — gap
- [ ] Maestro chord buffer — gap
- [ ] Hold player state — gap

## 14. JSON / tooling bridges

- [x] Spec → image compiler — `tools/spec_to_xy_image.py`, `tests/test_write_music_showcase_pack.py`
- [~] Project → JSON intent export — `xy/project_to_json.py` (notes + header; **no** preset refs, clones, scenes)
- [x] Profile-gated JSON build — `xy/profiles.py`, `tests/test_profiles.py`
- [x] Corpus index/lab — `tools/corpus_lab.py`
- [x] Round-trip verify — `tools/roundtrip_xy.py`
- [x] Inspector CLI with track preset paths, pattern presets, drum samples — `tools/inspect_xy.py`

## 15. Outside project `.xy`

- [ ] COM / system / Bluetooth / MTP settings — device-global, not in `.xy` — `opxy_user_guide_save_audit.md` § COM
- [ ] Sample folder WAV/AIFF on disk — filesystem; only paths referenced in project

---

## How to close a gap

1. Capture one-variable device diff → add fixture under `src/`.
2. Promote offset/rule to `docs/format/decoded_image_map.md` and
   `docs/format/image_coverage_map.md`.
3. Add read path (`inspect_xy` / `project_to_json`) and/or write path (`ImageProject`).
4. Check the box here and link the test file.
5. Update `docs/format/opxy_user_guide_save_audit.md` if guide-visible.

## Device roundtrip workflow (author → OP-XY → confirm)

Use this when promoting a field from decoded → **device-validated**:

1. **Author** — build or edit with `ImageProject` / `tools/spec_to_xy_image.py` /
   JSON profiles; save `.xy` under `output/` or `src/`.
2. **Expect** — write a short expectation file (YAML/JSON/markdown) listing what
   you believe the device should show: preset name, drum path per voice, tempo,
   etc. Keep one variable per probe file when possible.
3. **Transfer** — MTP upload to OP-XY (`tools/mtp_upload.py` or app).
4. **Load** — open on hardware; note pass/fail per expectation line.
5. **Capture** — Save As on device; pull `.xy` back; add as fixture under
   `src/app-*-probes/`.
6. **Verify** — `inspect_xy` + targeted tests; compare author bytes to capture
   where byte-exact writer tests exist (`tests/test_image_writer.py` pattern).

In-repo **software** roundtrip (no device): `tools/roundtrip_xy.py` checks RLE
re-encode; `tests/test_container_roundtrip.py` and corpus parametrized tests
check decode→encode on fixtures. That does **not** prove the device accepts an
authored edit — only that our container layer round-trips.

## Related logs

- App preset probe inspection: `docs/logs/2026-06-09_app_preset_probe_inspection.md`
- Drum sample path inspection: `docs/logs/2026-06-12_drum_sample_path_inspection.md`
- Round 0 `nt-z-fx` paths: `docs/logs/2026-06-12_round0_nt-z-fx_sample_paths.md`
- Drum path format reference: `docs/format/drum_sample_paths.md`
- State-of-understanding ledger: `docs/state_of_understanding.md`
- OP-XY user guide save audit (detailed tables): `docs/format/opxy_user_guide_save_audit.md`
