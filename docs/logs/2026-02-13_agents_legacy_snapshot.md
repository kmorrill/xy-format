# AGENTS: OP-XY Reverse Engineering

> Archive note: this is a preserved legacy notebook snapshot. It contains historical context and may include outdated operating instructions that are superseded by `AGENTS.md` and `docs/index.md`.

## Mission
- Partner to decode the `.xy` project container so we can read, edit, and eventually write OP-XY projects off-device.
- Keep a living log that captures device knowledge, experimental assets, hypotheses, and reverse-engineering progress.

## Reference Materials
- `docs/OP–XY Project File Format Breakdown.docx`: detailed manual-derived expectations for every subsystem of the project file. Converted plaintext lives at `docs/OP-XY_project_breakdown.txt` for quick grepping.
- `src/one-off-changes-from-default/`: corpus of minimally edited project files plus `op-xy_project_change_log.md` describing the exact UI action taken for each file.
- `tools/corpus_lab.py`: SQLite-backed corpus index/query tool for cross-file questions.
  - Database path: `output/corpus_lab.sqlite` (repo-root absolute default).
  - Indexes file-level fields: `path`, `source`, `size`, `sha1`, `pre_track_len`, `pre56_hex`, `ff_table_start`, `descriptor_var_hex`, `logical_entries`, parse status/error.
  - Indexes logical-entry fields (track/pattern layer): `track`, `pattern`, `pattern_count`, clone/leader/last flags, `preamble` bytes (`pre0..pre3`), `body_len`, `type_byte`, `engine_id`, `active`, `prev_active`, plus detected tail-event fields (`event_type`, `event_count`, `event_start`).
  - Supports test outcome logging: `status` (`pass|crash|untested`), optional `error_class`, note, timestamp.
  - Core commands:
    - `python tools/corpus_lab.py index`
    - `python tools/corpus_lab.py sql "SELECT name,size,logical_entries FROM files ORDER BY size DESC LIMIT 20"`
    - `python tools/corpus_lab.py report clone-pre1`
    - `python tools/corpus_lab.py report topology --where "f.source='oneoff'"`
    - `python tools/corpus_lab.py record output/k04_song_safefix2_12347.xy pass --note "device OK"`
    - `python tools/corpus_lab.py results --where "f.name LIKE 'k0%'"`
    - `python tools/corpus_lab.py report result-summary`
    - `python tools/corpus_lab.py report signal-clone-pre1`
- `tools/corpus_compare.py`: structural two-file compare using indexed logical entries.
  - `python tools/corpus_compare.py k03_song_safefix_12347.xy k04_song_safefix2_12347.xy`
  - Reports file-level deltas and exact `(track,pattern)` field differences (e.g., `pre1 0x64->0x2E`).

## Device Test File Naming
- Keep generated test filenames short so they are easy to scan on-device.
- When proposing multiple files to test, make the intended test sequence match **alphabetical filename order**.
- Prefer sortable prefixes (`a_`, `b_`, `c_` or `01_`, `02_`, `03_`) so device listing order and requested test order stay aligned.

## Device & File Expectations (from the breakdown doc)
### Storage Model
- Projects are standalone binaries (likely `.xy`) stored alongside rotating backups on device storage; sample audio stays external and must be copied separately.
- Projects capture arrangement, synthesis, mix, and routing data, but reference samples by path rather than embedding media.

### Sequencer Topology
- 16 tracks total: 8 instrument, 8 auxiliary. Each track hosts up to 9 patterns, capped at 120 note events per pattern with full polyphony.
- Patterns ride on a 64-step grid (4 bars of 16ths by default) with support for variable bar lengths via pattern length multipliers.
- Per-step components (14 varieties: pulse, hold, multiply, velocity, ramp up/down, random, portamento, bend, tonality, jump, skip trig/param, etc.) can stack, so expect bitfields or tagged lists per step.
- Parameter locks exist even if the manual avoids the term: steps can store arbitrary encoder values with conditional trig support.

### Scenes & Songs
- Up to 99 scenes snapshot pattern assignment per track plus mix state (volumes, mutes, sends, probably pan). Scene copy/paste implies contiguous indexing.
- Songs (apparently up to 14) are ordered scene playlists with per-song metadata (name, loop enable, loop points, tempo override hints?).

### Instrument Tracks (1–8)
- Engine selection plus preset reference on every pattern; engines expose four main encoders plus multiple “M” pages (M1–M4) for envelopes, filters, LFO, etc.
- Amplitude and filter envelopes store ADSR values; additional toggles (M4 enable, filter on/off, filter type selection) need discrete fields.
- Track LFO captures type, rate/sync value, amount, destination module/parameter, and extra type-specific options (e.g., Duck smoothing).
- Voice allocation per track may be stored (mono/poly priority) because total polyphony is 24 voices.

### Sampler Details
- Three sampler modes: single-sample, drum kit (24 slots), multi-sample (zoned). All keep external sample references plus tuning, envelope, filter, loop, and gain/pan per slot/zone.
- Drum kits hold per-key sample metadata, envelopes, filters, pitch, and choke group assignments; multi-sampler tracks define key/velocity splits.
- Sample references can point to factory or user folders, so expect path strings or hashed identifiers rather than implicit indices.

### Auxiliary Tracks (9–16)
- Track 9 Brain™: stores global scale/key, suggested chord progressions, and any captured theory automation.
- Track 10 Punch-in FX: holds which momentary FX are assigned plus per-step trigger data for recording performance punches.
- Track 11 External MIDI: behaves like a sequencer track but emits MIDI; needs channel/output routing fields distinct from instrument tracks.
- Track 12 External CV: stores CV/gate patterns and voltage scaling.
- Track 13 External Audio: routes external input, contains effect chain parameters and sends.
- Track 14 Tape looper: maintains clip buffers/markers, playback speed, pitch, direction, slice assignments.
- Tracks 15 & 16 FX I/II: choose effect algorithms, store their parameter sets, remember send levels and FX-to-FX routing.

### Global Mix & Tempo
- Track-level mix: volumes, mutes, pans, send amounts, possibly metering state.
- Master section: percussion/melodic bus faders, EQ (Lo/Mid/Hi/Blend), saturation (Low/Mid/High/Blend), master compressor amount, final output level, metronome level/toggle.
- Tempo block: BPM (supports decimals), groove template index and amount (swing vs shuffle continuum), time signature enum (e.g., 4/4, 3/4, 5/4, 6/8, 7/8, 12/8).

### MIDI & Controller Config
- Per-track MIDI channel assignments (1–16 or off/omni), external sync modes, clock send/receive toggles, controller mapping slots, and sustain/aftertouch routings.

### Structural Takeaways
- Expect a hierarchical binary layout: project header → track bank → scenes → songs → global settings. Many sections are fixed-count tables with compact entries (makes diffing easier).
- Strings probably stored as ASCII/UTF-8 with limited character set (alphanumeric plus `-`, `#`, space).

## OP-XY Documented Limits (Official Specs)

