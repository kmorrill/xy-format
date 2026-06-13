# Bar length / final-bar probe

> **Status:** analyzed · Firmware **1.1.4**
> **ID:** BAR-LEN · closes checklist §4 final-bar / partial-bar length

## Scope

Each file is Scene 1, Track 1, Pattern 1 with an empty loop. Filename format:

`bar-num<N>-len<M>.xy`

`N` is the displayed number of bars. `M` is the displayed number of active
steps in the final bar.

## Result

Track-relative `+0x01` stores the total active sequencer steps:

`stored_steps = (bar_count - 1) * 16 + final_bar_steps`

This is the same byte used by `ImageProject.set_pattern_steps`. Whole-bar
settings are therefore just the special cases `16`, `32`, `48`, and `64`.

| File | Bars | Final-bar steps | Stored `T1+0x01` |
| --- | ---: | ---: | ---: |
| `bar-num1-len1.xy` | 1 | 1 | `0x01` |
| `bar-num1-len2.xy` | 1 | 2 | `0x02` |
| `bar-num1-len3.xy` | 1 | 3 | `0x03` |
| `bar-num1-len7.xy` | 1 | 7 | `0x07` |
| `bar-num1-len8.xy` | 1 | 8 | `0x08` |
| `bar-num1-len9.xy` | 1 | 9 | `0x09` |
| `bar-num1-len10.xy` | 1 | 10 | `0x0A` |
| `bar-num1-len11.xy` | 1 | 11 | `0x0B` |
| `bar-num1-len12.xy` | 1 | 12 | `0x0C` |
| `bar-num1-len14.xy` | 1 | 14 | `0x0E` |
| `bar-num1-len15.xy` | 1 | 15 | `0x0F` |
| `bar-num1-len16.xy` | 1 | 16 | `0x10` |
| `bar-num2-len2.xy` | 2 | 2 | `0x12` |
| `bar-num2-len15.xy` | 2 | 15 | `0x1F` |
| `bar-num2-len16.xy` | 2 | 16 | `0x20` |
| `bar-num4-len3.xy` | 4 | 3 | `0x33` |

`bar-num1-len13.xy` stores `0x0E`, identical to `bar-num1-len14.xy`. Treat it
as a likely capture mistake until re-probed; it is not needed to identify the
encoding.

All edited files also clear the T1 pristine flag at `+0x11` from `08 00` to
`00 00`, except the unedited/full-bar baseline-style `bar-num1-len16.xy`.

## Code

- Read API: `xy/bar_menu_inspection.py` (`pattern_steps`, `bar_count`,
  `final_bar_steps`)
- Writer API: `ImageProject.set_pattern_steps`
- Tests: `tests/test_bar_menu_inspection.py`
