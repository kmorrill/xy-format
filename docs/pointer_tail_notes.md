# OP-XY Pointer Tail Decode Notes

## 2024‑xx‑xx Session

### What Changed
- **Inspector instrumentation** (`tools/inspect_xy.py`)
  - Classifies every 0x25 block as `inline-single`, `hybrid-tail`, or `pointer-tail`.
  - Splits tail bytes into per-voice entries (note/velocity, flag word, pointer list).
  - Derives pointer metadata:
    * Original little-end word pair (`lo`, `hi`) plus byte-swapped variants.
    * Absolute track-relative offsets when the pointer lands inside the owning block.
    * Dumps the first 32 bytes at each resolved target so we can see the per-step slab contents.
- Augmented report output now reads e.g.:
  ```
  ↳ tail[1]: note=0x40 (E4) vel=0x67 (103) flag=0x0000 ptrs={0:lo=0x0164|hi=0xF010|…|target=track+0x10F0}
    ptr[1] -> track+0x10F0: 0x0015 0x0400 0x3479 …
  ```
- Logged the new inspector behaviour and tail format in the format docs (`docs/format/events.md`) and legacy snapshot (`docs/logs/2026-02-13_agents_legacy_snapshot.md`).

### Key Observations
- **Tail structure**: `[note | vel] [flag] [lo | hi]*` repeats per voice. `swap_u16(hi)` jumps into the track block; common offsets:
  - `track+0x0164`: pointer directory.
  - `track+0x1600`: per-step mask (step token / gate words).
  - `track+0x10F0`: per-step parameter slab (note, velocity, envelopes).
- **Inline vs pointer**:
  - Single grid trigs (e.g. `unnamed_81`) keep inline data; tail is the legacy filter slab pointer.
  - Triads/multi-voice quantised events use pointer tails exclusively.
- **Per-step record** (`track+0x1600` example): `0xDF00 0x002C 0x0100 0x003E 0x0100 0x0018 0x0000 0x1490` → `[head, voice_id, guard, note, guard, step_token, zero, gate_ticks]`.
- **Per-step parameter slab** (`track+0x10F0` example): `0x0015 0x0400 0x3479 …` matches the voice metadata referenced by the tail pointers.

### 2024-xx-xx Follow-up
- **Inspector fixups**: decoding now reads the full 0x25 payload even when the tail spills a short distance past the nominal track boundary (`block_end`). The raw pointer words for `unnamed_80` (G4 chord voice) are captured as `2543 0000 8000 0016 0000 00F0 0100 2A41 0000 0164 F010`, confirming that the tail carries the note/velocity tuple plus a ladder of pointer pairs.
- **Pointer resolution**:
  - `lo=0x8000` / `hi=0x0016` → `swap_lo=0x0080` / `swap_hi=0x1600` ⇒ `track+0x1600`, and the derived offset (`track+0x1600 + 0x0080`) points at the mutated page around `track+0x1680`.
  - `lo=0x0000` / `hi=0x0164` → pointer directory at `track+0x0164`.
  - `lo=0xF010` → parameter slab at `track+0x10F0`.
- **Tail coverage**: even though the count=6 record only emitted one “tail entry”, the pointer list bundled inside that entry references all the slabs needed for the stacked trig on step 13 (pointer directory, mask table, per-step params). Future decoding will need to chase those offsets to recover step index + gate.
- **Outstanding decode work**:
  - Map how `swap_lo`/`swap_hi` pair with the real per-step offset (e.g. confirm `0x0080 → track+0x1680`) and extract the usable fields (step token, gate ticks) from that slab.
  - Correlate the 0x10F0 structures with note/velocity for each voice; the delta vs baseline shows the note/velocity words relocating to 0x1104/0x1144/etc, but we still need a deterministic readout.
