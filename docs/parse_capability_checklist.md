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

**Evidence tiers** (use in logs and when marking `[~]`)

| Tier | Meaning | Required citation |
| --- | --- | --- |
| **E0** | Code path only — no fixture | module + unit test or corpus-only diff |
| **E1** | Corpus diff | `src/one-off-changes-from-default/` or change log |
| **E2** | Device probe + in-repo fixture | `src/*-probes/` + `tests/test_*` + dated log |
| **E3** | Device load validated | E2 + operator pass note or `corpus_lab record` |

Every `[x]` row below should cite at least **E1**; prefer **E2** for guide-visible
fields. Heuristic reads must say so and stay `[~]` until structural decode exists.

**Citation format** (inline): `evidence: tests/foo.py · log · fixtures/pack`

**Inspection module index** (2026-06 read APIs)

| Module | Tests | Primary log | Fixtures |
| --- | --- | --- | --- |
| `xy/project_inspection.py` | `test_project_inspection.py` | `2026-06-09_app_preset_probe_inspection.md` | `preset-probes/` (heuristic preset refs) |
| `xy/preset_path_inspection.py` | `test_preset_path_structural.py` | `2026-06-12_preset_path_structural.md` | `2026-06-preset-path/` |
| `xy/drum_sample_inspection.py` | `test_drum_sample_inspection*.py`, `test_drum_pan_fade_inspection.py`, `test_drum_voice_params_inspection.py` | `2026-06-12_drum_sample_path_inspection.md` | `2026-06-sample-paths/`, `2026-06-drum-pan-fade/` |
| `xy/mixer_static_inspection.py` | `test_mixer_static_inspection.py` | `2026-06-12_mixer_static_inspection.md` | `2026-06-static/` |
| `xy/scene_volume_inspection.py` | `test_scene_volume_inspection.py` | `2026-06-12_scene_volume_inspection.md` | `2026-06-volumes/` |
| scene mutes (same module) | `test_scene_track_mute_inspection.py` | `2026-06-12_scene_track_mute_inspection.md` | `2026-06-track-mutes/` |
| `xy/master_eq_inspection.py` | `test_master_eq_inspection.py` | `2026-06-12_master_eq_inspection.md` | `2026-06-eq/` |
| `xy/master_saturator_inspection.py` | `test_master_saturator_inspection.py` | `2026-06-12_master_saturator_inspection.md` | `2026-06-saturator/` |
| `xy/sampler_sample_inspection.py` | `test_sampler_sample_inspection.py` | `2026-06-12_sampler_oneshot_inspection.md` | `2026-06-oneshot/` |
| `xy/project_config_inspection.py` | `test_project_config_inspection.py` | `2026-06-13_project_config_inspection.md`, `2026-06-13_global_header_inspection.md` | `2026-06-project-config/`, `2026-06-global-header/` |
| `xy/bar_menu_inspection.py` | `test_bar_menu_inspection.py` | `2026-06-13_bar_menu_inspection.md`, `2026-06-14_bar_length_inspection.md` | `2026-06-bar-menu/`, `2026-06-bar-length/` |

Contributor workflow: `docs/workflows/contributor_inspection_workflow.md`.

**Primary code paths**

| Layer | Read / inspect | Write |
| --- | --- | --- |
| Container + RLE | `xy/rle.py` (`decode_project`) | `xy/rle.py` (`encode_project`) |
| RAM image edits | `xy/image_writer.py` (`ImageProject`) | same |
| Arrangement assembly | `xy/image_writer.py` (`build_arrangement`) | same |
| Notes | decoded note vector (`tools/inspect_xy.py`, `xy/image_writer.py`) | `ImageProject.add_note` |
| P-locks | `xy/plocks.py` | `ImageProject.set_plock` |
| Step components | `xy/step_components.py` | `ImageProject.set_step_component` |
| Preset reference inference | `xy/project_inspection.py` (heuristic) | `ImageProject.set_preset` (donor copy) |
| Track preset path @ `+0x453F` | `xy/preset_path_inspection.py` | gap — donor `set_preset` only |
| Drum sample path read | `xy/drum_sample_inspection.py` | indirect via `set_preset`; no per-slot path API |
| Static mixer / master bus read | `xy/mixer_static_inspection.py` | `ImageProject.set_track_*_byte/raw`, `set_master_*_byte/raw` |
| Scene volumes + mutes read | `xy/scene_volume_inspection.py` | partial write via `build_arrangement` |
| Master EQ / saturator read | `xy/master_eq_inspection.py`, `xy/master_saturator_inspection.py` | `set_master_eq`, `set_master_saturator_*_byte/raw` |
| Sampler one-shot read | `xy/sampler_sample_inspection.py` | `set_sampler_sample_edit` |
| Project config/global header read | `xy/project_config_inspection.py` | `set_groove`, `set_groove_amount`, `set_click_volume`, `set_scene_length_mode`, `set_project_transpose`, `set_time_signature`, `set_voice_allocation`, `set_midi_channel`, `set_active_scene`, `set_active_song` |
| Bar menu read | `xy/bar_menu_inspection.py` | `set_pattern_steps`, `set_default_step_length_ticks`, `set_track_quantization_raw`, `set_track_groove_ui`, `set_plock_shape_raw` |
| Confirmed aux fields | aux probe tests | ergonomic wrappers where discrete labels are proven; raw-word setters where bucket boundaries remain open |
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
- [x] Groove type enum — read/write: `xy/project_config_inspection.py`, `set_groove`,
  global `0x03`, PCFG `prjconf-t-grv-*`
