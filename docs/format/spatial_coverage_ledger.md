# Spatial Coverage Ledger

This ledger maps the decoded OP-XY project image by contiguous byte ranges and
marks each range as decoded, partially decoded, or currently opaque. It is the
spatial companion to `docs/format/decoded_image_map.md`: the image map names
fields we know, while this document shows what is still unknown in-place.

Offsets are decoded-image offsets after `xy/rle.py` decompression, not raw file
offsets. Track offsets are relative to the start of a detected track struct.

## Baseline Image Shape

The baseline single-pattern project has this decoded shape:

| Range | Length | Status | Contents |
| --- | ---: | --- | --- |
| `0x00000..0x00D78` | 3,449 | partial | Global project header, MIDI channels, EQ, scene records. |
| `0x00D79 + n*0x45D4` | 17,876 each | partial | Sixteen track/pattern structs in the baseline image. |
| `end-53..end-1` | 53 | decoded | Song table footer. |

Adding a pattern inserts another `0x45D4` track/pattern struct in decoded
space. Adding notes grows the note vector in the relevant struct by 12 bytes per
note. That means all spatial analysis must use decoded bytes and track
boundaries, not raw RLE byte positions.

## Global Header

| Decoded range | Length | Status | Contents / current theory |
| --- | ---: | --- | --- |
| `0x0000..0x0007` | 8 | partial | Tempo, groove, metronome, song/scene count and selected ordinal fields. |
| `0x0008..0x0054` | 77 | opaque | `global.pre_scene_cluster`: likely selected track/pattern, UI focus, edit mode, transport/project flags. |
| `0x0055..0x0064` | 16 | decoded | Per-track MIDI channel array. |
| `0x0065..0x0067` | 3 | opaque | `global.eq_gap`: mostly zero; possible transpose, key/scale, sync, or compact project flags. |
| `0x0068..0x0073` | 12 | decoded | Master EQ low, mid, high. Device captures change the first byte of each 4-byte lane. |
| `0x0074..0x0074` | 1 | partial | `global.eq_blend_candidate`: likely master EQ blend, matching the fourth EQ control in the manual. Baseline is `0x40`. |
| `0x0075..0x0094` | 32 | partial | `global.master_mix_cluster`: likely eight 4-byte fixed-point-ish master controls from Mix M3/M4: saturator low/mid/high/blend plus percussion/melodic/compressor/master level. |
| `0x0095..0x0D78` | 3,300 | partial | Scene-record slab, apparently 100 x 33-byte scene-like records in the baseline layout. Scene/song semantics are partly decoded in `docs/format/scenes_songs.md`. |

Corpus scan signal:

- `global.pre_scene_cluster` has medium structured variance: 22 unique bodies
  across 920 files, with 46/77 variable bytes.
- `global.eq_gap` is low priority despite 3/3 variable bytes because 97.6% of
  observations are all zero.
- `global.eq_blend_candidate` has only 3 unique values and is `0x40` in 894
  of 920 files, consistent with a centered/default EQ blend byte.
- `global.master_mix_cluster` has only 7 unique bodies despite 31/32 variable
  bytes. The baseline aligns cleanly as eight 32-bit fractional values if read
  from `0x0075`, which fits the eight manual-visible master controls on Mix
  M3/M4 better than the older "scene prologue" theory.

## Track Struct

Each baseline track/pattern struct is `0x45D4` bytes before note-vector growth.

