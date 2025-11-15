# AGENTS: OP-XY Reverse Engineering

## Mission
- Partner to decode the `.xy` project container so we can read, edit, and eventually write OP-XY projects off-device.
- Keep a living log that captures device knowledge, experimental assets, hypotheses, and reverse-engineering progress.

## Reference Materials
- `docs/OP–XY Project File Format Breakdown.docx`: detailed manual-derived expectations for every subsystem of the project file. Converted plaintext lives at `docs/OP-XY_project_breakdown.txt` for quick grepping.
- `src/one-off-changes-from-default/`: corpus of minimally edited project files plus `op-xy_project_change_log.md` describing the exact UI action taken for each file.

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

## Example Corpus Notes
- `unnamed 1.xy` is the pristine baseline.
- Each `unnamed N.xy` adds a single, documented tweak (tempo change, step component toggle, filter adjustments, etc.). File sizes hover around 9.3 KB except sequence-heavy samples (`unnamed 6`, `unnamed 7`, `unnamed 3`) that are larger—good markers for structural inflation.
- `unnamed 79.xy` — hand-entered, non-quantized note on Track 3 landing on sequencer step 13 with a noticeable late micro-offset. The 0x21/0x01 node at 0x104D stores start ticks `0x16F5` (5877) which resolves to step 13 plus +117 tick drift, while the accompanying `0x00018B` word is the gate length (395 ticks ≈ 0.82 step).
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

## Immediate Next Actions
- Diff `unnamed 1.xy` against tempo variants (`unnamed 4` & `unnamed 5`) to pin down BPM encoding.
- Inspect step-component files (`unnamed 8` & `unnamed 9`) to see how component stacking alters nearby bytes.
- Document discovered offsets and value encodings back in this file as we learn them.

## Brute-Forced Offsets (Tempo / Groove / Metronome)
- `0x08`–`0x09` (`u16`): Tempo in tenths of BPM. Examples: `0x04B0` → 120.0 BPM, `0x0190` → 40.0 BPM, `0x04BC` → 121.2 BPM.
- `0x0A` (`u8`): Groove type enum. Baseline `0x00` (straight), `0x08` → “dis-funk”, `0x03` → “bombora” (matches the change log selections). Stored in the high byte of the packed word `0x0A:0x08`.
- `0x0C` (`u8`): Groove amount byte. Default project shows `0x00`; loading groove types populates it with the preset depth (`0xA8` observed for both “dis-funk” and “bombora”).
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
- **Parameter automation lane** (`unnamed 35.xy`): Track 3 macro 1 automation drops two new slabs into the block. A lane header appears at `block+0x0028` (`00 00 FF 08`) followed by four 16 B records and a `0x0000 7FFF` terminator. Each record starts with `value | (0x50 << 16)` — the capture shows values `0x7F`, `0x6F`, `0x42`, `0x7A` (UI 127→111→66→122) — and the remaining dwords keep a `0x50` byte that matches knob slot 1 while encoding timeline/tangent data (fields like `0x50A3`, `0xFF50/0x005F`, `0x6B84` still need decoding, but they scale like step ticks). Just downstream, the step-component directory at `block+0x01E0` replaces the `0x00FF/0xFF00` filler with sixteen `struct {u16 rel_ptr; u8 comp; u8 target;}` entries set to `0x0000, 0x0105`, i.e. component type `0x05` (“parameter lane”) targeting encoder 1. The header words `0x00FF, 0xFF00, 0x0000, 0x01EC` bracket the table and likely link those steps back to the lane blob. This automation payload lengthens Track 3 by `0x7F` bytes, which is why Track 4’s block now starts at `0x10D6`.
- **Pitch-bend performance capture** (`unnamed 39.xy`): Live wheel moves on Track 3 inject a `0x21/0x01` meta-event at `block+0x01CF` (absolute `0x1051`). The 18-byte header now stores start ticks in the high 24 bits of `0x1E03_0000`, gate ticks via the usual `(control >> 8)` path, and—critically—two little-endian counters `fieldA=0x22`, `fieldB=0x2D` for the automation buffers that follow. Immediately after the header, two keyframe tables replace the usual `0xFF00` filler: `fieldA` entries beginning at `block+0x01CF` and `fieldB` more entries starting around `block+0x0226`. Each 32-bit word packs `pitch_hi16 | tick_lo16`; decode ticks as an unsigned 16-bit timeline (add `0x10000` whenever the low half wraps) and interpret the signed high half as the normalized bend amount (0 = center, ±0x7FFF ≈ full throw). Files without pitch bend leave this region untouched, so the meta-event plus non-zero keyframes are a clean detection signal. This automation pathway does *not* touch the parameter-lane header or the step-component directory, confirming that performance bend capture is serialized separately from knob automation even though it occupies the same track-block automation slab.
- **Sample engine deltas** (vs Axis):
  - Drum (`unnamed 34c.xy`) flips the engine ID to `0x03` and restores the baseline lattice; the entire string region at `0x1040` zeroes out like Axis. Diff spans `0x008d–0x1f78`, last change landing at `0x1f78`, confirming the sampler payload sits wholly inside Track 1’s block.
  - Multisampler (`unnamed 34g.xy`) adopts ID `0x1E` and adds extra `0x00007F00` rows inside the pointer block plus subtle tweaks up to `0x1f77`, accounting for the +82 byte file size. Expect additional tables elsewhere referencing zones once we compare against a populated kit.
  - Sampler (`unnamed 34j.xy`) shares the Multisampler signature but runs a few extra tail words (file +87 B). Remaining sections outside Track 1 are byte-identical to Axis, so any kit/sample metadata must live within this block until further captures expose external tables.
