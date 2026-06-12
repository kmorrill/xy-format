# Docs Index

## Start Here
- Operating guide: `AGENTS.md`
- **Parse & author capability checklist: `docs/parse_capability_checklist.md`**
- **State of understanding (dated ledger of what we believe/doubt): `docs/state_of_understanding.md`**
- **Parse & author capability checklist: `docs/parse_capability_checklist.md`**
- Roadmap: `docs/roadmap.md`
- Human explainer: `docs/human-explainer.md`

## Workflows
- Device test naming: `docs/workflows/device_test_naming.md`
- Inspector sweep: `docs/workflows/inspector_sweep.md`
- Crash capture protocol: `docs/workflows/crash_capture.md`
- CC106 capture plan workflow: `docs/workflows/cc106_capture_plan.md`

## Tools

User-facing tools live at `tools/`. Research, probing, and one-off scripts
have moved to `tools/analysis/` — see `tools/analysis/README.md`.

User-facing:
- Inspector: `docs/tools/inspect_xy.md` (`tools/inspect_xy.py`)
- JSON spec compiler: `docs/tools/build_xy_from_json.md` (`tools/build_xy_from_json.py`)
- Corpus index/query: `docs/tools/corpus_lab.md` (`tools/corpus_lab.py`)
- Header reader: `docs/tools/read_xy_header.md` (`tools/read_xy_header.py`)
- MTP upload (device file management): `docs/tools/mtp_upload.md` (`tools/mtp_upload.py`)
- Scene/song token patching: `tools/patch_scene_song_tokens.py`
- MIDI → .xy conversion: `tools/midi_to_xy.py`
- Hypothesis harness: `docs/tools/hypothesis_tests.md` (`tools/hypothesis_tests.py`)
- P-lock extraction: `tools/extract_plocks.py`
- Corpus-wide analyses: `tools/analyze_corpus.py`
- Multi-pattern device capture: `tools/capture_9pat.py`
- Round-trip verification: `tools/roundtrip_xy.py`

Research (under `tools/analysis/`):
- Structural compare: `docs/tools/corpus_compare.md` (`tools/analysis/corpus_compare.py`)
- CC106 capture plan generator: `docs/tools/generate_cc106_capture_plan.md`
- Scene corpus sweep: `docs/tools/scene_corpus_sweep.md`
- Scene probe pack `72`-`77` generator: `docs/tools/generate_scene_hypothesis_pack_72_77.md`
- Scene probe pack `78`-`87` generator: `docs/tools/generate_scene_hypothesis_pack_78_87.md`
- Scene probe pack `88`-`92` generator: `docs/tools/generate_scene_hypothesis_pack_88_92.md`
- CC 86 project select (MIDI test oracle): `docs/tools/cc86_select.md`

Reference material:
- External tooling candidates: `docs/tools/external_tooling_candidates.md`
- OP-XY power plug control: `docs/tools/opxy_power_plug.md`

## Reference
- OP-XY documented limits: `docs/reference/opxy_limits.md`
- OP-XY MIDI CC map: `docs/reference/opxy_midi_cc_map.md`
- CC 106 remote key press map: `docs/reference/opxy_cc106_remote_keys.md`

## Format (Canonical)
- **Record structure (start here)**: `docs/format/record_structure.md`
  (serialization model, record grammar, tail bytes, pre-track scene RLE —
  supersedes the descriptor/preamble framing in older docs)
- **Decoded image map (RAM struct fields)**: `docs/format/decoded_image_map.md`
- OP-XY user guide save audit: `docs/format/opxy_user_guide_save_audit.md`
- Header: `docs/format/header.md`
- Pre-track / pattern directory: `docs/format/pretrack_pattern_directory.md`
- Scenes and songs: `docs/format/scenes_songs.md`
- Track blocks: `docs/format/track_blocks.md`
- Events: `docs/format/events.md`
- Event type selection: `docs/format/event_type_selection.md`
- Step components: `docs/format/step_components.md`
- P-locks: `docs/format/plocks.md`
- Mod routing: `docs/format/mod_routing.md`
- Multi-pattern block rotation: `docs/format/multi_pattern_block_rotation.md`
- Drum sampler sample paths: `docs/format/drum_sample_paths.md`

## Engineering
- **Authoring `.xy` files (canonical writer guide)**: `docs/engineering/authoring.md`
- Architecture notes: `docs/engineering/architecture.md`
- Writer alignment (`0x05`/`0x07`): `docs/engineering/writer_alignment_and_type05_type07.md`
- Track 1 writer prototype: `docs/engineering/writer_track1.md`
- JSON authoring bridge: `docs/engineering/json_authoring_bridge.md`
- Complete project JSON target: `docs/engineering/json_project_spec_complete.md`
- Known-good ranked test plan: `docs/engineering/known_good_test_plan.md`
- ImHex + ImHex Patterns brief: `docs/engineering/imhex_imhex_patterns_brief.md`
- Automated device testing (5,000-probe plan, **scrapped**): `docs/engineering/automated_device_testing_plan.md`

## Debug and Issues
- Crash catalog: `docs/debug/crashes.md`
- Issues index: `docs/issues/index.md`
- Pointer-tail issue: `docs/issues/pointer_tail_decoding.md`
- Preamble state-machine issue: `docs/issues/preamble_state_machine.md`
- Sparse topology stability issue: `docs/issues/sparse_topology_stability.md`