| Track-relative range | Length | Status | Contents / current theory |
| --- | ---: | --- | --- |
| `+0x0000..+0x0025` | 38 | partial | Pattern count, length, signature, track scale, pristine flag, engine id, M4/LFO selector, filter flags, and adjacent small state. |
| `+0x0026..+0x029F` | 634 | opaque | `track.low_preset_state`: low preset/track state copied by `set_preset`; likely play mode, width, portamento, bend range, engine switches, routing defaults, UI mirrors. |
| `+0x02A0..+0x179F` | 5,376 | decoded | P-lock value rows: 64 steps x 84 bytes, 42 u16 parameter columns per row. |
| `+0x17A0..+0x2C4D` | 5,294 | mostly empty | `track.post_plock_value_gap`: almost always zero; sparse nonzero bytes cluster near `+0x2BFE/+0x2C06/...` every 8 bytes, suggesting p-lock fringe state rather than a large unknown payload. |
| `+0x2C4E..+0x304D` | 1,024 | partial | P-lock activation/mask slab. First byte every 8 bytes is the known per-step active flag. Remaining bytes likely parameter masks, selected lane state, or inactive-lane flags. |
| `+0x304E..+0x304E` | 1 | decoded | P-lock master flag. |
| `+0x304F..+0x3056` | 8 | opaque | `track.post_plock_master_gap`: likely automation summary bytes or selected p-lock lane state. |
| `+0x3057..+0x3456` | 1,024 | decoded | Step components: 64 slots x 16 bytes. |
| `+0x3457..+0x3856` | 1,024 | opaque | `track.preset_identity_prefix`: copied by `set_preset`; likely preset-engine internal state, hidden params, modulation defaults, routing defaults, and engine tails. |
| `+0x3857..+0x3866` | 16 | decoded | M1 / engine parameter cells, four 4-byte values. |
| `+0x3867..+0x3876` | 16 | opaque | `track.m1_to_amp_gap`: candidate for M1 shift params 5-8, engine hidden params, or UI mirrors. |
| `+0x3877..+0x3886` | 16 | decoded | Amp envelope ADSR. |
| `+0x3887..+0x3896` | 16 | partial | `track.amp_to_filter_gap`: four M2 shift/current lanes. `+0x3887/+0x388B/+0x388F/+0x3893` map to poly/play mode, portamento, pitch-bend range, and engine volume from CC28-31 captures. |
| `+0x3897..+0x38A6` | 16 | decoded | Filter knob block. |
| `+0x38A7..+0x38B6` | 16 | partial | `track.filter_to_lfo_gap`: four M3 shift/current send lanes. `+0x38A7/+0x38AB/+0x38AF/+0x38B3` map to send ext, send tape, send FX I, and send FX II from CC36-39 captures; send tape is inferred by lane order because baseline already matched the recorded value. |
| `+0x38B7..+0x38C6` | 16 | partial | M4/LFO visible values. First two lanes are pinned as CC40/CC41 current values; exact UI labels vary by LFO/track type. |
| `+0x38C7..+0x38D6` | 16 | partial | `track.lfo_to_filter_env_gap`: LFO hidden/shift params. `+0x38D3..+0x38D6` is the strongest shape/type-specific candidate from `unnamed 33`; exact enum pending. |
| `+0x38D7..+0x38E6` | 16 | decoded | Filter envelope ADSR. |
| `+0x38E7..+0x38FF` | 25 | partial | `track.post_filter_env_gap`: last two 4-byte lanes are mixer current values: `+0x38F7` pan and `+0x38FB` volume. Earlier bytes remain opaque. |
| `+0x3900..+0x393B` | 60 | partial | Mod routing matrix. Velocity sensitivity and track high-pass are known; exact row/field names and signed amount encoding still need completion. |
| `+0x393C..+0x3956` | 27 | opaque | `track.pre_sample_gap`: candidate for final preset performance flags, filter tails, sampler-mode flags, or sample-table header. |
| `+0x3957..+0x453E` | 3,048 | partial | Non-overlapping sample/region table bytes before the preset label. Slot paths and several drum sampler params are decoded; tonal sampler and multisampler semantics are still incomplete. |
| `+0x453F..+0x456E` | 48 | decoded | Preset path string / label. |
| `+0x456F..+0x456F` | 1 | decoded | Note count byte. |
| `+0x4570..+0x45D3` | 100 | partial | Note records when present, otherwise opaque fixed-body tail copied by donor presets. Zero-note tracks show mostly-zero but structured variance. |

## Sample / Region Slot Zoom

The nominal table is 24 slots x 128 bytes at `track+0x3957`. Voice `v`
starts at `+0x3957 + 0x80*v`.