- [x] Groove amount — signed i8 at global `0x02`, `set_groove_amount`,
  HDR `hdr-grv-*`
- [x] Metronome click volume — `set_click_volume`
- [x] Metronome on/off persistence — HDR probes show no independent toggle byte;
  off and volume-min both persist as click volume `0x00` at global `0x04`
- [x] Per-track MIDI channel (T1–T16) — `set_midi_channel`,
  `xy/project_config_inspection.py`, global `0x55–0x64`, PCFG `prjconf-m-*`
- [x] Master EQ low/mid/high — device-validated min/default/max with exact u32 spill
  lanes — `read_master_eq`, global `0x68/0x6C/0x70`, P2-F `eq0`–`eq8`
- [x] Active scene/song selection — scene slot at global `0x06`, song slot at
  global `0x07` (`0x10` fresh Song 1 sentinel), HDR `hdr-arr-*`
- [x] Project-config scene length mode — `xy/project_config_inspection.py`,
  global `0x08`, PCFG `prjconf-g-slen-*`
- [x] Project transpose — signed i8 at global `0x1B`, range −24..+24,
  `set_project_transpose`, PCFG `prjconf-g-x*`
- [x] Time signature enum — global `0x1C`, `0x10` 3/4 through `0x15` 12/8,
  `set_time_signature`, PCFG `prjconf-t-sig-*`
- [x] Voice allocation / 24-voice priority — T1–T8 at global `0x4D–0x54`,
  `0` auto / `1`–`8` fixed, `set_voice_allocation`, PCFG `prjconf-v-*`
- [x] Internal project display name — no decoded-image name field found; project
  list name is external `.xy` filename, HDR decode search

## 3. Pattern topology

- [x] Leader vs clone pattern structs (17,876 B base) — `docs/format/decoded_image_map.md`, `xy/image_writer.py`
- [x] Pattern count and clone walking in decoded image — `pattern_starts_from_image`, `build_arrangement`
- [x] Scene/song selection rows over pattern indices — `docs/format/scenes_songs.md`

## 4. Sequencer: notes, timing, bars

- [x] Quantized note records (tick, gate, note, velocity, flags) —
  decoded vector at track+`0x456F`, `ImageProject.add_note`
- [x] 120-note pattern cap enforced on write — `ImageProject.add_note`
- [x] Bars per pattern / active steps (full bars: `16`, `32`, `48`, `64` at track+`0x01`) — `set_bars`, `set_pattern_steps`
- [x] Track scale byte (subset: 1/2, 1, 2, 16 observed) — `set_track_scale`
- [~] Track scale full enum (3, 4, 6, 8) — partial — `opxy_user_guide_save_audit.md`
- [x] Final-bar / partial-bar length — total active steps at track+`0x01`;
  `steps = (bars - 1) * 16 + final_bar_steps` — BAR-LEN fixtures
- [x] Per-track quantization amount — raw byte at track+`0x07`;
  UI display `floor(raw * 100 / 255)` — BAR fixtures
- [x] Default step length (persistent) — u16 ticks at track+`0x02`;
  `240` default, `480` max — `xy/bar_menu_inspection.py`
- [x] Per-track groove override — index byte at track+`0x08`;
  storage is `3 * index` into the displayed UI sequence, saturated at ±99 — BAR fixtures
