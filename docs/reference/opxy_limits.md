# OP-XY Documented Limits (Official Specs)

Sources: [teenage.engineering/products/op-xy](https://teenage.engineering/products/op-xy), [TE guides](https://teenage.engineering/guides/op-xy/), Sound On Sound review, OP Forums.

## Sequencer

| Limit | Value | Notes |
|-------|-------|-------|
| Steps per pattern | 64 (4 pages x 16) | 4 bars maximum |
| Bars per pattern | 4 | Community requests 8; TE points to 120-note cap |
| Notes per pattern | 120 | Hard cap per pattern |
| Sequencer resolution | 1920 PPQN | 480 ticks per 16th note |
| Track scale options | x1/2, x1, x2, x3, x4, x6, x8, x16 | Max effective 64 bars |
| Step component types | 14 | Stackable per step |
| Variations per component | 10 | |

## Polyphony

| Limit | Value | Notes |
|-------|-------|-------|
| Total voices | 24 | Dynamic allocation |
| Per-track max | 8 | Hard cap |
| Voice modes | Poly, Mono, Legato | Per-track setting |

## Tracks, Patterns, Songs

| Limit | Value | Notes |
|-------|-------|-------|
| Instrument tracks | 8 | T1-T8 |
| Auxiliary tracks | 8 | T9-T16 |
| Patterns per track | 9 | |
| Scenes | 99 | |
| Scenes per song | 96 | |
| Songs per project | 14 | Some sources differ by firmware |
| Projects | 10,000+ | Storage-limited |

## Synthesis and Sampling

| Limit | Value | Notes |
|-------|-------|-------|
| Synth engines | 8 | Drum, EPiano, Prism, Hardsync, Dissolve, Axis, Multisampler, Wavetable |
| Drum sampler slots | 24 | MIDI 48-71 |
| Max sample length | 20 seconds | 16-bit/44.1kHz WAV/AIFF |
| FX slots per track | 2 | Sequenceable |
| FX types | 6 | Reverb, delay, chorus, distortion, lofi, phaser |
| Punch-in FX | 24 | |
| Groove presets | 10 | |

## Format Implications
- 120-note cap defines parser/writer stress-test ceiling.
- 9-pattern limit should align with descriptor/rotation interpretation.
- 8-voice per-track and 24-voice total are hard constraints for chord-generation tests.
