# P3-A — Auxiliary tracks T9–T16

> **Status:** todo · Firmware **1.1.4**

One capture per aux track with **identifiable** knob moves. Pattern P1, one bar; optional one note on aux track.

## Shortcut (time-boxed)

Minimum set: **T9 Brain + T11 MIDI + T15 FX I** only — mark others deferred in checklist.

## Rules

- Re-open each track's **baseline** (`iN-0`) before param variants.
- One major knob/param change per variant file.
- Record exact UI labels and values.

## Capture checklist

### T9 Brain

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i9-brain-baseline.xy` | i9-0 | Select T9 Brain, save | ⬜ |
| `i9-brain-knob1-max.xy` | i9-1 | Knob 1 (manual/auto) → max | ⬜ |

### T10 Punch-in FX

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i10-punchin-baseline.xy` | i10-0 | T10 selected | ⬜ |
| `i10-punchin-fx-param.xy` | i10-1 | FX type + one param | ⬜ |

### T11 External MIDI

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i11-midi-baseline.xy` | i11-0 | T11 defaults | ⬜ |
| `i11-midi-channel.xy` | i11-1 | MIDI channel changed | ⬜ |
| `i11-midi-bank.xy` | i11-2 | Bank changed | ⬜ |
| `i11-midi-program.xy` | i11-3 | Program changed | ⬜ |

### T12 External CV

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i12-cv-baseline.xy` | i12-0 | T12 defaults | ⬜ |
| `i12-cv-param-max.xy` | i12-1 | One CV param → max | ⬜ |

### T13 Audio in

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i13-audio-baseline.xy` | i13-0 | T13 defaults | ⬜ |
| `i13-audio-gain-max.xy` | i13-1 | Input gain/threshold | ⬜ |

### T14 Tape

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i14-tape-baseline.xy` | i14-0 | T14 defaults | ⬜ |
| `i14-tape-param.xy` | i14-1 | One tape param | ⬜ |

### T15 FX I

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i15-fx1-baseline.xy` | i15-0 | T15 defaults | ⬜ |
| `i15-fx1-type.xy` | i15-1 | FX type changed | ⬜ |
| `i15-fx1-param-max.xy` | i15-2 | One param → max | ⬜ |

### T16 FX II

| PC filename | On-device | Action | Status |
| --- | --- | --- | --- |
| `i16-fx2-baseline.xy` | i16-0 | T16 defaults | ⬜ |
| `i16-fx2-type.xy` | i16-1 | FX type changed | ⬜ |
| `i16-fx2-param-max.xy` | i16-2 | One param → max | ⬜ |
