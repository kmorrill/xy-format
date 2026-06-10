# State of Understanding

A running ledger of what we believe about the `.xy` format at points in
time: what got sorted, what we currently think, what remains mysterious,
and what would falsify or confirm the current theory. Append a new dated
entry when the picture meaningfully changes; do not rewrite old entries
(they are the record of what we thought and when).

Format per entry: **Settled** (corpus/device-validated), **Believed**
(explained in principle, not held to the byte-exact standard yet),
**Mysteries** (genuinely unknown), **Next decisive test**.

---

## 2026-06-09 (later) — Round-trip passed; container layer solved

### One-sentence status

The decisive test passed: **245/246 corpus files decode and re-encode
byte-identically as one RLE stream**, so the whole-file RLE claim moves
from Believed to Settled, and the unit of study is now the decoded
~290 KB RAM image, where one-off changes are pure substitutions at fixed
offsets.

### Newly settled

- RLE semantics pinned: pairing on consecutive input bytes; the
  extension byte resets pair state; runs chunk at 257; the firmware
  encoder is canonical-greedy. Codec: `xy/rle.py` (252 tests).
- Decoded-space facts: tempo u16 @0x0, groove @0x3, click @0x4,
  song @0x6, MIDI @0x55/0x64, T1 bars @0xd7a, scale @0xd7f,
  step components = 16-byte per-step slots (T1 step1 @0x3dd0),
  notes = +12 bytes each, pattern struct = 17,875 bytes,
  engine swap = size-preserving in-place substitution.
- The "next decisive test" of the previous entry is discharged; the
  remaining-mysteries list shrinks to field mapping plus the device
  test of note==velocity written as `[n][n][00]`.

### New anomaly

- `bleez.xy` (alone in the corpus, incl. its bleez1–36 siblings)
  contains non-greedy run splits; decodes fine, re-encodes smaller.
  Believed tool-assembled in lineage. Treat as non-canonical specimen,
  not as evidence against the model.

### Next decisive test

Corpus-wide field-mapping join (decoded diff × change log) to produce
the RAM struct map; then author a file purely from a constructed image
(`encode_project`) and device-test it — the model's first generative
test.

### Update (same day, 5): Tier-2 device probes — 4/4, sparse issue closed

User-verified on hardware (corpus-lab recorded):
- **06 mute enum**: scene-2 mute values 1/2/3 ALL display as muted →
  mute is boolean (no solo here); writer emits 2 canonically.
- **07 note flags**: the two trailing note bytes ARE read by firmware
  (`flags[0]=127` retriggered a note in MIDI Monitor), but corpus shows
  the device only writes 0 (programmed) or 2 (some MIDI-record drums);
  `flags[1]` always 0. Micro-timing lives in the tick, not these bytes.
  Writer emits 0,0 (device default) — correct and safe; exact semantics
  of `flags[0]` deferred (non-blocking).
- **08 preset transfer**: boop kit copied onto T5 (non-native slot)
  shows as "boop" and plays drum hits → struct-level preset assignment
  works on the device.
- **09 sparse song**: T4-only Tiesto, 6 patterns + 6 scenes + song chain
  loads, plays, and chains → **sparse-topology stability issue CLOSED**
  (`docs/issues/sparse_topology_stability.md`). The old crashes were
  incoherent writer state, not sparseness.

Every authoring axis is now device-confirmed: notes, gates, multi-pattern,
scenes, songs, mutes, preset assignment, sparse arrangements.

### Update (same day, 4): CAPSTONE — Whitney plays on device