- [x] P-lock smoothing/shape — raw byte at track+`0x3056`;
  UI labels/icons still open — `xy/bar_menu_inspection.py`

## 5. Step components (14 types)

- [x] 16-byte slots, enabled mask, 14 value bytes — `xy/step_components.py`
- [x] Read/write pulse, hold, velocity, portamento, etc. — `set_step_component`, `STEP_COMPONENTS`
- [~] Complete user-facing value enum for every guide table column — partial — `docs/format/step_components.md`

## 6. Parameter locks

- [x] 64×84-byte table, 42 u16 columns — `xy/plocks.py`
- [x] Param name → column mapping (vol, params, ADSR, sends, LFO, pan, …) — `PLOCK_PARAMS`, `ImageProject.set_plock`
- [x] 8-byte per-step lane mask; columns 1–41 → bits 0–40, volume column 0 → bit 41 — `ImageProject.set_plock`
- [x] Automation across steps — `ImageProject.automate_param`
- [~] Static current-value offsets for mix params (vs p-lock-only) — partial — `docs/format/opxy_user_guide_save_audit.md` § Mix

## 7. Instrument, engine, preset

- [x] Engine ID @ track+`0x14` — `set_engine`, `inspect_xy`
- [x] Engine M1 params (4× u32 @ `+0x3857`) — `set_engine_param`
- [x] Amp/filter envelope blocks — `set_track_block`, decoded map
- [x] Filter type/on @ `+0x21`, `+0x25` — `set_filter`
- [x] Filter knobs @ `+0x3897` — decoded map
- [x] Preset identity **write** via donor region copy — `ImageProject.set_preset`, `tests/test_image_writer.py`
- [~] Preset reference **read** (heuristic) per active pattern — fixture-backed inference in
  `xy/project_inspection.py` / `tests/test_project_inspection.py`; stays partial until the
  `0xF7` preset-fragment region is structurally decoded
- [x] Preset path structural **read** @ track `+0x453F` — `xy/preset_path_inspection.py`,
  `tests/test_preset_path_structural.py`, `src/preset-probes/2026-06-preset-path/`
- [~] Preset path **write** @ `+0x453F` — no dedicated writer yet
- [~] Play mode poly/mono/legato current value — partial
- [~] Portamento amount/type, bend range — partial
- [~] Preset volume / engine volume current value — partial
- [~] LFO type and M4 subfunctions — partial, `+0x38B7`, mod matrix `+0x38FF`
- [x] Preset settings: high-pass, velocity sensitivity — decoded map
- [ ] Preset settings: tuning, root, transpose, width — gap
- [ ] Mod-routing destination enum + signed scaling — gap
- [ ] User `.preset` file format (filesystem) — outside `.xy`

## 8. Drum sampler (24 voices)

- [x] 24×128 B voice table @ track+`0x3957` — `set_drum_voice`, `tests/test_image_writer.py`
- [x] Sample path **read** @ slot+`0x08` — `xy/drum_sample_inspection.py`, device fixtures
  `src/drum-sample-probes/2026-06-sample-paths/` + `archive-round0-nt-z-fx/`,
  `tests/test_drum_sample_inspection.py`, `tests/test_drum_sample_inspection_round0.py`
- [~] Sample path **write** — only as part of donor `set_preset` region copy; no
  `set_drum_voice_path()` yet — `docs/format/drum_sample_paths.md`
- [x] Tune, play mode, direction, start, loop-start candidate, end, gain — `set_drum_voice` (tune device-validated);
  **read** via `DrumVoiceSample` (`tune_semitones`, `direction`, `start`, `end`, `gain_u32`) —
  `tests/test_drum_voice_params_inspection.py` (`cap_drum_params.xy`)
- [x] Pan read/write @ slot `+0x06` — device ±100, `tests/test_drum_pan_fade_inspection.py`
- [x] Fade / loop-crossfade @ preceding voice `+0x7C` — `fade_ui`, `encode_drum_fade_ui`,
  `set_drum_voice(..., fade=)`; v23 UI → v22 storage; 21 fade fixtures in
  `tests/test_drum_pan_fade_inspection.py`
- [ ] Drum slicing metadata / choke groups — gap

## 9. One-shot / multisampler slots

- [~] High-level sample table structure — partial — `docs/format/decoded_image_map.md`
- [x] One-shot loop/crossfade/tune/gain/direction per slot — P2-B `g0`–`g14` +
  `g-tune-*`, `decode_sampler_tune_tenths`, `.tune_ui` (header @ `+0x3943`);
  write via `ImageProject.set_sampler_sample_edit`
