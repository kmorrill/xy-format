# C++ Mental Model, Data Findings & Testable Hypotheses

*Generated 2026-02-12 from corpus analysis, MIDI harness experiments, and 8 device-crash root causes.*

---

## Part 1: Reconstructed C++ Architecture

### The Developer's Perspective

The OP-XY firmware is a C++ application running on an embedded ARM chip. The `.xy` file format is a flat binary serialization of an in-memory object tree. Reconstructing the developer's mental model from the serialized artifacts:

### Object Tree

```
XYProject
├── header (magic + firmware version)
├── pre_track_region (tempo, groove, MIDI config, pattern directory, handle table)
└── tracks[16]           // 8 instrument + 8 auxiliary
    ├── preamble (4 bytes: ptr_lo, ptr_hi/pat_count, bar_steps, 0xF0 tag)
    ├── signature (8 bytes: 00 00 01 [type] FF 00 FC 00)
    └── body
        ├── engine_params (engine-specific: 38-42 bytes)
        ├── common_params (183 bytes, anchored by 55 55 01 15)
        ├── patch_name (null-terminated ASCII, e.g. "pluck/beach bum")
        ├── [note_events] (optional, only when type=0x07)
        └── [engine_tail] (optional, 47 bytes for EPiano engine 0x07)
```

### `fixed_vector` and RAM Constraints

The crash at `fixed_vector.h:77` (`length < thesize`) tells us the firmware uses **fixed-capacity vectors** — `fixed_vector<T, N>` where `N` is a compile-time constant. This is standard practice on embedded systems where:

- Dynamic allocation is forbidden or minimized (no heap fragmentation)
- Pattern data must fit in pre-allocated SRAM buffers for real-time playback
- The documented 120-note limit per pattern is likely `fixed_vector<NoteEvent, 120>`

The compact variable-length tick encoding (flag bytes 0x00/0x01/0x02/0x04 selecting between 0-2 byte tick fields) is designed to minimize the serialized size so that 120-note patterns fit within the buffer. The serialized format may BE the runtime format — no conversion on load, just pointer arithmetic.

### Type 0x05/0x07 State Machine

The type byte at `body[9]` implements a two-state discriminated union:

```c++
// Conceptual C++ model
struct TrackBlock {
    uint8_t type;  // 0x05 = default, 0x07 = has events
    union {
        struct { uint8_t padding[2]; DefaultState state; } inactive;  // type=0x05
        struct { ActiveState state; NoteEvent events[]; } active;     // type=0x07
    };
};
```

- **Type 0x05** ("pristine"): Track has default engine parameters, no note events. The 2-byte padding `08 00` may be a state flags word (bit 3 = "use defaults"). All field offsets shift by +2 bytes relative to type 0x07.
- **Type 0x07** ("activated"): Track has been modified (notes added, bar count changed, or engine swapped). The padding is removed, shifting all subsequent fields by -2 bytes. Note events are appended (most engines) or inserted before a parameter tail (EPiano).

The type transition is one-way in practice: 0x05 → 0x07 on first modification. The firmware never reverts a track to 0x05 (clearing all notes still leaves type 0x07 with an empty event section, as seen in unnamed 19: bar count change only, no notes).

### Signature-Based Parsing

The parser finds track blocks by searching for the 8-byte signature `00 00 01 [type] FF 00 FC 00`, not by fixed offsets. This design accommodates:

- Variable pre-track region size (121-233 bytes observed)
- Multi-pattern clone blocks inserted inline (shifting all subsequent blocks)
- Block 15 overflow concatenation (multiple blocks packed end-to-end)

This is a **robust, forward-compatible** design — the firmware can add new features to the pre-track region or change pattern storage without breaking the track parser.

### Event Type as Preset-Specific Factory ID

At least 9 event types (0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x25, 0x2D) share identical per-note binary encoding but select different code paths during deserialization. **The event type is determined by the PRESET, not the engine or track slot.**

