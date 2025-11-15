# Step Component Notes

Offsets are given relative to the start of each track block (`block = track_signature_offset`). In these captures Track 1’s block begins at `0x0080`, Track 3’s at `0x0EB0`.

## Header words (`block+0x0B4–block+0x0BA`)

The 9-word mask starts at `block+0x0B4`. `block+0x0B4` carries the component ID in its high byte (step token in the low byte), `block+0x0B6` remains `0x0000` in every sample so far, and `block+0x0B8` encodes the UI configuration. `block+0x0BA` only lights up for pulse/velocity/trigger records.

| Component (UI setting) | File | `block+0x0B4` | `block+0x0B6` | `block+0x0B8` | `block+0x0BA` |
| --- | --- | --- | --- | --- | --- |
| Pulse repeat (min) | `unnamed 59.xy` | `0x0163` | `0x0100` | `0x0000` | `0x00FF` |
| Pulse repeat (max) | `unnamed 60.xy` | `0x0163` | `0x0000` | `0x00FF` | `0xFF00` |
| Hold (minimum) | `unnamed 61.xy` | `0x0263` | `0x0000` | `0x0100` | `0x0000` |
| Trigger every 4th | `unnamed 62.xy` | `0x2064` | `0x0404` | `0x0200` | `0x0405` |
| Multiply ÷4 | `unnamed 66.xy` | `0x0463` | `0x0000` | `0x0401` | `0x0000` |
| Velocity → random | `unnamed 67.xy` | `0x0863` | `0x0000` | `0x00FF` | `0xFF00` |
| Ramp up (4 steps, 3 oct) | `unnamed 68.xy` | `0x1063` | `0x0000` | `0x0803` | `0x0000` |
| Ramp down (3 steps, 1 oct) | `unnamed 69.xy` | `0x2063` | `0x0000` | `0x0204` | `0x0000` |
| Random span (4 steps, 1 oct) | `unnamed 70.xy` | `0x4063` | `0x0000` | `0x0305` | `0x0000` |
| Portamento 70 % | `unnamed 71.xy` | `0x8063` | `0x0000` | `0x0706` | `0x0000` |
| Bend (up/down) | `unnamed 72.xy` | `0x0164` | `0x0000` | `0x0106` | `0x0000` |
| Tonality +5th | `unnamed 73.xy` | `0x0264` | `0x0000` | `0x0407` | `0x0000` |
| Jump → step 13 | `unnamed 74.xy` | `0x0464` | `0x0000` | `0x0408` | `0x0000` |
| Parameter toggles (1–4) | `unnamed 75.xy` | `0x0864` | `0x0000` | `0x0409` | `0x0000` |
| Conditional every 2nd trig | `unnamed 76.xy` | `0x1064` | `0x0000` | `0x020A` | `0x0000` |
| Conditional every 9th trig | `unnamed 77.xy` | `0x2064` | `0x0000` | `0x090B` | `0x0000` |

### Track 3 synth capture (`unnamed 78.xy`)

`unnamed 78.xy` places the Multiply component on Track 3 (Prism synth) alongside a quantised note trig. The mask at `track3+0x0B4` mirrors the Track 1 record (IDs `0x0463`, config `0x0201`), confirming that the high byte of `block+0x0B8` holds the divide amount (`0x02` for “÷2”, `0x04` for “÷4”). The note metadata introduces extra fields ahead of the usual eight-word payload:

- `track3+0x0D0 = 0x7400` (versus `0x7500` for the ÷4 capture).
- `track3+0x0D2 = 0x147A`, `track3+0x0D6 = 0x04AE`, `track3+0x0D8 = 0x0007` tie the component back to the quantised note entry.
- The note payload that lived at `track3+0x0F0` in the note-only capture (`unnamed 65.xy`) now starts at `track3+0x0F8`.
- The tail at `track3+0x0172–0x0180` becomes `0x0D00, 0x0040, 0xFF00, 0x0000, 0x00FF, 0xFF00, 0x0000, 0x00FF`, aligning with the `0x21` linkage chunk inserted between track blocks.

Step-mask words at `track3+0x050` rotate to `[0xFF00, 0x0000, 0x00FF]` for step 9, and the `0x21 01 00 0F …` event binds the component record to the per-step note payload at `track3+0x0F8`.

## Parameter slots (`block+0x0D0` onward)

Key `u16` values touched by each component. Once the header is set, the firmware alternates guard words `0x0040/0x0100`; only the diverging entries are listed below.