- **Record pointer anatomy** (`0x25` fixed records):
  - The first dword in each 10-byte record carries an embedded pointer; shifting right by 8 bits exposes an address-like value. In the triad capture, `0x0016FD02 >> 8 → 0x16FD`, `0x0016EC04 >> 8 → 0x16EC`, and `0x0016DC01` (from the third record’s second dword) points at `0x16DC`. Each of those offsets hosts an 8-word slab containing the voice metadata (note number, velocity-like words, and a candidate step token).
  - Those slabs differ from the pointer lattice in the baseline: e.g. `0x16EC` now reads `[0x007F, 0x0000, 0x57FF, 0x0000, 0xFE00, 0x0043, 0x0000, 0x5255]`, where the sixth word matches the tail note (`0x0043` = G4) and neighbouring words (`0x007F`, `0xFE00`, `0x5255`) shift relative to the pristine project. This strongly suggests the “real” per-step info sits in this family of records rather than the broader 0x1600 pointer directory.
  - For more complex captures (e.g. `unnamed_80`), the high byte of the embedded pointer no longer lands in-range (e.g. `0x0000F002 >> 8 = 0x0000F0`), so we need a general rule rather than assuming a `0x16xx` prefix. Next step is to sweep across several files and cluster the resolved addresses that do fall within the current file to separate true metadata slabs from constant tables.
  - When the pointer lands inside the current track block the target is track-relative (add the track base offset before reading). Example: `unnamed_80` record #5 encodes `0x00168000` which resolves to `track+0x1680`; that slab (little-end words `0x0061 0x0000 0x26FF 0x5555 0x1501 0x0000 0x2F01 0x0000`) is the best candidate for the per-step token/gate bundle that we still need to decode.
  - Many records point at the shared preset tables (`track+0x0170` etc.) or global tables (pointer ≥ `0xF00000`). These appear to stay constant across files, so we can probably ignore them when deriving the per-step layout—focus only on pointers whose resolved offsets live inside the dynamic portion of the track (roughly `track+0x1600 .. track+0x1900`).
- **Step slab reconnaissance**:
  - Inline captures with a single note (e.g. `unnamed_81`, step 9) still populate only the preset tables (`ptr = 0x00F0`); hybrid captures (triad/chord) inject live data across the staircase that starts at `track+0x1600`. Offsets advance in `0x10` strides; the first non-empty block appears at `track+0x1610` for the step‑1 triad and at `track+0x1650` for the chord’s second trig (UI “step 5”). Word `#3` within each block matches the UI note (0x003E → D4, 0x0041 → F4, 0x0043 → G4), while word `#5` exhibits a multiple of six (e.g. `0x0018`, `0x0057`, …) that may encode the grid index.
  - The tail pointer’s `derived_offset` points one level deeper (e.g. `track+0x1700`). Those slabs mutate alongside the per-step blocks and look promising for micro-timing/gate extraction, but the mapping is still unclear. `track+0x1700` reads `[0x0000, 0xFF00, 0x007F, 0x0600, 0xFFF8, 0x00FF, 0x003F, 0x0400]` for the step‑13 chord voice.
  - Working hypothesis: `track+0x16xx` encodes the linked-list node (head word `0xDF00`, note in word `#3`, candidate step token in word `#5`, gate ticks in word `#7`), and `track+0x17xx` carries the allocator state for the same trig. Need more samples (esp. grid notes with known indexes) to finalize the formula.

### 2024-xx-xx Pointer-21 reconnaissance
- **Variant 0 events**: `unnamed_38` shows that some sequencer captures never emit the `0x25` header. Track 4 instead stores a single `0x21 0x00` record with `count=2`; all musical data sits in the surrounding pointer ladder.
- **Inspector behavior**: `tools/inspect_xy.py` now scans each track block for `0x21 0x00` and tags them as `form=pointer-21`. The raw tail words and pointer metadata are rendered so we can diff offsets across captures. Until we decode the downstream slabs, the report deliberately prints `note data unresolved` to avoid guessing at pitches.
- **Outstanding decode**: the pointer list resolves into offsets such as `track+0x02F0`, `track+0x00F0`, and `track+0x0F00`, the last of which contains the expected extreme-note payloads. We still need to formalize how those slabs encode pitch, step index, and gate before the inspector can surface real notes for these variant-0 events.

### Next Steps
1. **Step token & gate decode**
   - Diff the slabs at `track+0x1600`/`+0x10F0` across `unnamed_81` (step 9), `unnamed_3` (triad step 1), `unnamed_80` (multi-voice on step 1) to confirm token→step mapping and gate tick scaling.
2. **Engine matrix**
   - Capture grid notes on key engines (Drum, Simple, Sampler, Multisampler, Prism, etc.) to document whether they emit inline, hybrid, or pointer-only layouts.
3. **Inspector enhancements**
   - Auto-interpret the pointer targets (step token, gate, velocity) and reflect them in the note lines so hybrid/pointer events show exact step/beat/gate values.
4. **Documentation**
   - Summarize confirmed pointer structures (per-step table layout, token formula) once derived, then update `docs/format/events.md` (and keep chronology in `docs/logs/*`).