- **Preset strings** (`track+0x0FC0`, absolute `0x1040` for Track 1): projects that keep the bundled preset embed ASCII segments here. The untouched baseline (`unnamed 1.xy`) shows `00 00 F7 62 61 73 73 00 2F 73 68 6F 75 6C 64 65 72 00`, i.e. folder and filename (`"bass"`, `"/shoulder"`) as null-terminated slices prefixed by a single status byte (`0xF7`). Selecting an engine with “No preset” wipes the block to `0x00/0xFF` padding and leaves only the `'  N'` marker elsewhere, so serializers must restore the full ASCII payload when referencing a preset.
- File sizes track the pointer complexity: synth engines sit between 8057 B (Axis) and 8122 B (Simple), sample-based engines and Organ push into the 8130–8144 B range, and every diff stays inside the first track block (`offset 0x008d` through `0x1f78`).
- **Value scaling (tentative)**: fitting the observed pairs `(ui, raw)` = `(0, 0x0000)`, `(15, 0x147a)`, `(99, 0x7f01)` yields an almost linear rule `raw ≈ 324.65 * ui + 372.18`. More mid-range captures should tell us whether the firmware quantizes to a tidy step (e.g., `raw = ui * 0x0145 + bias`) or performs table lookup.
- **Record layout hypothesis** (`block+0x00c8`):
  - `0x00c8`: status flag (`0xff` default, `0x00` after an edit).
  - `0x00c9`–`0x00ca`: coarse bucket / preset slot (seen: `0xde00`, `0xdc00`, `0xe600`).
  - `0x00cb`: guard byte (`0xff` in all captures so far).
  - `0x00cc`–`0x00cd`: fine value (`u16_le` storing the knob amount).
  - `0x00ce`–`0x00cf`: trailing flags or pointer (zero in current samples).
- **M-page ordering**: the next record (~`block+0x0100`) assumes the same shape for M-page knobs, reinforcing that every encoder/toggle likely occupies a fixed-size slot in this sequence.

