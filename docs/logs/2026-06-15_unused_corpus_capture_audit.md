# Unused Corpus Capture Audit

This pass checks whether existing `.xy` samples already pin fields that were
still treated as mysterious in the spatial ledger. Corpus scanned:
`/Users/kevinmorrill/Documents/xy-format/src` and
`/Users/kevinmorrill/Documents/xy-format/output` (920 decoded files).

## Findings

### Master EQ

The source/device corpus already pins the three documented EQ gain lanes:

| File | User action | Byte delta |
| --- | --- | --- |
| `unnamed 14.xy` | EQ low to zero | `0x68: 0x40 -> 0x00` |
| `unnamed 15.xy` | EQ mid to zero | `0x6C: 0x40 -> 0x00` |
| `unnamed 16.xy` | EQ high to zero | `0x70: 0x40 -> 0x00` |

The change log previously mislabeled `unnamed_15` as "new empty song for
mid-range"; the bytes show it is the missing EQ mid capture.

There are **no source/device captures** that move `0x74` or `0x75..0x94`.
All `src/` files share the same `0x75..0x94` master-mix body. Variants in
`output/showcase`, `output/from-midi`, and crash outputs are writer-generated
artifacts, useful as generated defaults but not evidence for device UI
semantics.

### Track Current-Value Tails

The MIDI CC-map captures are more useful than the previous docs reflected.
They show that several page gaps are current-value mirrors for shift/mix
controls:

| Region | Lanes | Evidence |
| --- | --- | --- |
| M2 shift/current tail | `+0x3887`, `+0x388B`, `+0x388F`, `+0x3893` = poly/play mode, portamento, pitch-bend range, engine volume | `unnamed 122.xy` CC28-31 |
| M3 send/current tail | `+0x38A7`, `+0x38AB`, `+0x38AF`, `+0x38B3` = send ext, send tape, send FX I, send FX II | `unnamed 123.xy` CC36-39; send tape inferred by lane order because baseline already matched the recorded max |
| M4/LFO current lanes | `+0x38B7`, `+0x38BB` = CC40/CC41 current values | `unnamed 124.xy` |
| Mixer current lanes | `+0x38F7` = pan, `+0x38FB` = volume | `unnamed 99.xy`, `unnamed 124.xy` |
| LFO type/shape tail | `+0x38D3..+0x38D6` likely shape/type-specific state | `unnamed 33.xy`; exact enum still open |

This reduces the "small page gaps" mystery. They are mostly not padding; they
are current-value/shift-page mirrors adjacent to the visible four-knob page.

### Drum Slot Parameters

`output/image-probes/cap_drum_params.xy` is already enough to pin the important
drum sampler fields:

| Slot offset | Meaning | Evidence |
| --- | --- | --- |
| `+0x00` | tune/root note | voices 7 and 9 move to `0x6C` and `0x0C` |
| `+0x03` | play mode | voice 16 changes `0x01 -> 0x03` |
| `+0x07` | direction | voice 18 changes `0x00 -> 0x01` |
| `+0x68` | sample start | single-param start edits and paired start/end side effects |
| `+0x70` | sample end | single-param end edits and paired start/end side effects |
| `+0x7C` | gain | voice 20 changes to `0x7FFFFFFF` |

The same capture shows `+0x06` moving on voice 19 and `+0x05` moving on voice
23, but the file does not cleanly disambiguate pan vs fade. Voice 23 also
overlaps the preset-label region, so `+0x05/+0x06` still need a clean paired
capture on the same non-overlapping voice.

### Drive

No existing source-corpus capture appears to cover Audio In Drive. The only aux
CC-map source capture is `unnamed 126.xy`, and it records T13 CC12 input, not
T13 CC13 drive. A one-control T13 Audio In Drive capture is still needed.

## Revised Capture Priority

No new captures are needed for:

- master EQ low/mid/high;
- M2 shift current lanes for poly/portamento/pitch-bend/engine volume;
- M3 send current lanes;
- mixer current pan/volume;
- core drum sampler tune/play-mode/direction/start/end/gain.

Still high-value captures:

1. Master EQ blend only (`0x74` candidate).
2. Each master/saturator control in `0x75..0x94`.
3. T13 Audio In Drive only (CC13 / UI drive).
4. Drum sampler pan-only and fade-only on the same non-overlapping voice.
5. LFO shape/type-specific controls with one file per LFO type.