Evidence (discovered via unnamed 113, 116, 117):
- unnamed 116: Same Drum kit (boop) on T4/T7/T8 all produce 0x25 — proves slot doesn't matter
- unnamed 117: Prism on all 8 tracks with different presets produces 4 different types (0x1C, 0x1D, 0x1E, 0x1F) — proves engine doesn't determine type
- unnamed 113: Different Drum kits on T4/T7/T8 produce different types (0x21, 0x21, 0x22)

Each preset carries a baked-in event type byte. The firmware likely stores this in the preset ROM alongside the parameter defaults:

```c++
// Pseudocode
struct PresetDef {
    uint8_t event_type;    // e.g. 0x25 for boop kit, 0x1C for moog-funk
    EngineParams defaults;
    const char* name;
};

NoteBuffer* allocate_buffer(uint8_t event_type) {
    switch (event_type) {
        case 0x25: return new fixed_vector<DrumNote, 120>;   // boop/kerf kits
        case 0x22: return new fixed_vector<DrumNote, 120>;   // chamine kit
        case 0x21: return new fixed_vector<SynthNote, 120>;  // phase kit, shoulder, dissolve
        case 0x1C: return new fixed_vector<SynthNote, 120>;  // moog-funk/bass/dark
        case 0x1D: return new fixed_vector<SynthNote, 120>;  // bass-ana
        case 0x1E: return new fixed_vector<SynthNote, 120>;  // moog-pad, pk-arp/axe, hardsync
        case 0x1F: return new fixed_vector<PianoNote, 120>;  // pad-vib, EPiano
        case 0x20: return new fixed_vector<AxisNote, 120>;   // Axis, Multisampler
        case 0x2D: return new fixed_vector<WaveNote, 120>;   // engine-swap fallback
    }
}
```

Using the wrong type for a preset crashes because the allocated buffer or handler doesn't match the track's runtime state.

---

## Part 2: Data-Grounded Findings

Results from corpus analysis scripts run against the full `.xy` corpus (91 baseline files + 25 amb kit files).

### Preamble Byte[0] Groupings

Only **7 distinct values** appear across 16 track slots in the baseline corpus. This kills the "roster index" theory (which would require 16 unique values):

| byte[0] | Tracks | Body Size Range | Engine(s) |
|---------|--------|-----------------|-----------|
| 0xD6 | T1 | 1832 B | Drum |
| 0x8A | T2 | 1792 B | Drum |
| 0x86 | T3, T4, T6 | 419-490 B | Prism, EPiano, Hardsync |
| 0x2E | T5 | 419 B | Dissolve |
| 0x83 | T7 | 454 B | Axis |
| 0x85 | T8, T9 | 345-750 B | Multisampler, aux |
| 0x9B | T10-T16 | 269-403 B | Various aux |

Key observations:
- T3, T4, and T6 **share** byte[0] = 0x86 despite having different engines (Prism, EPiano, Hardsync) and different body sizes (419, 490, 433 B)
- T3 and T5 have **identical body sizes** (419 B) but different byte[0] (0x86 vs 0x2E)
- T8 and T9 share 0x85 despite vastly different body sizes (750 vs 345 B)
- All 7 auxiliary tracks T10-T16 share byte[0] = 0x9B
- Grouping does NOT cleanly correlate with body size, engine, or any single parameter

### Handle Table: 3-Byte Entries

The handle table at pre-track offsets 0x58-0x7B (in baseline) contains **12 entries of 3 bytes each** (not 4-byte entries as initially guessed):

- Format: `[value_lo] [value_hi] [flags]` per entry
- Unused entries: `FF 00 00`
- The table shifts rightward when pattern descriptors are inserted at 0x58
- Total: 12 × 3 = 36 bytes

### Pre-Track Growth Is Feature-Driven (Not Firmware-Version)

The pre-track region grows based on enabled features, NOT firmware version:

| Size | Trigger | Example Files |
|------|---------|---------------|
| **121 bytes** | Amb kit baseline (firmware `09 10 0D 84`) | amb kit files |
| **124 bytes** | Standard baseline (firmware `09 13 03 86`) | unnamed 1 |
| **126 bytes** | MIDI channel entry size increase (+1 byte at 0x23) | unnamed 41 |
| **129 bytes** | Multi-pattern (+5-byte descriptor at 0x58) | unnamed 6 |
| **131 bytes** | Track activation with MIDI config (+7 bytes) | unnamed 93, 94 |
| **233 bytes** | Unknown feature combination | amb kit variant |