## Mix & Master (WIP)
- **EQ block anchor**: right after the header bytes `04 00 00 0c`, the sentinel `ff ff 0e 00` kicks off a packed table at absolute offset `0x24` in `src/one-off-changes-from-default/unnamed 1.xy`. The table stores little-endian `<u16 value><u16 param-id>` pairs.
- **Band ordering**: the first two entries use param id `0x0040` and map to the low and mid knobs (baseline values read at `0x28` and `0x2c`). The third entry carries id `0x9a40` and tracks the rightmost (high) EQ band (`0x34` in the baseline capture).
- **Value encoding**: neutral settings serialize as `value = 0x0100`. Pulling a band to 0 dB pushes the value to `0x0500` while the id stays fixed — see low (`unnamed 14.xy`, `0x28`), mid (`unnamed 15.xy`, `0x2c`), and high (`unnamed 16.xy`, `0x34`) adjustments. The delta in steps of `0x0100` points to a simple `raw = knob * 0x0100 + bias` scheme; more mid-scale samples will confirm the exact mapping.
- **Locality**: all three EQ entries occupy the contiguous span `0x24–0x37`, immediately after the global header. Each tweak only touches its 4-byte lane (low `0x28–0x2b`, mid `0x2c–0x2f`, high `0x34–0x37`), leaving the rest of the file byte-identical.