- [ ] Multisampler zone boundaries / root key — gap

## 10. Scenes, songs, arrangement

- [x] Scene slots: pattern sel[16] + mute[16] + row-present flag — `build_arrangement`,
  `read_scene_slot_flag`, `read_present_scene_slots`, `docs/format/scenes_songs.md`
- [x] Scene mute (device value 2) — scenes 1–8, slot `N−1` — `tests/test_scene_track_mute_inspection.py`, `scene_mute_storage_slot`, `read_scene_muted_tracks`
- [x] Song footer chain + loop word — `build_arrangement`
- [x] Multi-pattern clone assembly — `build_arrangement`
- [~] 14 song slots vs guide “9 songs” — partial reconciliation — `docs/format/opxy_user_guide_save_audit.md`
- [x] Track mix volume **read** @ track+`0x38FE` (u32 @ `+0x38FB`) —
  `xy/scene_volume_inspection.py`, P2-D `s0b` fixtures; scene routing partial
- [x] Master mix volume **read** @ global+`0x94` — same module (`s5b`)
- [~] Scene-stored volumes **playback** — bytes differ per scene; operator
  heard global mix on 1.1.4 — needs chained capture retest

## 11. Mix, saturator, master

- [x] Master EQ — `xy/master_eq_inspection.py`, P2-F
- [x] Track static volume/pan/send FX1/FX2 **read/write** @ `+0x38FE`/`+0x38FA`/`+0x38B2`/`+0x38B6`
  — `xy/mixer_static_inspection.py`, P2-A f0–f24; write via
  `set_track_volume_*`, `set_track_pan_*`, `set_track_send_fx1_*`,
  `set_track_send_fx2_*`
- [x] Master perc/melody/compressor/master **read/write** @ global
  `+0x88`/`+0x8C`/`+0x90`/`+0x94` — write via `set_master_percussion_*`,
  `set_master_melody_*`, `set_master_compressor_*`, `set_master_volume_*`
- [x] Master saturator gain/clip/tone/mix — `read_master_saturator`, global
  `0x78`/`0x7C`/`0x80`/`0x84`, P2-G `sat0`–`sat8`; write via
  `set_master_saturator_gain_*`, `set_master_saturator_clip_*`,
  `set_master_saturator_tone_*`, `set_master_saturator_mix_*`

## 12. Auxiliary tracks (T9–T16)

Guide source: OP–XY guide chapter 15 “auxiliary”. Aux mode holds 8 tracks:
Brain, Punch-in FX, External MIDI, External CV, External Audio, Tape, FX I,
and FX II. Guide aux track numbers 1–8 correspond to project tracks T9–T16.
Guide-visible semantics only; storage offsets remain gaps unless cited below.

### 12.0 Shared auxiliary-track substrate

- [~] Generic auxiliary track struct, note sequencing, p-locks, step components —
  generic note vector confirmed on T9 Brain, T10 Punch-in FX, and T12 External
  CV; p-locks/step components still need aux-specific fixture coverage
- [ ] Aux track identity / type enum for T9–T16 — verify whether fixed by slot
  index only or persisted as engine/type byte
- [ ] Aux M1/M2/M3/M4 module selector state persistence — gap
- [ ] Aux-track keyboard note/event encoding differences vs instrument tracks —
  gap
- [~] Aux routing matrix common format: encoder banks T1–T4 / T5–T8 — source-track
  send words confirmed for T13/T14/T15/T16 targets; Brain route mask confirmed;
  full matrix UI ownership and per-aux semantics still partial
- [x] Aux LFO common block: speed, amount, destination, parameter — raw words at
  `+0x38B7`, `+0x38BB`, `+0x38BF`, `+0x38C3`; device-authored detents
  confirmed for T13 generic destinations and T11 MIDI destinations; bucket
  boundaries unverified for PC authoring; write via `set_aux_lfo_raw`,
  `set_aux_lfo_destination`, `set_aux_lfo_param_dest`; AUX-LFO
- [x] Aux filter common block: high-pass cutoff, low-pass cutoff — raw M3 words
  at `+0x3897` and `+0x38A3`; params 2/3 also persist raw words at
  `+0x389B` and `+0x389F`, but semantics remain unknown; write via
  `set_aux_filter_raw`; AUX-FILTER