The February crash-saga conversion (Whitney Houston, crashes #4/#5),
rebuilt from its original spec through `build_arrangement()` — 8 tracks
× 9 patterns, 1,617 notes, 9 scenes, Song 1 chain, loop on — **loads
and plays end-to-end on the device** (both probes, user-verified).
Multi-pattern/scene/song assembly was validated byte-exact against
j05/j06 before the device test; crash-era ghost placeholders dropped.
The project's original goal (MIDI → arranged .xy song) is achieved on
the new foundation. Device's role henceforth: acceptance testing for
new authoring features and enum-value lookups — no structural
mysteries remain on the critical path.

### Update (same day, 3): DEVICE VALIDATION — 3/3 probes pass

User-verified on hardware (2026-06-09, corpus-lab recorded):

1. `01_a_img_c4_step5.xy` — image-authored note file: loads, plays
   exactly as specified.
2. `02_b_img_notevel_60_60.xy` — **note==velocity written as an escaped
   RLE pair (`3c 3c 00`): loads AND plays velocity 60 (MIDI-monitor
   verified).** The old model predicted a crash here. This is the
   model's first *novel prediction* confirmed on hardware — the
   "note==vel firmware bug" is conclusively disproven (it was always
   our unescaped pair), and the velocity-nudge workaround is obsolete.
3. `03_c_img_t3_melody.xy` — multi-note/varied gates: correct.

Status promotion: **the format is understood generatively.** Files
authored from first principles (decoded-image edits, no scaffolds) are
accepted and interpreted correctly by the device. The reading model
(245/246 round-trip), the replication model (byte-exact reproduction of
device captures), and now the device itself all agree.

### Update (same day, 2): event types never existed; generative test passed offline

1. **Crash #2 resolved — the "event type byte" is an RLE artifact.**
   There is no type field. The raw 0x1C–0x2D values are the extension
   counts of the zero gap between the end of the preset-name string and
   the note count at track+0x456F. "Preset-specific" because presets
   have different name lengths ("0x25" ends at 'p' in boo*p*; "0x2D
   fallback" ends at '/' of a stripped path). Verified 24/24
   (u2/81/91/92/93/113/116/117). Crash #2 = claiming the wrong gap
   length → count misread 4 bytes early → fixed_vector assert. The
   inline/fine-tick/pointer event-form taxonomy is the same artifact.
2. **Image-based authoring is generative-grade offline:**
   `xy/image_writer.py` reproduces device-saved unnamed 2/81/19/92
   **byte-identically** from semantic edits alone
   (`tests/test_image_writer.py`). Non-replicable residue in richer
   files = UI session bytes (+0x3CBF families), not format semantics.
3. **Device probe pack ready** (`output/image-probes/`): conservative
   note file, T3 melody, and the note==velocity probe written with its
   RLE extension byte — the crisp old-model-vs-new-model discriminator.

### Update (same day): field-mapping join DONE — first pass

`docs/format/decoded_image_map.md`. Image = global header (3,449 B) +
16 × 17,876 B track structs + 53 B song-table footer, exact. Global:
tempo/groove/click/song @0x0–0x7, per-track MIDI array @0x55–0x64,
master EQ @0x68/0x6C/0x70. Track-relative: bars +0x01, scale +0x06,
**pristine flag u16 @+0x11 (8→0, sticky — the old "type 05/07 + 08 00
padding" mystery)**, M-page config +0x1C–0x25, step components =
16 B/step slots @+0x3057 with one byte per component type, engine params
@+0x3857 (4-byte values), envelopes/filter/mod-routing @+0x38xx–0x393B,
note events near struct end as `[count u8]` + 12-byte
`{u32 tick; u32 gate; u8 note; u8 vel; u8 flags[2]}`. T15/T16 = FX1/FX2.
Remaining gaps: event-type byte placement, sample tables, full component
slot order. Crash #1's padding rule is now understood; crash #2 (event
types) remains the main open mystery.

---

## 2026-06-09 — The serialization-model reframe

### One-sentence status

We found the serialization *paradigm* — the file is byte-level
RLE-compressed little-endian C structs — which retrodicts five months of
device experiments including most of the crash ledger; it is a reading
breakthrough, not yet a writing one.

### Settled (corpus/device-validated)

1. **Record boundaries.** The 4-byte "track preamble" was misframed: the
   leading byte is the *previous* record's trailing byte; `count/bars/F0`
   head the next record; clones carry no count byte. The entire
   "preamble state machine" (0x64 propagation, T5 exemption, 0xB5
   multi-pattern marker — ~50 rules at 98.2%) dissolves into local
   struct content. Evidence: 687/687 deviations across 206 files.
2. **Pre-track scene records.** One RLE-compressed 33-byte struct
   (`selected_pattern[16] + mute[16] + flags`), record 0 = live
   selection. Replaces the descriptor Scheme A/B apparatus, v56/v57,
   tokens, short/collapsed forms, and the bleez "record families".
   Evidence: 245/246 files byte-exact; the one rejected file
   (`bleez34.xy`) is the one the device also rejects.
3. **Scene-edit crash mechanics** (crashes #8/#12, probes 59–92): a
   pre-track edit is safe iff the stream still decodes to n×33 values
   with the tail byte equal to n. Retroactively predicts every
   pass/crash in those probe packs.
4. **Crashes #3/#5/#6** (preamble/T5/T9 families): tail bytes are
   zero-fill run counts of each record's fixed trailing region — purely
   local; the cross-track rules were artifacts. 2,224 records, zero
   unexplained cells.
5. **Song table.** File footer = 14 slots of
   `[scene_count][scene_ids…][loop_word]`; loop word `00 01` = on,
   `01 00` = off (unnamed 150 nl/lp device A/B). Pre-track byte 0x11 =
   selected song − 1.
6. **Performance automation lanes** (the 0x60/0x61 tails):
   `[first_lane][count][v0 u16][vmax u16]` + `(t u16, v u16)` keyframes;
   lanes PB/MW/AT (vmax 8191/254/254); static lanes count=1. unnamed
   106–109 MIDI-harness ramps decode to exact 480-tick linear keyframes.
7. **Track scale** is the 4th signature byte (0x03=1×, 0x05=2×,
   0x0E=16×, 0x01=½×) — the "signature" is not all magic.

### Believed (explained in principle, not byte-exact-proven)

- **The whole-file RLE claim**: every track body is the same RLE over
  serialized structs. Converging evidence: gate "token" `F0 00 00 01` =
  u32 gate of 240 ticks; tick "flag bytes" = zero-run extension counts
  inside u32 ticks; chord "separators" = zero runs; decoded body sizes
  grow exactly ~12 bytes/note (RAM note struct
  `u32 tick; u32 gate; u8 note; u8 vel; u8 ×2`); tail bytes derive as
  zero-fill extensions (0x63 vs 0x64 = one extra trailing event byte;
  0x92 vs 0x8A = 8-byte preset field zeroed). **Not yet held to the
  round-trip standard.**
- **note==velocity crash** = an unescaped RLE pair; correct encoding is
  `[n][n][00]`. The velocity nudge treats the symptom. Untested on
  device.
- **Crashes #9/#10** (scene track-generalization / insert probes):
  failure mode is byte-poking inside an RLE stream; individual artifacts
  not yet re-decoded to show each specific corruption.
- **P-lock "val ≥ 256" rule (crash #10 family)** likely the same pair
  phenomenon (val_hi=0 changing byte patterns); not re-derived.

### Mysteries (genuinely unknown)

- **Decoded track-struct field map** — engine params, sample tables
  (the `FF 00 00` lattices), step components, p-locks as fixed-offset
  fields in decoded space. Most of the file by volume.
- **Event type bytes 0x1C–0x2D**: why presets carry different type bytes
  and what the loader selects on them (crash #2 still only empirical).
- **Type 0x05/0x07 + `08 00` padding** (crash #1 root): obeyed, not
  understood; likely falls out of the struct decode.
- **Pointer-21 / live-recorded note storage** (unnamed 39/120): lanes
  decoded, live note events not.
- **Sparse multi-pattern instability** (crash #4/#6 family, u01 vs u02):
  not re-derived; suspected to reduce to scene/selection-record
  consistency, but that is a guess.
- **RLE codec corner cases**: decoder state after an extension byte,
  runs > 257, and scope boundaries (the unnamed 109 lane boundary needed
  count-driven reading, not naive RLE). These details decide whether a
  byte-exact encoder is possible.
- **Pre-track fixed-header fields** beyond tempo/scene ordinals; handle
  table semantics; the one extra byte in `unnamed 154b`/`unnamed 156`.

### Practical capability check

"Can we generate files now?" — **Same capability as before this work,
transformed prospects.** Writers still use validated scaffold paths.
What changed is that we now know *why* those paths work and why the
others crashed.

### Next decisive test

Build the full-file RLE codec and run the **246-file round-trip**:
decode → re-encode → byte-identical. Pass ⇒ authoring becomes struct
construction (archaeology over). Fail ⇒ the failures point exactly at
the remaining unknown scopes. Secondary device test: write
note==velocity with the proper `00` extension byte.

### Pointers

- Canonical model: `docs/format/record_structure.md`
- Full narrative + validation: `docs/logs/2026-06-09_record_boundary_reframe.md`
- Decoder tool: `tools/analysis/pretrack_records.py`

---

## Pre-2026-06-09 — The compositional-serializer era (for contrast)

What we thought before the reframe (preserved so the shift is legible):

- The format was modeled as "baseline scaffold + feature-driven edit
  atoms"; pre-track inserts were catalogued per topology (descriptor
  Schemes A/B) rather than derived.
- Preamble byte[0] was modeled as a cross-track state machine (98.2%
  accuracy with exception families), with hardcoded exemptions (T5) and
  global markers (0xB5).
- Scene records were three encoding "families" (tag/alt/matrix + bleez)
  with partially-understood field couplings; single-byte edits were
  device-tested one at a time, crashing often.
- note==velocity was catalogued as a firmware parser bug, worked around
  with a velocity nudge.
- Gate/tick encodings were treated as token systems with width flags.
- Authoring safety came from byte-exact mimicry of device captures
  (scaffolds, transplants, strict-mode lookups) — effective, but every
  new topology required new device probes.

The legacy docs (`descriptor_encoding.md`, `preamble_state_machine.md`,
`scenes_songs.md` §§5–23) remain useful as device-outcome ledgers even
though their *models* are superseded.