## Pattern Directory (WIP)
- **Global count**: header word at `0x0056` tracks the highest populated pattern slot. Baseline `0x0000`; `unnamed 6` (one extra blank pattern) bumps it to `0x0001`; `unnamed 7` (two additional blanks on top) pushes it to `0x0002`. Practical count = `stored + 1`, so serializers must increment this before emitting new pattern payloads.
- **Per-track handles**: 4-byte lanes from `0x0058` to `0x007F` (little-end pairs) map each track to the pattern roster. Default state is `0x00FF/0xFF00` (unused). Once Track 1 gains an extra pattern the lane flips to `0x001D/0x0001` (`unnamed 6+`), pointing at roster slot `0x001D`.
- **Roster entries**: slot indices multiply by `0x10` to find 16-byte descriptors (slot `0x001D` ⇒ `0x01D0`). Those descriptors show recurring halfwords `0x0400`, `0x3FFF`, `0xFF04`, etc. Later captures insert additional 32-bit words ahead of the legacy data (e.g., `0x00FFFFF8`, `0x0000003F`), which likely serve as `prev/next` links in a circular list (Elektron-style sentinel of `0x3FFF` / `-1`).
- **Track block handle**: the 32-bit word sitting immediately before each `00 00 01 03 ff 00 fc 00` signature re-roots the block back into the roster. Baseline Track 1 uses `0xF01001D6`; after new patterns it mutates — e.g., `unnamed 6` shows `0x1002B500` — so any relocation that shifts the roster must rewrite these handles.
- **Pattern payloads**: pattern data lives between track blocks. An empty slot contributes the sentinel `0x8A` plus a pointer (`0x0000F010`) before the next block; real content swaps in a `0x25 <event-count> 00 00` header followed by 10-byte note events (`start`, `voice`, `note`, `velocity`, `gate`). See `unnamed 2` (`0x7A6`) and `unnamed 3` for concrete examples.
- **Multiple blanks**: additional empty patterns create more `0x8A` sentinels just upstream of later blocks (`unnamed 7` shows them at `0x07AD`, `0x0ED8`, `0x1603`). Their ordering matches the linked-list hypothesis: new nodes append immediately before the next track bank without shuffling earlier payloads.
- **Working model**: header → roster slot → per-track linked ring → payload blob. The exact bit layout inside the 16-byte roster entries still needs confirmation, but the sentinel values (`0x3FFF`, `0x00FFFFF8`) behave like guard nodes that make the firmware expect a non-empty ring — explaining why stale header counts trip the `num_patterns > 0` assertion.
- **Note trig nodes**: `unnamed 50` (Track 3 step 6) inserts a single 16-byte record just ahead of the next track block. The four dwords decode to `0xCB012100`, `0x00000008`, `0x00000149`, `0x00213000`. Removing the trig (`unnamed 51`) shrinks the file by 16 bytes and restores the pre-track pointer words to their sentinel pair `0x10018600 / 0x010000F0`, proving the node is physically unlinked rather than just muted. The third dword (`0x149 = 5*64 + 9`) matches the expected step index plus micro-timing; the remaining fields likely hold the ring links and an event-type/parameter pointer (`0x21` shows up in both high bytes). We still need more specimens to map each field.
- **Step payload block**: the live trig also flips the per-step data strip at `0x24C0`. With the note present it reads `0x017F, 0x0000, 0x0AF8, 0xFFFF, 0x003F, 0x0000, 0xFF00, 0x00FF` (16-bit words), which encodes voice/velocity (`0x017F`), a signed timing offset (`0xFFFFF80A` in 32-bit view), and the custom gate (`0x003F`). Deleting the trig restores the baseline sentinel pattern (`0x00FF/0xFF00` repeating), so the firmware eagerly clears payload state rather than leaving residue in the rotation table.
- **Quantized trig delta** (`unnamed 52.xy` → `unnamed 53.xy`): Track 1 pattern 1 still uses the older `0x25 01` header with a single 10-byte event (coarse start `0x0000F0C0`, note `0x3C`, velocity `0x64`, gate `0x6400`). Switching it off reverts the payload to the empty sentinel `0x8A 01 10 F0…`, so quantized trigs follow the same insert/remove mechanics even when they travel through the step-encoder UI instead of live record.
- **Step state table** (`0x12C0` stride): every trig toggle rewrites the 32-byte mask that alternates `0xFF/0x00` per step. Inserting a trig flips the associated 2-byte lane from the baseline `0x00FF` into `0xFF00` and it stays there even after the trig is removed (see `unnamed 53.xy`). Live-record deletions also yield `0x0000` in the same lane, so treat the tuple (`0x00FF`, `0xFF00`, `0x0000`) as three distinct states (pristine, active, touched-empty).
- **Quantised `0x25` fine ticks** (`unnamed 81.xy`): the little-end `fine` word stores the grid-aligned tick count straight up. A single trig on step 9 (C4, default velocity) serialises as `fine = 0x0F00` (3840 ticks) with the usual `STEP_TICKS = 480`, so `step_index = fine / 480 = 8`. The coarse dword only repeats `0x000000F0` in this case; when `fine` is zero we fall back to the pointer-based decode above. Working rule: if `fine % 480 == 0`, use `fine // 480` as the 0-based step index.
- **0x25 variants** (`tools/inspect_xy.py`): the inspector now labels each event `form=…` as it parses. `inline-single` means a single grid trig with clean `fine` ticks (count = 1, fine divisible by 480). `hybrid-tail` covers mixed inline + tail records (triads, chords). `pointer-tail` flags cases with no reliable inline data (tail only). Tail bytes are emitted verbatim so we can see the pointer words (`… 0xF010` etc.) that jump into the per-step slabs; pointer decoding still needs to be formalised.
- **Tail word rescue pass**: when a `0x25` event still lacks voices after parsing inline records plus structured tail entries, we now scan all `tail_words` for `u16` values with `1 < velocity <= 0x7F`. This surfaces hidden chord voices such as the F4 in `unnamed_80` while ignoring pointer scaffolding (`velocity ≤ 1` or `> 0x7F`). Inline single-note captures with `fine % STEP_TICKS == 0` force their tail entries to pointer-only so legacy lattice words (`0x1001`, `0xF010`, …) no longer render as phantom `C#-1` notes.
- **Pointer-21 tail cleanup**: every `0x21` tail token is currently reported as pointer metadata with note/velocity nulled. This prevents the earlier A8/D7/G#7 clutter on files like `unnamed_39` and `unnamed_87`. Real pitch/step/gate data still lives in the per-step slabs that these pointers reference; decoding those blocks remains a TODO.
- **Encoding split (grid vs. live)**: pure step-entry notes keep the inline `0x25` record regardless of engine—see Drum (`unnamed 2.xy:0x07A6`), Prism chord entry (`unnamed 3.xy`), Multisampler (`unnamed 65.xy:0x0FE7`), and Wavetable step capture (`unnamed 85.xy:0x0FD0`). Every live-recorded Prism take instead emits the meta-form `0x21 01 …` header with embedded start/gate ticks (`unnamed 50.xy:0x1051`, `unnamed 79.xy:0x104D`, `unnamed 87.xy:0x1051`). Live Wavetable capture (`unnamed 86.xy`) stays on `0x25` but redirects the inline dwords to a tail block at `0x2330`, matching the “pointer-tail” parse, and Multiply-driven grid edits (`unnamed 78.xy`) also surface as `0x21`. Conclusion: workflow alone does not select the format—Prism’s engine code prefers the `0x21` meta event for recorded notes, while other engines may reuse the `0x25` block with an attached tail. Serialisers must preserve the observed form rather than normalising all notes to one opcode.
- **Quantised `0x25` event layout** (`unnamed 2.xy:0x07A6`): the Track 1 capture shows the 16-byte record explicitly (ticks-per-step ≈ 0xF0 = 240):
  - bytes `0–1`: `0x25 0x01` (note event + single entry)
  - bytes `2–3`: fine tick (`0x12C0`, 20× the coarse start)
  - bytes `4–7`: coarse tick (`0x000000F0`, 48 ticks per step → step index = value ÷ 48)
  - bytes `8–9`: voice id (`0x0001` for mono)
  - bytes `10–11`: MIDI note (`0x3C`)
  - bytes `12–13`: velocity (`0x0064`)
  - bytes `14–15`: gate percentage (`0x0064` → 100 % of a single step when grid-entered via the sequencer)
  The micro-timing sits in the fine tick (divide by 20 to get the coarse slot, modulo 20 is the swing offset).
