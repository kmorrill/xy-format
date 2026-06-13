# 2026-06-12 Mission 3 — Drum pan vs fade

Fixtures: `src/drum-sample-probes/2026-06-drum-pan-fade/`
Operator notes: `src/drum-sample-probes/2026-06-drum-pan-fade/README.md`

## Setup

- Firmware 1.1.4, T1 drum kit **`pp`**, no pattern notes.
- Pad edited: **leftmost low F / kick** → struct **voice 23**, MIDI key **53**.

## Pan (decoded)

| File | UI | Voice | Slot offset | Value |
| --- | --- | --- | --- | --- |
| `d0-baseline-pp.xy` | default | 23 | `+0x06` | 0 |
| `d1-v23-pan-hard-left.xy` | pan L | 23 | `+0x06` | **−100** (u8 `0x9C`) |
| `d2-v23-pan-hard-right.xy` | pan R | 23 | `+0x06` | **+100** (u8 `0x64`) |

Only voice 23 slot `+0x06` changes vs baseline. Slot `+0x05` stays 0.

`ImageProject.set_drum_voice(..., pan=±100)` reproduces the device byte at `+0x06`.

## Fade / loop-crossfade (decoded)

Fade UI on pad **voice 23** is stored on **voice 22** slot **`+0x7C`** (u32).
Image offset `0x524C..0x524F` on these captures.

### Encoding (fine-grained sweep `d3-v23-fade-01` … `14`, `44`…`47`)

```text
ui 0   → u32 0
ui 1..98 → u32 = ui × 0x0147AF00
ui 99  → u32 0x7FFFFFFF
```

Decode (works for all captures, including legacy byte0=`0xFF`):

```text
ui = (u32 >> 8) // 0x0147AF     # clamp 0 and 99 at ends
```

Fine sweep writes **3 bytes** at `+0x524D..+0x524F` (byte at `+0x524C` stays 0).
Earlier `d3-v23-fade-27/63/99` captures wrote **4 bytes** with `+0x524C = 0xFF`;
decode still returns the correct UI.

### Sample values

| UI | u32 (fine sweep) | bytes @ `0x524C` (fine) |
| --- | --- | --- |
| 1 | `0x0147AF00` | `00 af 47 01` |
| 14 | `0x11EB9200` | `00 92 eb 11` |
| 44 | `0x38521400` | `00 14 52 38` |
| 99 | `0x7FFFFFFF` | `00 ff ff 7f` |

## API

- `DrumVoiceSample.fade_ui` — decode from slot `+0x7C` on **storage** voice (22 for pad 23)
- `encode_drum_fade_ui` / `decode_drum_fade_u32`
- `set_drum_voice(..., fade=)` — writes preceding voice `+0x7C`
- `set_drum_voice(..., pan=)` — writes same voice `+0x06`
- Tests: `tests/test_drum_pan_fade_inspection.py`

## Open

- Whether voice−1 storage rule holds for all pads / kits (only validated v23→v22).
- Whether `+0x05` is used on other kits / engines.