Sources: [teenage.engineering/products/op-xy](https://teenage.engineering/products/op-xy), [TE guides](https://teenage.engineering/guides/op-xy/), Sound On Sound review, OP Forums.

### Sequencer

| Limit | Value | Notes |
|-------|-------|-------|
| Steps per pattern | 64 (4 pages × 16) | 4 bars maximum |
| Bars per pattern | 4 | Community has requested 8; TE says limited by 120-note cap |
| Notes per pattern | **120** | Hard cap; per-pattern, not per-track. Confirmed by multiple sources |
| Sequencer resolution | 1920 PPQN | = 480 ticks per 16th note (matches our STEP_TICKS) |
| Track scale options | ×1/2, ×1, ×2, ×3, ×4, ×6, ×8, ×16 | Max effective = 64 bars (4 bars × scale 16) |
| Step component types | 14 | All stackable on a single step |
| Variations per component | 10 | — |

### Polyphony

| Limit | Value | Notes |
|-------|-------|-------|
| Total voices | **24** | Dynamically allocated across all tracks |
| Per-track max | **8** | Hard cap regardless of available voices |
| Voice modes | Poly, Mono, Legato | Selectable per track |

### Tracks, Patterns, and Songs

| Limit | Value | Notes |
|-------|-------|-------|
| Instrument tracks | 8 | T1-T8 |
| Auxiliary tracks | 8 | T9-T16 (external MIDI/CV/FX) |
| Patterns per track | **9** | Indexed in pattern directory |
| Scenes | **99** total | Snapshot pattern assignment + mix state |
| Scenes per song | **96** | — |
| Songs per project | **14** | TE guide says 14; some sources say 9 or 10 (may vary by firmware) |
| Projects | 10,000+ | Limited by 8 GB internal storage |

### Synthesis and Sampling

| Limit | Value | Notes |
|-------|-------|-------|
| Synth engines | 8 | Drum, EPiano, Prism, Hardsync, Dissolve, Axis, Multisampler, Wavetable |
| Drum sampler slots | 24 | One-shot samples per kit (MIDI 48-71 = C3-B4) |
| Max sample length | 20 seconds | 16-bit / 44.1 kHz WAV/AIFF |
| FX slots per track | 2 | Sequenceable |
| FX types | 6 | Reverb, delay, chorus, distortion, lofi, phaser |
| Punch-in FX | 24 | — |
| Groove presets | 10 | — |

### Hardware

| Spec | Value |
|------|-------|
| Processing | Dual Blackfin + triple-core DSP co-processor + 2 MCUs |
| Storage | 8 GB internal |
| RAM | 512 MB |
| Display | 480 × 222 px IPS TFT (grayscale) |
| Battery | 4000 mAh, ~16 hours |

### Implications for Format Work

- **120-note cap**: Our 48-note unnamed 101 event is 40% of max. A 120-note event would be ~1700 bytes (rough estimate). This is the ceiling for stress-testing the event parser.
- **9 patterns per track**: The handle table at 0x58-0x7B has 12 entries of 3 bytes each (36 bytes). The relationship between handle entries and the 9-pattern limit is not yet clear.
- **8-voice polyphony**: Chord events with flag 0x04 should support up to 8 simultaneous notes per track. We've tested 3; 8 is the hard limit.
- **24 total voices**: With 8 tracks playing 3-note chords = 24 voices, the system is at capacity. Beyond this, voice stealing occurs.

## Example Corpus Notes
- `unnamed 1.xy` is the pristine baseline.
- Each `unnamed N.xy` adds a single, documented tweak (tempo change, step component toggle, filter adjustments, etc.). File sizes hover around 9.3 KB except sequence-heavy samples (`unnamed 6`, `unnamed 7`, `unnamed 3`) that are larger—good markers for structural inflation.
- `unnamed 79.xy` — hand-entered, non-quantized note on Track 3 landing on sequencer step 13 with a noticeable late micro-offset. The 0x21/0x01 node at 0x104D stores start ticks `0x16F5` (5877) which resolves to step 13 plus +117 tick drift, while the accompanying `0x00018B` word is the gate length (395 ticks ≈ 0.82 step).
- `unnamed 92.xy` — 3 notes on Track 3 with different gate lengths: step 1 (2 steps), step 5 (4 steps), step 11 (6 steps). Uses 0x21 sequential event with explicit gate encoding (`[gate_u32_le] 00`). Body is byte-identical to baseline apart from type byte flip, padding removal, and appended event.
- Change log gives us controlled deltas for: note events, tempo decimals, groove types, pattern length, step components, track parameters, EQ/FX adjustments, and song creation.

## Integration Tests
- **Inspector vs. change log sweep**  
  1. Run `python tools/inspect_xy.py '<path/to/file>'` across every project listed in `src/one-off-changes-from-default/op-xy_project_change_log.md` (loop over the filenames from the log to avoid missing captures).  
  2. Compare each report section against the corresponding human-written annotation and note any mismatches, missing fields, or crashes directly in the log and this notebook.  
  3. File bugs or TODOs for decoding gaps exposed by the sweep (e.g., wrong step indices, missing component summaries) before the next parser update.

## Reverse-Engineering Strategy
1. **Build diff tooling**: scriptable hexdump comparator that highlights byte offsets changing between specific file pairs (`unnamed 1` vs others) to isolate field regions quickly.
2. **Section boundary discovery**: search for repeating headers or magic numbers; align offsets across files to identify track/scene/song blocks.
3. **Map core metadata**: start with easy wins (tempo, BPM decimals, groove type) where change log offers direct toggles.
4. **Pattern decoding**: analyze note insertion files (`unnamed 2`, `unnamed 3`) to derive step encoding, then correlate with pattern length variations (`unnamed 17–19`) and step components (`unnamed 8–9`).
5. **Parameter tables**: use track 3 tweaks (`unnamed 23–33`) to map instrument parameter layout, filter enable bits, and LFO pages.
6. **Automation vs scenes**: once pattern format is understood, move to scenes/songs (`unnamed 6`, `unnamed 13`, `unnamed 15`) to capture higher-level structures.
7. **Validate with round-trips**: eventually build a parser that emits JSON and a serializer to regenerate the original bytes, using checksums/file sizes as guardrails.

## Libanalogrytm-Inspired Approach
- **Container vs payload**: keep a thin `.xy` container reader (header, size, checksums) separate from payload parsers for tracks/patterns/scenes.
- **Size/version guards**: define per-section size constants and hard-validate them before decoding to catch shifts like the metronome-mute anomaly.
- **Preserve unknowns**: treat undecoded bytes as explicit blobs so round-trips remain byte-stable while semantics are discovered.
- **Per-subsystem modules**: split parsing by header, track blocks, pattern directory, scenes, songs, global mix/tempo, mirroring device UI domains.
- **Round-trip tests**: decode → encode → compare bytes, reporting first mismatch offsets to guide updates.

## Immediate Next Actions
- Diff `unnamed 1.xy` against tempo variants (`unnamed 4` & `unnamed 5`) to pin down BPM encoding.
- Inspect step-component files (`unnamed 8` & `unnamed 9`) to see how component stacking alters nearby bytes.
- Document discovered offsets and value encodings back in this file as we learn them.

## Multi-Pattern Generation Readiness (2026-02-12)
- `xy.project_builder.build_multi_pattern_project()` now supports descriptor strategies:
  - `strict` (default): only device-verified descriptor sets (`T1` and `T1+T3`).
  - `heuristic_v1` (experimental): allows broader track sets anchored on `T1`; derived from `unnamed 102–105` descriptor bytes.
- **Status update after `j01`-`j05` captures**:
  - `heuristic_v1` is no longer considered safe for non-`T1` topologies; multiple generated files crash while device-authored equivalents load.
  - New device-authored captures confirm pre-track descriptor insertion is **not fixed at `0x58`** and varies by topology/state (`0x56`, `0x57`, or `0x58` in current corpus).
  - The old assumption "`pattern_max_slot` is always `u16 LE` at `0x56`" only holds for the earlier `T1`-centric captures (`unnamed 6/7/102/103/104/105/105b`).
- Added `tools/write_multi_track_two_pattern.py` to generate two-pattern stress projects across multiple tracks with deterministic notes per track/pattern.
- Recommended workflow for current confidence:
  - Use `--strategy strict --tracks 1,3` for known-good device behavior.
  - Treat `heuristic_v1` outputs as exploratory only unless matched against a device-authored scaffold of the same topology.

### `j06` / `j07` Scaffold Findings (2026-02-12, high confidence)
- New scaffold captures:
  - `j06_all16_p9_blank.xy` (from `unnamed 94.xy`)
  - `j07_all16_p9_sparsemap.xy` (from `unnamed 95.xy`)
- Both files share the same pre-track descriptor variant:
  - Insert relative to `unnamed 1` at base `0x56`: `08 08 06 00 00 16 01`
  - Pre-track length: `131` bytes
  - This confirms descriptor stability across blank vs sparse-note content in the same topology.
- Decomposing block 16 by embedded track signatures yields **80 logical pattern entries**.
  - Grouping by leader `preamble[1]` yields:
    - Tracks 1-8: `9` patterns each
    - Tracks 9-16: `1` pattern each in the currently decoded block-rotation layer
  - Inference: pattern expansion for tracks 9-16 may be stored differently (or not present) in this capture; do not assume 16×9 block-rotation entries.
- `j07` sparse-map confirms deterministic track/pattern addressing for tracks 1-8:
  - T1: P1 step 1, P9 step 9
  - T2: P2 step 2, P9 step 10
  - T3: P1 step 3, P9 step 11
  - T4: P2 step 4, P9 step 12
  - T5: P1 step 5, P9 step 13
  - T6: P2 step 6, P9 step 14
  - T7: P1 step 7, P9 step 15
  - T8: P2 step 8, P9 step 16
- Reliability principles for writing (no heuristics):
  - For this topology, treat pre-track descriptor bytes as authoritative scaffold data; do not synthesize/recompute them.
  - Parse to logical entries first (including overflow inside block 16), then map by leader pattern counts.
  - Mutate only target pattern bodies/preambles and preserve all unrelated descriptor/overflow structure byte-for-byte.
  - Apply established preamble propagation semantics (`0x64` chain behavior, including known exemptions) only where activation requires it.
- Critical body-write rule (derived from `j06 -> j07` exact diffs):
  - Do **not** activate/append directly into a non-last pattern's stored body (those are one-byte-trimmed forms).
  - For any pattern where `pattern < pattern_count`:
    1. Start from that track's full-body donor (the last pattern block).
    2. Activate + inject the event in full-body space.
    3. Trim one byte from the tail of the resulting body.
  - For last patterns (`pattern == pattern_count`), inject directly in full-body form (no post-trim).
  - This rule reproduces device-authored `j07` event alignment exactly, including:
    - non-tail engines: `... 00 00 [event...]` placement (vs incorrect direct `... 00 [event...] 00`)
    - EPiano tail marker handling (`0x28 -> 0x08`) at the correct offset after insertion.
- Clone preamble byte[1] propagation refinement (`j06 -> j07`, `k03 -> k04`):
  - Old rule "`clone byte[1] = 0x64 whenever previous block is activated`" is incomplete.
  - Corrected rule: when previous block is activated, fold clone `byte[1]` to `0x64` **only** for the high-bit family (`0x8A/0x86/0x85/0x83` observed). Keep low-byte families (notably `0x2E` in Track-4 chains) unchanged.
  - Evidence: regenerating `j07` from `j06` differed by exactly one byte (`Track 4, Pattern 3 preamble byte[1]: 0x2E` vs `0x64`). Fixing this produced byte-identical output.
- Added helper: `tools/analyze_pretrack_descriptors.py` dumps descriptor inserts, FF-table start, and pattern-count-bearing block preambles for any capture set.

### `unnamed 105b.xy` (new multi-pattern datapoint)
- `unnamed 105b.xy` adds a single note trig on **Track 3, Pattern 1** on top of the existing `unnamed 105` setup.
- This capture is the first confirmed case of a **non-T1 leader block** carrying note data in a multi-track multi-pattern project.
- High-impact structural deltas versus `unnamed 105.xy`:
  - File size: `11792 -> 11867` (`+75` bytes).
  - Pre-track length: `131 -> 129` (`-2` bytes).
  - Descriptor at `0x58`: switches from 7-byte T1+T3 form (`01 00 00 1B 01 00 00`) to 5-byte T1-style form (`00 1D 01 00 00`).
  - Block 4 (Track 3 leader) flips from `type=0x05` to `type=0x07` and grows `418 -> 431` bytes.
  - Block 5 preamble byte[1] is `0x64` (`008610f0 -> 006410f0`), indicating the post-activation chain behavior extends through the second T3 block.
  - Blocks 11-16 gain extra inline words in a repeated mid-body lane:
    - Typical replacement pattern:
      - old: `00 00 19 40 00 00 01 60 ...`
      - new: `00 00 11 40 00 00 01 40 00 00 01 40 00 00 01 60 ...`
    - Net growth: `+8` bytes each for blocks 11-15 and `+24` for block 16 (three occurrences).
- Practical takeaway: generating valid files when non-T1 leader patterns contain notes needs a distinct serialization branch beyond the current `unnamed 105` model.

### Post-`105b` generated validation (2026-02-12)
- Device load **PASS** for non-byte-identical generated files using the `105b` serialization branch:
  - `output/mp2_v5_105b_novel_single.xy` (11869 B)
  - `output/mp2_v5_105b_novel_dense.xy` (11909 B)
- Both files differ from `unnamed 105b.xy` and `output/repro_105b.xy` (different SHA-1), confirming this is not a replay-only success.
- What this confirms:
  - The `105b` branch is structurally correct for novel content, not just exact-byte reproduction.
  - Note payloads can vary in step, pitch, velocity, and per-pattern density without triggering the `num_patterns > 0` crash, as long as the structural rules match `105b`.
  - The working two-track multi-pattern descriptor in this mode remains the 5-byte form at `0x58`: `00 1D 01 00 00`.
  - The blocks 11-16 aux mid-body rewrite used in `105b` is part of the required valid structure for this branch.
- Current known-good writer profile for multi-pattern on device:
  - Tracks: `{1, 3}`
  - Pattern count: `2` on both tracks
  - Track 1: leader blank, clone active
  - Track 3: leader may be active, clone may be active
  - Descriptor strategy: `strict` with `105b` compatibility branch engaged

### Multi-Track / Multi-Pattern Breakthrough (v7 diagnostics, 2026-02-12)
- Device load **PASS** for all diagnostic variants:
  - `output/mp2_v7_diag_h5_both_sparse.xy`
  - `output/mp2_v7_diag_h7_both_sparse.xy`
  - `output/mp2_v7_diag_h5_both_dense.xy`
  - `output/mp2_v7_diag_h7_both_dense.xy`
  - `output/mp2_v7_diag_t1both_dense_t3clone.xy`
- Key finding: the previous crash case was not "both leaders active" or "dense T1 drum notes".  
  It was a **Track 3 leader note insertion offset** bug (event shifted by one byte when non-T1 leaders used trimmed pre-activation body).
- Writer fix (now in `xy/project_builder.py`):
  - For any **leader with notes**, start from full body before activation.
  - After insertion, trim one tail byte for non-T1 leaders (same final-length behavior as the validated 105b path).
- Resulting confidence:
  - We can now generate multi-pattern content across multiple tracks (`T1` + `T3`) with both tracks carrying distinct A/B note data.
  - Both pre-track descriptor forms observed in testing (`5-byte` and `7-byte`) load with the corrected leader-body serialization.

## Brute-Forced Offsets (Tempo / Groove / Metronome)
- `0x08`–`0x09` (`u16`): Tempo in tenths of BPM. Examples: `0x04B0` → 120.0 BPM, `0x0190` → 40.0 BPM, `0x04BC` → 121.2 BPM.
- `0x0A` (`u8`): Padding/Unused (always `0x00` in baseline).
- `0x0B` (`u8`): Groove type enum. Baseline `0x00` (straight), `0x08` → “dis-funk”, `0x03` → “bombora”.
- `0x0C` (`u8`): Groove amount byte. Default project shows `0x00`; loading groove types populates it with the preset depth (`0xA8` observed for both “dis-funk” and “bombora”).
- `0x0D` (`u8`): Metronome level / Groove side-effect? Default `0xA8`. Muting click (`unnamed 10`) changes this but also removes 4 bytes from the file header. Setting groove (`unnamed 11/12`) resets this to `0x00`.
- **Metronome Mute Anomaly**: `unnamed 10` (mute click) is 4 bytes smaller than baseline. The diff shows a massive shift because a 4-byte chunk (likely `01 04 00 00` at `0x001F`) was removed. This contradicts the earlier claim that metronome edits don't shift content.
- `0x0D` (`u8`): Metronome level. Default appears at `0xA8`; muting the click drives it down to `0x10`.
- `0x10`–`0x17`: Four more `u16` slots that reshuffle based on whether we touch groove or metronome. Groove selection fills them with non-zero values (`0x0010/0x1200` and `0x0011/0x2000`), while metronome edits populate them with `0x1112` and `0xFF20/0x0001`. Likely these encode groove curvature presets plus metronome routing/state flags—needs more captures to finish decoding.

### Header Reader Utility
- Added `tools/read_xy_header.py` to dump these header fields for any set of `.xy` files (wildcards supported). It outputs a columnar table showing tempo (float and raw), groove type/flags, groove amount, metronome level, and the three 32-bit words at `0x0C`, `0x10`, and `0x14`.
- Running `python tools/read_xy_header.py 'src/one-off-changes-from-default/*.xy'` confirms every project under `one-off-changes-from-default` keeps these values at the fixed offsets above. Tempo variants only touch the tempo word; groove presets flip the groove type byte plus the `0x0C/0x10/0x14` words; metronome edits adjust the volume byte and those same words without shifting other content.

### Project Inspector Utility
- Added `tools/inspect_xy.py` to emit a multi-section report (header, pattern directory, per-track scan, EQ) for a single `.xy` file. v0.1 decodes 0x25 quantised note blobs well enough to recover coarse ticks, rough step index, MIDI note/velocity, and gate percentage; step-state bitmaps remain TODO.

### MIDI Chunk Stub (early read)
- Header word at `0x20` is `0x{entry_size}{entry_count}` (little-end): default projects show `0x0C000004` → 4 directory entries, each 12 bytes. `unnamed 41.xy` bumps it to `0x0D000004`, confirming that toggling project MIDI append an extra byte to every descriptor.
- The first descriptor (`offset 0x24`) mutates from `ffff0e000001400000014000` to `ffff0c0f000001400000014000`. The only functional delta is the 16-bit field swapping `0x000E` for `0x0F0C`, while the downstream offsets remain `0x00000140`.
- Removing the injected `0x0F` byte (and restoring the header bytes to `0x0C`/`0x0E`) makes the file byte-identical to the baseline, so the project-MIDI setting is entirely encoded in that substituted field. Working theory: it is a compact track→channel tuple where `0x0F` records the zero-based MIDI channel (16 → 0x0F) and `0x0C` tags which track was touched; we need additional captures (different tracks/channels, multiple assignments) to nail down the exact mapping.

## Track Blocks (WIP)
- **Signature** `00 00 01 03 ff 00 fc 00` marks each of the 16 track blocks. In `unnamed 1.xy` the block starts land at `0x0080, 0x07ac, 0x0eb0, 0x1057, 0x1245, 0x13ec, 0x15a1, 0x176b, 0x1a5d, 0x1bba, 0x1d17, 0x1e28, 0x1f85, 0x20d9, 0x222a, 0x2388`.
- **Block size** varies slightly by track type; instrument track 3 spans roughly `0x1a7` bytes (next block begins at `start+0x1a7`).
- **Pointer table** at block offsets `0x0008`–`0x0023` shuffles when a main knob deviates from its default. Example: knob 1 edits (`unnamed 23/24`) push the `0x0112` word from offset `0x000c` to `0x000a` and insert zeros where `0x0a0a`/`0x0101`/`0x0202` lived; this likely re-roots the knob map to a dedicated data blob.
- **Activation mask**: bytes `0x0024`–`0x00c7` flip from the baseline pattern (`00 00 ff 00` repeating) to (`ff 00 00 ff`) once knob 1 is touched. Both max (`unnamed 23`) and min (`unnamed 24`) captures share the same mask, so it probably gates “custom value present” rather than encoding the value itself.
- **Knob 1 value field** resides around `block+0x00c8`. Observed tuples:
  - Baseline (UI 15): `ff 00 de 7a 14 00 00 00…` → 16-bit little endian at `0x00cc` = `0x147a`.
  - Max (UI 99): `00 dc ff ff 01 7f 00 00…` → `0x00cc` = `0x7f01`.
  - Min (UI 0): `00 e6 ae 07 00 00 00 29…` → `0x00cc` = `0x0000`.
  These records also tweak the two preceding bytes (`0x00c9`–`0x00ca`), suggesting a coarse/fine split or calibration table still to decode.
- **Knob 4 (M1 page)** changes (`unnamed 25`) light up a second record starting near `block+0x0100`. The altered span mirrors knob 1 (mask set, pointer shift, 16-bit value updated), pointing to one record per knob laid out sequentially.
- **Engine selection** (`unnamed 34`) rewrites the whole track block. The byte at `block+0x000d` is the engine ID (`0x03` → sampler in `unnamed 1.xy`; `0x16` → Axis synth). Swapping engines replaces the pointer table that follows (`0x14c` onward now points at Axis macro defaults) and drops the preset pathname: the baseline “bass/shoulder” string at `0x1040` becomes zero/`0xFF` padding, with only the short `'  N'` marker at `0x150` signalling “No preset”. The absence of an ASCII path confirms that engine-only slots rely on numeric defaults rather than string references.
- **Engine capture set**: we now have a sweep of Track 1 exports for every engine, each derived from `unnamed 34` with only the picker selection changed. Filenames map to UI labels: `unnamed 34` (Axis), `34b` (Dissolve), `34c` (Drum), `34d` (EPiano), `34e` (Hardsync), `34f` (MIDI), `34g` (Multisampler), `34h` (Organ), `34i` (Prism), `34j` (Sampler), `34k` (Simple), `34l` (Wavetable). Use these for per-engine enum values and structural diffs.
- **Engine enum map** (`block+0x000d` byte; pointer words sampled from `block+0x00cc`):
  | Engine | File | ID | Pointer signature & notes |
  | ------ | ---- | -- | ------------------------- |
  | Axis | `unnamed 34.xy` | `0x16` | `0x00004140, 0x004E2020, 0x75300000…`; `'  N'` marker at `0x150`, no preset string. |
  | Dissolve | `unnamed 34b.xy` | `0x14` | Shares Axis pointer form; minor word `0x1FFF→0x59BA` tweaks reflect different default macros. |
  | Drum | `unnamed 34c.xy` | `0x03` | Reverts to sampler-style table (`0x01000040` repeats) matching baseline drum kit layout. |
  | EPiano | `unnamed 34d.xy` | `0x07` | Hybrid table (`0x00001999`, `0x00002009`) plus `'N'` marker; unique defaults for EP macro pages. |
  | Hardsync | `unnamed 34e.xy` | `0x13` | Same structural form as Axis/Dissolve with Hardsync-specific parameter words. |
  | MIDI | `unnamed 34f.xy` | `0x1D` | Dense mask of `0x7F00FFFF`/`0x00FFFF00` repeating; no `'N'` string, indicates routing matrix instead of synth macros. |
  | Multisampler | `unnamed 34g.xy` | `0x1E` | Uses sampler/drum pointer grid; expect additional zone tables elsewhere (to be mapped). |
  | Organ | `unnamed 34h.xy` | `0x06` | Distinct words (`0x000033ED`, `0x00451500`, `0x69730000`) implying drawbar table; marker bytes differ from `'N'`. |
  | Prism | `unnamed 34i.xy` | `0x12` | Pointer block blends Axis lead-in with `0x00007Fxx` defaults; no preset path. |
  | Sampler | `unnamed 34j.xy` | `0x02` | Matches baseline sample engine table (`0x01000040` repeats); preset string absent because we picked “No preset”. |
  | Simple | `unnamed 34k.xy` | `0x20` | Unique lead word `0x00007FFF` followed by `0x007Fxxxx` defaults; `'N'` marker persists. |
  | Wavetable | `unnamed 34l.xy` | `0x1F` | Pointer block filled with `0x0100007F` ladders ending in `0x4F551100`; suggests separate wavetable parameter slab. |
- Sample-driven engines (`Drum`, `Sampler`, `Multisampler`) preserve the sampler-style pointer lattice and will likely pull external directory data; follow-up work should diff their broader file structure versus synth engines.
- **Pointer block groups** (`track+0x140`–`0x1AF`):
  - Axis/Dissolve/Hardsync share the same skeleton: `0x00004140` lead word, `'  N'` marker at `track+0x150`, and a stack of macro defaults ending in `0x00002E68`. Dissolve/Hardsync swap only the middle macro constants (`0x1FFF/0x59BA` and `0x55FE` lanes).
  - Prism/Simple/Wavetable push the same “no preset” marker but load `0x00007Fxx` ladders for their pointer table. Simple starts with `0x00007FFF` while Wavetable repeats `0x0100007F`; Prism mixes `0x00004140` headword with `0x1C7F0000` to feed its partial table.
  - EPiano and Organ both deviate: EPiano opens with `0x00001999`/`0x00002009` and still keeps the `'N'` marker, whereas Organ replaces that marker with little-endian “si” (`0x7369` at `track+0x158`) plus `0x00451500`, hinting at drawbar defaults baked into the block.
  - MIDI’s block is entirely different: twelve words alternate `0x7F00FFFF`/`0x00FFFF00` with a lone `0x00001155` slot, signalling a routing-mask table instead of macro pointers.
  - Drum/Sampler/Multisampler revert to the sampler lattice (`0x01000040` repeating). Multisampler extends the run with extra `0x00007F00` words and the tail grows by ~80 bytes, matching the file-size bump (Axis 8057 B vs Multisampler 8139 B, Sampler 8144 B).
- **Track hi-pass (M1) capture** (`unnamed 40.xy`, `unnamed 82.xy`): touching Track 1’s “HP” encoder rewires the 8-word table at `block+0x013E` (absolute `0x01BE`). Baseline Drum block stores `[0x005C, 0x0900, 0x0040, 0x0100, 0x0040, 0x0100, 0x0040, 0x0100]`; pushing the knob to 100 swaps in `[0x0900, 0x0040, 0x0100, 0x0040, 0x0100, 0x0040, 0x0100, 0x0060]` (current value promoted into the lead slot, defaults shift down). Dropping it to UI value 1 (`unnamed 82.xy`) keeps the same table layout but the slot descriptor at `0x0FF0` changes from the baseline default `0xFF040000` to `0x60010000`, which packs the current value in the upper half (`0x0160` ticks ≈ UI 1) and the default in the lower half (`0x0000`). UI 100 serialises as `0x00400900` (current `0x0900`, default `0x0040`). The pointer stub before it (`0x0FE0`) still re-points into the per-track parameter slab (`0x1484`, `0x51`, `0x568F`, `0x251E` little-end), so serializers must juggle those relocations while writing custom HP values.
- **Velocity sensitivity** (`unnamed 82.xy`): Track 1’s velocity sensitivity byte lives at absolute `0x0A83` (`block+0x0A03`). Baseline value `0x3B` (UI 59) drops to `0x00` when the UI slider is set to zero, without disturbing the neighbouring sample path table.
- **Mod routing block** (`unnamed 83.xy`): Track 1’s mod-wheel/aftertouch/pitch-bend/velocity routings live in the slab from `block+0x0F70` through `block+0x101F`. The 6×16 B table at `block+0x0F70` is a pointer directory; each mod source links to an 8 B payload at `block+0x1000 + index*0x08`.
  - Payload layout (tentative, little-endian `u16` words):
    1. coarse amount word (signed; scaling TBD — new capture shows values drifting negative for the `-50` and `-25` edits but the exact factor is still unclear).
    2. fine amount / bias word (also signed; paired with the coarse word).
    3. destination enum.
    4. aux flags (still acting like a slot index; defaults stay 0).
  - Destination IDs confirmed so far:
    * `0x005F` → `synth2` (modwheel target swapped from the default `0x0055`/`synth1`).
    * `0xFF00` → `lfo4` (aftertouch moved off `0x001A`/`filter1`).
    * `0x0000` appears for both the old pitch‑bend `synth1` slot and the new `adsr1` pick, so either ADSR lives at the zero ID or we still need another capture where pitch bend goes to a non-synth destination to disambiguate.
    * Velocity target flip shows up as `0x0266` (`filter3`) replacing the previous synth code inside the second half of the routing directory (words `block+0x0FB0`..`+0x0FB7` now read `[0x002B, 0x0100, 0x0016, 0x0200, …]`, matching the expected “filter3, amount, slot-index” pattern).
  - Pitch-bend payload anchor: the 8 B record at `block+0x0F88` (absolute `0x1008`) stores `[u16 dest, u16 amount, u16 guard, u16 guard]`. Defaults serialize as `dest=0x0000` (synth1) with `amount=0x001A`. In `unnamed 83.xy` switching to ADSR1 writes `dest=0x1ADF`; in `unnamed 84.xy` targeting filter3 writes `dest=0xDF00` while keeping the amount/guards unchanged. That gives us a working map of `0x0000 → synth1`, `0x1ADF → ADSR1`, `0xDF00 → filter3`.
  - Amount encoding: both the coarse/fine words swing with the UI values (e.g. modwheel `-50` pushed the pair to `0xFF27/0xFFE8`, aftertouch `+50` yields `0x1ADF/0x0000`, pitch‑bend `+25` writes `0x0000/0x0BE5`, velocity `-25` stores `0xFFFF/0x3F00`). They clearly form a signed fixed-point format, but we still need another sweep that steps the encoder through known increments to pin down the exact scale factor.
  - The slot descriptor at `block+0x0FF0` also flips: the raw blob mutates to `3d0a000002ffff017fffff017f0031ae`, which likely carries the new directory length plus pointers into the payload list. None of the higher tracks react when we touch the mod settings, confirming this table is confined to Track 1.
- **P-lock (parameter lock) encoding** (`unnamed 35.xy`, `unnamed 115.xy`): Each track body contains a p-lock region immediately after the engine config tail bytes `40 1F 00 00 0C 40 1F 00 00`. The region holds **48 entries** arranged as **3 lanes of 16 steps** each. The exact start offset varies by engine and type byte (find the config tail to locate it reliably).
  - **Entry format** (variable-length):
    - Empty: `FF 00 00` (3 bytes) -- step uses default value
    - Value: `[param_id] [val_lo] [val_hi] 00 00` (5 bytes) -- step has p-locked value
  - **Parameter ID byte**: The first non-empty entry in a lane carries the actual parameter ID. All subsequent entries in the same lane use `0x50` as a continuation marker.
  - **Value encoding**: u16 LE in bytes 1-2, range 0-32767 mapping linearly to 0-100%.
  - **Known parameter IDs**: `0x7C` = filter cutoff (unnamed 115, 14 steps ramping 1.2%-97.5%), `0x08` = macro 1 / synth param 1 (unnamed 35, 14 steps with varied values). `0x50` = continuation marker (not a real parameter).
  - **Trailing empties**: After the 48 lane entries, 0-8 additional `FF 00 00` empties pad before the sentinel byte. Baseline files have 7 trailing empties; files with p-lock values have fewer (5-6).
  - **Sentinel byte**: Single byte after trailing empties. Baseline Prism T3 = `0xDE`; filter cutoff p-lock = `0xCE`; macro 1 p-lock = `0xEC`; Drum T1/T2 baseline = `0xDF`. The sentinel appears to encode which parameters (if any) have been modified but the exact encoding rule is undetermined.
  - **Step-component directory** (present only when p-locks exist): 16 x 4-byte records immediately after the sentinel. Each record encodes `[u8 unk] [u8 unk] [u8 unk] [u8 component_type]`. For parameter lanes: `01 00 00 05` (component type `0x05`). The 16th step uses `01 00 00 FF` if that step has no p-lock. Baseline files (no p-locks) omit this directory entirely.
  - **Post-directory region**: After the step-component directory, additional metadata appears: `00 00 FF 00 00 FF 00 00 82 01 00 00` followed by more empties and the 2-byte footer `7A 14` immediately before the 196-byte synth parameter block. Baseline files skip directly from sentinel to `7A 14`.
  - **P-lock start offset by track** (baseline type-05): T1/T2/T3 = `body[0x26]`, T4 = `body[0x23]`, T5-T8 = `body[0x27]`. For type-07 bodies, subtract 2 from the type-05 offset. Universal method: search for the `40 1F 00 00 0C 40 1F 00 00` tail and start immediately after.
- **Pitch-bend performance capture** (`unnamed 39.xy`): Live wheel moves on Track 3 inject a `0x21/0x01` meta-event at `block+0x01CF` (absolute `0x1051`). The 18-byte header now stores start ticks in the high 24 bits of `0x1E03_0000`, gate ticks via the usual `(control >> 8)` path, and—critically—two little-endian counters `fieldA=0x22`, `fieldB=0x2D` for the automation buffers that follow. Immediately after the header, two keyframe tables replace the usual `0xFF00` filler: `fieldA` entries beginning at `block+0x01CF` and `fieldB` more entries starting around `block+0x0226`. Each 32-bit word packs `pitch_hi16 | tick_lo16`; decode ticks as an unsigned 16-bit timeline (add `0x10000` whenever the low half wraps) and interpret the signed high half as the normalized bend amount (0 = center, ±0x7FFF ≈ full throw). Files without pitch bend leave this region untouched, so the meta-event plus non-zero keyframes are a clean detection signal. This automation pathway does *not* touch the parameter-lane header or the step-component directory, confirming that performance bend capture is serialized separately from knob automation even though it occupies the same track-block automation slab.
- **Sample engine deltas** (vs Axis):
  - Drum (`unnamed 34c.xy`) flips the engine ID to `0x03` and restores the baseline lattice; the entire string region at `0x1040` zeroes out like Axis. Diff spans `0x008d–0x1f78`, last change landing at `0x1f78`, confirming the sampler payload sits wholly inside Track 1’s block.
  - Multisampler (`unnamed 34g.xy`) adopts ID `0x1E` and adds extra `0x00007F00` rows inside the pointer block plus subtle tweaks up to `0x1f77`, accounting for the +82 byte file size. Expect additional tables elsewhere referencing zones once we compare against a populated kit.
  - Sampler (`unnamed 34j.xy`) shares the Multisampler signature but runs a few extra tail words (file +87 B). Remaining sections outside Track 1 are byte-identical to Axis, so any kit/sample metadata must live within this block until further captures expose external tables.
- **Preset strings** (`track+0x0FC0`, absolute `0x1040` for Track 1): projects that keep the bundled preset embed ASCII segments here. The untouched baseline (`unnamed 1.xy`) shows `00 00 F7 62 61 73 73 00 2F 73 68 6F 75 6C 64 65 72 00`, i.e. folder and filename (`"bass"`, `"/shoulder"`) as null-terminated slices prefixed by a single status byte (`0xF7`). Selecting an engine with “No preset” wipes the block to `0x00/0xFF` padding and leaves only the `'  N'` marker elsewhere, so serializers must restore the full ASCII payload when referencing a preset.
- File sizes track the pointer complexity: synth engines sit between 8057 B (Axis) and 8122 B (Simple), sample-based engines and Organ push into the 8130–8144 B range, and every diff stays inside the first track block (`offset 0x008d` through `0x1f78`).
- **Value scaling (tentative)**: fitting the observed pairs `(ui, raw)` = `(0, 0x0000)`, `(15, 0x147a)`, `(99, 0x7f01)` yields an almost linear rule `raw ≈ 324.65 * ui + 372.18`. More mid-range captures should tell us whether the firmware quantizes to a tidy step (e.g., `raw = ui * 0x0145 + bias`) or performs table lookup.
- **Record layout hypothesis — Structure (Single Note - Grid)**:
  - `0x00`: `0x25` (Track 1 only) OR `0x2d` (Track 3+ synth slots) OR `0x20` (Track 7-8). See "Event Type Selection" section for track-slot rules.
  - `0x01`: `u8` Count (Number of notes)
  - `0x02`: `u16` Absolute Fine Ticks (Little Endian).
  - `0x04`: `u32` Preamble.
      - **If Ticks == 0**: `02 F0 00 00` (4 bytes).
      - **If Ticks > 0**: `00 00 00 F0 00 00` (6 bytes).
  - **Payload** (6 bytes for Grid):
      - `0x00`: `u8` Voice ID (`01`)
      - `0x01`: `u8` Note (`3C` for C4).
      - `0x02`: `u8` Velocity (`64`)
      - `0x03`: `u24` Gate/Flags.
          - `00 00 00`: Default Grid Gate.
          - `00 00 64`: Explicit Gate 100%.

- **Structure (Live / Complex - 0x21)** — used on Track 3+ synth slots:
  - Used for sequential notes, live recording, micro-timing, custom gate/velocity.
  - `0x00`: `0x21` (Event Type — synth track slots)
  - `0x01`: `u8` Count (`01`)
  - `0x02`: `u32` Start Ticks (LE).
  - `0x06`: `00` (Padding?)
  - `0x07`: `u16` Gate Ticks (LE).
  - `0x09`: `00 00 00` (Padding - 3 bytes).
  - `0x0C`: `u8` Note (e.g. `30` for C4 on Synth).
  - `0x0D`: `u8` Velocity.
  - `0x0E`: `00 00` (Padding).
  - `0x10`: `64 01` (Tail/Field B).

### Track Sentinels
- **Drum/Sampler (Engine 03)**: Sentinel is `0x8A` (1 byte).
- **Prism (Engine 12)**: Sentinel is `00 86` (2 bytes).
- **Writer Logic**: Search for Tail Pointer `01 10 F0` and use the byte(s) immediately preceding it.

### 0x25 Note Event Variants
The `0x25` tag marks the start of a note-event block.
- **Byte 1**: Count.
- **Bytes 2-3**: Absolute Fine Ticks (u16 LE).
- **Bytes 4+**: Variable Preamble + Payload.
- **Preamble Logic**:
    - First Note (Ticks=0): `02 F0 00 00`.
    - Subsequent Notes / First Note (Ticks>0): `00 00 00 F0 00 00`.
- **Note**: Writing new notes should mimic the "Grid" structure (6-byte payload, fixed preamble) for compatibility.ff a packed table at absolute offset `0x24` in `src/one-off-changes-from-default/unnamed 1.xy`. The table stores little-endian `<u16 value><u16 param-id>` pairs.
- **Band ordering**: the first two entries use param id `0x0040` and map to the low and mid knobs (baseline values read at `0x28` and `0x2c`). The third entry carries id `0x9a40` and tracks the rightmost (high) EQ band (`0x34` in the baseline capture).
- **Value encoding**: neutral settings serialize as `value = 0x0100`. Pulling a band to 0 dB pushes the value to `0x0500` while the id stays fixed — see low (`unnamed 14.xy`, `0x28`), mid (`unnamed 15.xy`, `0x2c`), and high (`unnamed 16.xy`, `0x34`) adjustments. The delta in steps of `0x0100` points to a simple `raw = knob * 0x0100 + bias` scheme; more mid-scale samples will confirm the exact mapping.
- **Locality**: all three EQ entries occupy the contiguous span `0x24–0x37`, immediately after the global header. Each tweak only touches its 4-byte lane (low `0x28–0x2b`, mid `0x2c–0x2f`, high `0x34–0x37`), leaving the rest of the file byte-identical.

## Pattern Directory (Validated)

The pre-track region between the header and the first track block contains a pattern directory and handle table. This section summarizes the validated structure; see "Multi-Pattern Storage Model" for the full block rotation mechanism.

### Pre-Track Layout (0x56 to end)

| Offset | Size | Field | Notes |
|--------|------|-------|-------|
| 0x56-0x57 | 2 | `pattern_max_slot` (u16 LE) | 0-based: 0=1 pattern, 1=2, 2=3. Validated across unnamed 1/6/7/102/103/104/105 |
| 0x58+ | 5+ | Pattern descriptor(s) | Only present when patterns > 1. See below |
| variable | 36 | Handle table (12 x 3 bytes) | Shifts rightward when descriptors are inserted |

**Pattern descriptors** (inserted at 0x58 when going from 1 to 2+ patterns):
- Single-track multi-pattern: `00 1D 01 00 00` (5 bytes)
- Two-track multi-pattern (unnamed 105): `01 00 00 1B 01 00 00` (7 bytes = 5 + 2 per additional track)

**Handle table**: 12 entries of 3 bytes each (`FF 00 00` = unused). In the baseline, the table occupies 0x58-0x7B (36 bytes). When pattern descriptors are inserted, the entire handle table shifts rightward by the descriptor size (e.g., 0x5D-0x80 for a 5-byte descriptor).

**Pre-track total size**: baseline = 0x7C (124 bytes); 2+ patterns single track = 0x81 (129 bytes); 2 tracks with patterns = 0x83 (131 bytes).

### Pre-Track Descriptor Variants (`j01`-`j07`, 2026-02-12)

New device-authored captures show that the descriptor region is more flexible than the fixed-`0x58` model above:

- The 36-byte `FF 00 00` handle table is still present and contiguous at the end of pre-track.
- The descriptor insert start can shift (`0x56`, `0x57`, or `0x58` in current captures).
- Working files exist where bytes `0x56-0x57` are not a clean little-endian `pattern_max_slot`, so readers/writers must not hardcode that field globally.

Observed inserts relative to `unnamed 1` pre-track:

| File | Insert pos | Insert bytes | Notes |
|------|------------|--------------|-------|
| `unnamed 6/102/103/105b` | `0x56` | `01 00 00 1d 01` | T1, 2 patterns |
| `unnamed 7/104` | `0x56` | `02 00 00 1d 01` | T1, 3 patterns |
| `unnamed 105` | `0x56` | `01 00 01 00 00 1b 01` | T1+T3, 2 patterns |
| `j03_t4_p2_p1note` | `0x58` | `1e 01 00 00` | T4-only, 2 patterns, note in pattern 1 |
| `j04_t4_p2_p2note` | `0x58` | `01 01 00 00 1a 01 00 00` | T4-only, 2 patterns, note in pattern 2 |
| `j05_t2_p3_blank` | `0x57` | `02 00 00 1c 01 00` | T2-only, 3 patterns, all blank |
| `j01_5trk_p9_blank` | `0x56` | `08 08 02 00 00 00 08 00 00 17 01` | T1/T2/T3/T4/T7, 9 patterns blank |
| `j02_5trk_p9_sparse` | `0x57` | `02 04 01 00 00 00 03 00 00 17 01 00` | Same topology as `j01`, sparse notes |
| `j06_all16_p9_blank` | `0x56` | `08 08 06 00 00 16 01` | 80 logical entries in block-rotation decode; tracks 1-8 at 9 patterns, tracks 9-16 at 1 |
| `j07_all16_p9_sparsemap` | `0x56` | `08 08 06 00 00 16 01` | Same descriptor as `j06`; sparse note map confirms stable addressing |

Practical implication: descriptor serialization must be topology-aware (and likely state-aware), not a single fixed insertion formula.

### Note Event Storage

Note events are appended directly to the track block body (NOT stored in a separate roster):
- Empty pattern: body ends at the track block sentinel area
- Pattern with notes: event blob (0x25 or 0x21 header + note records) is appended at the tail of the body
- The track block's type byte flips 0x05 to 0x07 when notes are present (2-byte padding removed)

See "Sequencer Pattern Bits" below for full event encoding and "Multi-Pattern Storage Model" for how multiple patterns are stored via block rotation.

### Sequencer Pattern Bits (Notes / Length / Scale)
- **Note-event variants (`0x25` decoder taxonomy)**:
  - *Inline-single*: `count=1` captures (e.g. `unnamed 2.xy`, `unnamed 81.xy`) populate a single 10-byte record. `start` dword carries coarse/fine ticks, `field_a` high byte stores the MIDI note, `field_b` low byte stores velocity, and the tail is either empty or just a preset pointer. No auxiliary structures are allocated.
  - *Hybrid-tail*: sample-heavy or poly captures (triads/stacked chords, e.g. `unnamed 3.xy`, `unnamed 80.xy`) still emit the legacy 10-byte records but the note/velocity lanes inside them are either zeroed or reused as pointers. Actual note data lives in the tail (`tail_words` start with `[note | vel, flag, lo, hi, …]`), and every voice gets a `PointerInfo` pair landing in the per-step slab (`track+0x16xx`). Inspector must harvest note/velocity from the tail entries and follow `start>>8` to decode step/gate.
  - *Pointer-tail only*: some hybrid captures hide all per-voice data behind the tail pointers (record `field_a/field_b/field_c` are pure addresses). The tail enumerates voices first (`note | vel` words) followed by one or more pointer pairs. Treat any pointer whose swapped high word resolves within the track block as the node’s backlink; ignore pairs that would jump outside the file.
  - *Live/0x21 meta events*: performance takes (e.g. `unnamed 50.xy`, `unnamed 56.xy`, `unnamed 65.xy`) add `0x21/0x01` blocks elsewhere in the track. These carry `start_ticks`/`gate_ticks` directly plus additional automation tables; they do **not** alter the `0x25` payload and should be handled separately.
- **Per-step node slab (`track+0x16xx`)**:
  - Quantised hybrid notes allocate 16-byte records starting at `track+0x1650`. Layout: `[0xDF00, idx?, 0x0100, NOTE, 0x0100, STEP_TOKEN, 0x0000, GATE_TICKS]`. Known samples show `STEP_TOKEN=0x0018` and `GATE_TICKS=0x1490` for default one-step holds; future captures with other grid positions are needed to derive the exact formula.
  - Upstream words act like a linked-list header (the first `0xDF00` found per voice), while downstream offsets (`track+0x1670…`) mirror preset tables but include the raw note bytes (`0x0043`, `0x0041`, …). Treat `track+0x1650`, `+0x1660`, etc. as the authoritative node for step/math decoding.
- **Tail-derived slab (`track+0x1700` and beyond)**:
  - Tail pointer `derived_offset` usually lands one block deeper (e.g. `track+0x1700`). The chord capture shows `[0x0000, 0xFF00, 0x007F, 0x0600, 0xFFF8, 0x00FF, 0x003F, 0x0400]` versus the baseline preset values, so this region clearly tracks per-voice state (likely micro-offset / gate runtime metadata). Mapping still TBD.
  - Inline captures (single-note, `unnamed 81.xy`) never allocate these nodes, so `0xDF00` and mutated `0x1700` slabs are reliable indicators that the pattern is using the hybrid/pointer representation.
- **Pattern length (bars)**: byte at `0x7E` controls Track 1 Pattern 1 length. Default `0x10` (16 steps ≈ 1 bar); diff captures show `0x20`, `0x30`, `0x40` when the UI switches to 2/3/4 bars. It sits two bytes before the Track 1 block header, so the per-pattern table likely precedes each track bank; need to confirm the stride for other tracks.
- **Track scale enum**: byte at track-block offset `+0x03` (absolute `0x83` for Track 1) mirrors the “track scale” picker. Observed: `0x03` baseline, `0x05` for “track scale 2”, `0x0E` for “track scale 16”, `0x01` for “track scale 1/2`. Sequence suggests a straight mapping to the UI list.
- **Note chunk sentinel**: baseline has a lone `0x8A` at block offset `+0x726` (absolute `0x7A6`) marking an empty step slot. Adding a trig swaps that byte for a variable-length blob beginning with `0x25 <note-count> 00 00`.
- **Mono event layout** (`unnamed 2.xy`): the blob `25 01 00 00 02 F0 00 00 01 3C 64 00 00 64` parses cleanly as `type`, `count`, reserved, then a 10-byte event:
  - `start` dword `0x0000F002` (step index + micro-timing; low byte flips when we move the trig—bitfields still TBD).
  - `voice`, `note`, `velocity`, `flags` = `01`, `3C`, `64`, `00`.
  - `gate` word `0x6400` (decimal 100) gives the full-step hold. Rewriting pitch/velocity only touches bytes 9–10 (MIDI note) and 10–11 (velocity).
- **Chord trail** (`unnamed 3.xy`): same header with count `0x03`, but the first two 10-byte records already pack note/velocity in `fieldB` (low byte = note, high byte = velocity). The third record flips `fieldA` away from zero and hands off to a 6-byte tail (`40 67 00 00 64 01`) that carries the remaining voice’s note/velocity plus its gate before the usual `0xF010` pointer. Updated inspector surfaces all three voices by combining the inline records with that tail; still need to map how the non-zero `fieldA`/`fieldB` pair links back to the tail offset for synthesis.
- **Gate duration field** (`unnamed 56/57/50`): For the 16-byte trig record that lives around `track_block+0x0150`, bytes `+8..+11` are a little-endian tick count. Resolution is 480 ticks per sequencer step (1/1920 note). Examples: `0x000003C0` (960 ticks) spans two steps, `0x00000780` (1920 ticks) spans four, and `0x00000149` ≈ 329 ticks from a live take gives a 0.685-step hold. The next two u16s still store note (`pitch << 8`) and velocity, so finding the note/velocity pair and updating the preceding dword lets us author arbitrary gate lengths, including fractional steps and pattern-spanning wraps.
- **Live record chunk** (`unnamed 50.xy`): Track 3 swaps the empty sentinel `0x86` for a `0x21` header followed by 14-byte records. First word `0x08CB` matches the raw tick capture from record mode (≈ step index with micro-timing), third word exposes the live velocity (`0x49` → 73), fourth word lands on `0x0100` which lines up with the halved gate the UI shows. This chunk also flips the step bitmap around `0x2130`, so the record payload probably packs both tick timing and a pointer into the step-mask table. Need another capture with quantized live input to lock the scaling.
- **Live trig step decode** (`unnamed 50/56/57/65/78/79`): the 0x21/0x01 node carries two timing words—bytes 2–5 are absolute start ticks (480 ticks per 16th), bytes 6–9 (after shifting off the low byte) are gate length in ticks. Step index is recovered by rounding `start_ticks / 480`. Example set: `unnamed 50` → start 2251 ⇒ step 6 with −149 tick micro-early, gate `0x000149` = 329 ticks; `unnamed 56/57/65/78` → start 3840 ⇒ step 9, gates 960/1920/240/240 ticks; `unnamed 79` → start 5877 ⇒ step 13 with +117 tick micro-late, gate `0x00018B` = 395 ticks. The control word never encodes the step directly—earlier alignment happened by coincidence.

### Step Component Encoding (Corpus-Verified Decode)

**Slot Table Structure** (body07 offsets 0xA2-0xC8):
- 13 consecutive 3-byte slots. Empty sentinel = `FF 00 00`.
- All 13 slots verified as `FF 00 00` on pristine baseline Track 1 (unnamed 1).
- Confirmed on Track 1 (19 specimens) and Track 3 (unnamed 78, Prism synth).
- Note: Track 7/8 baselines use `00 FF 00` instead of `FF 00 00` (different engine default).

**Header Format** (3 bytes, occupies one slot):
```
Byte 0: [(0xE - step_0_indexed) << 4] | [nibble]
Byte 1: component bitmask (B1)
Byte 2: second bitmask or supplementary byte (B2)
```
Header slot position: step_0=0 at slot 5 (offset 0xB1, 2 specimens), step_0=8 at slot 6 (offset 0xB4, 17 specimens). Formula for other steps unknown — only these 2 step positions observed in the corpus.

**Nibble Encoding** (partially decoded):
- nibble=3 (step 9, 11 specimens): B1 = bank-1 bitmask, B2 = bank-2 bitmask. Used for ALL single bank-1 components at step 9, and for the ALL multi-component entry (unnamed 63: `63 FF 3F`).
- nibble=4 (step 9, 7 specimens): B1 = bank-2 bitmask, B2 = 0x00 (or 0x04 for Trigger). Used for ALL single bank-2 components at step 9.
- nibble=4 (step 1, 2 specimens): B1 = bank-1 bitmask (0x01 = Pulse), B2 = 0x00. This CONTRADICTS the "nibble=4 means bank-2" interpretation — unnamed 8 and unnamed 9 both use nibble=4 for Pulse, which is a bank-1 component.
- **Conclusion**: nibble meaning is step-dependent. At step 9, nibble=3/4 reliably distinguishes bank-1/bank-2. At step 1, nibble=4 is used for bank-1 components too. Insufficient data (only 2 step positions) to derive the general rule.

**Bank-1 Bitmask** (8 bits — all 8 individually verified plus ALL union):
| Bit  | Component   | Verified by              |
|------|-------------|--------------------------|
| 0x01 | Pulse       | unnamed 59, 60, 8, 9     |
| 0x02 | Hold        | unnamed 61               |
| 0x04 | Multiply    | unnamed 66, 78 (Track 3) |
| 0x08 | Velocity    | unnamed 67               |
| 0x10 | RampUp      | unnamed 68               |
| 0x20 | RampDown    | unnamed 69               |
| 0x40 | Random      | unnamed 70               |
| 0x80 | Portamento  | unnamed 71               |
ALL union: unnamed 63 has B1=0xFF (all 8 bits set). Cross-check: 0x01|0x02|0x04|0x08|0x10|0x20|0x40|0x80 = 0xFF.

**Bank-2 Bitmask** (6 bits — 5 uniquely verified, bit 0x20 ambiguous):
| Bit  | Component          | Verified by              |
|------|--------------------|--------------------------|
| 0x01 | Bend               | unnamed 72               |
| 0x02 | Tonality           | unnamed 73               |
| 0x04 | Jump               | unnamed 74               |
| 0x08 | Parameter          | unnamed 75               |
| 0x10 | Conditional        | unnamed 76               |
| 0x20 | **AMBIGUOUS**      | unnamed 77 AND unnamed 62|
- **Bit 0x20 conflict**: Both Conditional-9th (unnamed 77, B1=0x20 B2=0x00) and Trigger-4th (unnamed 62, B1=0x20 B2=0x04) use bit 0x20. They are distinguished by B2: Trigger has B2=0x04, Conditional-9th has B2=0x00. It is unclear whether bit 0x20 represents "Trigger" or "Conditional (variant 2)" or a shared slot that uses B2 to disambiguate.
- ALL union: unnamed 63 has B2=0x3F (bits 0x01-0x20 all set), consistent with 6 bank-2 components.

**Standard Param Record** (5 bytes: `00 [TYPE_ID] [PARAM] 00 00`):
Each verified by exactly one corpus specimen (two for Conditional):
| Type ID | Component    | PARAM value  | Specimen    |
|---------|-------------|-------------|-------------|
| 0x00    | Hold        | 0x01 (min)  | unnamed 61  |
| 0x01    | Multiply    | 0x04 (div4) | unnamed 66  |
| 0x01    | Multiply    | 0x02 (div2) | unnamed 78  |
| 0x03    | RampUp      | 0x08        | unnamed 68  |
| 0x04    | RampDown    | 0x02        | unnamed 69  |
| 0x05    | Random      | 0x03        | unnamed 70  |
| 0x06    | Portamento  | 0x07 (70%)  | unnamed 71  |
| 0x06    | Bend        | 0x01        | unnamed 72  |
| 0x07    | Tonality    | 0x04 (+5th) | unnamed 73  |
| 0x08    | Jump        | 0x04 (s13)  | unnamed 74  |
| 0x09    | Parameter   | 0x04        | unnamed 75  |
| 0x0A    | Conditional | 0x02 (2nd)  | unnamed 76  |
| 0x0B    | Conditional | 0x09 (9th)  | unnamed 77  |
Note: Portamento and Bend share type_id 0x06 — distinguished by which bitmask bit is set. Gap at type_id 0x02 (no specimen).

**Pulse Param** (non-standard, 3 bytes per slot): `[REPEAT] 00 00` for repeat mode (unnamed 59: `01 00 00`), or `00 FF 00` repeating for random mode (unnamed 60). Both step 1 and step 9 specimens show identical param structure.

**Velocity Param**: Random mode only specimen (unnamed 67): same `00 FF 00` slot-fill pattern as Pulse random.

**Allocation Marker** (pattern `[XX] 40 00 00`, followed by `01 40 00 00` repeating):
- Baseline position: body07 0xC9 (unnamed 1, alloc=0xDF).
- After component insertion, marker shifts rightward by insertion size.
- **Allocation byte formula** (verified 16/19 corpus specimens):
  `alloc = 0xF7 - step_0 * 0x10 - component_global_index`
  Global indices follow bitmask order: Pulse=0, Hold=1, Multiply=2, Velocity=3, RampUp=4, RampDown=5, Random=6, Portamento=7, Bend=8, Tonality=9, Jump=10, Parameter=11, Conditional=12, bit0x20=13.
- Formula exceptions: Pulse/Velocity random-mode specimens have +2/+5 delta (non-standard param encoding).
- The formula confirms Cond-9th (unnamed 77) is at global index 13 (same as Trigger), consistent with the bit 0x20 ambiguity.
- Step 1: formula verified for Pulse repeat (0xF7). Step 1 random-mode has delta=+2.
- Track 3: no allocation marker found in search range 0xC0-0xFF (unnamed 78). May be at a different offset on non-drum tracks.

**Multi-Component Entries** (Trigger and ALL):
- Both produce 17 bytes of param data after the 3-byte header (unnamed 62, unnamed 63).
- Both share allocation byte 0x6A and identical data length.
- Trigger header: `64 20 04` — B2=0x04 meaning unknown (possibly Jump co-activation bit, or trigger-every-N encoding).
- ALL header: `63 FF 3F` — bank1=all 8 + bank2=all 6 = 14 components.
- Per-byte mapping of the 17-byte param block not fully decoded. 14x1-byte interpretation (one default param per component) is plausible but unverified.

**Step Component Authoring** (DEVICE-VERIFIED WORKING):
- Component-only activation works standalone — no note events required.
- The initial test batch crashed due to two bugs (Crash #9): wrong allocation byte (shifted baseline 0xDF instead of formula-computed value) and wrong preamble (0x64 on next track). After fixing both, component-only files load correctly.
- Authoring recipe: (1) activate body (type 0x05→0x07), (2) insert component data at slot offset, (3) update allocation byte. Can also be combined with note authoring in any order.
- Component insertion is pure byte insertion at the slot position. Body grows by insertion size (6 bytes for Pulse/Velocity, 8 bytes for standard components).
- Component activation does NOT set preamble 0x64 on the next track (verified: all 19 corpus specimens keep original preambles). Setting 0x64 incorrectly causes `num_patterns > 0` crash.
- The allocation byte is critical — a wrong value also causes `num_patterns > 0` crash.
- Implementation: `xy/step_components.py` (types, encoding, alloc formula) + `project_builder.add_step_components()`.
- **Device-verified components** (6 of 13, all on Track 1 step 9):
  | Component  | Param | File                | Status |
  |------------|-------|---------------------|--------|
  | Hold       | 0x01  | comp_B1_hold.xy     | WORKING |
  | Multiply   | 0x04  | comp_B2_multiply.xy | WORKING |
  | Bend       | 0x01  | comp_B3_bend.xy     | WORKING |
  | Pulse      | 0x01  | comp_B4_pulse.xy    | WORKING |
  | RampUp     | 0x08  | comp_B5_rampup.xy   | WORKING |
  | Portamento | 0x07  | comp_B6_porto.xy    | WORKING |
  | Hold (solo)| 0x01  | comp_C_hold_only.xy | WORKING (no notes) |
- Byte-perfect corpus matches: Hold=unnamed 61, Bend=unnamed 72, Pulse=unnamed 59. All 3 match every byte of the full file.
- Untested: RampDown, Random, Velocity, Tonality, Jump, Parameter, Conditional (encoding follows same pattern, expected to work).

**Multi-Step Component Encoding** (unnamed 118 + 119, full 16-step decode):

The single-step model above (3-byte header + 5-byte param) applies to isolated components at one step.
When components are present on ALL 16 steps, the encoding changes fundamentally to a **contiguous
variable-length block stream** replacing the sentinel table:

*Sentinel Structure* (both unnamed 118 and 119):
- 11 sentinels (`FF 00 00`) before data region at body07 0x90-0xB0
- Component data starts at 0xB1
- 7 sentinels after data region
- Allocation marker = 0x06 at the end

*unnamed 118* (Hold on all 16 steps, 128 bytes = 16 x 8B):
- Step 1: `e4 02 00 00 00 04 00 00` (hdr=0xE4, type=Hold=0x02)
- Steps 2-16: ALL identical `0a 02 00 00 00 04 00 00` (hdr=0x0A = repeat marker)
- Single-type context: all repeats are uniform 8-byte blocks with byte[2]=0x00

*unnamed 119* (different type on each step, 130 bytes variable-length):
Full parse of all 16 blocks:
```
Step  Type           Bank  Size  Hdr   Mask  Byte2  Byte4  Param  Extra
----  -------------  ----  ----  ----  ----  -----  -----  -----  -----
  1   Pulse          B1     6B   0xE4  0x01  0x00          0x04
  2   Hold           B1     8B   0x0B  0x02  0x00   0x00   0x04
  3   Multiply       B1     8B   0x0A  0x04  0x00   0x01   0x02
  4   Velocity       B1     8B   0x09  0x08  0x00   0x02   0x05
  5   RampUp         B1     8B   0x08  0x10  0x00   0x03   0x04
  6   RampDown       B1     8B   0x07  0x20  0x00   0x04   0x04
  7   Random         B1     8B   0x06  0x40  0x00   0x05   0x04
  8   Portamento     B1     8B   0x05  0x80  0x00   0x06   0x04
  9   Bend           B2     8B   0x05  0x01  0x00   0x06   0x01
 10   Tonality       B2     8B   0x04  0x02  0x00   0x07   0x04
 11   Jump           B2    10B   0x03  0x04  0x00   0x07   0x04   04 00
 12   Parameter      B2     9B   0x02  0x08  0x00   0x08   0x04   02
 13   Conditional    B2    10B   0x01  0x10  0x00   0x09   0x02   02 00
 14   Type14(0x20)   B2     4B   0x00  0x20  0x00
 15   Pulse(repeat)  --     9B   0x0A  0x02  0x02   0x01   0x00   04
 16   Hold(repeat)   --    10B   0x0A  0x02  0x02   0x00   0x00   00 04
```

*Key patterns discovered*:
1. **Header byte**: Step 1 always 0xE4. Steps 2-14: decreasing from 0x0B to 0x00 as each new type is introduced. Porto(B1) and Bend(B2) share hdr=0x05. Repeat blocks use hdr=0x0A.
2. **hdr + byte[4] invariant**: Equals 0x0B for all bank-1 types and the first 2 bank-2 types (Bend, Tonality). Drops to 0x0A for Jump/Parameter/Conditional.
3. **All blocks end with `00 00`** — this is the structural invariant that enables parsing variable-length blocks.
4. **Block sizes**: 6B (Pulse special), 8B (standard), 9B (Parameter), 10B (Jump, Conditional), 4B (Type14 terminal).
5. **Bank-2 types 11-13 have extra bytes** after the standard param byte — likely type-specific sub-parameters (jump target, parameter selector, condition type).
6. **Type14 is the 14th component**: mask=0x20 in bank 2. Resolves the bit 0x20 ambiguity — this IS a distinct type (not Trigger). Its 4-byte minimal encoding (hdr=0x00, mask, 00, 00) suggests it may be a simple toggle with no parameter.
7. **Repeat blocks** (hdr=0x0A) have byte[2]=0x02 when bank-2 types are present in the same component chain (vs 0x00 in unnamed 118 which has only bank-1 types). They are variable-length (8B, 9B, 10B observed).

**Other observations**:
- Step bitmap at body07 offset ~0x2400 flips step lane to `0x0000` for every component activation, matching the "touched" state observed with note trigs.
- Track 3 Multiply capture (unnamed 78) confirms the same slot table structure on non-drum tracks. Header `63 04 00` with param `00 01 02 00 00` (type=Multiply, param=0x02=divide-by-2).


## Firmware Package Notes (2025-02-14)
- `src/firmware/opxy_firmware_1_1_0.tfw` opens with two 0x40-byte headers keyed by `0xBABECAFE`/`0xBEEFCAFE`. Interpreting the fields as little-endian shows a global length word (`0x002BAD00`), firmware version `0x00010001` (v1.1), and a shared payload offset of `0x00014008`.
- The second header carries a 32-bit checksum-like word (`0x8CD00501`) and a payload size field (`0x0069C840` ≈ 6.9 MB). All bytes between the 0x80-byte header slab and offset `0x14008` are zero padding.
- At `0x14008` the main blob begins. The data is highly entropic; multiple compression stubs exist downstream:
  - `0x00999472`: local file header `PK\x03\x04` with a non-standard compression method `0x4182`. General-purpose flag `0x497E` has bit 3 set, hinting at a custom codec rather than deflate. No ZIP central directory (`PK\x01\x02`/`PK\x05\x06`) appears anywhere in the container, so the entry is likely stream-parsed by the updater.
  - `0x0001BBA0`: gzip-like header (`0x1F8B`) advertising compression method `0x16`; `gzip` refuses to decompress because it only supports method `0x08`. This confirms the updater wraps custom codecs in familiar container markers.
  - Standard signatures coexist deeper in the image: deflate-flavoured GZIP headers (`1F 8B 08`) pop up at `0x10C7F98`, `0x1215F9E`, `0x23D3B53`, `0x29AC19B`, `0x2C2677D`, `0x48F2144`, and `0x5552D32`, but Python’s `gzip` module rejects them with `invalid block type`, suggesting either encrypted payloads or non-deflate back-ends behind the nominal header.
  - A lone Zstandard frame (`28 B5 2F FD`) lives at `0x4C1EED2`. Its frame header encodes a window descriptor byte `0xB9`, i.e. `windowLog = 33` → `windowSize = 10,737,418,240 B`. Stock `zstd`/`zstandard` builds cap `ZSTD_WINDOWLOG_MAX` at 31, so every off-the-shelf decoder aborts with “Frame requires too much memory” unless we recompile libzstd with a larger window and enough RAM to host a 10 GB history buffer.
- No raw instances of the project magic `dd cc bb aa 09 13 03 86` exist in the compressed data, so we must decode at least one of the embedded payloads before hunting for `loadProject()` strings.
- Immediate blocker: the Zstd frame’s 10 GB window makes naive extraction impractical. Attempting to spoof the window descriptor (patched to `0xA0`) lets the standard decoder start but it quickly flags data corruption, confirming the stream actually relies on long-distance matches. We will either need TE’s decompressor (likely shipped alongside the updater) or a bespoke zstd build compiled with `ZSTD_WINDOWLOG_MAX ≥ 33` and plenty of disk-backed workspace.
- Next steps: locate or implement the custom decompressor (reverse the updater binary, search the firmware for a codec table that maps `0x4182`/`0x16`, or diff another `.tfw` release to see if the checksum/payload fields shift predictably). Once decompression works we can scan the extracted ELF/ROM for the project tag jump table described in the playbook.

## 2025-02-11 — Variable-Length Encoding Discovery & Writer Root Cause

### Firmware Assertion
- Device crash when loading writer-produced files: `/src/sequencer/serialize/serialize_latest.cpp:30 num_patterns > 0`
- Fires at line 30 — very early in deserialization, before any pattern content is parsed.
- `num_patterns` is NOT simply the value at `0x56` (that field is `0x0000` in all working single-pattern files too).
- The firmware likely derives `num_patterns` from the preamble byte[1] and pattern_max_slot — if offsets are wrong, it reads garbage and fails the assertion.

### Variable-Length Track Block Encoding (100% Verified)
- **Type byte** at `block+0x09`: controls whether 2 padding bytes follow.
  - `0x05` (default/inactive): 2 padding bytes `08 00` present at `block+0x0A`. Parameter data starts at `block+0x0C`.
  - `0x07` (activated/touched): NO padding bytes. Parameter data starts at `block+0x0A` (2 bytes earlier).
- **Corpus verification**: 1,345 blocks with type `0x05` all have padding; 63 blocks with type `0x07` all lack padding. Zero exceptions across 88 files (1,408 total track blocks).
- **Parameter data is identical** between the two formats — just shifted by 2 bytes. A type-07 block is exactly 2 bytes shorter than its type-05 counterpart for the same track content.

### Writer Root Cause (SOLVED)
- `xy/writer.py`'s `_activate_pointer_words()` adds `0x0200` to the first pointer word, changing `0x0500` → `0x0700`. This flips the type byte from `0x05` to `0x07`.
- **But the writer does NOT remove the 2 padding bytes** (`08 00`) that type `0x05` requires and type `0x07` forbids.
- Result: firmware reads type `0x07`, expects no padding, but the padding is still there — ALL downstream data is misaligned by 2 bytes.
- The firmware then reads garbage at every field offset, eventually hitting the `num_patterns > 0` assertion.
- **Fix required**: when changing type `0x05` → `0x07`, physically remove the 2 padding bytes and shrink the file by 2 bytes per activated track. Or alternatively, keep type `0x05` and don't change the pointer words at all (just insert note data at the correct offsets for the existing format).

### Shift Propagation (Verified)
- When one track block changes size, ALL subsequent track blocks shift uniformly by the same delta. Unmodified tracks are byte-identical to baseline, just relocated.
- **71/87 files**: clean uniform shift (single-track edits).
- **Anomalies** (all explained):
  - `unnamed_34` family: staircase shift (engine change affects 8 bytes per track — engine ID byte change propagates).
  - `unnamed_40`: non-uniform shift (HP filter parameter changes multiple tracks).
  - `unnamed_64`: progressive +8 bytes per track.
  - `unnamed_6/7`: major restructuring (new patterns added via block rotation).

### No Checksum Found
- Tempo-only changes (unnamed 4/5) affect ONLY the tempo bytes at `0x08-0x09`. No other bytes change.
- No hidden CRC, hash, or integrity check detected anywhere in the file format.

### Handle Table Correction
- The handle table at `0x58` contains **12 entries** of 3 bytes each (through `0x7B`, 36 bytes total), NOT 9 entries of 4 bytes and NOT 16 as coded in `find_track_handles()`.
- Each entry is `FF 00 00` in the baseline (unused). The 3-byte grouping aligns perfectly; 4-byte grouping does not.
- Bytes `0x7C-0x7F` are the first track's preamble word (LE u32 with `0xF0` high byte), not part of the handle table.
- `xy/structs.py`'s `find_track_handles()` reads 16 handles (range(16)), which means handles 13-16 read into track preamble/data -- this is a bug.
- When pattern descriptors are inserted at `0x58`, the entire handle table shifts rightward (see Pattern Directory section above).
## Outstanding Issues
- **Pointer-tail note decode gap**: pointer-driven note payloads (hybrid 0x25 events and pointer-21 meta blocks) still stop at pointer metadata in the inspector. The per-voice node slabs at `track+0x16xx` mingle live note entries with static lookup tables, so we need deterministic rules to recover `step`, `beat`, and `gate` before changing the report. See `docs/issues/pointer_tail_decoding.md` for the current findings and plan.
- **Pointer-21 display**: to avoid misleading output we now suppress the bogus high-octave tail notes that came from parsing ASCII pointer words. The report shows "note data unresolved" for these events until we can decode the referenced slabs; the missing decode remains tracked alongside the pointer-tail issue.
- **Writer produces unloadable files**: SOLVED — see "Variable-Length Encoding Discovery" above. The writer changes the type byte without removing padding, causing 2-byte misalignment in all downstream data.
- **`find_track_handles()` reads past handle table**: reads 16 entries but only 12 exist (0x58-0x7B, 3 bytes each). Entries 13-16 overlap with track preamble data.
- **Triple-write bug in writer**: `xy/writer.py` lines 173-176 write `PREPAYLOAD_WORDS` three times to the same offset `block_offset + 0x0024`. Only one write is needed.

## Open Questions

### Answered
- ~~Is there a checksum or version field guarding the project file?~~ **ANSWERED**: No checksum detected. Tempo-only edits change only the tempo bytes.
- ~~Do pattern slots reserve fixed-size blocks per track, or are they length-prefixed blobs?~~ **ANSWERED**: Neither. Patterns use block rotation -- clone blocks are inserted inline, always 16 block slots total. See "Multi-Pattern Storage Model".
- ~~Pattern roster entries: which bitfields carry `prev/next`, payload offsets, and active counts?~~ **ANSWERED**: No roster/linked ring. The old model was wrong. Patterns are stored as cloned track blocks with preamble encoding. The `0x3FFF`/`0x00FFFFF8` values are part of the handle table entries, not linked-list sentinels.
- ~~Track-block handle word: how are slot index and payload pointer packed into the preamble dword?~~ **ANSWERED**: Preamble = `[byte0] [byte1] [bar_steps] [0xF0]`. byte0 encodes role (0xB5=leader, 0x00=clone, 0x64=post-activation sentinel). byte1 = pattern count (leaders) or next-track baseline byte0 / 0x64 (clones).
- ~~Empty pattern sentinel `0x8A`: does it require a matching roster flag?~~ **ANSWERED**: 0x8A is the baseline preamble byte0 for T2 (Drum phase). Not a sentinel -- it just appears at clone byte[1] when the preceding block is not activated, because it's T2's original byte0.
- ~~How does the firmware compute `num_patterns` from the file data?~~ **ANSWERED**: `pattern_max_slot` at offset 0x56 (u16 LE, 0-based). Value 0 = 1 pattern, 1 = 2 patterns, etc. The firmware reads this plus the preamble byte[1] (pattern count per track).
- ~~What is the exact relationship between the handle table entries and track block locations?~~ **ANSWERED**: Handle table is 12 entries of 3 bytes each (`FF 00 00` = unused). Position shifts when pattern descriptors are inserted. Entries are NOT pointers to track blocks -- track blocks are located by signature scanning.

### Still Open
- Are scenes stored sequentially even when unused, or does the file include a scene count bitmap?
- How are sample paths encoded -- plain text, hash, or indices into a directory table?
- Trig node layout: what do each of the four dwords (`0xCB012100`, `0x00000008`, `0x00000149`, `0x00213000`) represent (prev/next IDs, track ID, component flags), and how do we compute them when authoring new events?
- Step state table: which byte order (`0x00FF` vs `0xFF00`) corresponds to "active trig", "edited empty", and "pristine", and how do we derive the correct ordering when writing patterns from scratch?
- ~~How does the mask header's low byte map to the actual step index (e.g., `0x63/0x64` for step 9)?~~ **ANSWERED**: Header byte = `[(0xE - step_0_indexed) << 4] | bank_nibble`. Nibble 3 = bank-1 entry, nibble 4 = bank-2 entry. See "Step Component Encoding" section.
- ~~Derive the exact mapping from UI values to the stored words for each component.~~ **MOSTLY ANSWERED**: Standard param format is `00 TYPE_ID PARAM 00 00`. Full type_id table decoded (12 components). Pulse/Velocity use non-standard 3-byte format. Multi-component (Trigger/ALL) uses 17-byte compact table -- per-byte mapping still TBD.
- ~~What determines the slot position for each step number?~~ **PARTIALLY ANSWERED**: In multi-step mode (unnamed 118/119), the single-step slot table is replaced by a contiguous variable-length block stream starting at body07 0xB1. The 3-byte header + 5-byte param model is replaced by variable-length blocks (4-10 bytes). The slot position question applies only to single-step mode.
- Why does step_0=0 use nibble=4 for bank-1 components (step 1 Pulse)?
- Can step components be authored without triggering the ~1300-byte slab reorganization that accompanies component activation?
- ~~What is the 14th component type (bit 0x20 in bank 2)?~~ **ANSWERED via unnamed 119**: It IS a distinct 14th type (mask=0x20, bank 2). It encodes as a minimal 4-byte block `00 20 00 00` when hdr reaches 0x00 (terminal). The UI name is unknown but it exists as a real component type separate from Trigger and Conditional.
- How do multi-step repeat blocks encode the specific component type being repeated? In unnamed 119, both repeat blocks (steps 15-16) have byte[1]=0x02, but represent different types (Pulse and Hold). The type may be encoded in byte[4] (0x01 for Pulse repeat, 0x00 for Hold repeat).
- What determines variable block sizes for bank-2 types? Jump and Conditional get 10B, Parameter gets 9B, Type14 gets 4B. The extra bytes likely encode type-specific sub-parameters but the mapping is not yet confirmed.

## Next Steps
1. **DONE: Byte-perfect round-trip parser** — `xy/container.py` (XYProject) verified across 88 corpus files.
2. **DONE: First successful device-loadable file** — `output/ode_to_joy_v2.xy` confirmed working on OP-XY hardware using 0x21 event format + pure-append recipe.
3. **DONE: Full Ode to Joy with varied note lengths** — `output/ode_to_joy_full.xy` plays 15 notes across 4 bars (quarter, dotted-quarter, eighth, half) confirmed on device.
4. **Build a proper note writer API**: encode the pure-append recipe into `xy/container.py` or a new `xy/writer.py` module for programmatic note authoring.
5. **Decode pointer-21 events**: the inspector still shows "note data unresolved" for these. The per-voice node slabs need deterministic rules.
6. Diff track-scale and pattern-length edits on another track to confirm stride patterns.
7. **MOSTLY DONE: Decode step component encoding** -- slot table, header format, bitmasks, type_ids, and standard param records all decoded. Remaining: multi-component compact table, slot position formula, Trigger/ALL param structure.

### Previous Next Steps (retained, lower priority)
- Capture a quantized live-record trig so we can compare the `0x21` chunk’s start word against grid-aligned timing and finalize the tick scaling.
- Decode the pointer-21 (0x21 variant 0) sequencer events so the inspector can surface real notes instead of `note data unresolved`.
- Add a step-entered trig on a later step (e.g., Step 9) with a non-default gate to verify how the simpler `0x25` records increment the start word and gate field.
- Diff track-scale and pattern-length edits on another track to confirm whether the `0x7E`/`+0x03` bytes repeat at a fixed stride per track block.
- Sweep the newly captured step components across multiple keypad values to decode how their config words (`0x0138`, `0x0150`, etc.) scale.
- Layer a step component onto a step that already has a note trig to expose how note payloads and component structures reference one another.
- Try stacking two different step components on the same step inside one project to determine whether the firmware stores them in a list or a packed bitfield.
- Create a pattern that only edits component parameters (no notes) on a different track to test whether the component table location moves with the track block or lives in a shared region.

## Working Norms
- Keep AGENTS.md up to date after each discovery session.
- Store scripts/utilities under `tools/` (to be created) with clear README once we start coding.
- Prefer reversible edits; never overwrite the baseline `.xy` files.

## 2025-02-14 — Track 1 Writer Prototype
- Refactored common parsing helpers into `xy/structs.py` so both inspector and writer share the same offset math (`find_track_blocks`, pointer readers, sentinel bytes, etc.).
- Added `xy/writer.py`:
  - `activate_track()` promotes `unnamed 1.xy` to the firmware’s “touched but empty” state by rewriting the pointer table, slot descriptor, sentinel payload, tail strip, and 32-word step slab (derivable from the baseline via rotation and constant suffix).
  - `activate_track()` now interprets track-handle slot words in little-endian form so the slot descriptor offset resolves correctly for any track (track handles keep their big-endian sentinel).
  - `apply_single_trig(track_index=…)` emits the modern single-trig layout captured in `unnamed 81.xy`: updates the 0x25 header (`fine = step * STEP_TICKS`, coarse = 0x000000F0), rewrites the eight node dwords (note/velocity, pointer back to param slab, voice/coarse word, and the constant trailer), patches the tail region (`0x0600,0x0002,…,0xFF00` header + repeating `00FF/FF00` mask), swaps in the event slot descriptor, and installs the fixed 32-word step slab with the gate word carrying `gate_percent`.
  - Reference slabs (pre-payload and tails) now come straight from firmware captures: the rotated mask/table and “touched blank” tail bytes are lifted from `unnamed 53.xy`, and the single-trig tail mirrors `unnamed 81.xy`. The writer writes these verbatim so Track 1 lands in the same state the device produces.
  - `TrigSpec` accepts an optional `gate_ticks`, letting us write long notes (e.g., 960 ticks ≈ two steps) without guessing at firmware scaling. The CLI accepts `gate_ticks=` alongside the existing percentage knob.
- New CLI `tools/write_xy.py`:
  - Usage: `python tools/write_xy.py --template 'src/one-off-changes-from-default/unnamed 1.xy' --output build/drum.xy --trig step=8,note=60,vel=100`.
  - Currently supports a single quantised trig on Track 1 (arbitrary step/note/velocity/gate). Multi-trig authoring is `NotImplemented` until we decode the linked list layout.
- Regression tests `tests/test_writer_roundtrip.py`:
  - `test_activate_matches_reference` checks that `activate_track()` reproduces the relevant slices of `unnamed 53.xy` (pointer words, slot descriptor, sentinel/node/tail/slab).
  - `test_single_trig_matches_step9` writes step 9 / C4 into the activated buffer and asserts byte-for-byte parity with `unnamed 81.xy` for the event regions and slot descriptor.
- Persisting gaps:
  - Gate scaling is still hard-coded to the 100 % (0x03E8 ticks) case; need additional captures to map non-default gates.
  - The per-step mask slab is presently set to the observed constant for drum trigs; we still owe a derivation that works for arbitrary counts and post-pattern cleanup.
- Follow-up: extend `apply_single_trig()` to accept multiple hits (decode linked node table / tail pointer chain) and add tests for different notes/gates once captures exist.

### Notes for the Next Agent (re: writer + inspector refactor)
- The shared module `xy/structs.py` is now the single source of truth for low-level offsets. Any further inspector rewrites should go through that module so the writer stays in sync; avoid re-introducing duplicated logic inside `tools/inspect_xy.py`.
- `SENTINEL_BYTES` intentionally uses the *activated* sentinel (`8A … FC 00`). If we discover alternative firmware revs, record the variant here and gate on project signature instead of hard-coding another blob.
- Writer tests (`tests/test_writer_roundtrip.py`) treat `unnamed_53.xy` and `unnamed_81.xy` as golden references. If future analysis reveals those files were captured on buggy firmware, replace the fixtures and update the tests rather than deleting them—the diff-based approach keeps the authoring path deterministic.
- Known blind spots before resuming writer work:
  1. The inspector still guesses at multi-note/tail decoding. Until we stabilise that analysis, hold off on adding writer support for stacked chords or long gates; otherwise we risk baking incorrect assumptions into `xy/writer.py`.
  2. Gate duration currently maps `gate_percent` → `round(percent * 1000 / 100)`. Capture additional examples to confirm whether the firmware stores ticks, percent, or a lookup table. Once verified, update both `apply_single_trig` and the inspector’s reporting.
  3. Multi-trig linked list: the device writes extra `0x25` headers, node entries, and tail pointers when multiple hits exist. Plan to diff `unnamed_80` (multiple notes) once the inspector exposes the correct structure.
- When file-analysis bugs are fixed:
  - Re-run the existing pytest suite (`pytest tests/test_writer_roundtrip.py tests/test_inspector_outputs.py`) to ensure no regressions.
  - Extend `TrigSpec` to accept explicit tick counts (or other metadata) instead of `gate_percent` once the true encoding is known.
  - Consider adding an integration harness that loads a writer-produced file back through the inspector and compares the human-readable report to the change log entry that motivated it.


### Synth / Multisampler Note Payloads (unnamed_65)
- Step entries for non-drum tracks do not emit the global `0x25` note event. Instead, the track block itself carries activation flags and the per-step parameter record.
- Each track block begins with a 3-word-per-step state table at `block+0x24`. An idle step stores `[0x0000, 0x00FF, 0xFF00]`; placing a trig rotates the triplet to `[0x00FF, 0xFF00, 0x0000]`. Step 9 (1-based) on Track 3 and Track 8 flips the triplet starting at `block+0x54`.
- A per-step parameter record sits at `block+0xF0`. For Prism (Track 3) the eight 16-bit words become `1FFF 0000 4500 0061 0400 0CCC 0000 7000`, where `0x45` (high byte of word 3) is the MIDI pitch and `0x0061` the velocity. The multisampler record at the same offset reads `7AFD 0000 FF00 007F 0000 2B30 5555 0115`, using the high byte of word 3 (`0xFF`) to select the drum/multi zone and `0x007F` for velocity.
- Track pointer tables (words `block+0x08`..`block+0x1F`) swap their sentinel words when a note is armed. Example: `0x0500 0x0008` becomes `0x0700 0x1201`, pointing at the new metadata chunk.
- A new 18-byte chunk appears before the next track block: `21 01 00 0F 00 00 00 F0 00 00 01 29 64 00 00 64 01 10`. This `0x21` record (type 1) links the step mask to the per-step record. Fields decode as: subtype = 0x01 (“quantised note”), step code = 0x0129 (9 × 0x21), parameter offset = 0xF0, duplicated velocity = 0x64, and a track mask (`0x0110`) that flags Track 3 (Prism) and Track 8 (Multisampler).
- Practical recipe: to author a synth/multisampler note, rotate the triplet for the target step, drop the eight-word record at `block+0xF0` with the desired pitch/velocity/gate, and emit a type-1 `0x21` chunk pointing at that record.

## 2025-02-xx — Pointer-21 Corpus Sweep
- Ran a quick audit across `src/one-off-changes-from-default/*.xy` using the inspector helpers. **NOTE**: the original analysis attributed event type to engine type, but subsequent corpus analysis (91 files) shows a consistent pattern of Track 1 → `0x25`, Tracks 2+ → `0x21` or `0x2D`. The exact selection mechanism (track index vs. body structure vs. collision avoidance) remains unproven — see "Event Type Selection" section.
- Every pointer-21 capture (12 files in the change log) exposes the same five-entry tail ladder. Only the pair `lo=0xF000` (`swap_lo=0x00F0`) resolves inside the owning track (`track+0x00F0`); the remaining pairs (`0x0000/0x01E0`, `0x0800/0x002B`, `0xFFF1/0x0020`, `0xFFFA/0x004F`, `0x000B/0x0045`, `0xFFFB`) jump beyond the project file, implying they reference firmware lookup tables rather than serialized data.
- `track+0x00F0` behaves like a preset slab for pointer-21 events: Track 4 captures tied to metronome/groove edits keep the baseline template `5983 5555 1501 0000 7904 0034 0000 6446`; `unnamed_38` (Track 4 extreme notes) rewrites the slab to `5555 1501 0000 7904 0034 0000 6446 0000`; `unnamed_6` (Track 5) replaces its track-specific baseline with the same Track 4-style template. The neighbouring slot originally holding the preset marker (`track+0x01B8`) now stores per-note records where the lower 16 bits encode `velocity << 8 | note` (e.g., `0x1F00` → note 0, velocity 31; `0x647C` → note 124, velocity 100).
- Raw 18-byte headers (example `unnamed_38`: `21 00 02 00 16 00 F3 FF 0F 00 FD FF 47 00 07 00 1D 00`) show `count = 0x0002`, with start ticks packed into bytes 4–7 and gate ticks encoded in bytes 8–11. We still need to normalise those values (likely wrap into unsigned tick counts) and decode the positional fields.
- `0x25` hybrid records continue to provide usable coarse ticks when the note lives inline. `unnamed_80` record #1 holds raw ticks `0x00000780`, which divides cleanly by `STEP_TICKS (480)` to give step index 4 → step 5. Later voices in the same capture fall back to pointer slabs; those are the ones that still need the step/gate derivation work. For the D4 hit on step 5 we observe `step_token = 0x0018`, supporting the working rule `step_token = (step_index_zero_based * 0x06)`; the associated gate word (`0x1490`) still needs interpretation.
- Follow-up for next session:
  1. Decode the remaining 32-bit lanes surrounding the pointer-21 note words (e.g., `0x00F00200`, `0x64050100`, `0xF1002B08`) so we can surface precise step/gate values.
  2. Map the off-file pointer destinations (e.g., `track_start + 0x2B00`, `+0x2000`, `+0x4F00`, `+0x4500`, `+0xFBFF`) to their firmware tables once we have a memory dump or additional captures that serialize those regions.
  3. Expand the hybrid `0x25` sample set (e.g., single pointer-managed note on a later step) to validate whether the suspected rule `step_token = step_0_based * 0x06` holds beyond the immediate examples.

## Crash Dump Catalog

Every crash dump from loading custom-generated `.xy` files on the OP-XY is documented here as intel for understanding firmware validation.

### Crash #1: `num_patterns > 0` assertion
- **Source file**: `custom_note.xy` (writer-produced file with misaligned padding)
- **Firmware**: v1.1.1 (build Oct 14 2025)
- **Assertion**: `/src/sequencer/serialize/serialize_latest.cpp:30 num_patterns > 0`
- **Root cause (SOLVED)**: Writer changed type byte 0x05 to 0x07 without removing the 2-byte padding, causing all downstream data to misalign by 2 bytes. The firmware read garbage for pattern count.
- **Screenshot**: `IMG_4564.heic`

### Crash #2: `fixed_vector` overflow
- **Source files**: `output/ode_to_joy_drum.xy`, `output/ode_to_joy_synth.xy`
- **Firmware**: v1.1.1 (build Oct 14 2025)
- **Assertion**: `./src/shared/fixed_vector.h:77 length < thesize`
- **Context**: These files used 0x25 (drum) and 0x2d (synth) event types with multiple notes on different steps. The format was correct for single-note events but the multi-note sequential encoding was wrong.
- **Significance**: PROGRESS -- got past the `num_patterns > 0` structural validation (Crash #1). The firmware now parses the track structure correctly but overflows a fixed-size vector during note event parsing.
- **Likely cause**: Used 0x25/0x2d events for sequential notes on different steps, but unnamed 89 (3 sequential notes from the device) uses the 0x21 event type for this purpose. The 0x25/0x2d format may have different per-note record sizes that caused the vector to overflow.
- **Screenshot**: `IMG_4565.heic`

### Crash #3: `num_patterns > 0` on two-track drum pattern
- **Source file**: `output/drum_pattern.xy` (Track 1 + Track 2 both modified with 0x21 events)
- **Firmware**: v1.1.1 (build Oct 14 2025)
- **Assertion**: `../src/sequencer/serialize/serialize_latest.cpp:90 num_patterns > 0`
- **Screenshot**: `IMG_4566.heic`
- **Stack trace** (partial, from crash screen):
  ```
  SP: 0x840d0b34
  FP: 0x840d0b9c
  0x8fed322e, 0x8fed2b2c, 0x8d57f770, 0x8d57f96c,
  0x8d56f19e, 0x8d56f76c, 0x8d55fe98, 0x8d4cdbcc
  ```
- **Context**: First attempt at multi-track note authoring. The pure-append recipe was applied to both Track 1 and Track 2 (both drum engine 0x03). Track 1 got 8 notes (kick/snare), Track 2 got 16 notes (hats/percussion). The 0x21 event format, type byte flip, and padding removal were applied identically to the proven single-track recipe that worked for `ode_to_joy_v2.xy`.
- **Key difference from working file**: `ode_to_joy_v2.xy` only modified Track 3 (small body, 419B baseline). `drum_pattern.xy` modifies Track 1 AND Track 2 (large drum bodies, ~1800B each). This is the first time two adjacent tracks were both activated.
- **Line number difference**: This crash is at line **90**, vs line **30** for Crash #1. Same assertion text (`num_patterns > 0`) but different location in the deserialization code — suggests the firmware hits this check once per track or per block, and the crash occurs at a later track than Crash #1 did.
- **Root cause (SOLVED)**: The `0x64` preamble sentinel was MISSING on Track 2. The initial incorrect rule said "activated tracks keep original preamble; 0x64 only on first unmodified track after the group." This was wrong for adjacent activated tracks.
- **Correct rule** (proven by `unnamed 93.xy`, 8 activated tracks T1-T8): Every track immediately following an activated track gets 0x64 preamble byte 0, even if that track is itself activated. The first activated track in a chain keeps its original preamble. **Exception**: Track 5 in unnamed 93 keeps its original `0x2E` preamble despite T4 being activated — reason unknown.
- **Fix**: `append_notes_to_tracks()` sets 0x64 on `idx+1` for every activated track idx, not just the first unmodified one. For T1+T2: T1 keeps 0xD6 (original), T2 gets 0x64, T3 gets 0x64. **Device-verified working.**

## 2025-02-11 -- 0x21 Sequential Note Event Format

### Discovery
Analysis of `unnamed 89.xy` (3 notes on Track 3 at different steps) reveals that sequential notes on different steps use the **0x21 event type**, not 0x25 or 0x2d. The file follows the pure-append pattern with no interior body changes.

### Verified Event Format (from unnamed 89)
```
21 03                                         # type=0x21, count=3
00 00 02 F0 00 00 01 05 64 00 00 00           # Note 1: tick=0, note=F(0x05), vel=100
E0 01 00 00 00 F0 00 00 01 7C 64 00 00 00     # Note 2: tick=480, note=E(0x7C), vel=100
C0 03 00 00 00 F0 00 00 01 3C 64 00 00        # Note 3: tick=960, note=C(0x3C), vel=100
```

### Per-Note Record Structure
- **First note (tick=0)**: `00 00` (2-byte tick) + `02` (flag) + `F0 00 00 01` (gate) + note + vel + `00 00 00` (trailing) = **12 bytes**
- **Middle note (tick>0)**: tick_le32 (4-byte) + `00` (flag) + `F0 00 00 01` (gate) + note + vel + `00 00 00` = **14 bytes**
- **Last note (tick>0)**: tick_le32 (4-byte) + `00` (flag) + `F0 00 00 01` (gate) + note + vel + `00 00` = **13 bytes** (1 byte shorter, no separator)

### Tick Encoding
- tick=0: 2 bytes LE (`00 00`)
- tick>0: 4 bytes LE (e.g., `E0 01 00 00` = 480 = step 2)
- Ticks are absolute, not delta: 480 ticks per 16th-note step

### Flag Byte
- `0x02` when tick=0 (first note at start)
- `0x00` when tick>0

### Pure-Append Recipe for Adding Notes
1. Change `body[9]` from `0x05` to `0x07`
2. Remove 2-byte padding at `body[10:12]`
3. Append 0x21 event data at end of body
4. Update next track's preamble byte 0 to `0x64`
5. No other body or pre-track changes needed

### Generated Test File
- `output/ode_to_joy_v2.xy`: 4 notes (E4, E4, F4, G4) at quarter-note spacing on Track 3 using the 0x21 format. **CONFIRMED WORKING ON DEVICE** (2025-02-11).

### Device Test Result: SUCCESS
The file `output/ode_to_joy_v2.xy` loaded and played correctly on the OP-XY hardware. This is the **first custom-authored .xy file to successfully load on the device**. The 0x21 event format, pure-append recipe, and preamble update are all confirmed correct.

### Gate Encoding in 0x21 Multi-Note Events (CONFIRMED WORKING)

#### Discovery
The `F0 00 00 01` token in note records is a **default gate marker** (4 bytes). To encode custom gate lengths, replace it with an **explicit gate** value: `gate_u32_le + 0x00` (5 bytes total — one byte longer per note).

#### Two Gate Modes
| Mode | Bytes | Format | Meaning |
|------|-------|--------|---------|
| Default gate | 4 | `F0 00 00 01` | Short default gate (~240 ticks) |
| Explicit gate | 5 | `[gate_u32_le] 00` | Custom gate in ticks |

The parser distinguishes the two by checking if the byte at the gate position is `0xF0`.

#### Record Sizes with Explicit Gate (1 byte longer than F0-token versions)
- **First note (tick=0)**: `00 00` (2B tick) + `02` (flag) + `gate_u32_le` (4B) + `00` (sep) + note + vel + `00 00 00` = **13 bytes**
- **Middle note (tick>0)**: `tick_le32` (4B) + `00` (flag) + `gate_u32_le` (4B) + `00` (sep) + note + vel + `00 00 00` = **15 bytes**
- **Last note (tick>0)**: `tick_le32` (4B) + `00` (flag) + `gate_u32_le` (4B) + `00` (sep) + note + vel + `00 00` = **14 bytes**

#### Tick-to-Step Gate Reference
| Duration | Ticks | Steps |
|----------|-------|-------|
| Sixteenth | 480 | 1 |
| Eighth | 960 | 2 |
| Quarter | 1920 | 4 |
| Dotted quarter | 2880 | 6 |
| Half | 3840 | 8 |
| Whole | 7680 | 16 |

#### Corpus Evidence
- **Explicit gate (16-byte single-note events)**: unnamed 50 (gate=329), unnamed 56 (gate=960), unnamed 57 (gate=1920), unnamed 79 (gate=395), unnamed 87 (gate=335)
- **F0 token (15-byte single-note events)**: unnamed 65, unnamed 78 — both use `F0 00 00 01`
- **F0 token (multi-note)**: unnamed 89 — all 3 notes use `F0 00 00 01`
- **Explicit gate (multi-note)**: unnamed 92 — 3 notes with different gates (960/1920/2880 ticks = 2/4/6 steps). Device capture confirms explicit gate in multi-note sequential events. Body is byte-identical to baseline (no step state table changes). +42 bytes net (44-byte event minus 2-byte padding removal).

#### Working Code Pattern
```python
def build_note_record(tick, note, vel, gate_ticks, is_first, is_last):
    parts = []
    if is_first:
        parts.append(struct.pack('<H', tick))  # u16 for first note
        parts.append(b'\x02')                  # first note flag
    else:
        parts.append(struct.pack('<I', tick))  # u32 for subsequent
        parts.append(b'\x00')                  # subsequent flag
    # Custom gate: gate_u32_le + 00 separator (5 bytes)
    parts.append(struct.pack('<I', gate_ticks))
    parts.append(b'\x00')  # separator after gate
    parts.append(bytes([note, vel]))
    parts.append(b'\x00\x00' if is_last else b'\x00\x00\x00')
    return b''.join(parts)
```

#### Device Test Results
- `output/gate_test.xy`: 4 notes with gates 1920/3840/960/7200 ticks. **CONFIRMED WORKING** — device showed 4/8/2/15 step note lengths as expected.
- `output/ode_to_joy_full.xy`: 15 notes across 4 bars with quarter, dotted-quarter, eighth, and half note durations. **CONFIRMED WORKING ON DEVICE** (2025-02-11). Full Ode to Joy first phrase plays correctly with varied note lengths visible in step sequencer.

#### Failed Approaches (for reference)
1. `[gate_u16_le] [00] [01]` replacing F0 token (4 bytes) — notes sustained forever
2. `[F0] [gate_u16_le] [01]` keeping F0 marker — notes sustained forever
3. Multiple concatenated `21 01` single-note events — crashes with `num_patterns > 0`

## Event Type Selection (DECODED — unnamed 93 MIDI Harness Experiment)

### Discovery: Engine-Dependent Event Types

The MIDI harness experiment (unnamed 93) sent identical C4 notes via MIDI to all 8 instrument tracks simultaneously, with the OP-XY recording them. This produced a definitive mapping of event types:

| Track | Engine ID | Engine | Event Type | Notes |
|-------|-----------|--------|------------|-------|
| T1 | 0x03 | Drum | 0x25 | Track 1 only |
| T2 | 0x03 | Drum | 0x21 | Same engine as T1, different type |
| T3 | 0x12 | Prism | 0x21 | |
| T4 | 0x07 | EPiano | 0x1F | NEW type, not seen before |
| T5 | 0x14 | Dissolve | 0x21 | |
| T6 | 0x13 | Hardsync | 0x1E | NEW type, not seen before |
| T7 | 0x16 | Axis | 0x20 | Confirmed (matched corpus) |
| T8 | 0x1E | Multisampler | 0x20 | Confirmed (matched corpus) |

**Nine distinct event types discovered**: 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x25, 0x2D.

**Per-note encoding is identical across ALL event types** — only the type byte differs.

### Selection Rules (CORRECTED — 2026-02-12)

**The event type is determined by the PRESET, not the engine or track slot.** Different presets within the same engine produce different event types. This was proven via controlled experiments:

- **unnamed 116**: Same Drum kit (boop) loaded on T4/T7/T8 — all produce 0x25 (not slot-dependent)
- **unnamed 117**: Prism engine on all 8 tracks with different presets — produced 4 different event types (0x1C, 0x1D, 0x1E, 0x1F)
- **unnamed 113**: Different Drum kits on T4/T7/T8 — produced different types (mushroom=0x21, playwood=0x21, chamine=0x22)

Known preset-to-event-type mapping:

| Preset | Engine | Event Type | Source |
|--------|--------|------------|--------|
| boop | Drum | 0x25 | unnamed 116 (T4/T7/T8) |
| kerf | Drum | 0x25 | unnamed 113 (T1 default) |
| in phase | Drum | 0x21 | unnamed 93 (T2 default) |
| mushroom | Drum | 0x21 | unnamed 113 (T4) |
| playwood | Drum | 0x21 | unnamed 113 (T7) |
| chamine | Drum | 0x22 | unnamed 113 (T8) |
| bass-ana | Prism | 0x1D | unnamed 117 (T1) |
| moog-funk | Prism | 0x1C | unnamed 117 (T2) |
| moog-bass | Prism | 0x1C | unnamed 117 (T3) |
| moog-pad | Prism | 0x1E | unnamed 117 (T4) |
| moog-dark | Prism | 0x1C | unnamed 117 (T5) |
| pad-vib | Prism | 0x1F | unnamed 117 (T6) |
| pk-arp | Prism | 0x1E | unnamed 117 (T7) |
| pk-axe | Prism | 0x1E | unnamed 117 (T8) |
| shoulder | Prism | 0x21 | unnamed 93 (T3 default) |
| beach bum | EPiano | 0x1F | unnamed 93 (T4 default) |
| gaussian | Dissolve | 0x21 | unnamed 93 (T5 default) |
| dielectric | Hardsync | 0x1E | unnamed 93 (T6 default) |
| draemy | Axis | 0x20 | unnamed 93 (T7 default) |
| bandpasser | Multisampler | 0x20 | unnamed 93 (T8 default) |
| (engine swap, no preset load) | any | 0x2D | unnamed 91, 94 |

**Key constraint**: Track 1 only accepts 0x25 regardless of preset — 0x21 crashes even with Prism engine on T1.

**Untested engines**: Sampler (0x02), Organ (0x06), MIDI (0x1D), Simple (0x20).

### Practical Authoring Rule (Device-Verified)
- **Track 1 → 0x25** (only type that works; 0x21 and 0x2D both crash)
- **Track 4 → 0x1F** (0x21 crashes; insert-before-tail required)
- **Track 6 → 0x1E** (device-verified via test_D_single_t6.xy)
- **Track 7 → 0x20** (device-verified single + multi-note via test_B/C)
- **Track 8 → 0x20** (same engine family as T7; untested but expected to work)
- **All other tracks → 0x21** (safe universal fallback, verified on T2, T3, T5)
- All native types (0x1E, 0x1F, 0x20, 0x25) confirmed working for authoring.
- 0x2D may only be safe for single-note (count=1) events.
- **Chords work**: flag=0x02 encoding accepted on T1 (0x25) and T3 (0x21), both pure chord and chord+melody mix.

### Previous Hypotheses (Resolved)

Multiple theories were proposed and tested over time:
1. ~~Track index determines type~~ — DISPROVED: unnamed 116 shows same type (0x25) on T4/T7/T8 with same preset.
2. ~~Engine determines type~~ — DISPROVED: unnamed 117 shows 4 different types within Prism engine across different presets.
3. ~~Body structure~~ — DISPROVED: T2 and T1 both have Drum engine with 24 sample paths, but use different event types.
4. **PRESET determines type** — CONFIRMED (unnamed 113, 116, 117). Each preset carries a baked-in event type byte.
5. **Track 1 slot constraint**: Track 1 only accepts 0x25 regardless of preset (test_B: 0x21 crashes even with Prism on T1). This is a slot-level constraint layered on top of the preset rule.

### Device-Verified Test Results
- 0x25 on Track 1: WORKS (unnamed 2, 3, 52, 80, 81; velocity_ramp_0x25.xy)
- 0x25 chord on Track 1: WORKS (test_E_chord_t1.xy — 3 simultaneous drum hits)
- 0x21 on Track 1: CRASHES (`num_patterns > 0`) — Crash #4
- 0x21 on Track 2: WORKS (drum_pattern.xy, unnamed 93)
- 0x21 on Track 3: WORKS (ode_to_joy_v2.xy, gate_test.xy, ode_to_joy_full.xy)
- 0x21 chord on Track 3: WORKS (test_A_chord_t3.xy — C+E+G triad)
- 0x21 chord+melody on Track 3: WORKS (test_F_mixed_t3.xy — chord step 1 + singles steps 5, 9)
- 0x1E on Track 6: WORKS (test_D_single_t6.xy — Hardsync native type)
- 0x1F on Track 4: WORKS (unnamed 93 byte-match via insert-before-tail)
- 0x20 on Track 7 single: WORKS (test_B_single_t7.xy — Axis native type)
- 0x20 on Track 7 multi: WORKS (test_C_melody_t7.xy — 4-note melody)
- 0x25 on Track 2: CRASHES (device-verified)
- 0x25 on Track 3 (Prism): CRASHES — 0x25 is Track-1-only (test_A)
- 0x21 on Track 1 (engine changed to Prism 0x12): CRASHES — slot-based, not engine (test_B)
- 0x2D on Track 1 (Drum): CRASHES (test_C)
- 0x2D on Track 2 (Drum): CRASHES (test_D)

### Corpus Evidence Summary
Default-preset files (factory presets on original slots):
- Track 1: 0x25 (boop kit — unnamed 2, 3, 52, 80, 81)
- Track 2: 0x21 (in phase kit — unnamed 93)
- Track 3: 0x21 (shoulder preset — 10 files) or 0x2D (engine swap — unnamed 85, 86, 94)
- Track 4: 0x1F (beach bum preset — unnamed 93), 0x2D (engine swap — unnamed 91)
- Track 5: 0x21 (gaussian preset — unnamed 93), 0x2D (engine swap — unnamed 94)
- Track 6: 0x1E (dielectric preset — unnamed 93)
- Track 7: 0x20 (draemy preset — unnamed 64, 65, 93)
- Track 8: 0x20 (bandpasser preset — unnamed 64, 65, 93)

Preset-variation experiments:
- unnamed 113: Drum mushroom=0x21 (T4), playwood=0x21 (T7), chamine=0x22 (T8)
- unnamed 116: Drum boop=0x25 on T4/T7/T8 (same preset → same type regardless of slot)
- unnamed 117: Prism bass-ana=0x1D, moog-funk/bass/dark=0x1C, moog-pad=0x1E, pad-vib=0x1F, pk-arp/axe=0x1E

**Corrected engine_id bug**: An earlier analysis claimed "all activated tracks share engine 0x03" — this was wrong. The `container.py` `engine_id` property was reading `body[3]`, which is always 0x03 (part of the track block signature `00 00 01 03 ff 00 fc 00`). The correct engine ID locations are: type-05 → `body[0x0D]`, type-07 → `body[0x0B]`.

### Remaining Tests
1. Test more presets per engine to expand the preset→event-type mapping table
2. MIDI harness with untested engines: Sampler (0x02), Organ (0x06), MIDI (0x1D), Simple (0x20) → discover their preset event types
3. ~~Try native event types (0x1E, 0x1F, 0x20) for authoring~~ → **DONE**: all three confirmed working (0x1E on T6, 0x1F on T4, 0x20 on T7)
4. Test 0x20 on Track 8 (Multisampler) — expected to work (same type as T7)
5. Test 0x21 on T6, T7, T8 — verify universal fallback also works on these tracks, or whether native types are required (like T1 and T4)
6. Determine if Track 1 constraint is truly "only 0x25" or "only the preset's native type" — try loading a non-boop Drum kit on T1

### Note on 0x2D
The byte `0x2D` appears in two different contexts — don't confuse them:
1. **Structural 0x2D**: in Track 1 drum body at pos 376 (grid preset data region), NOT an event
2. **Event 0x2D**: the engine-swap fallback event type — used when the firmware swaps an engine WITHOUT fully rewriting the body from a preset template (unnamed 85, 86, 91, 94). Per-note encoding is identical to all other types.
3. **NOT used when a preset is explicitly loaded**: unnamed 116 shows Drum "boop" kit on T4/T7/T8 producing 0x25, not 0x2D — the preset's native type wins when a preset is properly loaded.
4. **Multi-note 0x2D crashes**: 0x2D with count>1 crashes on T1 (test_C) and T2 (test_D). Device-written 0x2D files all had count=1.

### 0x2D Event Format (DECODED — unnamed 91)
```
2d 01 00 00 02 f0 00 00 01 53 64 00 00
│  │  └──┘  │  └───────┘  │  │  └──┘
│  │  tick  │  gate(def)   │  │  trail
│  count   flag            note vel
type
```
- type=0x2d, count=1, tick=0, flag=0x02, gate=F0 default, note=83 (B5), vel=100
- Multi-note 0x2d events crashed in early testing (Crash #2: fixed_vector overflow)
- Safe for single-note grid events; use 0x21 for multi-note sequential authoring

## unnamed 91 — Engine Change + Single Note (Track 4)

### What changed
Track 4 engine changed from Pluck (0x07) to Drum (0x03), single hit on step 1.

### Structural delta (Track 4 body, vs baseline unnamed 1)
| Region | Baseline | unnamed 91 | Delta |
|--------|----------|------------|-------|
| Type byte (body[9]) | 0x05 | 0x07 | flip |
| Padding (body[10:12]) | `08 00` | removed | -2B |
| Engine ID | 0x07 (Pluck) at body[0x0D] | 0x03 (Drum) at body[0x0B] | changed |
| Engine-specific params | 42B | 38B | -4B |
| Common params (`55 55 01 15` anchor) | 183B | 183B identical | 0 |
| f7 + patch name | `pluck/beach bum\0\0` (17B) | `/\0\0` (3B) | -14B |
| Event data | none | 0x2d single note (+13B) | +13B |
| Tail data | 42B (first byte 0x28) | 42B (first byte 0x08) | 0 |
| **Net** | 490B | 483B | **-7B** |

### Preamble 0x64 NOT set on engine-change files
- unnamed 2 (note-only edit on Track 1): Track 2 preamble[0] = 0x64 ✓
- unnamed 91 (engine change + note on Track 4): Track 5 preamble[0] UNCHANGED
- Hypothesis: 0x64 sentinel is only needed for note-append-without-engine-change. When the firmware writes an engine change, it rewrites the entire track body rather than appending, so the bookkeeping differs.

### Engine ID location (corrected)
The `engine_id` property in container.py was reading `body[3]` (always 0x03, part of the fixed signature `00 00 01 03`). The real engine ID position depends on the type byte:
- type-05 (has padding): `body[0x0D]`
- type-07 (no padding): `body[0x0B]`

Both resolve to the same structural field — the shift is due to the 2-byte padding presence/absence.

### Full engine map (baseline unnamed 1, all type-05)
| Track | body[0x0D] | Engine |
|-------|-----------|--------|
| 1 | 0x03 | Drum |
| 2 | 0x03 | Drum |
| 3 | 0x12 | Prism |
| 4 | 0x07 | Pluck |
| 5 | 0x14 | Dissolve |
| 6 | 0x13 | Hardsync |
| 7 | 0x16 | Axis |
| 8 | 0x1E | Multisampler |
| 9-14 | 0x12 | Prism (aux) |
| 15 | 0x00 | (aux) |
| 16 | 0x05 | (aux) |

## unnamed 93 — MIDI Harness Experiment (8-Track Simultaneous Recording)

### Method
Built `tools/midi_harness.py` using `mido`/`python-rtmidi` to send controlled MIDI data to the OP-XY. The harness generates MIDI clock at configurable BPM, sends transport Start/Stop, and fires precisely-timed note events on specified channels.

**Experiment**: `single_note_all_tracks` — sent C4 (note 60, velocity 100) on MIDI channels 1-8 simultaneously at step 1, with the OP-XY recording all 8 instrument tracks in real-time record mode.

### Structural Findings
- **File size**: 9607 bytes (baseline 9499, +108 bytes net)
- **All 8 instrument tracks activated**: type byte flipped 0x05 → 0x07 on all 8
- **Pre-track region**: grew by 7 bytes (MIDI channel configuration data)
- **Gate encoding**: all notes use explicit gate (480 ticks = 1 step), NOT the F0 default marker — MIDI-recorded notes always get explicit gate
- **Event blob**: all 8 events are byte-identical (14 bytes) except the type byte: `XX 01 00 00 02 E0 01 00 00 00 3C 64 00 00`

### Event Type Discovery (Major Finding)
See "Event Type Selection" section above. The key result: **five distinct event types** observed in device-written data (0x1E, 0x1F, 0x20, 0x21, 0x25). The device writes different types per engine, but subsequent device testing proved that for **authoring**, event type selection depends on track slot position, not engine: T1 → 0x25 only, T2+ → 0x21 universally.

### Event Insertion Strategies (Deep Decode Finding)
Two distinct strategies observed for how events are placed in track bodies:

1. **Pure-append** (6 of 8 tracks: T1, T3, T5, T6, T7, T8): Event bytes appear at the very end of the track body, after the patch name null terminators. Zero interior byte changes. This is the simple case our writer handles.

2. **Mid-body modifications** (2 of 8 tracks):
   - **Track 2 (Drum phase)**: 5-byte insertion in sample metadata at data offset ~0x0150. Bytes `02 22 56 00 00` inserted, shifting the entire sample path table by 5 bytes. The event itself is still appended at the end. Likely firmware updating an internal sample-table pointer or counter.
   - **Track 4 (EPiano/Pluck)**: Event inserted **before** a 47-byte tail pointer section, not at the end. The tail data shifts forward by 14 bytes (event size). First byte of the tail changes from 0x28 to 0x08 (delta -0x20). This tail section may contain patch-related pointer data that must follow a specific structure.

**Implication for authoring**: Pure-append works for most engines. Drum tracks with sample paths and EPiano tracks may require more careful insertion logic if firmware expects specific layout.

### Pre-track MIDI Config Structure (Deep Decode Finding)
When MIDI channels are assigned to tracks, the pre-track header grows:
- Byte 0x23 (entry size): 12 → 13 bytes per entry
- 4 entries × 13 = 52 bytes total (was 4 × 12 = 48, net +4 per entry but only some entries grow)
- Total pre-track growth: +7 bytes
- Channel assignments `01 02 03 04 05 06 07` embedded in the config entries
- Handle table values at 0x58-0x7B are identical, just shifted by 7 bytes

### Preamble 0x64 Behavior in Multi-Track Recording
**unnamed 93** (all 8 tracks activated, contiguous):
- T1: keeps original 0xD6 (first activated)
- T2-T4: all get 0x64
- **T5: keeps original 0x2E** — T5 is exempt from 0x64 rule
- T6-T8: all get 0x64
- T9: gets 0x64 (first unmodified after chain)

**unnamed 94** (T1/T3/T5/T7 activated, non-contiguous, T3→Wavetable, T5→Drum):
- T1: keeps original 0xD6 (activated)
- T2: gets 0x64 (follows activated T1, itself NOT activated)
- T3: keeps original 0x86 (activated)
- T4: gets 0x64 (follows activated T3, not activated)
- **T5: keeps original 0x2E** (activated, follows non-activated T4)
- T6: gets 0x64 (follows activated T5)
- T7: keeps original 0x83 (activated)
- T8: gets 0x64 (follows activated T7)
- T9-T16: unchanged

**T5 anomaly is consistent**: T5 keeps 0x2E regardless of whether T4 is activated (unnamed 93) or not (unnamed 94), and regardless of T5's engine (Dissolve in 93, Drum in 94). This is a **slot-specific** exemption — T5 never gets 0x64. Setting T5 to 0x64 crashes the device (Crash #6).

## unnamed 94 — MIDI Harness Experiment (Non-Contiguous Tracks + Engine Changes)

### Method
Used `tools/midi_harness.py` experiment `selective_multi_note` to send controlled MIDI data to 4 non-contiguous tracks (T1, T3, T5, T7). Before recording, user manually changed engines: T3 from Prism to Wavetable, T5 from Dissolve to Drum (empty sampler). T1 (Drum) and T7 (Axis) kept defaults.

**Events sent via MIDI**:
- T1 (ch1, Drum): C4 at step 1 + D4 at step 5, velocity 100, 1-step gate
- T3 (ch3, Wavetable): C4+E4+G4 chord at step 1, velocity 100, 1-step gate
- T5 (ch5, Drum): C4 at step 1, velocity 50, 1-step gate
- T7 (ch7, Axis): E4 at step 9, velocity 100, 4-step hold

### Structural Findings
- **File size**: 9568 bytes (baseline 9499, +69 bytes)
- **Pre-track**: 131 bytes (+7 from baseline, same growth as unnamed 93 — MIDI config)
- **4 of 8 instrument tracks activated** (type 0x05 → 0x07): T1, T3, T5, T7
- **Non-activated tracks** (T2, T4, T6, T8) kept type 0x05 but preamble changed to 0x64
- Engine changes visible in body: T3 engine_id 0x12→0x1F (Wavetable), T5 engine_id 0x14→0x03 (Drum)
- T3 and T5 bodies had ~150+ interior byte changes due to engine change (params, preset name)
- T1 and T7 had only 1 interior diff (type byte 05→07) — pure append

### Event Type Findings (Major Update)

| Track | Engine | Event Type | Count | Notes |
|-------|--------|------------|-------|-------|
| T1 | 0x03 Drum | 0x25 | 2 | Multi-note confirmed for 0x25 |
| T3 | 0x1F Wavetable | 0x2D | 3 | NEW: Wavetable uses 0x2D (chord) |
| T5 | 0x03 Drum | 0x2D | 1 | Drum on non-default slot uses 0x2D |
| T7 | 0x16 Axis | 0x20 | 1 | Confirmed Axis type |

**Key finding: 0x2D follows engine, not slot**. Both Wavetable (T3) and Drum (T5, changed from Dissolve) produce 0x2D. In unnamed 93, T5 had Dissolve engine and produced 0x21 — now with Drum engine it produces 0x2D. The device WRITES engine-specific types; the discrepancy with unnamed 93's T2 (Drum→0x21) may be a T2-specific exception or a first-vs-changed-engine distinction.

### Multi-Note 0x25 Confirmation (T1)
T1 produced a single `0x25` event with count=2 containing both notes:
- Note 1: tick=0 (step 1), C4 (0x3C), velocity=100 (0x64), gate=480t explicit
- Note 2: tick=1920 (step 5), D4 (0x3E), velocity=100 (0x64), gate=480t explicit

This confirms multi-note 0x25 events are valid and matches our builder's approach.

### Chord Encoding Discovery (Major New Finding — T3)

T3 produced event type `0x2D` with count=3 for a C4+E4+G4 chord:

```
2d 03 00 00 04 e0 01 00 00 00 43 64 00 00
               └─ flag 0x04!  └─ G4 (67)
00 04 e0 01 00 40 64 00 00
   └─ flag 0x04  └─ E4 (64)
00 04 e0 01 00 3c 64 00 00
   └─ flag 0x04  └─ C4 (60)
```

**Flag byte 0x04 = chord continuation**: When multiple notes share the same tick, notes after the first use flag 0x04. When flag=0x04, **no tick field is emitted** — the note inherits the tick from the previous note. This is a compact encoding for chords.

**Chord note ordering**: Notes stored **HIGH-TO-LOW** (G4→E4→C4), despite being sent as C4→E4→G4 via MIDI.

**Separator bytes**:
- 3 bytes (`00 00 00`) before notes at new ticks
- 2 bytes (`00 00`) before continuation notes (flag 0x04) and after last note

### Two Distinct Chord Encodings (Cross-Reference with unnamed 80)

Grid-entered chords (unnamed 80) and MIDI-recorded chords (unnamed 94) use **different** encodings:

| Feature | Grid-entered (unnamed 80) | MIDI-recorded (unnamed 94) |
|---------|--------------------------|---------------------------|
| Flag byte | 0x00 for all notes | 0x04 for continuation notes |
| Tick field | Compact tick (flag 0x00/0x01) repeated per note | Omitted for continuation notes |
| Note ordering | Low-to-high (C4→F4→G4→A4) | High-to-low (G4→E4→C4) |
| Separator before continuation | 3 bytes (00 00 00) | 2 bytes (00 00) |
| Event type | 0x25 | 0x2D |

Both formats are device-generated and accepted by firmware. The grid format is more verbose (repeats tick for each note); the MIDI format is compact (uses flag 0x04 to skip tick).

**Note**: unnamed 80 step-9 E4 was originally parsed as tick=3841 (expected 3840). This was a **parsing error** caused by reading `01 0F` as a 4-byte u32 LE value (0x0F01 = 3841). The correct interpretation uses variable-length tick encoding: escape byte (0x01) + tick_hi (0x0F) = tick 0x0F00 = 3840 exactly. See "Variable-Length Tick Encoding" under unnamed 101.

### Velocity and Gate Fidelity
- **Velocity maps 1:1**: Sent vel=50 to T5, got 0x32 (50) in file. Perfect fidelity.
- **Tick encoding verified**: Step 9 = tick 3840 (8 × 480), perfectly encoded on T7.
- **Gate encoding verified**: 4-step hold = 1920 ticks (4 × 480), perfectly encoded on T7.
- All MIDI-recorded notes get **explicit gate** (not the 0xF0 default marker).

### Builder Impact
Our `build_event()` emits chord notes with `flag=0x02` and tick=0, which differs from both the MIDI format (flag=0x04, no tick field) and grid format (flag=0x00, repeated tick_u32). **Device-verified working**: test_A (pure chord on T3), test_E (chord on T1), test_F (chord+melody mix on T3) all load and play correctly. The firmware accepts all three chord encoding variants.

## unnamed 101 — 4-Bar Drum + Bass (First Multi-Bar Test)

### Method
Used `tools/midi_harness.py` experiment `4bar_drums_bass` with `--post-roll 0` (384 MIDI clocks = exactly 4 bars). T1 (ch1, Drum) and T3 (ch3, Prism) both extended to 4 bars on device before recording. 120 BPM.

### Bar Count Field (DECODED)

**Location**: Preamble byte 2 of each track's 4-byte preamble word.

```
Preamble word (4 bytes LE):
  [byte 0]  [byte 1]  [byte 2]       [byte 3]
   ptr_lo    ptr_hi    bar_steps       0xF0 (tag)
```

**Formula**: `bar_count = preamble[2] >> 4`

| Bars | Byte 2 | Steps |
|------|--------|-------|
| 1 | 0x10 | 16 |
| 2 | 0x20 | 32 |
| 3 | 0x30 | 48 |
| 4 | 0x40 | 64 |

Verified across unnamed 1 (1 bar), 17 (2 bars), 18 (3 bars), 19 (4 bars), and 101 (4 bars on T1+T3). 100% match across all 1408 track blocks in the corpus.

**Key properties**:
- Per-track (each track has independent bar count)
- Range: 1-4 bars (low nibble of byte 2 always 0)
- Changing bar count on the device triggers type 05→07 conversion (even without adding notes)
- `container.py` now exposes `TrackBlock.bar_count` property
- `project_builder.py` auto-sets bar count from the maximum step in the note list

### Structural Findings (Byte-Level)

| Track | Preamble (base→test) | Body Size | Type | Bars | Change |
|-------|----------------------|-----------|------|------|--------|
| T1 | `d60110f0`→`d60140f0` | 1832→2513 (+681) | 05→07 | 1→4 | 48 drum notes added |
| T2 | `8a0110f0`→`640110f0` | 1792 (unchanged) | 05 | 1 | Preamble byte 0 only |
| T3 | `860110f0`→`860140f0` | 419→649 (+230) | 05→07 | 1→4 | 16 bass notes added |
| T4 | `860110f0`→`640110f0` | 490 (unchanged) | 05 | 1 | Preamble byte 0 only |
| T5-T16 | unchanged | unchanged | 05 | 1 | — |

- **File size**: 9,499 → 10,410 (+911 bytes)
- **Pre-track region**: 124 bytes, identical
- **T2, T4**: preamble byte 0 changed to 0x64 (follows activated tracks; T5 exempt as previously seen)
- **Type 05→07 on T1, T3**: body[9] changed, 2-byte padding (`08 00`) at body[10:12] removed, all downstream bytes shifted by -2
- **unnamed 19 comparison** (4-bar, no notes): only T1 changed — preamble bar count 1→4, type 05→07, body shrinks by 2 bytes (padding removal only, no notes added). Confirms the type conversion is triggered by bar count change, not by note insertion.

### Variable-Length Tick Encoding (MAJOR DISCOVERY)

The device firmware uses a **compact, variable-length tick encoding** — NOT the 4-byte u32 LE format we assumed. A flag/separator byte determines the tick field width:

```
Per-note record layout:

FIRST NOTE (flag=0x02, tick always 0):
  [00 00] [02] [gate...] [00 00 00] [note] [vel] [00 00]
  tick: 2-byte u16 LE (always 0x0000)
  No pad between flag and gate

CHORD CONTINUATION (flag=0x04, same tick as previous note):
  [04] [gate...] [note] [vel] [00 00]
  No tick field at all (inherits previous tick)

NORMAL NOTE, tick_lo != 0x00 (flag=0x00):
  [00] [tick_lo] [tick_hi] [00 00 00] [gate...] [00 00 00] [note] [vel] [00 00]
  0x00 = separator, tick = u16 LE in next 2 bytes

NORMAL NOTE, tick_lo == 0x00 (flag=0x01, escape):
  [01] [tick_hi] [00 00 00] [gate...] [00 00 00] [note] [vel] [00 00]
  0x01 = escape (tick_lo implicitly 0x00), saves 1 byte
  tick = tick_hi << 8
```

**Why the escape**: `0x00` is reserved as the inter-note separator, so when a tick's low byte would naturally be `0x00` (happens every 256 ticks, i.e. every 8th step for grid-quantized notes at 480 ticks/step), the format uses `0x01` as an escape byte and encodes only the high byte. This avoids ambiguity with the separator and saves 1 byte.

**Flag byte summary**:

| Flag | Meaning | Tick Field | Occurs When |
|------|---------|------------|-------------|
| `0x00` | Separator + 2-byte tick | `[tick_lo] [tick_hi]` (u16 LE) | `tick & 0xFF != 0` |
| `0x01` | Escape + 1-byte tick | `[tick_hi]` (lo implied 0) | `tick & 0xFF == 0` and `tick > 0` |
| `0x02` | First note marker | `[00 00]` (preceding, always 0) | First note only |
| `0x04` | Chord continuation | (none, inherits prev) | Same tick as previous note |

**Note record sizes** (bytes, including leading separator from previous note):

| Format | Default Gate (F0) | Explicit Gate (E0) |
|--------|------------------|--------------------|
| First note (0x02) | 11 | 12 |
| Chord (0x04) | 9 | 10 |
| Normal, flag=0x00 | 14 | 15 |
| Normal, flag=0x01 | 13 | 14 |

Final note followed by 2-byte trail (`00 00`).

### Gate Encoding (Refined)

Two gate formats observed:

| Gate Bytes | Size | Meaning |
|-----------|------|---------|
| `F0 00 00 01` | 4 bytes | Default/standard gate (firmware default duration) |
| `[gate_u16 LE] 00 00 00` | 5 bytes | Explicit gate in ticks (e.g., `E0 01 00 00 00` = 480 ticks = 1 step) |

The gate field in native encoding is **u16 LE** (not u32 LE as in our builder). Observed values: 480 (1 step), 960 (2 steps), 1920 (4 steps). The 3 trailing zero bytes after the u16 gate may be padding or reserved fields.

**Note**: Our builder uses u32 LE explicit gates (`[gate_u32 LE] 00`), which is also accepted by firmware. The native format appears to use u16 LE for the gate value.

### T1 Decode: 48 Notes (0x25 Event)

Event at body offset `0x072B`, 678 bytes total (header `25 30` + 676 data bytes).

Bars 1-3 repeat a steady pattern; bar 4 is a fill with solo snare crescendo.

| # | Tick | Step | Bar.Step | Flag | Gate | Note | Vel |
|---|------|------|----------|------|------|------|-----|
| 0 | 0 | 0 | 1.1 | 0x02 | F0 def | G#3 | 70 |
| 1 | 0 | 0 | 1.1 | 0x04 | E0 480t | C3 | 120 |
| 2 | 960 | 2 | 1.3 | 0x00 | F0 def | G#3 | 70 |
| 3 | 1920 | 4 | 1.5 | 0x00 | F0 def | A#3 | 80 |
| 4 | 1920 | 4 | 1.5 | 0x00 | E0 480t | D3 | 110 |
| 5 | 2880 | 6 | 1.7 | 0x00 | F0 def | G#3 | 70 |
| 6 | 3840 | 8 | 1.9 | **0x01** | F0 def | G#3 | 70 |
| 7 | 3840 | 8 | 1.9 | **0x01** | E0 480t | C3 | 110 |
| 8-11 | 4800-6720 | 10-14 | 1.11-1.15 | 0x00 | mixed | mixed | — |
| 12 | 7680 | 16 | 2.1 | **0x01** | F0 def | G#3 | 70 |
| 13 | 7680 | 16 | 2.1 | **0x01** | E0 480t | C3 | 120 |
| 14-23 | 8640-14400 | 18-30 | 2.3-2.15 | 0x00/0x01 | mixed | mixed | — |
| 24 | 15360 | 32 | 3.1 | **0x01** | F0 def | G#3 | 70 |
| 25 | 15360 | 32 | 3.1 | **0x01** | E0 480t | C3 | 120 |
| 26-35 | 16320-22080 | 34-46 | 3.3-3.15 | 0x00/0x01 | mixed | mixed | — |
| 36 | 23040 | 48 | 4.1 | **0x01** | E0 480t | C3 | 120 |
| 37 | 24000 | 50 | 4.3 | 0x00 | E0 480t | C3 | 100 |
| 38 | 24960 | 52 | 4.5 | 0x00 | E0 480t | D3 | 110 |
| 39 | 25920 | 54 | 4.7 | 0x00 | E0 480t | D3 | 100 |
| 40 | 26880 | 56 | 4.9 | **0x01** | E0 480t | D3 | 105 |
| 41 | 27360 | 57 | 4.10 | 0x00 | E0 480t | D3 | 100 |
| 42 | 27840 | 58 | 4.11 | 0x00 | E0 480t | D3 | 110 |
| 43 | 28320 | 59 | 4.12 | 0x00 | E0 480t | D3 | 105 |
| 44 | 28800 | 60 | 4.13 | 0x00 | E0 480t | D3 | 115 |
| 45 | 29280 | 61 | 4.14 | 0x00 | E0 480t | D3 | 110 |
| 46 | 29760 | 62 | 4.15 | 0x00 | E0 480t | D3 | 120 |
| 47 | 30240 | 63 | 4.16 | 0x00 | E0 480t | D3 | 127 |

Notes by pitch: G#3 (0x38) = 18, D3 (0x32) = 16, C3 (0x30) = 8, A#3 (0x3A) = 6.
Gate types: F0 default = 24 notes, E0 explicit = 24 notes.
Tick encoding: flag=0x00 (34 notes), flag=0x01 (12 notes), flag=0x02 (1), flag=0x04 (1).
All 48 ticks are exact multiples of 480 — zero drift, zero anomalies.

### T3 Decode: 16 Notes (0x21 Event)

Event at body offset `0x01A1`, 232 bytes total (header `21 10` + 230 data bytes).

C minor bass line across 4 bars, one note every 4 steps with 2-step gates (except bars 2/4 endings).

| # | Tick | Step | Bar.Step | Flag | Gate (ticks) | Note | Vel |
|---|------|------|----------|------|-------------|------|-----|
| 1 | 0 | 0 | 1.1 | 0x02 | 960 (2 steps) | C2 | 100 |
| 2 | 1920 | 4 | 1.5 | 0x00 | 960 | C2 | 95 |
| 3 | 3840 | 8 | 1.9 | **0x01** | 960 | G2 | 100 |
| 4 | 5760 | 12 | 1.13 | 0x00 | 960 | F2 | 95 |
| 5 | 7680 | 16 | 2.1 | **0x01** | 960 | D#2 | 100 |
| 6 | 9600 | 20 | 2.5 | 0x00 | 960 | D2 | 95 |
| 7 | 11520 | 24 | 2.9 | **0x01** | 1920 (4 steps) | C2 | 100 |
| 8 | 15360 | 32 | 3.1 | **0x01** | 480 (1 step) | C2 | 100 |
| 9 | 16320 | 34 | 3.3 | 0x00 | 480 | C2 | 80 |
| 10 | 17280 | 36 | 3.5 | 0x00 | 960 | G2 | 100 |
| 11 | 19200 | 40 | 3.9 | **0x01** | 960 | F2 | 95 |
| 12 | 21120 | 44 | 3.13 | 0x00 | 960 | D#2 | 100 |
| 13 | 23040 | 48 | 4.1 | **0x01** | 960 | C2 | 100 |
| 14 | 24960 | 52 | 4.5 | 0x00 | 960 | D2 | 95 |
| 15 | 26880 | 56 | 4.9 | **0x01** | 960 | D#2 | 100 |
| 16 | 28800 | 60 | 4.13 | 0x00 | 1920 (4 steps) | G2 | 110 |

Gate encoding here is u16 LE (not the `F0 00 00 01` default marker). All gates are explicit.
Flag=0x01 at steps 8, 16, 24, 32, 40, 48, 56 — exactly every 8th step where `tick % 256 == 0`.
All 16 ticks are exact multiples of 480.
230 data bytes consumed + 2-byte trailing pad = 232, zero leftover.

### Tick +1 Anomaly — RESOLVED (Was a Parsing Error)

The previously reported "+1 tick at 8-step boundaries" (step 9 = tick 3841, step 17 = tick 7681) was **not a real anomaly**. It was caused by reading the bytes `01 0F` as a 4-byte u32 LE value:

```
Incorrect parse:  01 0F 00 00 → u32 LE → 0x00000F01 = 3841
Correct parse:    01 = escape flag (tick_lo is 0x00)
                  0F = tick_hi
                  tick = 0x0F << 8 = 0x0F00 = 3840 ✓
```

Every tick in both the T1 (48-note) and T3 (16-note) events resolves to an exact multiple of 480 under the variable-length encoding. There is no MIDI timing drift, no clock jitter, and no +1 artifact.

### Builder Compatibility

Our `build_event()` uses 4-byte u32 LE ticks and u32 LE explicit gates, which is **different from the native encoding** but is accepted by firmware. Device-verified files (`arrange_full.xy`, etc.) use our verbose format and load/play correctly. Matching the native compact encoding is a future optimization, not a correctness issue.

### Engineering Rationale (C++ Analysis)

The flag values `0x00`, `0x01`, `0x02`, `0x04` are powers of two — a classic C++ bit-flag enum:

```c++
enum NoteFlag : uint8_t {
    TICK_FULL   = 0x00,  // 2-byte u16 LE tick follows
    TICK_HI     = 0x01,  // 1-byte tick_hi only (lo == 0)
    TICK_ZERO   = 0x02,  // tick is 0, no data
    CHORD       = 0x04,  // inherit previous tick, no data
};
```

The deserialization is a textbook `if/else` chain:

```c++
uint16_t tick;
if (flag & TICK_ZERO)     tick = 0;
else if (flag & CHORD)    tick = prev_tick;
else if (flag & TICK_HI)  tick = (uint16_t)buf.read_u8() << 8;
else                      tick = buf.read_u16_le();
```

**Why u16 is sufficient**: max tick = 63 × 480 = 30,240 (4-bar pattern, 64 steps), well within u16 range.

**Why bother with the 0x01 escape**: The savings are small (~1 byte per note at 8-step boundaries, max ~8 bytes per 4-bar pattern). The likely motivation is the `fixed_vector` buffer — we've seen `fixed_vector.h:77` crashes twice (Crash #2, #7), indicating patterns are loaded into fixed-capacity RAM buffers for real-time playback. On an embedded ARM chip, SRAM is scarce. The serialized event format may BE the runtime format (no conversion on load), so every byte directly reduces headroom. The compact encoding ensures 120-note patterns fit within the buffer.

**Why our verbose format works**: The firmware parser is tolerant (Postel's law — accept liberally), but the serializer always writes the tightest encoding. Our extra 1-2 bytes per note from u32 ticks eat into headroom but don't overflow for the note counts tested (up to 129 notes across 5 tracks).

**Why 0x00 needs the escape**: `0x00` serves double duty as both the inter-note separator byte and the "full tick follows" flag. When a tick's low byte is naturally `0x00` (every 256 ticks = every 8th step), the separator and tick_lo would be ambiguous. The `0x01` escape resolves this: it signals "tick_lo is zero, only tick_hi follows."

### unnamed 3 — Compact Live-Recorded Tick Anomaly

unnamed 3 is a live-recorded C-E-G triad on Track 1, step 1. The event (`25 03`) appends 38 bytes to the body. Notes 0 and 1 parse cleanly under the standard encoding. **Note 2 (E4, vel=103) is 1 byte shorter than expected** (14 bytes instead of 15 for a standard flag=0x00 note with explicit gate).

Byte-level analysis of note 2:
- Gate: `dc 16 00 00 00` = u32_LE(5852 ticks), explicit gate ✓
- Note+vel: `40 67` = E4 (64), vel 103 ✓
- Tick area: 4 bytes where standard flag=0x00 would need 5 (flag + u16 tick)
- Bytes at tick position: `05 00 00 01` — the `01` could be a flag=0x01 escape, but then tick = 5 << 8 = 1280 ticks (2.67 steps), which is too large for a note that should be near step 1 in a live chord

**Best hypothesis**: For very small ticks from live performance (tick < 256), the encoding may use a compact form we haven't fully decoded. Only 1 instance in the entire corpus. The `near_chord` MIDI harness experiment (notes at step 1 + step 2, close but not simultaneous) is designed to produce more examples of small-tick encoding to resolve this.

### Pending MIDI Harness Experiments (Tick/Chord Encoding)

Three experiments staged in `tools/midi_harness.py`, ready for device testing:

1. **`disc01_sequential`**: 4 sequential notes at steps 1/5/9/13 on T3 (ch3, Prism). Step 9 (tick 3840 = 15×256) should produce flag=0x01 encoding. Confirms the escape byte behavior with known ground truth.

2. **`chord_variants`**: Mixed chords and singles on T3 — triad (C4+E4+G4) at step 1, single (A4) at step 5, dyad (C4+E4) at step 9, single (G4) at step 13. Tests flag=0x04 chord continuation, flag=0x01 at step 9, and transitions between chord/sequential encoding within one event.

3. **`near_chord`**: C4+G4 chord at step 1, E4 solo at step 2 on T3. Tests the boundary between chord encoding (flag=0x04) and sequential encoding when notes are temporally close but not simultaneous. Should produce a small-tick sequential note (~480 ticks) that clarifies the unnamed 3 anomaly.

## Multi-Pattern Storage Model (DECODED — unnamed 102-105)

Addendum (2026-02-12): `j06_all16_p9_blank` / `j07_all16_p9_sparsemap` follow the same block-rotation + overflow mechanism, but at much larger scale (80 logical entries in currently decoded rotation space). The core mechanism below remains valid; do not assume the early `unnamed 102-105` pre-track descriptor formulas generalize to every topology.

### Core Mechanism: Block Rotation

The OP-XY stores multiple patterns by **cloning track blocks and inserting them inline**. The file always contains exactly 16 block slots. When patterns are added to a track, clone blocks are inserted immediately after the leader block for that track, pushing all subsequent blocks down. Displaced blocks that fall off the end are concatenated into block 15 as sub-blocks with embedded preambles.

```
Baseline (1 pattern each):
  [T1] [T2] [T3] [T4] ... [T14] [T15] [T16]

T1 has 2 patterns (unnamed 102/103):
  [T1p1] [T1p2] [T2] [T3] [T4] ... [T14] [T15+T16]

T1 has 3 patterns (unnamed 104):
  [T1p1] [T1p2] [T1p3] [T2] [T3] ... [T13] [T14+T15+T16]

T1 AND T3 have 2 patterns each (unnamed 105):
  [T1p1] [T1p2] [T2] [T3p1] [T3p2] [T4] ... [T13] [T14+T15+T16]
```

### Preamble Word Encoding

The 4-byte preamble `[byte0] [byte1] [byte2] [0xF0]` encodes pattern metadata:

**Leader blocks** (first block of a track group):
- `byte[0]`: changes from baseline value when patterns added (e.g., T1: `0xD6` → `0xB5`)
- `byte[1]`: **pattern count** for this track (1=single, 2=two patterns, 3=three)
- `byte[2]`: bar count (`0x10`=1 bar, `0x40`=4 bars)

**Clone blocks** (additional pattern slots):
- `byte[0]`: always `0x00` -- distinguishing mark of a clone block
- `byte[1]`: if preceding block is activated (type 0x07), fold to `0x64` only for the high-bit clone family (`0x8A/0x86/0x85/0x83` observed). Keep low-byte families (notably `0x2E`, Track-4 chain) unchanged; otherwise use the baseline `byte[0]` of the next track in the original layout.
- `byte[2]`: `0x10` (1 bar default)

**Adjacent-track sentinel**: the block immediately after a clone group gets `byte[0]=0x64` (same rule as note activation, T5 exempt).

| File | Block 0 (leader) | Block 1 (clone/T2) | Pattern count |
|------|-------------------|---------------------|---------------|
| baseline | `D6 01 10 F0` | `8A 01 10 F0` (T2) | 1 |
| unnamed 6 | `B5 02 10 F0` | `00 8A 10 F0` (clone) | 2 (blank patterns, T1 not activated) |
| unnamed 7 | `B5 03 10 F0` | `00 8A 10 F0` (clone) | 3 (blank patterns, T1 not activated) |
| unnamed 102 | `B5 02 10 F0` | `00 8A 10 F0` (clone) | 2 (T1 not activated, notes only in pat2) |
| unnamed 103 | `B5 02 10 F0` | `00 64 10 F0` (clone) | 2 (T1 activated with notes, clone gets 0x64) |
| unnamed 104 | `B5 03 10 F0` | `00 64 10 F0` (clone) | 3 (T1 activated, pat2 blank, pat3 has notes) |
| unnamed 105 | `B5 02 10 F0` | `00 64 10 F0` (clone) | 2 (T1+T3 each have 2 patterns) |

### Pre-Track Pattern Directory

> Legacy note: the rules in this subsection were derived from the early T1/T1+T3 corpus and are still valid for those captures, but `j01`-`j05` prove the descriptor area is not globally fixed at `0x58` and `0x56-0x57` is not always a stable LE `pattern_max_slot` field.

When patterns > 1, the pre-track region grows:

**Offset 0x56-0x57**: `pattern_max_slot` (u16 LE, 0-based). Value 0=1 pattern, 1=2 patterns, 2=3 patterns.

**Offset 0x58+**: 5-byte pattern descriptor inserted once when going from 1→2+ patterns:
- Single-track multi-pattern: `00 1D 01 00 00` (5 bytes, pre-track grows by 5)
- Two-track multi-pattern (unnamed 105): `01 00 00 1B 01 00 00` + 2 extra bytes (pre-track grows by 7)

The handle table shifts rightward by the inserted bytes.

### Type Byte and Notes

| Type | Padding | Meaning |
|------|---------|---------|
| `0x05` | 2 bytes (`08 00`) | Default/blank pattern (no notes) |
| `0x07` | none | Pattern with note event data |

- Blank pattern clones retain type `0x05` (unnamed 104, block 1)
- Pattern clones with notes get type `0x07` (padding removed, event appended)
- Leader blocks with notes also get type `0x07`

### Block 15 Overflow (T16 Absorption)

Displaced blocks are concatenated into block 15 with their preambles embedded inline:

```
Block 15 body = [T(N).body] [T(N+1).preamble] [T(N+1).body] [T(N+2).preamble] [T(N+2).body] ...
```

Size accounting (verified byte-exact):
- unnamed 102/103 (1 clone): T15 body (346) + T16 preamble (4) + T16 body (403) = **753 bytes**
- unnamed 104/105 (2 clones): T14 body (333) + T15 preamble (4) + T15 body (346) + T16 preamble (4) + T16 body (403) = **1,090 bytes**

### Leader Body Changes

When patterns are added, the leader block's body:
1. Loses exactly **1 trailing `0x00` byte** (1832 → 1831 for T1, 419 → 418 for T3)
2. Gets type 0x07 if it contains notes (padding removed: net -3 bytes for body with notes)
3. Body content within shared range is otherwise identical to baseline

### Note Events in Pattern Clones

Notes are appended at the tail of the clone block body, using the same event format as single-pattern tracks:

**unnamed 102** — T1 pattern 2, C4 at step 9 (0x25 event):
```
25 01 00 0F 00 00 00 F0 00 00 01 3C 64 00 00
```

**unnamed 103** — T1 pattern 1, C4 at step 1 / pattern 2, E4 at step 9:
- Block 0: `25 01 00 00 02 F0 00 00 01 3C 64 00` (C4 step 1)
- Block 1: `25 01 00 0F 00 00 00 F0 00 00 01 40 64 00 00` (E4 step 9)

**unnamed 105** — T1 pat2 C4 step 1 (0x25) / T3 pat2 E3 step 2 (0x21):
- Block 1: `25 01 00 00 02 F0 00 00 01 3C 64 00 00` (C4 step 1, drum)
- Block 4: `21 01 E0 01 00 00 00 F0 00 00 01 34 64 00 00` (E3 step 2, Prism)

### Implications for Authoring

To write a multi-pattern project:
1. Clone the leader track block (minus 1 trailing zero byte)
2. Set leader `preamble[1]` = pattern count
3. Set leader `preamble[0]` = `0xB5` (for T1; other tracks TBD)
4. Set clone `preamble[0]` = `0x00`
5. Set clone `preamble[1]` = baseline `preamble[0]` of next track
6. Insert clone blocks immediately after leader, push all subsequent blocks down
7. Concatenate displaced blocks into block 15 with embedded preambles
8. Update pre-track `[0x56]` = pattern_max_slot
9. Insert 5-byte descriptor at `0x58` (+ 2 bytes per additional track with patterns)
10. Activate clone bodies (type 05→07, remove padding) and append note events

This recipe is valid for the legacy `unnamed 102-105` family only. For broader/non-`T1` topologies, use device-authored scaffolds (`j01`-`j05`) and treat descriptor bytes as topology-specific until the generalized encoding is decoded.

## Multi-Bar Authoring (DEVICE-VERIFIED WORKING)

### First Working 5-Track, 4-Bar Arrangement

`output/arrange_full.xy`: 129 notes across 5 tracks, 4 bars, key of A minor (Am | F | Dm | E). **CONFIRMED WORKING ON DEVICE.**

| Track | Engine | Event Type | Notes | Description |
|-------|--------|-----------|-------|-------------|
| T1 | Drum (0x03) | 0x25 | 30 | Kick+snare groove, fill bar 4 |
| T2 | Drum (0x03) | 0x21 | 36 | 8th-note hats, 16ths in fill |
| T3 | Prism (0x12) | 0x21 | 19 | Root-fifth bass movement |
| T4 | EPiano (0x07) | 0x1F | 20 | Singable melody with arc |
| T7 | Axis (0x16) | 0x20 | 24 | Sustained pad triads (chords) |

Individual track files also verified: `arrange_drums.xy`, `arrange_bass.xy`, `arrange_melody.xy`, `arrange_chords.xy`.

### Two Key Discoveries Required for Multi-Bar

#### 1. Pattern Length Field (preamble[2])

The track preamble byte at position 2 controls how many bars the sequencer plays. Without setting this, notes beyond step 16 are silently ignored (the sequencer only loops 1 bar).

```
Default: preamble[2] = 0x10 (1 bar, 16 steps)
         preamble[2] = 0x20 (2 bars, 32 steps)
         preamble[2] = 0x30 (3 bars, 48 steps)
         preamble[2] = 0x40 (4 bars, 64 steps)

Formula: preamble[2] = ceil(max_step / 16) * 16
```

**Verification path**: unnamed 17/18/19 (bar-length-only changes) confirmed the byte position. unnamed 101 (4-bar drum+bass created on device) confirmed byte-for-byte match with our generated files. The `project_builder` now auto-calculates this from the maximum step in the note list.

**Diagnostic history**: Initial 4-bar files had preamble[2]=0x10 (default). T3 bass loaded but only played 1 bar. T1 drums crashed because the firmware validates notes against the declared bar count for 0x25 events.

#### 2. Firmware Bug: note==velocity Crash

**The firmware crashes when any note's MIDI note byte equals its velocity byte.**

```
note=50, vel=50  (0x32 0x32) → CRASH
note=65, vel=65  (0x41 0x41) → CRASH
note=50, vel=51  (0x32 0x33) → works
note=48, vel=50  (0x30 0x32) → works
```

Confirmed with isolated tests: even a single note with note==velocity at step 1 crashes the device. The crash is independent of bar count, note count, step position, or event type (tested on 0x25).

**Fix**: `build_event()` nudges velocity by +1 when it would equal the note number (or -1 if at 127). A 1-unit velocity change is musically imperceptible.

**Diagnostic history**: This bug was particularly hard to isolate because it masqueraded as a bar-count or note-count issue. The arrangement happened to have SNARE(50) at velocity 50 in bar 2, so it looked like multi-bar patterns were broken. The isolation process:
1. All 2-bar arrangement files crashed → hypothesized tick range issue
2. Single notes at any step worked → not the tick range
3. 20 consecutive notes at steps 1-20 worked → not the note count
4. Same steps with uniform note/velocity worked → narrowed to note content
5. Mixed notes with uniform velocity worked → not MIDI note mixing
6. Uniform notes with varied velocity worked → not velocity variation alone
7. Incrementally adding notes found crash at note[10] (SNARE=50, vel=50) → found the collision

### Complete Multi-Bar Authoring Recipe

To write a multi-bar pattern to a track:

1. **Activate body**: Flip type byte 0x05→0x07, remove 2-byte padding at body[10:12]
2. **Set bar count**: Set preamble[2] = `ceil(max_step / 16) * 16`
3. **Build event**: Encode notes with `build_event()` (auto-avoids note==velocity)
4. **Insert event**:
   - Most tracks: append event blob at end of body
   - T4 (EPiano/Pluck, engine 0x07): insert before 47-byte tail, clear bit 5 of marker
5. **Update preamble sentinels**: Set preamble[0]=0x64 on the track after each activated track (except T5 which is exempt)

All of this is handled by `append_notes_to_tracks()` in `project_builder.py`.

## Multi-Pattern Storage (unnamed 6, 7) -- MERGED

**This section has been merged into "Multi-Pattern Storage Model (DECODED)" above.** All findings from unnamed 6/7 binary diffs (block rotation, overflow mechanism, pre-track changes, preamble behavior) are now documented in the consolidated section along with unnamed 102-105 data. The preamble table includes unnamed 6/7 rows.

## Performance Controller Automation Format (DECODED — unnamed 106-109)

### Background

MIDI CC automation (CC7, CC10, CC12, CC20-23, CC32, CC33) is NOT recorded by the OP-XY (unnamed 95-100 confirmed: only note events stored). However, three "special" performance controllers ARE recorded as rich keyframe automation data:

- **Pitchbend** (confirmed in unnamed 39, decoded in unnamed 108)
- **Channel Aftertouch** (decoded in unnamed 107)
- **Modwheel (CC1)** (decoded in unnamed 106, 109)

### Method

Used `tools/midi_harness.py` experiments to send precisely-timed performance controller ramps (0->127 over 16 steps) on Track 3 (ch3, Prism) with a sustained C4 note (16-step gate):

| File | Experiment | Controllers | Post-roll |
|------|-----------|-------------|-----------|
| unnamed 106 | `modwheel_sweep` | CC1 only | 0 |
| unnamed 107 | `aftertouch_sweep` | Channel AT only | 0 |
| unnamed 108 | `pitchbend_sweep` | PB only | 0 |
| unnamed 109 | `perf_all_sweep` | PB + AT + CC1 simultaneously | 0 |

### Extraction Method

All automation data is appended to the T3 track body after the preset name string. Extraction anchored on the `bass\0/shoulder\0\0` preset string -- everything after it is the note event + automation blob.

Type-05 vs type-07 padding must be normalized: baseline T3 is type-05 (2-byte padding at body[10:12]); activated T3 is type-07 (no padding). Structural comparison strips the padding to align offsets.

### Note Event with Automation (Flag 0x03)

When a note carries automation data, the flag byte changes from `0x02` to `0x03`, and the gate encoding changes to a compact single-byte form:

```
[event_type:1B] [count:1B] [00 00] [03] [gate_hi:1B] [00 00 00] [note:1B] [vel:1B] [00 00]
```

- Flag `0x03` signals "first note + automation sections follow"
- Gate = `gate_hi << 8` ticks (e.g., `0x1E` = 7680 ticks = 16 steps)
- The 3-byte `00 00 00` after gate_hi replaces the normal gate encoding
- After the note+velocity+trailing bytes, automation sections follow immediately

Compared to flag `0x02` (notes only):
```
Flag 0x02: [00 00] [02] [gate: F0 00 00 01 or u32_LE 00] [note] [vel] [00 00]
Flag 0x03: [00 00] [03] [gate_hi] [00 00 00] [note] [vel] [00 00] [auto sections...]
```

### Automation Section Header

**First section** (7 bytes):
```
[type:1B] [count:1B] [init_val:u16LE] [sep:1B] [final_val:u16LE]
```

**Subsequent sections** (6 bytes, type byte omitted):
```
[count:1B] [init_val:u16LE] [sep:1B] [final_val:u16LE]
```

| Field | Size | Meaning |
|-------|------|---------|
| type | 1B | Controller type (first section only) |
| count | 1B | Total keyframe count including init (keyframes = count - 1) |
| init_val | u16 LE | Value at note start (tick 0) |
| sep | 1B | Separator (always 0x00) |
| final_val | u16 LE | Value at note end |

### Automation Type Bytes

| Type Byte | Controller |
|-----------|------------|
| `0x00` | Pitchbend |
| `0x01` | Modwheel (CC1) |
| `0x02` | Channel Aftertouch |

### Multi-Section Ordering

When multiple controllers are recorded simultaneously, sections appear in this order:
```
PB (0x00) -> AT (0x02) -> MW (0x01)
```

Only the first section has the type byte. Subsequent sections omit it (6-byte header vs 7-byte).

### Keyframe Format

After each section header, `count - 1` keyframes follow. Each keyframe is nominally 4 bytes:

```
[tick:u16LE] [value:u16LE]
```

**Variable-length escape**: When previous keyframe's `val_hi == 0x00` AND current `tick_lo == 0x00`, an extra `0x00` byte is inserted before the tick field. This is the same zero-byte ambiguity seen in note tick encoding -- `0x00` is the separator byte, so a `0x00 0x00` sequence (val_hi + tick_lo) would be misinterpreted as a section boundary.

Detection rule for parsing:
```python
if prev_val_hi == 0x00 and data[pos] == 0x00 and data[pos+1] == 0x00:
    pos += 1  # skip escape byte
```

This escape only triggers for AT/MW automation (where values < 256, so val_hi is always 0x00) at tick boundaries where tick_lo == 0x00 (e.g., tick=3840=0x0F00, tick=7680=0x1E00).

### Value Encoding

| Controller | MIDI Range | Stored Range | Formula | Verified |
|-----------|-----------|-------------|---------|----------|
| Pitchbend | 8192-16383 (center-max) | 0-8191 | `stored = midi_pb - 8192` | Exact match |
| Aftertouch | 0-127 | 0-254 | `stored = midi_val * 2` | Within +/-1 |
| Modwheel | 0-127 | 0-254 | `stored = midi_val * 2` | Within +/-1 |

PB center (8192) maps to stored value 0. PB max (16383) maps to 8191.
AT/MW values are doubled -- MIDI 127 becomes stored 254.

### Decoded Results

#### unnamed 106 (MW only) -- 21 bytes automation
```
Section 1: type=0x01(MW), count=1, init=0x0000(0), final=0x00FE(254)
Keyframes: 0 (count=1 means only init+final, no intermediate keyframes)
```

**MW behavioral quirk**: Standalone MW records only count=1 (init + final value, no keyframes). The ramp was 0->127 over 16 steps, but the device only stored the final value (254 = 127*2). All intermediate values are lost.

#### unnamed 107 (AT only) -- 82 bytes automation
```
Section 1: type=0x02(AT), count=16, init=0x0000(0), final=0x00FE(254)
15 keyframes:
  KF1:  tick=480,  val=16   (sent AT=8,   expected=16)   MATCH
  KF2:  tick=960,  val=34   (sent AT=17,  expected=34)   MATCH
  KF3:  tick=1440, val=50   (sent AT=25,  expected=50)   MATCH
  KF4:  tick=1920, val=68   (sent AT=34,  expected=68)   MATCH
  KF5:  tick=2400, val=84   (sent AT=42,  expected=84)   MATCH
  KF6:  tick=2880, val=102  (sent AT=51,  expected=102)  MATCH
  KF7:  tick=3840, val=118  (sent AT=59,  expected=118)  MATCH *escape byte here*
  KF8:  tick=4320, val=134  (sent AT=67,  expected=134)  MATCH
  KF9:  tick=4800, val=152  (sent AT=76,  expected=152)  MATCH
  KF10: tick=5280, val=168  (sent AT=84,  expected=168)  MATCH
  KF11: tick=5760, val=186  (sent AT=93,  expected=186)  MATCH
  KF12: tick=6240, val=202  (sent AT=101, expected=202)  MATCH
  KF13: tick=6720, val=220  (sent AT=110, expected=220)  MATCH
  KF14: tick=7200, val=236  (sent AT=118, expected=236)  MATCH
  KF15: tick=7680, val=254  (sent AT=127, expected=254)  MATCH
```

All 15 keyframes match sent values exactly (MIDI val * 2).

#### unnamed 108 (PB only) -- 82 bytes automation
```
Section 1: type=0x00(PB), count=16, init=0x0000(0), final=0x1FFF(8191)
15 keyframes: all match sent PB values within +/-1 (rounding)
  KF1:  tick=480,  val=546   (sent PB=8738,  stored=8738-8192=546)
  KF2:  tick=960,  val=1092
  ...
  KF15: tick=7680, val=8190  (sent PB=16382, stored=16382-8192=8190)
```

#### unnamed 109 (PB+AT+MW combo) -- 215 bytes automation
```
Section 1: type=0x00(PB), count=16, init=0, final=8191
  15 PB keyframes (all correct)
Section 2: (no type byte) count=16, init=0, final=254
  15 AT keyframes (all correct)
Section 3: (no type byte) count=16, init=0, final=254
  15 MW keyframes (all correct -- FULL keyframes this time!)
```

**Key finding**: MW in combo records full 16-count keyframes, unlike standalone MW which only records count=1.

### Standalone vs Combo MW Behavior

| Context | MW count | Keyframes | Data Size |
|---------|----------|-----------|-----------|
| MW only (unnamed 106) | 1 | 0 (init+final only) | 7 bytes |
| MW + PB + AT (unnamed 109) | 16 | 15 (full ramp) | ~64 bytes |

Hypothesis: The device may optimize MW-only recordings to store just the final value, but when other controllers are recorded simultaneously, it uses the same keyframe infrastructure for all three.

### Automation Data Size Reference

| Configuration | Note Event | Automation | Total Appended |
|---------------|-----------|------------|----------------|
| 1 note, no auto (flag 0x02) | 12 bytes | 0 | 12 bytes |
| 1 note + MW only (flag 0x03) | 12 bytes | 7 bytes | 19 bytes |
| 1 note + AT or PB (16 KF) | 12 bytes | 67 bytes | 79 bytes |
| 1 note + PB+AT+MW (all 16 KF) | 12 bytes | 199 bytes | 211 bytes |

### Implications for Authoring

To write automation data:
1. Use flag byte `0x03` instead of `0x02` on the note
2. Encode gate as single hi byte: `gate_hi = gate_ticks >> 8`
3. Append automation sections after the note trailing bytes
4. First section: 7-byte header with type byte
5. Subsequent sections: 6-byte header (no type byte)
6. Keyframes: `count - 1` entries of `[tick_u16LE] [val_u16LE]`
7. Handle escape byte when val_hi=0x00 and tick_lo=0x00

**NOT YET DEVICE-TESTED for authoring** -- format decoded from device-written captures only.

## C++ Mental Model & Hypotheses (2026-02-12)

The `.xy` format is a flat binary serialization of an in-memory C++ object tree. The firmware uses `fixed_vector<T, N>` for note buffers (explaining the 120-note cap and `fixed_vector.h:77` crashes), a type 0x05/0x07 state machine acting as `Optional<EngineState>` (0x05 = pristine with `08 00` sentinel, 0x07 = activated with explicit parameters and optional events), and signature-based block search (`00 00 01 [type] FF 00 FC 00`) for forward-compatible parsing across variable pre-track sizes and multi-pattern block rotations. The compact variable-length tick encoding (flag bits 0/1/2/4) minimizes serialized size for RAM-constrained real-time playback — the serialized format may be the runtime format with zero-copy loading.

### 10 Testable Hypotheses

- **H1**: Event types (0x1E/0x1F/0x20/0x21/0x25/0x2D) are `fixed_vector` capacity selectors — wrong type allocates wrong buffer size
- **H2**: Preamble byte[0] encodes a body-size-class for slab/pool memory allocation (7 distinct values map to allocation buckets)
- **H3**: The note==velocity crash is a delimiter/sentinel collision — `[N, N]` bytes parsed as end-of-record marker
- **H4**: `FF 00 FC 00` signature suffix is a constant magic number (not a version field)
- **H5**: 0x2D is the "non-default engine on slot" event type — firmware checks `current_engine != factory_default[slot]`
- **H6**: EPiano 47-byte tail = 1 marker byte + 22 × s16 LE parameter deltas + 2 zero padding
- **H7**: Pre-track region grows by byte insertion at fixed offsets per feature (not TLV)
- **H8**: T5 preamble exemption is a hardcoded `if (idx == 4) skip` patch in the serializer
- **H9**: Step components stored in a flat array indexed by step number within engine param block
- **H10**: `08 00` padding is a u16 state flags field (bit 3 = "use engine defaults")

### Key Data Corrections

- Preamble byte[0] has only **7 distinct values** across 16 tracks (not 16 unique) — kills "roster index" theory
- Handle table uses **3-byte entries** (not 4-byte): `[value_lo] [value_hi] [flags]`, 12 entries
- Pre-track growth is **feature-driven** (MIDI config, multi-pattern, activation), not firmware-version
- EPiano tail is **22 signed 16-bit values** (range -15 to +92), not floats or unsigned

### Detailed Document

Full writeup with test protocols, C++ rationale, and prioritized experiment plan: **[`docs/cpp_hypotheses.md`](../cpp_hypotheses.md)**