## Logs
- Parse capability checklist: `docs/parse_capability_checklist.md`
- App preset probe inspection: `docs/logs/2026-06-09_app_preset_probe_inspection.md`
- Drum sample path inspection: `docs/logs/2026-06-12_drum_sample_path_inspection.md`
- Round 0 `nt-z-fx` sample paths: `docs/logs/2026-06-12_round0_nt-z-fx_sample_paths.md`
- Variable-length + writer root cause: `docs/logs/2025-02-11_variable_length_and_writer_root_cause.md`
- Firmware package notes: `docs/logs/2025-02-14_firmware_package_notes.md`
- Multi-pattern breakthrough: `docs/logs/2026-02-12_multipattern_breakthrough.md`
- MIDI CC -> p-lock discovery: `docs/logs/2026-02-13_midi_cc_plock_discovery.md`
- Legacy long-form notebook snapshot: `docs/logs/2026-02-13_agents_legacy_snapshot.md`
- `p01`-`p10` deep analysis: `docs/logs/2026-02-14_p01_p10_deep_analysis.md`
- `01`-`08` single-track P2 matrix: `docs/logs/2026-02-14_01_08_single_track_p2_matrix.md`
- `r01`-`r05` note-branch analysis: `docs/logs/2026-02-14_r01_r05_note_branch_analysis.md`
- `r06`-`r10` + multipattern corpus consolidation: `docs/logs/2026-02-14_r06_r10_and_multipattern_corpus_consolidation.md`
- `s04`-`s09` minimal-plan progress: `docs/logs/2026-02-14_s04_s09_minimal_plan_progress.md`
- `unnamed 1` -> `j06` bootstrap equivalence + Chase A/B: `docs/logs/2026-02-28_unnamed1_to_j06_bootstrap.md`
- Time After Time scene/song probe (round 1): `docs/logs/2026-02-28_time-after-time_scene_song_probe.md`
- Time After Time scene/song probe (round 2): `docs/logs/2026-02-28_time-after-time_scene_song_probe_round2.md`
- Scene pattern-map probe plan: `docs/logs/2026-02-28_scene_pattern_map_probe_plan.md`
- Scene/song tooling integration: `docs/logs/2026-02-28_scene_song_tooling_integration.md`
- Scene pattern selection probe set A: `docs/logs/2026-02-28_scene_pattern_selection_probe_set_a.md`
- Scene pattern selection probe set B (hybrid seed): `docs/logs/2026-02-28_scene_pattern_selection_probe_set_b.md`
- `bleez1` -> `bleez2` scene edit pair analysis: `docs/logs/2026-02-28_bleez_scene_edit_pair_analysis.md`
- `bleez7`-`bleez12` scene probe analysis: `docs/logs/2026-02-28_bleez7_12_scene_probe_analysis.md`
- Scene contribution probes `31`-`36`: `docs/logs/2026-02-28_scene_contribution_probes_31_36.md`
- Scene corpus consolidated readout: `docs/logs/2026-02-28_scene_corpus_consolidated_readout.md`
- Scene batch A device chain analysis (`00`-`07`): `docs/logs/2026-03-01_scene_batch_a_device_chain_analysis.md`
- Scene cross-branch invariants (batch A + existing corpus): `docs/logs/2026-03-01_scene_cross_branch_invariants.md`
- Scene batch A follow-up (`08`-`10`): `docs/logs/2026-03-01_scene_batch_a_followup_08_10.md`
- Scene batch A follow-up (`11`-`13`): `docs/logs/2026-03-01_scene_batch_a_followup_11_13.md`
- Scene hypothesis pack (`41`-`50`): `docs/logs/2026-03-01_scene_hypothesis_pack_41_50.md`
- Scene hypothesis pack (`51`-`58`): `docs/logs/2026-03-01_scene_hypothesis_pack_51_58.md`
- `unnamed 156` scene matrix initial analysis: `docs/logs/2026-03-02_unnamed_156_scene_matrix_initial_analysis.md`
- Scene corpus full-model sweep: `docs/logs/2026-03-02_scene_corpus_full_model.md`
- Scene probe `59` hybrid-matrix test (`bleez35`): `docs/logs/2026-03-02_scene_probe_59_hybrid_bleez35.md`
- Scene probes `60`-`61` coupled `R13` tests: `docs/logs/2026-03-03_scene_probe_60_61_coupled_r13.md`
- Scene probes `62`-`65` follow-up set: `docs/logs/2026-03-03_scene_probe_62_65_followups.md`
- Scene probe `66` vs `67` behavior validation: `docs/logs/2026-03-03_scene_probe_66_67_behavior.md`
- Scene probes `68`-`71` (`R11` step + boundary): `docs/logs/2026-03-03_scene_probe_68_71_r11_step_boundary.md`
- Scene probes `72`-`77` (`P5..P9` + Track7 candidate): `docs/logs/2026-03-03_scene_probe_72_77_p5_p9_t7_candidates.md`
- Scene probes `78`-`87` (no-override + Track7 sweep): `docs/logs/2026-03-03_scene_probe_78_87_nooverride_t7_sweep.md`
- Scene probes `88`-`92` (long-form + preamble coupling): `docs/logs/2026-03-03_scene_probe_88_92_longform_and_preamble.md`
- Manual resave selection-state probe: `docs/logs/2026-03-03_manual_resave_selection_state_probe.md`
- Selection audit pack B (`01`-`15`) results: `docs/logs/2026-03-03_selection_audit_pack_b_results.md`
