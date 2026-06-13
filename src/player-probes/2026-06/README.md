# P3-B — Players (hold / arpeggio / maestro)

> **Status:** todo · Firmware **1.1.4**

Player enable byte + parameter block per player type. T1 = Simple or EPiano (easy to hear).

## Rules

- Re-open **`j0` baseline** before each variant (except j8 flow).
- One player setting per file where possible.
- On **j1**: hold a key ~2s before save; note LED/state.

## Capture procedure

| PC filename | On-device | Setup |
| --- | --- | --- |
| `j0-baseline-no-player.xy` | j0 | T1 preset, all players off |
| `j1-hold-on.xy` | j1 | **Hold** enabled only |
| `j2-arp-on-default.xy` | j2 | **Arpeggio** on, defaults |
| `j3-arp-rate-fast.xy` | j3 | Arp rate → fastest |
| `j4-arp-octave-2.xy` | j4 | Arp octave range → 2 |
| `j5-maestro-on.xy` | j5 | **Maestro** on |
| `j6-maestro-2note-chord.xy` | j6 | Maestro: record 2-note chord |
| `j7-hold-plus-arp.xy` | j7 | Hold + Arp (if UI allows) |
| `j8-player-off-after-arp.xy` | j8 | *(optional)* Arp on → save → re-open → off |

## Results

| PC filename | Status | Player(s) | Notes |
| --- | --- | --- | --- |
| `j0-baseline-no-player.xy` | ⬜ | off | |
| `j1-hold-on.xy` | ⬜ | hold | |
| `j2-arp-on-default.xy` | ⬜ | arp | |
| `j3-arp-rate-fast.xy` | ⬜ | arp | |
| `j4-arp-octave-2.xy` | ⬜ | arp | |
| `j5-maestro-on.xy` | ⬜ | maestro | |
| `j6-maestro-2note-chord.xy` | ⬜ | maestro | |
| `j7-hold-plus-arp.xy` | ⬜ | both | |
| `j8-player-off-after-arp.xy` | ⬜ | | optional |
