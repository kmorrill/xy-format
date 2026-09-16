# P-lock rotation carry-curve capture — 2026-08-26

## Question

Why did a generated Param 1 lock display as `-12.00` after sequence rotation,
even though the source lock displayed at its intended value?

## Device evidence

- Device: connected OP-XY
- Firmware: 1.1.25
- Transport: macOS MTP
- Captures: `pr24-p1-native.xy`, `pr24-p2-manual.xy`, and
  `pr24-p2-native.xy`

The device-generated Step 7 `+9.00` lock had two non-zero Param 1 value cells:
Step 6 contained `0x6FFF` and the armed Step 7 contained `0x7000`. After the
native sequence-left operation, the device image contained:

- Step 5: `0x6FFF`
- Step 6: `0x7000`, armed
- Step 7: `0x7000`, retained but unarmed

The step component moved from Step 7 to Step 6 and the Param 1 UI
current-value cache was cleared. A separate native right shift showed the same
copy-without-source-clearing behavior around a Step 1 lock.

This demonstrates that p-lock value cells form a sparse carry/cache curve.
The per-step activation row determines where the lock applies; a native shift
does not circularly rotate and clear the value rows.

## Implementation and regression

`ImageProject.set_plock()` now seeds an empty, unarmed predecessor cell with
`value - 1`. `ImageProject.rotate_pattern()` copies non-zero value cells into
their shifted destinations without clearing source cells, rotates the
activation and step-component rows normally, and clears the affected UI cache.

The generated verification pair `e_rot_fixed_src.xy` and
`f_rot_fixed_expected.xy` was copied to the same OP-XY, read back byte-for-byte,
and checked from the front panel. The source locks displayed `-9.00` and
`+9.00`; after rotation both retained those values at the expected destination
steps, with Multiply ×3 and Hold ×2 moving alongside their notes.

## Track 3 boundary control

A later four-pattern control on Track 3's `bass/shoulder` synth engine isolated
the start-of-pattern boundary:

- P1 Step 1, raw Param 1 `0x1000`, displayed `0`
- P2 Step 2 after a right shift, the same raw value displayed `12`
- P3 Step 7 and P4 Step 6 after a left shift both displayed `87`
- Multiply ×3 and Hold ×2 moved correctly in both cases

The failing low pair had a synthetic `0x0FFF` carry wrapped into Step 8 and an
empty current-value cache. The earlier device-native right-shift capture had
no Step 8 carry: it retained `0x1000` in Step 1, copied it into Step 2, and
cleared the current-value cache. This establishes Step 1 as a non-circular
boundary. New locks write the lane current-value cache; predecessor carry
cells are created only for Steps 2–64.

The corrected `h_rot_t3_fixed.xy` was uploaded and downloaded byte-identically
(SHA-256 `fa0ab817aef9f1bba211db106dd86c1407d89bf0948db5c9442caa323b5d23dc`).
All four front-panel checks then passed:

- P1 Step 1 and shifted P2 Step 2 both displayed Param 1 `12` with Multiply ×3
- P3 Step 7 and shifted P4 Step 6 both displayed Param 1 `87` with Hold ×2
- the notes moved to Steps 2 and 6 with their respective components
