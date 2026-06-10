# 2026-06-10: Aurora Engine — Parameter Automation

## What this adds

Real per-step parameter automation in `10_j_aurora_engine.xy`, tied to the
song's energy: synth-param moves, filter-cutoff sweeps, and an LFO-param
ramp that rises across the sections.

## How automation is stored (decoded this session)

The earlier `set_plock` wrote only the value cell — which is **inert**: the
firmware also needs flags or it ignores the lane. The complete structure
(from the clean device capture `unnamed 35` and the device-passed
`plock_drum_t2`):

```
value lane      track+0x2A0 + 84·(step−1) + 2·col   u16 value per step
per-step flag   track+0x2C4E + 8·(step−1) = 0x01     GLOBAL per step (any param)
master flag     track+0x304E = 0x01                  once per automated track
```

The per-step flag is **global** (param1 in u35 and param2 in plock_drum_t2
share the same flag offsets) — only the value-lane column changes per
parameter. `automate_param()` writes all three and reproduces unnamed 35's
automation byte-exact (value lane + flags + master; the UI current-value
header at +0x24E and the resting engine value at +0x3857 are cosmetic and
omitted). Param columns: param1–4, cutoff, resonance, pan = solid;
`lfo_param`/`lfo_dest` from the CC40/41 captures (the LFO ramp targets
`lfo_param` — confirm on device whether it reads as rate or depth; either
way it modulates the LFO with energy).

## Automation map (verify these on device)

| section (scene) | track | param | curve | what to notice |
|---|---|---|---|---|
| breakdown (5) | T5 pad | cutoff | 1200→31000 / 64 steps | filter opens near-closed → wide across all 4 bars |
| groove (3) | T5 pad | cutoff | 9000↔22000 wobble | pad breathes once per bar |
| climax (6) | T6 lead | cutoff | 14000→30000 / 32 | lead brightens across the first half of the chorus |
| climax-var (7) | T6 lead | cutoff | 16000→32000 / 64 | lead pushed fully bright in the final chorus |
| climax (6) | T3 bass | param1 | 6000↔26000 ×8/bar | bass timbre pulses every half-beat for drive |
| climax-var (7) | T3 bass | param1 | 8000↔30000 | bass grit intensified |
| breakdown (5) | T5 pad | param1 | 4000→20000 / 64 | pad character morphs as filter opens |
| build (2) | T5 pad | lfo_param | 3000→9000 | LFO begins slow, edges up |
| groove (3) | T5 pad | lfo_param | 9000→14000 | LFO faster |
| breakdown (5) | T5 pad | lfo_param | 6000→24000 | LFO accelerates as the swell builds |
| climax (6) | T5 pad | lfo_param | 22000→30000 | LFO fast and intense at the peak |
| groove-var (4) | T4 arp | pan | ping-pong L/R / 4 | arp bounces across the stereo field |

## How to verify on device

1. Load `10_j_aurora_engine.xy`, play the song.
2. Per row above: at that scene, select the track, watch the named
   parameter (cutoff/filter, the LFO M4 page, or the engine param) on the
   screen during playback — the value should move along the curve. The
   cutoff sweeps and the breakdown LFO acceleration should be clearly
   audible; pan is audible in stereo.
3. The breakdown (scene 5) is the showcase: drums muted, filter opening,
   LFO accelerating, pad morphing — all at once.

Generator: `tools/analysis/compose_aurora_engine.py` (prints the map).
Mechanism + validation: `tests/test_image_writer.py::test_automate_param_*`.