- **Tick resolution sanity check** (`unnamed 2/3/52/50/56/65/78.xy`): `0x21` live captures put `start_ticks` on multiples of `0x1E0` (480) per 16th—e.g. `unnamed 65` Track 3 step 9 stores `0x00000F00` (3840 ticks) and `unnamed 50` Track 3 step 6 stores `0x000008CB` with a −149 tick micro offset. `0x25` quantised payloads are not consistent: the triad in `unnamed 3` yields per-note little-end values like `0x0016FD02`, `unnamed 2` shows `0x0000F002`, and `unnamed 52` packs the same lane as `00 00 00 F0` (big-end `0x00F0`, little-end `0xF0000000`). Some headers still end in the `0x...600` stride, but the raw tick dword clearly doubles as a pointer. Takeaway: only the `0x21` 480-tick rule is backed by repeat captures; all `0x25` tick math stays hypothesis until we record quantised notes on later steps and decode the pointer linkage.
- **0x25 pointer tail layout** (`unnamed 3.xy`, `unnamed 80.xy`): treating the 10-byte lanes as 5×`u16_be` values makes the structure legible. The fifth word still packs `note<<8 | velocity` (e.g. `0x3C4B`, `0x4329`), while the middle word (`0x1600`) is a constant pointer into the step/component table at `track_base+0x1600`. The post-record “tail” is a sequence of little-end words pairing extra voices with track-local offsets: `[note/vel, 0x0000, pointer_lo, pointer_hi, …]`. Example (step 13 chord in `unnamed 80`): `0x2543` (G4 @ 0x25), `0x2A41` (F4 @ 0x2A), followed by offsets `0x00F0` and `0x0164` which resolve to `track_base+0x10F0` (per-step payload slab) and `track_base+0x164` (pointer directory). The earlier triad tail ends with `[0x4067, 0x0000, 0x0164, 0xF010]`, proving the same scheme was already present on step 1.
- **Triad pointer trail** (`unnamed 3.xy`): a C–E–G chord dropped on Track 1 step 1 confirms the 0x25 header’s first dword is not a tick count but a pointer. Masking off the low byte yields offsets `0x16FD`, `0x16EC`, and `0x0500`, each of which hosts 32-bit parameter slabs for the corresponding voice. The big-end coarse word carries a 0x600 stride marker – `coarse & 0xFFF` stepping through `0x000`, `0x600`, `0xC00`, … – so we tentatively recover the grid index via `(mod // 0x600) - 1` (clamped at zero). These per-voice tables still keep the velocity/gate automation payload; explicit step flags inside the slab remain TBD, but the user capture verified all three trigs live on step 1.
- **0x21 start ticks** (`unnamed 50/56/57/65.xy`): the live/quantised synth captures show `start_ticks` increasing in 480-tick increments per grid step. Rounding `start_ticks ÷ 480` gives the nearest step (1-based once we add 1), while the low 6 bits of `packed` supply a ±micro offset in 1/64-step units. `packed`’s upper bits change with gate length (e.g., 0x149 → default gate, 0x3C0/0x780 → extended holds), so step decoding should prefer `start_ticks` over `packed`.
- **Step state table** (`0x12C0` stride): every trig toggle rewrites the 32-byte mask that alternates `0xFF/0x00` per step. Inserting a trig flips the associated 2-byte lane from `0x00FF`/`0xFF00` into `0xFF00` and it stays there even after the trig is removed (see `unnamed 53.xy`). That suggests the table tracks “touched” state in addition to on/off, so serializers should treat `0x00FF` vs `0xFF00` as a three-state flag (unused, legacy default, custom). Baseline empty → `0x00FF`; first toggle → `0xFF00`; some captures also show `0x0000` in the same lane when we clear a live-record trig, so expect at least three distinct encodings.
- **Per-step note records** (`unnamed 3`, `unnamed 80`): the pointer offsets recovered from the 0x25 tail land in a 16-byte structure at `track_base+0x16D0`. Little-end words decode as `[head, voice_id, 0x0100, note, 0x0100, step_token, 0x0000, gate_ticks]`. Example: `unnamed 80` step 5 (D4) produces `[0x00DF, 0x002C, 0x0100, 0x003E, 0x0100, 0x0018, 0x0000, 0x1490]`. The sixth word increments in multiples of six (step index × 6 so far), and the tail word matches the default gate tick count (`0x1490` ≈ 0.65 steps). Additional voice-specific metadata (random seeds, envelopes) follows immediately afterwards at `b+0x16E0`. We still need captures on other steps to confirm the exact scaling (whether the 6× factor holds across the grid and longer pattern lengths).
- **Pointer table flip**: touching a track promotes the first four pointer slots in the track block (`block+0x0C`..`0x1B`) from “pointer, flags=0” to “pointer=0, flags=offset”. Track 3 (`unnamed 23`) and Track 1 (`unnamed 52`) both adopt this layout and never revert, so writers must emit the promoted form whenever they create pattern content.
- **Per-step payload** (`0x24C0`): with the quantised trig active the eight 16-bit words read `0x007F, 0x0000, 0x0AF0, 0x0000, 0x0064, 0x0000, 0xFF00, 0x00FF`. We interpret these as `[voice+velocity, reserved, coarse tick, micro offset, gate, reserved, flag, guard]`. Clearing the trig resets the block to the sentinel fill, so unlinking nodes always zeroes the payload.

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