- [x] Aux send levels to External Audio / Tape / FX I / FX II — source-track
  words `+0x38A7`, `+0x38AB`, `+0x38AF`, `+0x38B3`; write via
  `set_track_send_ext_*`, `set_track_send_tape_*`, existing FX send setters;
  AUX-T13/AUX-T14/AUX-T15/AUX-T16

### 12.1 T9 / aux 1 — Brain™

Guide: Brain transposes a whole song or selected routed tracks. M1 exposes
Brain scale/key controls; M2 exposes routing. Routed tracks are transposed and
also participate in automatic key detection.

- [ ] Brain enable / active state — gap
- [~] Brain manual vs automatic key detection mode — raw word located at T9
  `+0x3857`; semantic state mapping still partial; AUX-BRAIN
- [~] Brain key enum — raw word located at T9 `+0x385B`; device-authored detents
  fit the 12 displayed key names, but exact raw boundaries remain unresolved;
  AUX-BRAIN
- [~] Brain scale enum — raw word located at T9 `+0x385F`; device-authored
  detents fit a 7-bucket hypothesis, but true boundaries remain open;
  AUX-BRAIN
- [~] Brain link target / linked instrument-track selection — raw word located
  at T9 `+0x3863`; guide says links instrument tracks to Brain for live riffing;
  semantic map still partial; AUX-BRAIN
- [x] Brain routing mask T1–T8 — M2 routing, T9 `+0x09`, T1-low bit order;
  write via `set_brain_route_mask` / `set_brain_routes`; AUX-BRAIN
- [x] Brain transpose note/event encoding from musical keyboard — generic note
  vector at T9 `+0x456F`; AUX-BRAIN
- [ ] Brain recorded automation / p-lock support for key, scale, link, routing —
  gap
- [ ] Brain interaction with project transpose/global scale fields — gap

### 12.2 T10 / aux 2 — Punch-in FX™

Guide: Punch-in FX can be played, recorded, and performed from the keyboard.
Lower octave targets percussion tracks; higher octave targets melodic tracks.
Some effects use gyroscope and pitchbend. Per-track punch-ins can also be
recorded from instrument tracks with Shift + keyboard and are stored on the
Punch-in FX aux track.

- [ ] Punch-in FX note/key map — low octave percussion group, high octave melodic
  group; exact key → effect enum gap
- [x] Punch-in FX event record format — recorded punch-ins use the generic
  note vector at T10 `+0x456F`, `tests/test_t10_punch_in_fx_inspection.py`
- [ ] Punch-in FX per-track vs group-wide target encoding — gap
- [ ] Punch-in FX percussion/melodic grouping rule — guide-visible; storage gap
- [ ] Punch-in FX gyroscope modulation capture / persistence — likely runtime-only
  or event-modulated; gap
- [ ] Punch-in FX pitchbend modulation capture / persistence — gap
- [ ] Punch-in FX duration/gate behavior in sequencer — gap
- [ ] Punch-in FX p-lock/step component compatibility — gap

### 12.3 T11 / aux 3 — External MIDI

Guide: External MIDI sequences notes to external devices over USB-C or multi-out.
M1 controls MIDI channel, bank, and program. M2/M3 expose eight MIDI CC controls.
Shift + encoder turns on or selects each CC message. M4 exposes an LFO with
speed, amount, destination, and parameter.

- [~] External MIDI generic notes/sequencer events — same track substrate likely;
  needs fixture confirmation
- [ ] External MIDI output port / transport target interaction with COM or
  multi-out settings — probably device-global, not `.xy`; verify
- [x] External MIDI channel current value — M1 dark gray encoder, T11
  `+0x3857`; 16-bucket detent hypothesis matches captures; boundary-safe
  formula not proven; raw write via `set_external_midi_m1_raw`; AUX-T11
- [x] External MIDI bank value — M1 mid gray encoder, T11 `+0x385B`;
  129-bucket detent hypothesis with index 0 = off matches captures;
  boundary-safe formula not proven; raw write via `set_external_midi_m1_raw`;
  AUX-T11
- [x] External MIDI program value — M1 light gray encoder, T11 `+0x385F`;
  129-bucket detent hypothesis with index 0 = off matches captures;
  boundary-safe formula not proven; raw write via `set_external_midi_m1_raw`;
  AUX-T11