## 2024-xx-xx Follow-up

### Tail word heuristics
- Added a second-pass scan over `tail_words` (only for `0x25` events) that lifts any word with `1 < velocity <= 0x7F` into the note list when the main inline records/tail entries do not yet supply enough voices. This recovers missing chord voices such as the F4 in `unnamed_80`.
- `use_fine` events (single grid trig with `fine % STEP_TICKS == 0`) now coerce their tail entries to pointer-only metadata. This stops bogus low notes (`C#-1`, `C-1`) from appearing on files like `unnamed_2` and `unnamed_81` where the tail only contains legacy pointer scaffolding.

### Pointer-21 handling
- The `0x21` reader now treats every tail token as pointer metadata. All note/velocity fields are nulled before rendering, avoiding spurious high-octave values sourced from ASCII preset strings (`0x6C70`, `0x6361`, …).
- Inspector output labels such tails as “pointer metadata” so we can still diff the pointer ladder while the actual live-trig data (pitch/step/gate) remains to be decoded from the downstream slabs.
- Pointer-21 events now leave `note entries` empty in the report (`note data unresolved`) so we do not surface misleading pitches while the slab decode is outstanding.

### Outstanding
- Need to decode the per-step slabs pointed to by pointer-21 events so we can surface real note/gate values for captures like `unnamed_39`, `unnamed_65`, `unnamed_87`.
- Investigate whether additional velocity filtering is required for exotic pointer tables; current heuristic ignores velocity ≤ 1 and > 0x7F, which matches observed data but still needs confirmation across the corpus.
- Track the unresolved decode work in `docs/issues/pointer_tail_decoding.md` so future sessions can pick up the exact gaps without re-discovering them.

## 2024-xx-xx Pointer-21 Recon Pass

### Engine / variant sweep
- Scripted a corpus crawl across `src/one-off-changes-from-default/*.xy` to record every track that emits note payloads. Current findings:
  - Engine `0x00` (default synth placeholder) shows both `0x25` events (`inline-single`, `hybrid-tail`) and `0x21` events; the latter always render as `pointer-21`.
  - EPiano tracks (engine `0x07`) only surface `pointer-21` events; no inline `0x25` payloads observed in the change-log set.
  - 12 files in the sample set carry at least one `pointer-21` emission; every capture shares the same tail ladder (see below), which hints that the decode path may be engine-wide rather than per-file.

### Pointer-21 tail ladder shape
- For each `pointer-21` record (e.g., `unnamed_38`, `unnamed_39`, `unnamed_65`, `unnamed_87`) we consistently observe five tail entries immediately before the `0x21 00` header:
  1. Flags `0x2F6B`, `0x6562`, `0x6361` … (`\"kbu\"`, `\"eb\"`, `\"ca\"` when read as ASCII) – no pointer words attached.
  2. Second and third entries mirror the same ASCII-derived flags; still no pointer payloads noted.
  3. Fourth entry carries a single pointer word `lo=0x006D` (swap ⇒ `0x6D00`) but no resolvable target inside the current track; likely a jump into the preset table.
  4. Fifth entry is the only one with a resolvable pointer: `lo=0xF000`, swap ⇒ `0x00F0`, which reliably lands at `track+0x00F0`. Additional pointer pairs follow (`0xFFF1/0x0020`, `0xFFFA/0x004F`, `0x000B/0x0045`, `0xFFFB`), all of which currently resolve outside the track block (probably global lookup tables).
- The `track+0x00F0` slab differs from baseline only in the final word (`0x6446 → 0x0000`). This change repeats across every pointer-21 capture, suggesting the slab is where the live note metadata is written.
- Raw `0x21` header bytes (example `unnamed_38`: `21 00 02 00 16 00 F3 FF 0F 00 FD FF 47 00 07 00 1D 00`) confirm:
  - `count` = `0x0002` (two note entries expected).
  - Start ticks live in bytes 4–7; interpreting as signed little-end gives `start_ticks = 0xFFF30016` (needs wrapping to a positive tick count).
  - Control word bytes 8–11 encode gate ticks and a set of status bits (`0x000FFDFF` in the same example).
- None of the tail entries expose note/velocity bytes directly, which explains why the inspector currently prints “note data unresolved”. Only the pointer pair `lo=0xF000` (`swap_lo=0x00F0`) resolves inside the owning track, landing on `track+0x00F0`; the remaining pairs currently drift outside the block (likely into shared lookup tables). We must derive note/velocity/step from that slab (and any external tables those pointers reference) to finish the decode.