- Component masks sit at `block+0x0B4`. The first word’s high byte is the component ID (`0x01` pulse, `0x02` hold, `0x04` multiply, `0x08` velocity, `0x10` ramp/random/conditional, `0x20` extended conditionals) and the low byte is the step token (`0x63/0x64` = step 9). `block+0x0B6` stays `0x0000`; the high byte of `block+0x0B8` carries the UI span (multiply ÷4 ⇒ `0x04`, multiply ÷2 ⇒ `0x02`, ramp up 4 steps ⇒ `0x08`, conditional every 9th ⇒ `0x09`) while the low byte stores the secondary value.
- Parameter slots start at `block+0x0D0`. Pulse/velocity reuse the `block+0x0D0`/`0x0D4` pair (`0x7900` ↔ `0x00FF`, etc.) plus the tail at `block+0x0F0`. Hold writes its high byte to `block+0x0D0` (`0x7600` for the minimum capture). Multiply/ramp/random/portamento/jump/tonality/parameter/conditional all land in `block+0x0D0` with high bytes stepping from `0x7500` (multiply ÷4) down to `0x6A00` (conditional every ninth). They share a tail at `block+0x0F0` = `[0x0800, 0x7FFF, 0x0000, 0xE800, 0x5503, 0x0155, 0x0015, 0x0400]`.
- Velocity random keeps the pulse registers but swaps in its own tail (`0xE800/0x5503/0x0155/0x0015/0x0400/0x1FFF/0x0000/0xAC00`).
- Trigger every 4th toggles `block+0x0D0–0x0D6` as a condition mask and stores the divisor in `block+0x0D8` (`0x6A00`).
- Track 3’s note+Multiply capture (`unnamed 78.xy`) confirms the ratio encoding (high byte of `block+0x0B8` and `block+0x0D0` = 0x02 for ÷2). The synth block inserts extra pointers (`block+0x0D2=0x147A`, `block+0x0D6=0x04AE`), shifts the note payload to `block+0x0F8`, and emits a `0x21 01 00 0F …` chunk (big-endian fields: step=15, pointer=0xF0, payload offset=0x130, vel=0x0064, mask=0x0110) to link the component and note records. The component keeps the BITMASK guard values, so nothing corrupts when a note and component share a step.
- The nine `u16` slots at `block+0x0B4–block+0x0C4` still OR together linearly; the “all components” capture (`unnamed 63.xy`) equals the union of the single-component masks.
- Step bitmap at `0x2400` flips the step‑9 lane to `0x0000` for every component we touched, matching the “touched” state observed with note trigs.

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