- [~] External MIDI CC slot table, 8 slots — table localized to T11
  `+0x3877..+0x3896`; exact number/message word ownership still partial;
  raw word write via `set_external_midi_cc_word`; AUX-T11
- [ ] External MIDI CC slot enable/on state — Shift + encoder; gap
- [ ] External MIDI CC number selection per slot — gap
- [ ] External MIDI CC current value per slot — gap
- [ ] External MIDI CC p-lock/automation lanes — guide-visible; storage gap
- [x] External MIDI LFO speed — shared M4 word at T11 `+0x38B7`; AUX-LFO
- [x] External MIDI LFO amount — shared M4 word at T11 `+0x38BB`; AUX-LFO
- [x] External MIDI LFO destination module enum — T11 `+0x38BF`, off/cc1/cc2
  detents confirmed; bucket boundaries unverified; AUX-LFO
- [x] External MIDI LFO destination parameter enum — shared M4 word at T11
  `+0x38C3`; T13 generic param-target detents confirmed; AUX-LFO
- [ ] External MIDI bank/program send timing on project load vs pattern start —
  device-behavior gap

### 12.4 T12 / aux 4 — External CV

Guide: External CV uses the multi-out jack; CV is on tip/left and gate is on
ring/right. The keyboard and sequencer can play notes on a connected CV device.

- [x] External CV generic notes/sequencer events — generic note vector at T12
  `+0x456F`; octave stored in the ordinary note byte; AUX-T12
- [ ] External CV output enable / multi-out mode dependency — likely device-global
  plus project track data; gap
- [ ] External CV pitch scaling / volts-per-octave assumptions — no project-file
  field found in current T12 note probes; likely system/CV behavior, but gap
- [ ] External CV gate polarity / level persistence — no project-file field
  found in current T12 note probes; likely system/CV behavior, but gap
- [~] External CV note-to-voltage mapping and transpose behavior — note pitch
  persists as generic note byte; voltage calibration/transpose behavior gap
- [ ] External CV pitchbend / glide / portamento support — gap
- [ ] External CV p-lockable parameters, if any — gap
- [ ] External CV interaction with project transpose and Brain routing — gap

### 12.5 T13 / aux 5 — External Audio

Guide: External Audio manages audio input and auxiliary output. M1 controls input
source, analog input drive, input level, and mix to main output. M2 routes
instrument tracks to aux audio output, with per-track input amount distinct from
the main mix. M3 provides high-pass/low-pass filtering plus Tape and FX send
levels. M4 provides LFO speed, amount, destination, and parameter.

- [x] External Audio input source enum — T13 `+0x3857`; mic/default plus
  headset, line, USB-C, main-output detents captured; bucket boundaries
  unverified; write via `set_external_audio_source` or raw M1 setter; AUX-T13
- [x] External Audio analog drive/gain — T13 `+0x385B`; 0/default and 20 dB
  anchors captured; display boundaries unverified; raw write via
  `set_external_audio_m1_raw`; AUX-T13
- [x] External Audio input level — T13 `+0x38FB`; 0/99 anchors and baseline
  75 captured; display boundaries unverified; raw write via
  `set_external_audio_m1_raw`; AUX-T13
- [x] External Audio main-output mix — T13 `+0x3863`; 0 and 99/default
  anchors captured; display boundaries unverified; raw write via
  `set_external_audio_m1_raw`; AUX-T13
- [~] External Audio input activation / armed state — input-off/default and
  input-on captures produced no dedicated setting beyond known save noise;
  likely runtime-only or implicit, but not proven; AUX-T13
- [~] External Audio routing mask T1–T8 to aux output — M2 sends are source-track
  words at `+0x38A7`; explicit separate mask not found; AUX-T13
- [x] External Audio per-routed-track send amount to aux output — source-track
  `+0x38A7`; write via `set_track_send_ext_*`; AUX-T13
- [x] External Audio high-pass cutoff — T13 `+0x3897`; AUX-FILTER
- [x] External Audio low-pass cutoff — T13 `+0x38A3`; AUX-FILTER
- [ ] External Audio Tape send level — Shift + mid gray encoder; gap
- [ ] External Audio FX I send level — Shift + light gray encoder; gap
- [ ] External Audio FX II send level — Shift + white encoder; gap
- [x] External Audio LFO speed — T13 `+0x38B7`; AUX-LFO
- [x] External Audio LFO amount — T13 `+0x38BB`; AUX-LFO
- [x] External Audio LFO destination module enum — T13 `+0x38BF`,
  syn/filter/amp detents confirmed; bucket boundaries unverified; AUX-LFO
