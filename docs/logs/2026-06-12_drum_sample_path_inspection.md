# 2026-06-12 Drum sample path inspection

Read-only extraction of per-voice sample path strings from the drum sampler
table (24 × 128 B at track `+0x3957`, path at slot `+0x08`).

AI-assisted implementation; claims are fixture-backed (round 1 captures below).

## Round 1 captures (canonical)

Operator README:
`opxy_mtp_manager/.../user_probes/2026-06-sample-paths/README.md`.

| File | Pad (UI) | Voice | MIDI key | Sample | Slot path |
|------|----------|-------|----------|--------|-----------|
| `c1-baseline-pp.xy` | — | — | — | `pp` kit | all `…/pp.preset/unnamed-….wav` |
| `c1-pad01-lowf-v23-chi-box.xy` | 1, leftmost **low F** | **23** | 53 F3 | chi box | `content/samples/perc/chi box.wav` |
| `c1-pad02-v00-chi-cham.xy` | 2 | **0** | 54 F#3 | chi cham | `content/samples/perc/chi cham.wav` |
| `c1-pad03-v01-chi-flet.xy` | 3 | **1** | 55 G3 | chi flet | `content/samples/perc/chi flet.wav` |

Each variant is saved from baseline with **one** voice changed; decoded diffs
confirm single-slot isolation.

## Pad index vs voice index (`pp` kit)

The OP-XY drum grid is **not** “voice 0 = leftmost pad” for this kit.

On `pp`, the **leftmost keyboard pad (low F)** maps to **voice 23** (lowest
key in the 24-slot table). The next pad right is voice 0 (F#3), then voice 1
(G3), and so on. Only indices **0–23** exist.

Generic docs sometimes describe “v0 kick … v23 chi” as a factory layout story;
**kit `pp` permutes keys** so the lowest physical pad is slot 23.

## Path anatomy: preset-nested vs library-relative

### Kit-embedded samples (`pp` defaults)

```
/fat32/presets/drum/pp.preset/unnamed-f#2-31.wav
                 ^^              ^^^^^^^^^^^^^^^
           preset bundle    opaque generated name
```

The **drum preset name** (`pp`) is part of the path. User-added kits often
keep the `unnamed-…` pattern, which makes eyeballing assignments hard.

### Built-in / browser picks (`perc/chi *`)

```
content/samples/perc/chi box.wav
                ^^^^ ^^^^^^^^^^^
         sample folder   display name
```

- `perc` here is the **sample library category**, not a `.preset` file.
- The slot does **not** become `/fat32/presets/drum/perc.preset/...`.
- Track-level kit string remains `drum/pp` (~`+0x453F`) while individual
  voices can point at `content/samples/...` paths.

Fragment strings (`chi box`, `perc/chi box.wav`) may also appear elsewhere in
the track image (browser/history); authoritative assignment is the **voice
slot path at `+0x08`**.

## Implementation

- `xy/drum_sample_inspection.py` — reads paths from decoded RAM image via
  `ImageProject` track bases (not scaffold logical-entry bodies).
- `tools/inspect_xy.py` — `[Drum Samples]` section.
- Tests: `tests/test_drum_sample_inspection.py`.

## Round 0 — fully decoded (`nt-z-fx` user preset samples)

Archived under `archive-round0-nt-z-fx/`. **Not lost — documented and tested.**

When pads were pointed at samples inside the **user FX preset `nt-z-fx`**
(while track kit stayed `pp`), the slot path became:

```text
/fat32/presets/fx/nt-z-fx.preset/unnamed-a2-3.wav
```

`nt-z-fx` is the **preset bundle name in the path**; category is `fx`, not
`drum`. Track kit string remains `drum/pp`.

| File | Voice | Path |
|------|-------|------|
| `c0-baseline-pp.xy` | — | all `…/drum/pp.preset/…` |
| `c0-pad01-lowf-v23-nt-z-fx-a2-3.xy` | 23 (low F) | `…/fx/nt-z-fx.preset/unnamed-a2-3.wav` |
| `c0-pad02-v00-nt-z-fx-a3-3.xy` | 0 | `…/fx/nt-z-fx.preset/unnamed-a3-3.wav` |
| `c0-pad03-v01-nt-z-fx-b2-4.xy` | 1 | `…/fx/nt-z-fx.preset/unnamed-b2-4.wav` |

Full analysis: `docs/logs/2026-06-12_round0_nt-z-fx_sample_paths.md`  
Canonical format doc: `docs/format/drum_sample_paths.md`  
Tests: `tests/test_drum_sample_inspection_round0.py`

Round 1 replaced round 0 as the **primary** probe set because `chi *` names are
easier to verify on hardware; round 0 remains the evidence for user-preset-
nested paths.

## Three path families (summary)

| Family | When | Example |
|--------|------|---------|
| A — kit nested | Default on loaded drum kit | `…/drum/pp.preset/unnamed-f#2-31.wav` |
| B — user preset nested | Pad sample from user preset bank | `…/fx/nt-z-fx.preset/unnamed-a2-3.wav` |
| C — library relative | Pad sample from built-in browser | `content/samples/perc/chi box.wav` |

## Open questions

- Sampler / multisampler non-drum path layout.
- Full pad-grid → voice-index map for kits other than `pp`.
- Non-`unnamed` sample ids inside user preset bundles.
