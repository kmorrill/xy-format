# Struct Layout Hypothesis: Manual Surfaces vs Decoded Bytes

This note records a follow-up inference from thinking about how firmware would
write the project to disk: preserve the important in-memory project structs,
then RLE-compress the resulting byte image. The current decoded image supports
that model better than a bespoke file grammar.

## Global Master Area

The previous spatial ledger treated `0x0074..0x0094` as a possible 33-byte
scene prologue because it sat immediately before the scene slab. The product
manual gives a better fit:

- Mix M2 exposes four master EQ controls: low, mid, high, blend.
- Mix M3 exposes four saturator controls.
- Mix M4 exposes four master controls: percussion, melodic, compressor, master
  level.

Known captures already place master EQ low/mid/high at `0x68`, `0x6C`, and
`0x70`, changing the first byte of each 4-byte lane. The next byte,
`0x74`, defaults to `0x40` in the baseline and is now the best candidate for
EQ blend.

The following range, `0x75..0x94`, is exactly 32 bytes. In the baseline it
reads cleanly as eight 32-bit fractional/default values when aligned at
`0x75`:

| Offset | Raw | Approx fraction |
| --- | --- | ---: |
| `0x75` | `9a 99 99 19` | `0.10` |
| `0x79` | `9a 99 99 19` | `0.10` |
| `0x7D` | `00 00 00 40` | `0.25` |
| `0x81` | `00 00 00 00` | `0.00` |
| `0x85` | `00 00 00 40` | `0.25` |
| `0x89` | `00 00 00 40` | `0.25` |
| `0x8D` | `cd cc cc 0c` | `0.05` |
| `0x91` | `00 00 00 40` | `0.25` |

That 1-byte + 32-byte shape is a stronger struct fit than "one extra scene
record": it accounts for all four EQ controls plus the eight manual-visible
master/saturator controls before the 100 x 33-byte scene slab begins at
`0x0095`.

Direct capture priority:

1. Change only EQ blend and save.
2. Change only each saturator knob and save.
3. Change only percussion, melodic, compressor, and master level and save.

Those nine captures should name the whole global master cluster.

## Track Sound State

The track struct strongly resembles a packed `TrackPattern` state object:

```c
struct TrackPattern {
    TrackHeader header;
    u8 lower_preset_state[0x27A];
    u16 plock_value[64][42];
    u8 mostly_empty_or_reserved[0x14AE];
    u8 plock_step_mask[64][8];
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
    u8 filter_env_tail[25];
    u8 mod_routes[60];
    u8 pre_sample_tail[27];
    SampleSlot sample_slot[24];
    char preset_path[48];
    NoteVector notes;
};
```

The 16-byte tails after M1, amp, filter, and LFO now look like genuine page
companion structs, not padding. The manual exposes many controls that fit those
tails:

- M2 shift: poly/mono/legato, portamento amount, bend range, preset volume.
- M3 shift: aux out, tape, FX I, FX II sends.
- M4 subfunctions: LFO shape, random envelope/onset, value destination/free
  behavior, duck source type, and other type-specific options.
- Preset settings: high-pass, velocity sensitivity, portamento style, width,
  tuning/transposition.

The known `+0x3900..+0x393B` modulation matrix likely follows those page tails
because it belongs to preset settings rather than to one specific M page.

## Sampler Slots

The manual confirms the 24 x 128 slot model:

- drum sampler: 24 keys;
- multisampler: maximum 24 zones;
- one-shot and multisampler share start, loop start, loop end, end, direction,
  tune/pan, fade/crossfade, gain, and loop type concepts.

This supports treating `slot+0x68..+0x7F` as a dense numeric tail rather than
path padding. Drum sampler already maps start/end/gain at `+0x68`, `+0x70`,
and `+0x7C`; one-shot and multisampler probably reuse the same tail for
start, loop start, loop end, sample end, crossfade/fade, gain, and loop type.

Capture priority remains:

1. one-shot sampler: change only start, loop start, loop end, sample end;
2. one-shot sampler: change only direction, tune, crossfade, gain, loop type;
3. multisampler one-zone equivalent captures to compare slot root/key and
   zone-boundary bytes.

## Practical Authoring Implication

For generation, the safest model is:

- write known musical structures directly: notes, p-locks, step components,
  engine page values, sample slot paths/tails where decoded;
- copy complete donor preset identity regions for undecoded sound-state tails;
- avoid synthesizing global master cluster bytes until the nine direct captures
  above name each lane;
- avoid treating sparse or UI-like bytes as randomizable sound design material.