| Component | File | Key words (hex) | Notes |
| --- | --- | --- | --- |
| Pulse repeat (min) | `unnamed 59.xy` | `block+0x0D0=0x00FF`, `block+0x0D4=0x7700`, `block+0x0F0=0x0800` | Repeat count hides in `block+0x0D4`; `block+0x0F0` hits `0x0800`. |
| Pulse repeat (max) | `unnamed 60.xy` | `block+0x0D0=0x7900`, `block+0x0D4=0x0040`, `block+0x0F0=0x0800`, `block+0x0F2=0x7FFF` | Max/repeat random swaps the high/low bytes. |
| Hold (minimum) | `unnamed 61.xy` | `block+0x0D0=0x7600` | High byte of `block+0x0D0` tracks envelope time. |
| Trigger every 4th | `unnamed 62.xy` | `block+0x0D0=0xFF00`, `block+0x0D2=0x0000`, `block+0x0D4=0x00FF`, `block+0x0D6=0xFF00`, `block+0x0D8=0x6A00` | `block+0x0D0–0x0D6` form the condition mask; `block+0x0D8` stores the divisor (4). |
| Multiply ÷4 | `unnamed 66.xy` | `block+0x0D0=0x7500`, tail `block+0x0F0–0x0FFE = [0800,7FFF,0000,E800,5503,0155,0015,0400]` | Multiply ratio sits in the high byte of `block+0x0D0`. |
| Multiply ÷2 (note present) | `unnamed 78.xy` | `block+0x0D0=0x7400`, `block+0x0D2=0x147A`, `block+0x0D6=0x04AE`, note payload begins at `block+0x0F8` | Ratio still tracks the high byte; additional words bridge to the quantised note record. |
| Velocity → random | `unnamed 67.xy` | `0x014C=7900`, `0x014E=0040`, `0x0150=0100`, `0x016C=0800`, `0x016E=7FFF`, tail `0x0172–0x0180 = [E800,5503,0155,0015,0400,1FFF,0000,AC00]` | Reuses the pulse register pairing plus a distinct tail table. |
| Ramp up (4 steps, 3 oct) | `unnamed 68.xy` | `0x0150=7300`, tail `0x0172–0x0180 = [7FFF,0000,E800,5503,0155,0015,0400,1FFF]` | High byte `0x73` matches a 4-step span with 3-oct depth. |
| Ramp down (3 steps, 1 oct) | `unnamed 69.xy` | `0x0150=7200`, same tail as above | |
| Random span (4 steps, 1 oct) | `unnamed 70.xy` | `0x0150=7100`, same tail as above | |
| Portamento 70 % | `unnamed 71.xy` | `0x0150=7000`, same tail as above | |
| Bend (up/down) | `unnamed 72.xy` | `0x0150=6F00`, same tail as above | |
| Tonality +5th | `unnamed 73.xy` | `0x0150=6E00`, same tail as above | |
| Jump → step 13 | `unnamed 74.xy` | `0x0150=6D00`, same tail as above | |
| Parameter toggles (1–4) | `unnamed 75.xy` | `0x0150=6C00`, same tail as above | High byte reflects the enabled bitmask (first four toggles). |
| Conditional every 2nd trig | `unnamed 76.xy` | `0x0150=6B00`, same tail as above | |
| Conditional every 9th trig | `unnamed 77.xy` | `0x0150=6A00`, same tail as above | |

## Shared observations

- The nine mask words at `block+0x0B4–block+0x0C4` still OR together cleanly: the “all components” capture (`unnamed 63.xy`) equals the union of the individual component files.
- Component IDs occupy the high byte of `block+0x0B4`. The values march in a sensible order (`0x01` pulse, `0x02` hold, `0x04` multiply, `0x08` velocity, `0x10` ramp/random/conditional families, …) while the low byte carries the step token (`0x63/0x64` for step 9).
- Config word `block+0x0B8` uses its high byte for span/length data and the low byte for the secondary parameter (e.g. multiply ÷4 ⇒ `0x0401`, multiply ÷2 ⇒ `0x0201`, ramp up 4 steps & 3 oct ⇒ `0x0803`, conditional every 9th ⇒ `0x090B`).
- Most components share a tail at `block+0x0F0` consisting of `[0x0800, 0x7FFF, 0x0000, 0xE800, 0x5503, 0x0155, 0x0015, 0x0400]`; velocity random swaps in `[0xE800, 0x5503, 0x0155, 0x0015, 0x0400, 0x1FFF, 0x0000, 0xAC00]`. The synth+note capture overrides that tail with `0x0D00/0x0040/0xFF00/…` to link against the `0x21` event.
- The per-step bitmap at `block+0x050` flips the step‑9 lane to `[0xFF00, 0x0000, 0x00FF]` whenever we touch a step component, matching the “touched” state seen with previous note captures.