## Outstanding Issues
- **Pointer-tail note decode gap**: pointer-driven note payloads (hybrid 0x25 events and pointer-21 meta blocks) still stop at pointer metadata in the inspector. The per-voice node slabs at `track+0x16xx` mingle live note entries with static lookup tables, so we need deterministic rules to recover `step`, `beat`, and `gate` before changing the report. See `docs/issues/pointer_tail_decoding.md` for the current findings and plan.
- **Pointer-21 display**: to avoid misleading output we now suppress the bogus high-octave tail notes that came from parsing ASCII pointer words. The report shows “note data unresolved” for these events until we can decode the referenced slabs; the missing decode remains tracked alongside the pointer-tail issue.

## Open Questions
- Are scenes stored sequentially even when unused, or does the file include a scene count bitmap?
- Do pattern slots reserve fixed-size blocks per track, or are they length-prefixed blobs?
- How are sample paths encoded—plain text, hash, or indices into a directory table?
- Is there a checksum or version field guarding the project file?
- Pattern roster entries: which bitfields carry `prev/next`, payload offsets, and active counts? Are `0x3FFF`/`0x00FFFFF8` literal sentinels or ones-complement IDs?
- Track-block handle word: how are slot index and payload pointer packed into the preamble dword (e.g., `0xF01001D6` vs `0x1002B500`)?
- Empty pattern sentinel `0x8A`: does it require a matching roster flag, and how is the `0xF010` pointer interpreted when appending non-empty payloads?
- Trig node layout: what do each of the four dwords (`0xCB012100`, `0x00000008`, `0x00000149`, `0x00213000`) represent (prev/next IDs, track ID, component flags), and how do we compute them when authoring new events?
- Step state table: which byte order (`0x00FF` vs `0xFF00`) corresponds to “active trig”, “edited empty”, and “pristine”, and how do we derive the correct ordering when writing patterns from scratch?
- How does the mask header’s low byte (`(block+0x0B4) & 0x00FF`) map to the actual step index (e.g., `0x63/0x64` for step 9)?
- Derive the exact mapping from UI values to the stored words (`block+0x0B8`, `block+0x0D4`, `block+0x0D0`, `block+0x0D8`, `block+0x0F0`) for each component, including the shared tail tables at `block+0x0F0`.