The firmware parser must know which features are present to correctly parse field positions. This is likely done via:
- Size/count bytes early in the header (e.g., byte at 0x23 encodes entry size)
- Fixed insertion points per feature (the firmware knows "if multi-pattern, look for descriptor at 0x58")

### EPiano Tail: 22 Signed 16-Bit Parameter Values

The 47-byte tail on EPiano (engine 0x07) track bodies decomposes as:

```
Offset  Content
  0     marker byte (0x28 = no events, 0x08 = has events; difference = bit 5)
  1-44  22 × s16 LE values (signed 16-bit, little-endian)
 45-46  00 00 (terminator/padding)
```

The 22 s16 values observed in baseline (unnamed 1, T4):
- Range: -15 to +92
- Likely **parameter deltas from engine defaults** (signed offsets for macro knobs, envelope ADSR, filter cutoff, LFO params, etc.)
- EPiano has 4 macro knobs × 4 M-pages = up to 16+ tweakable params; 22 values covers the full parameter set plus some metadata

The marker byte's bit 5 (0x20) serves as an "events present" flag:
- `0x28 = 0b00101000` → bit 5 set → no events after tail
- `0x08 = 0b00001000` → bit 5 clear → events precede this tail

### T5 Preamble Exemption Is Absolute

Confirmed across all test scenarios:
- **Contiguous activation** (unnamed 93: all 8 tracks T1-T8 activated): T5 keeps 0x2E
- **Non-contiguous activation** (unnamed 94: T1/T3/T5/T7 activated): T5 keeps 0x2E
- **Engine change on T5** (unnamed 94: T5 changed from Dissolve to Drum): T5 keeps 0x2E
- **Setting T5 to 0x64 crashes** (Crash #6: `serialize_latest.cpp:90`)

The exemption is **slot-specific** (track index 4 in 0-based numbering), not engine-specific. Likely a hardcoded `if (idx == 4) skip` in the serializer's preamble update loop.

---

## Part 3: 10 Testable Hypotheses

### H1: Event Types Are `fixed_vector` Capacity Selectors (PARTIALLY SUPERSEDED)

**Theory**: The 9 known event types (0x1C/0x1D/0x1E/0x1F/0x20/0x21/0x22/0x25/0x2D) select different `fixed_vector<NoteEvent, N>` template instantiations with different max capacities. Using the wrong type for a preset allocates a buffer with the wrong capacity, causing the `length < thesize` assertion at `fixed_vector.h:77`.

**Update**: The event type is preset-specific, not slot/engine-specific (proven by unnamed 116/117). The factory ID is baked into each preset definition, not determined at runtime by slot or engine.

**C++ rationale**: Each preset carries its own event type byte. The firmware uses this as a factory ID: `allocate_buffer(preset.event_type)`.

**Test protocol**:
1. Create files with increasing note counts (60, 80, 100, 120 notes) for each event type on its native track. The 120-note limit is documented but there may be type-specific thresholds below 120.
2. On T3 (native type 0x21), craft a file using 0x25 (known to crash) with only 1 note. If it crashes with 1 note, the crash is type-validation, not capacity-related.
3. Compare crash behavior: does the crash message differ between "wrong type" and "too many notes"?

**Prediction**: If correct, there will be a note count N < 120 where one event type crashes but another doesn't. If ALL types crash at exactly 120, capacity is track-level, not type-level.

---

### H2: Preamble Byte[0] Encodes a Body-Size-Class for Memory Pool Allocation

**Theory**: byte[0] is a **coarse size class** telling the firmware which memory pool to allocate from when loading a track block. Tracks with similar default body sizes share the same byte[0] because they fit in the same allocation bucket.

**C++ rationale**: Embedded allocators use fixed-size pools (slabs) to avoid heap fragmentation. A uint8_t size class could map to pool buckets: 0x9B → "small auxiliary" (269-403B), 0x86 → "medium synth" (419-490B), 0x83 → "medium-large" (345-750B), 0x8A/0xD6 → "large drum" (1792-1832B).

**Test protocol**:
1. Check engine-change files: In unnamed 91 (T4 EPiano→Drum), does T4's byte[0] change from 0x86? In unnamed 94 (T5 Dissolve→Drum), does T5's byte[0] change from 0x2E?
2. Across all corpus files with activated tracks (type 0x07), check if byte[0] ever changes from its baseline value for the same slot.
3. Cross-reference with the amb kit corpus (different firmware) to see if byte[0] values differ per slot.

**Prediction**: byte[0] NEVER changes for a given slot regardless of engine or content changes — it's hardcoded per-slot. If it DOES change during engine changes, it's dynamically computed from engine parameters.

---

### H3: The note==velocity Crash Is a Delimiter/Sentinel Collision

**Theory**: The firmware note parser uses `note_byte != vel_byte` as a distinguishing heuristic to detect end-of-record markers or run-length-encoded padding. When they're equal, the parser enters a wrong code path.

**C++ rationale**: In compact binary formats, sentinel bytes are chosen to be "unlikely in practice." MIDI note and velocity are typically different values, so `note == vel` was never tested. The adjacent bytes `[N, N]` might look like a repeat-encoding marker or a 16-bit sentinel (e.g., `0x3232` might collide with an internal constant).

**Test protocol**:
1. **Systematic equal-pair test**: Create single-note files for specific (note, vel) pairs: (60,60), (0,0), (127,127), (64,64), (1,1). Test which crash and which survive.
2. **Near-miss test**: Also test (60,61) and (59,60) to confirm only exact equality crashes.
3. **Multi-note isolation**: In a 4-note file, put note==velocity only on note 3. Does the whole file crash or just fail at note 3?

**Prediction**: ALL equal pairs crash with no exceptions (it's a structural ambiguity, not a specific sentinel value). The crash happens at parse time (load), not during playback.

---

### H4: The `FF 00 FC 00` Signature Suffix Is a Constant Magic Number

**Theory**: The bytes `FF 00 FC 00` at body[4:8] are a fixed magic number, not a format version. They serve as additional validation alongside the `00 00 01 [type]` prefix.

**Test protocol**:
1. Cross-firmware check: The "amb kit" corpus uses firmware `09 10 0D 84` (different from baseline `09 13 03 86`). Verify their track signatures also contain `FF 00 FC 00`.
2. Check if any corpus file has a different value in these 4 bytes.

**Prediction**: Identical across ALL firmware versions and ALL corpus files. If it differs in any file, it's a version field.

---

### H5: 0x2D Is the "Engine-Swap Fallback" Event Type (PARTIALLY SUPERSEDED)

**Theory (original)**: The firmware serializer writes event type 0x2D when an engine runs on a non-default track slot.

**Update**: The discovery that event types are preset-specific (unnamed 116/117) changes this picture. When a preset is explicitly loaded (even on a non-default slot), the firmware uses that preset's native event type. For example, unnamed 116 shows Drum "boop" kit producing 0x25 on T4/T7/T8 — NOT 0x2D.

0x2D appears specifically when:
- The engine is swapped but the body is NOT fully rewritten with a new preset (unnamed 91: T4 EPiano→Drum without loading a kit preset)
- The firmware does a minimal engine-swap (just patches engine_id) without loading preset-specific parameters

**Revised evidence**:
- unnamed 94: T3 Prism→Wavetable and T5 Dissolve→Drum produce 0x2D (engine swap, no explicit preset selection)
- unnamed 116: T4/T7/T8 with explicit Drum "boop" kit selection produce 0x25 (preset-specific, NOT 0x2D)
- unnamed 113: T4/T7/T8 with different Drum kit presets produce 0x21/0x21/0x22 (preset-specific)

**Revised prediction**: 0x2D is the fallback when the firmware does a quick engine swap without fully reinitializing the body from a preset template. It signals "body not rewritten for this engine."

---

### H6: The 47-Byte EPiano Tail Is a Fixed `EngineParams` Struct with s16 Parameter Deltas

**Theory**: The 47 bytes = 1 flag byte + 22 × s16 LE parameter offsets + 2 zero padding. The s16 values are signed deltas from engine-default values.

**Test protocol**:
1. **Parameter knob sweep**: Use MIDI CC or device UI to record an EPiano track with one macro knob (e.g., filter cutoff) swept to known positions (0%, 25%, 50%, 75%, 100%). Diff the tail bytes across captures.
2. **Engine change check**: Change T4 from EPiano to Prism. Does the tail disappear? If so, it's engine-specific.
3. **Preset change**: Load different EPiano presets and diff the tail values.

**Prediction**: Exactly one or two s16 values change when a single parameter is modified. Changed values scale linearly with knob position. The tail disappears entirely when engine changes from EPiano (0x07) to any other engine.

---

### H7: The Pre-Track Region Uses Insertion-Based Growth (Not TLV)

**Theory**: Rather than TLV (type-length-value) encoding, the pre-track region has a **fixed-layout header** that grows by byte insertion at specific offsets when features are enabled. The firmware knows the insertion points and adjusts field parsing accordingly.

**Evidence**:
- Unnamed 41 (MIDI config): 1 byte inserted at offset 0x23 (entry size `0C` → `0D`)
- Unnamed 6 (multi-pattern): 5 bytes inserted at offset 0x58 (descriptor `00 1D 01 00 00`)
- Unnamed 93 (activation + MIDI): 7 bytes of growth (offset TBD)

**Test protocol**:
1. For each distinct pre-track size in the corpus, byte-diff against the 124-byte baseline. Identify exact insertion points and content.
2. Look for a size/count field early in the header (e.g., at 0x22 or 0x23) that might encode the pre-track size or optional section count.
3. Check if any two features can be independently combined (e.g., multi-pattern + MIDI config) and whether their insertions are additive.

**Prediction**: Each feature adds bytes at a specific, consistent insertion point. There is NO length-prefix or TLV header. The firmware has hardcoded knowledge of which features add how many bytes and where. The pattern directory at 0x56 is always at the same relative position from the end of the pre-track region (not from the start).

---

### H8: T5's Preamble Exemption Is a Hardcoded `if (idx == 4) skip` in the Serializer

**Theory**: The T5 exemption is not structural but a **literal hardcoded check** in the firmware's preamble update loop. It may be a bug fix for an earlier crash, patched with a conditional rather than a proper fix.

**C++ rationale**: The crash at `serialize_latest.cpp:90` (`num_patterns > 0`) suggests byte[0] participates in pattern count calculation. For T5, the default byte[0] = 0x2E produces a valid pattern count, but 0x64 does not. Rather than fixing the pattern count extraction logic, the developer added `if (track == 4) continue;`.

**Test protocol**:
1. Already confirmed: T5 exemption holds with both Dissolve (default) and Drum (swapped) engines. Eliminates engine-specific causes.
2. **New test**: Activate ONLY T5 (no other tracks). Check if T6 gets 0x64 (it should, since T5 is activated). Verify T5's own byte[0] is still 0x2E.
3. **Inverse test**: Activate ONLY T4. Check T5 keeps 0x2E (not 0x64).

**Prediction**: T5 NEVER gets 0x64 regardless of context. T6 DOES get 0x64 from T5's activation. The rule applies FROM T5 to T6, just not TO T5 from T4. This asymmetry is a textbook "special-case patch."

---

### H9: Step Components Live in the Engine Param Block, Indexed by Step Number

**Theory**: The 14 step component types (pulse, hold, multiply, velocity, ramp, random, portamento, bend, tonality, jump, skip trig/param) are stored in a **flat array** within the engine parameter region of each track body. Each step has a fixed-size record for each possible component.

**C++ rationale**: With 14 types and 64 steps, a sparse flat array at 4 bytes per entry = 14 × 64 × 4 = 3,584 bytes. This fits within track body sizes. Alternatively, a more compact encoding stores only populated entries with (step_index, component_type, value) tuples.

**Test protocol**:
1. **Corpus diff pairs**: Compare unnamed 59 (pulse on step 9) vs unnamed 60 (hold on step 9) vs unnamed 63 (all components on step 9). The diff reveals the component storage region.
2. **Step position test**: Compare unnamed 59 (pulse on step 9) vs a file with pulse on step 1 (if available). The diff shows the same data at a different offset, with the stride revealing per-step record size.
3. **Multi-component test**: unnamed 63 has all 14 components on step 9. Check if the data is contiguous (flat array) or scattered (linked list / tagged records).

**Prediction**: Component data at `base_offset + step * stride + component_id * record_size`. The stride and record_size are consistent across all tested files.

---

### H10: The `08 00` Padding Is a Serialized State Flags Field

**Theory**: The 2-byte padding `08 00` in type-0x05 blocks is a u16 LE value = 8, representing a **state flags word** where bit 3 (value 0x08) means "pristine/use engine defaults." When the track is activated (type 0x07), this flags word is removed because the state is now explicitly serialized in the body content.

**C++ rationale**: `0x08 = 0b00001000` — bit 3 could mean "use factory defaults for all engine parameters." The firmware checks: if `flags & 0x08`, skip detailed parameter deserialization and load engine presets from ROM.

**Test protocol**:
1. Already confirmed: All 16/16 type-0x05 blocks in baseline have exactly `08 00`. Universal constant across the main corpus.
2. Check if the amb kit files (different firmware, all type 0x07) also had `08 00` in their type-0x05 blocks before activation (they were all activated, so this may not be testable).
3. Check if any corpus file has a non-`08 00` value at body[10:12] while retaining type 0x05.

**Prediction**: `08 00` is universal across ALL firmware versions and ALL type-0x05 blocks. It's a constant sentinel meaning "default state," never varied.

---

## Part 4: Prioritized Experiment Plan

### First Batch: Corpus-Only (No Device Needed)

These can be tested by running analysis scripts against existing `.xy` files:

| Priority | Hypothesis | Effort | Method |
|----------|-----------|--------|--------|
| 1 | **H7**: Pre-track insertion-based growth | Low | Byte-diff all distinct pre-track sizes |
| 2 | **H9**: Step component flat array | Medium | Diff unnamed 59-67 (step component corpus) |
| 3 | **H4**: `FF 00 FC 00` = constant magic | Low | Check across amb kit corpus |
| 4 | **H2**: Preamble byte[0] = size class | Low | Check engine-change files (unnamed 91, 94) |
| 5 | **H10**: `08 00` = state flags | Low | Already confirmed, verify amb kit |

### Second Batch: Device/MIDI Harness Required

| Priority | Hypothesis | Effort | Method |
|----------|-----------|--------|--------|
| 6 | **H5**: 0x2D = non-default engine type | Medium | Engine swap MIDI captures |
| 7 | **H1**: Event types = capacity selectors | Medium | Note count stress test (60/80/100/120) |
| 8 | **H6**: EPiano tail = s16 param deltas | Medium | Knob sweep MIDI captures |
| 9 | **H3**: note==velocity = sentinel collision | Low | Systematic equal-pair authoring test |
| 10 | **H8**: T5 exemption = hardcoded skip | Low | Mostly confirmed already |

### Recommended Implementation

For the first batch, write `tools/hypothesis_tests.py` — a single script with subcommands:

```bash
python tools/hypothesis_tests.py h7-pretrack   # Diff all pre-track sizes
python tools/hypothesis_tests.py h9-components  # Diff step component files
python tools/hypothesis_tests.py h4-signature   # Check FF 00 FC 00 across corpora
python tools/hypothesis_tests.py h2-preamble    # Check byte[0] stability
```

For the second batch, add new experiments to `tools/midi_harness.py`:
- `engine_swap_t3_dissolve` — for H5
- `note_stress_120` — for H1
- `epiano_knob_sweep` — for H6
- `equal_pairs` — for H3