- [x] External Audio LFO destination parameter enum — T13 `+0x38C3`, param
  targets 1-4 confirmed; bucket boundaries unverified; AUX-LFO

### 12.6 T14 / aux 6 — Tape

Guide: Tape plays clips from routed tracks. M1 controls pitch, speed, loop length,
and wet/original mix. M2 routes tracks into Tape and allows per-track amount.
M3 provides high-pass/low-pass filter plus FX send levels. M4 provides LFO speed,
amount, destination, and parameter.

- [ ] Tape clip/key map from musical keyboard — gap
- [x] Tape pitch — T14 `+0x3857`; x1/default and x10 anchor captured;
  display boundaries unverified; raw write via `set_tape_m1_raw`; AUX-T14
- [x] Tape speed — T14 `+0x385B`; 50/default/200 anchors captured; display
  boundaries unverified; raw write via `set_tape_m1_raw`; AUX-T14
- [x] Tape loop length enum/scaling — T14 `+0x385F`; length 1/default and
  length 10 anchors captured; bucket boundaries unverified; raw write via
  `set_tape_m1_raw`; AUX-T14
- [x] Tape wet/original mix — T14 `+0x3863`; 0/default and 99 anchors captured;
  display boundaries unverified; raw write via `set_tape_m1_raw`; AUX-T14
- [~] Tape routing mask T1–T8 — M2 sends are source-track words at `+0x38AB`;
  explicit separate mask not found; AUX-T14
- [x] Tape per-routed-track input amount — source-track `+0x38AB`; write via
  `set_track_send_tape_*`; AUX-T14
- [x] Tape high-pass cutoff — shared aux M3 word at `+0x3897`; AUX-FILTER
- [x] Tape low-pass cutoff — shared aux M3 word at `+0x38A3`; AUX-FILTER
- [ ] Tape FX I send level — Shift + light gray encoder; gap
- [ ] Tape FX II send level — Shift + white encoder; gap
- [x] Tape LFO speed — shared aux M4 word at `+0x38B7`; AUX-LFO
- [x] Tape LFO amount — shared aux M4 word at `+0x38BB`; AUX-LFO
- [x] Tape LFO destination module enum — shared aux M4 word at `+0x38BF`;
  T13 generic detents confirmed; bucket boundaries unverified; AUX-LFO
- [x] Tape LFO destination parameter enum — shared aux M4 word at `+0x38C3`;
  T13 param-target detents confirmed; bucket boundaries unverified; AUX-LFO

### 12.7 T15 / aux 7 — FX I

Guide: FX I and FX II are OP–XY’s two FX send tracks. Any sound-producing track
can send into them, and FX I can send to FX II. M1 edits current FX engine
parameters. M2 exposes routing. M3 provides high-pass/low-pass filtering, and
FX I has a send level into FX II. M4 provides LFO speed, amount, destination,
and parameter.

- [~] FX I type enum and params — type byte at T15 `+0x14`; delay/reverb/
  chorus/phaser/distortion/lofi type bytes and delay param block captured;
  other engines' parameter schemas remain open; AUX-T15
- [x] FX I selected engine ID — T15 `+0x14`; known type bytes captured;
  write via `set_fx_type` / `set_fx_type_name`; AUX-T15
- [~] FX I engine parameter block — T15 `+0x3857..+0x3863`; delay anchors
  captured, per-engine schemas still partial; AUX-T15
- [ ] FX I preview keyboard behavior: plays last selected instrument track —
  runtime/UI behavior; persistence likely none
- [~] FX I routing mask / send sources from sound-producing tracks — M2 sends
  are source-track words at `+0x38AF`; explicit separate mask not found; AUX-T15
- [x] FX I route amount per source track — source-track `+0x38AF`; write via
  `set_track_send_fx1_*`; AUX-T15
- [x] FX I high-pass cutoff — shared aux M3 word at `+0x3897`; AUX-FILTER
- [x] FX I low-pass cutoff — shared aux M3 word at `+0x38A3`; AUX-FILTER
- [ ] FX I → FX II send level — Shift + white encoder; not isolated from
  ordinary source-track FX II send yet
- [x] FX I LFO speed — shared aux M4 word at `+0x38B7`; AUX-LFO
- [x] FX I LFO amount — shared aux M4 word at `+0x38BB`; AUX-LFO
- [x] FX I LFO destination module enum — shared aux M4 word at `+0x38BF`;
  T13 generic detents confirmed; bucket boundaries unverified; AUX-LFO