## Next Steps
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
- Ran a quick audit across `src/one-off-changes-from-default/*.xy` using the inspector helpers: only two engines emit note payloads today. Engine `0x00` (baseline synth placeholder) produces both `0x25` (inline / hybrid) and `0x21` (“pointer-21”) records, while EPiano (engine `0x07`) sticks exclusively to the pointer-21 form.
- Every pointer-21 capture (12 files in the change log) exposes the same five-entry tail ladder. Only the pair `lo=0xF000` (`swap_lo=0x00F0`) resolves inside the owning track (`track+0x00F0`); the remaining pairs (`0x0000/0x01E0`, `0x0800/0x002B`, `0xFFF1/0x0020`, `0xFFFA/0x004F`, `0x000B/0x0045`, `0xFFFB`) jump beyond the project file, implying they reference firmware lookup tables rather than serialized data.
- `track+0x00F0` behaves like a preset slab for pointer-21 events: Track 4 captures tied to metronome/groove edits keep the baseline template `5983 5555 1501 0000 7904 0034 0000 6446`; `unnamed_38` (Track 4 extreme notes) rewrites the slab to `5555 1501 0000 7904 0034 0000 6446 0000`; `unnamed_6` (Track 5) replaces its track-specific baseline with the same Track 4-style template. The neighbouring slot originally holding the preset marker (`track+0x01B8`) now stores per-note records where the lower 16 bits encode `velocity << 8 | note` (e.g., `0x1F00` → note 0, velocity 31; `0x647C` → note 124, velocity 100).
- Raw 18-byte headers (example `unnamed_38`: `21 00 02 00 16 00 F3 FF 0F 00 FD FF 47 00 07 00 1D 00`) show `count = 0x0002`, with start ticks packed into bytes 4–7 and gate ticks encoded in bytes 8–11. We still need to normalise those values (likely wrap into unsigned tick counts) and decode the positional fields.
- `0x25` hybrid records continue to provide usable coarse ticks when the note lives inline. `unnamed_80` record #1 holds raw ticks `0x00000780`, which divides cleanly by `STEP_TICKS (480)` to give step index 4 → step 5. Later voices in the same capture fall back to pointer slabs; those are the ones that still need the step/gate derivation work. For the D4 hit on step 5 we observe `step_token = 0x0018`, supporting the working rule `step_token = (step_index_zero_based * 0x06)`; the associated gate word (`0x1490`) still needs interpretation.
- Follow-up for next session:
  1. Decode the remaining 32-bit lanes surrounding the pointer-21 note words (e.g., `0x00F00200`, `0x64050100`, `0xF1002B08`) so we can surface precise step/gate values.
  2. Map the off-file pointer destinations (e.g., `track_start + 0x2B00`, `+0x2000`, `+0x4F00`, `+0x4500`, `+0xFBFF`) to their firmware tables once we have a memory dump or additional captures that serialize those regions.
  3. Expand the hybrid `0x25` sample set (e.g., single pointer-managed note on a later step) to validate whether the suspected rule `step_token = step_0_based * 0x06` holds beyond the immediate examples.