### 0x25 hybrid record sanity check
- Re-ran the record dump for `unnamed_80` (step pattern: C4@1, D4@5, E4@9, chord F4/G4/A4@13). Records confirm the inline fast-path still provides usable steps for voices that keep note data in the 10-byte payload:
  - Record #1: raw ticks `0x00000780` → `1920` ticks → `1920 / STEP_TICKS (480) = 4` (`step = 5` after converting to 1-based). Note and velocity appear in the trailing word `0x3E01`.
  - Record #2 and onward drop the note bytes and instead hand off to the tail/pointer slabs; those are the cases where we need the slab decode to recover pitch/velocity/gate.
- The observation above backs the working hypothesis that `step_token = (step_0_based * 0x06)` for the brick we saw at `track+0x1650` (`0x0018` maps to step`5` when 0-based). We still need additional captures to verify the constant for steps beyond the first bar and for live-record entries, and to confirm how the trailing word (`0x1490` in this example) encodes gate length.

### Next steps (analysis focus)
- Normalize the `track+0x00F0` slab across all pointer-21 captures (baseline vs edited) to identify which words track note, velocity, or gate.
- Trace the out-of-track pointers (`swap_lo` in the `0xFFF1/0x0020` family) to see whether they reference a shared per-project lookup table for step tokens.
- Expand the hybrid `0x25` dataset with captures where the pointer-managed voice lands on different steps (e.g., step 9 only) to confirm the `step_token = n * 0x06` rule and to look for gate encoding (suspected to live in the final word of the 16-byte slab, e.g., `0x1490`).

### Pointer-21 slab sweep (2025-02-xx)
- `track+0x00F0` comparison:
  - Track 4 captures `unnamed_10/11/12/13/14/15/16/41/54/79` retain the baseline slab `5983 5555 1501 0000 7904 0034 0000 6446`, implying that metronome/groove tweaks alone do not populate the per-note node.
  - `unnamed_38` (Track 4, “lowest/highest note”) rewrites the slab to `5555 1501 0000 7904 0034 0000 6446 0000`, so this block is definitely touched once real notes exist.
  - `unnamed_6` (Track 5) swaps its slab from the Track 5 baseline (`419A 0000 DF08 001C 0000 5DFF 3300 0033`) to the same template seen on Track 4 (`5983 5555 1501 0000 7904 0034 0000 6446`), suggesting pointer-21 initialisation copies a synth-style preset even on other tracks.
- Pointer ladder destinations:
  - The only in-block pointer remains `lo=0xF000` (`swap_lo=0x00F0`), landing at `track+0x00F0`.
  - All other pointer pairs from the tail (`0x0000/0x01E0`, `0x0800/0x002B`, `0xFFF1/0x0020`, `0xFFFA/0x004F`, `0x000B/0x0045`, `0xFFFB`) translate to absolute offsets well beyond the owning track—and, in current captures, beyond the end of the project file. These likely reference firmware lookup tables that are not serialized into the `.xy` container.
  - Because these words originated from the preset name blob (ASCII `\"/kb…\"`) in the baseline project, they might not be live pointers at all—just opaque metadata that the firmware interprets locally. Treat them as raw 32-bit data until we can observe a capture where they resolve to an in-file address.
- Note/velocity fields:
  - When real notes are present the region that formerly held the ASCII preset marker (`track+0x01B8` onward) is repurposed into per-voice records. Each 32-bit little-endian word encodes `velocity << 8 | note` in its lower half.
    * `unnamed_38` Track 4 step 1 (lowest note) → word at `track+0x01B8 = 0x00021F00` ⇒ note `0x00` (C‑2) with velocity `0x1F` (31).
    * Step 2 (highest note) → word at `track+0x01D0 = 0x0000647C` ⇒ note `0x7C` (124) with velocity `0x64` (100). The remaining 32-bit lanes in the same block appear to carry timing/gate metadata still to be decoded.
- Interpretation status:
  - We can now extract pointer-21 note lists by scanning the `track+0x01B8 + 0x18*n` slots for non-zero `(velocity << 8 | note)` words.
  - The surrounding words (`0x00F00200`, `0x64050100`, … for the first note; `0xF1002B08`, `0xFA0020FF`, … for the second) likely hold the start tick, gate length, and linkage flags, but the exact formulas remain unknown.