- [x] FX I LFO destination parameter enum — shared aux M4 word at `+0x38C3`;
  T13 param-target detents confirmed; bucket boundaries unverified; AUX-LFO

### 12.8 T16 / aux 8 — FX II

Guide: FX II is the second FX send track. It shares the FX-track structure:
engine selection, M1 engine parameters, M2 routing, M3 high-pass/low-pass
filtering, and M4 LFO modulation.

- [~] FX II type enum and params — type byte at T16 `+0x14`; delay/reverb/
  chorus/phaser/distortion/lofi type bytes and delay param block captured;
  other engines' parameter schemas remain open; AUX-T16
- [x] FX II selected engine ID — T16 `+0x14`; known type bytes captured;
  write via `set_fx_type` / `set_fx_type_name`; AUX-T16
- [~] FX II engine parameter block — T16 `+0x3857..+0x3863`; reverb baseline
  and delay anchors captured, per-engine schemas still partial; AUX-T16
- [ ] FX II preview keyboard behavior: plays last selected instrument track —
  runtime/UI behavior; persistence likely none
- [~] FX II routing mask / send sources from sound-producing tracks — M2 sends
  are source-track words at `+0x38B3`; explicit separate mask not found; AUX-T16
- [x] FX II route amount per source track — source-track `+0x38B3`; write via
  `set_track_send_fx2_*`; AUX-T16
- [x] FX II high-pass cutoff — shared aux M3 word at `+0x3897`; AUX-FILTER
- [x] FX II low-pass cutoff — shared aux M3 word at `+0x38A3`; AUX-FILTER
- [x] FX II LFO speed — shared aux M4 word at `+0x38B7`; AUX-LFO
- [x] FX II LFO amount — shared aux M4 word at `+0x38BB`; AUX-LFO
- [x] FX II LFO destination module enum — shared aux M4 word at `+0x38BF`;
  T13 generic detents confirmed; bucket boundaries unverified; AUX-LFO
- [x] FX II LFO destination parameter enum — shared aux M4 word at `+0x38C3`;
  T13 param-target detents confirmed; bucket boundaries unverified; AUX-LFO

## 13. Players (arpeggio / maestro / hold)

- [ ] Player enable/type per track — gap
- [ ] Arpeggio parameters — gap
- [ ] Maestro chord buffer — gap
- [ ] Hold player state — gap

## 14. JSON / tooling bridges

- [x] Spec → image compiler — `tools/spec_to_xy_image.py`, `tests/test_midi_to_xy_json_selection.py`
- [x] Corpus index/lab — `tools/corpus_lab.py`
- [x] Round-trip verify — `tools/roundtrip_xy.py`
- [x] Inspector CLI — presets, paths, drums, sampler, mixer, scenes, EQ, saturator, p-lock lanes, project config —
  `tools/inspect_xy.py`, `docs/tools/inspect_xy.md`

## 15. Outside project `.xy`

- [ ] COM / system / Bluetooth / MTP settings — device-global, not in `.xy` — `docs/format/opxy_user_guide_save_audit.md` § COM
- [ ] Sample folder WAV/AIFF on disk — filesystem; only paths referenced in project

---

## How to close a gap

1. Capture one-variable device diff → add fixture under `src/`.
2. Promote offset/rule to `docs/format/decoded_image_map.md` and
   `docs/format/image_coverage_map.md`.
3. Add read path (`inspect_xy`) and/or write path (`ImageProject`).
4. Check the box here and link the test file.
5. Update `docs/format/opxy_user_guide_save_audit.md` if guide-visible.

## Device roundtrip workflow (author → OP-XY → confirm)

Use this when promoting a field from decoded → **device-validated**:

1. **Author** — build or edit with `ImageProject` / `tools/spec_to_xy_image.py` /
   decoded-image spec compiler; save `.xy` under `output/` or `src/`.
2. **Expect** — write a short expectation file (YAML/JSON/markdown) listing what
   you believe the device should show: preset name, drum path per voice, tempo,
   etc. Keep one variable per probe file when possible.
3. **Transfer** — MTP upload to OP-XY (`tools/mtp_upload.py` or app).
4. **Load** — open on hardware; note pass/fail per expectation line.
5. **Capture** — Save As on device; pull `.xy` back; add as fixture under
   `src/*-probes/`.
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
