# M5 base — Phase B engine sweep (T1)

> **Status:** captured · Firmware **1.1.4**

40 files. T1 engine/preset sweep (Axis … Wavetable).

## Capture procedure

- Create **`b1-t1eng1bar1`**. T1 only: pick engine type, first custom preset (not factory).
- Fill 1 bar with base note (low F# area on OP-XY; octave may differ by 12 — try mod 12 when hunting note bytes).
- Save As **`…bar2`**, fill bar 2, etc. through bar 4.
- Repeat for eng2…eng11. Optionally extend to T2, T3, …

**Bar-removal artifact:** some projects were created bar4→bar1 (removing bars leaves notes). Started mid-sweep around eng6 — **`b1-t1eng1bar*`** and **`eng2bar*`** were incremental bar1-up; eng7–eng11 redone upward.

**Engine 9 octave:** cloning bar1 then changing engine/preset may ignore preset default octave because notes already exist.

### Engine → first preset used

| Eng | Engine | Preset |
| --- | --- | --- |
| 1 | axis | nt-accord |
| 2 | dissolve | nt-cold brew |
| 3 | drum | nt-aeroplane |
| 4 | epiano | nt-crowded |
| 5 | hardsync | nt-cabin pressure |
| 6 | multisampler | bandpasser (factory) |
| 7 | organ | nt-castle vania |
| 8 | prism | nt-blip tips |
| 9 | sampler | nt-106 bass |
| 10 | simple | nt-dunce cap |
| 11 | wavetable | nt-tall drink |

**Optional alt captures:** copy bar1 projects with suffix **`a`**, change F → F# (note parsing).

### Analysis follow-up

1. Document canonical one file per engine in tests.
2. Diff matrix: all `b1-t1eng{N}bar1` vs `b1-t1eng1bar1`.
3. Optional recapture: eng6 bar1–2, eng9 bar4 if gaps remain.

Tests: `tests/test_project_inspection.py`
