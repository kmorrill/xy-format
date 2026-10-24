# OP-XY Drumline preset capture checklist — firmware 1.2.0

This capture supplies byte-authoritative donor state for the new Drumline drum synth engine. The names are transcribed from the `drumline` column of the OP-XY Factory Presets sheet.

Status: **accepted**. Both device-authored projects passed the checks below.

## Capture rules

1. On an OP-XY running OS 1.2.0, start from a fresh blank project with one pattern and no recorded notes on Tracks 1–8.
2. Name the project `drumline01`.
3. Load the exact **factory Drumline** preset shown below on each track.
4. Do not record notes or alter synth parameters, M1–M4 controls, mixer values, effects, octave, track scale, pattern length, mute state, or voice settings.
5. Save once after all eight assignments are complete.
6. Transfer the unchanged project back as `drumline01.xy` into `src/factory-preset-captures/firmware-1.2.0/batches/`.

| Track | Category | Factory preset   |
| ----: | -------- | ---------------- |
|     1 | Drumline | atom             |
|     2 | Drumline | beatnic          |
|     3 | Drumline | cinortcele       |
|     4 | Drumline | dote yet         |
|     5 | Drumline | helpline         |
|     6 | Drumline | macaroni         |
|     7 | Drumline | that tom tom tom |
|     8 | Drumline | tyche            |

The ninth preset, `we will c`, uses a second pristine capture:

1. Start from another fresh blank project.
2. Name it `drumline02`.
3. Load `drumline/we will c` on Tracks 1–8 and save once.
4. Transfer it back as `drumline02.xy` into the same folder.

## Acceptance

Each assigned donor track must have exactly one pattern, zero notes, and the expected `drumline/<preset>` identity.

Accepted files:

- `drumline01.xy`: SHA-256 `0668a764328c5313b37048d787e8ad194494d0efdfecfd11244a10fb8eacf0f7`
- `drumline02.xy`: SHA-256 `3c1d34ee46b2f64e2886e39f3677d9332033264a633e5487d5e319187887ca15`

Both decode to 289,521 bytes with container header `ddccbbaa09140786` and 16 internal track leaders. Tracks 1–8 satisfy the requested preset and pristine-pattern checks. Every assigned track uses Drumline engine ID `0x04` at track+0x14. `tests/test_os_1_2_0_drumline_captures.py` covers both captures.