| Slot-relative range | Length | Status | Contents / current theory |
| --- | ---: | --- | --- |
| `+0x00` | 1 | decoded for drum sampler | Tune/root byte; drum capture maps default `0x3C` and +/-48 semitone behavior. |
| `+0x01` | 1 | opaque | Sparse but many-value byte; candidate low key, velocity low, slot enable, or alignment. |
| `+0x02` | 1 | decoded for drum sampler | Key assignment / trigger note. |
| `+0x03` | 1 | decoded for drum sampler | Play mode: key, one-shot, mute group, loop. |
| `+0x04` | 1 | opaque | Sparse but many-value byte; candidate velocity high, region enable, group, or loop flag. |
| `+0x05..+0x06` | 2 | partial | Provisional pan/fade/crossfade-adjacent signed bytes. Need paired captures to identify which is which across sampler engines. |
| `+0x07` | 1 | decoded for drum sampler | Direction: forward/backward. |
| `+0x08..+0x67` | 96 | partial | Sample path string plus padding/engine-specific region metadata. |
| `+0x68..+0x6B` | 4 | partial | Drum sampler sample start; tonal sampler may use a different normalized/unit interpretation. |
| `+0x6C..+0x6F` | 4 | opaque | Candidate loop start, region length, or engine-specific numeric field. |
| `+0x70..+0x73` | 4 | partial | Drum sampler sample end; tonal sampler may store project-local start/end mirrors differently. |
| `+0x74..+0x7B` | 8 | opaque | Candidate loop end, fade/crossfade, or sampler playback window fields. |
| `+0x7C..+0x7F` | 4 | partial | Drum sampler gain; other sampler engines may reuse the tail differently. |

Important overlap: the 24-slot table would nominally span
`+0x3957..+0x4556`, but the preset label starts at `+0x453F`. Voice 23's
tail collides with the label region. Corpus tooling should skip voice 23 for
slot-tail statistics until a device capture proves how the firmware resolves
that overlap.

Corpus scan signal:

- `slot.tail_68_7f` is the current highest-yield region: 401 unique bodies,
  24/24 variable bytes, and only 26.5% all-zero observations.
- `slot.bytes_05_06` is also high yield: 137 unique two-byte bodies. It is
  likely real per-slot state, not padding.
- `slot.byte_01` and `slot.byte_04` are sparse but have 55 and 49 distinct
  values respectively. These are good candidates for small surgical captures.

## Current Priority Order

1. Decode sampler slot tails (`slot.tail_68_7f`) with paired captures for
   tonal sampler start/end/loop/gain and drum sampler pan/fade/crossfade.
2. Decode `slot.bytes_05_06`, `slot.byte_01`, and `slot.byte_04` with minimal
   one-knob/one-slot captures.
3. Finish the remaining page-gap labels: M2 shift lanes, M3 send lanes, and
   mixer pan/volume are now pinned, but M1 tail, LFO type-specific tails, and
   early filter-env tail bytes remain open.
4. Finish the modulation routing matrix row names and signed amount encoding.
5. Treat `track.post_plock_value_gap` and `global.eq_gap` as lower priority
   until a targeted device edit moves them consistently.

## Struct-Writer Hypothesis

The decoded image now looks less like a handcrafted file format and more like a
mostly packed firmware state dump:

```c
struct ProjectImage {
    ProjectHeader header;        // tempo, groove, project settings, MIDI, master mix
    Scene scenes[100];           // 33-byte scene records
    TrackPattern pattern[];      // variable count: one struct per track pattern
    SongFooter songs;            // 14 compact song slots
};
```

Within `TrackPattern`, sound pages appear as fixed page structs with visible
four-knob values followed by small companion tails:

```c
struct SoundState {
    u8 lower_preset_state[0x27A];
    u16 plock_value[64][42];
    u8 mostly_empty_or_reserved[0x14AE];
    u8 plock_mask[64][8];
    u8 plock_master;
    u8 plock_tail[8];
    StepComponent step_component[64];
    u8 preset_identity[0x400];
    Page4 m1;
    u8 m1_tail[16];
    Page4 amp_env;
    u8 amp_tail[16];
    Page4 filter;
    u8 filter_tail[16];
    Page4 lfo;
    u8 lfo_tail[16];
    Page4 filter_env;
    u8 mod_header_or_tail[25];
    ModRoute mod_routes[?];
    SampleSlot sample_slots[24];
};
```

This explains why the 16-byte gaps around M1, amp, filter, and LFO are dense
and structured: they are probably not padding. They are likely shift controls,
hidden subfunction values, current-value mirrors, or engine-specific page tails.
The OP-XY manual's shift/subfunction controls provide the best capture targets
for those tails.

## Corpus Index

The first systematic scan is `docs/logs/2026-06-15_spatial_variance_index.md`.
It was produced by:

```bash
python3 tools/analyze_spatial_variance.py \
  /Users/kevinmorrill/Documents/xy-format/src \
  /Users/kevinmorrill/Documents/xy-format/output \
  --md-out docs/logs/2026-06-15_spatial_variance_index.md \
  --json-out /tmp/opxy-spatial-variance.json
```

Use the report as an index of variance, not proof of meaning. Promote bytes to
decoded status only after paired captures or writer/device validation.
