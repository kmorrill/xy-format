# Complete Project JSON Spec (User-Controlled Draft)

## Purpose
This is the long-term JSON contract for **user-controllable OP-XY project intent**.

The JSON should contain what a user can set on-device (or conceptually set through the manual), and avoid low-level binary implementation details.

## Core Rule
If a field is not a user control, it does not belong in authored JSON.

Examples of fields that should **not** be in authored JSON:
- template provenance (`source_template`)
- static limits/constants (`max_tracks`, `max_scenes`, etc.)
- binary offsets, descriptor byte blobs, handle tables, preamble bytes
- parser/debug internals

Those stay in compiler/runtime black-box logic.

## Scope
Include:
1. Musical/arrangement controls
2. Track sound and mix controls
3. Pattern note/step behavior
4. Scene/song sequencing
5. External asset references (sample/preset refs)

Exclude:
1. Binary-structure controls
2. Reverse-engineering diagnostic fields
3. Static limits that are not user-editable

## User-Controlled Coverage (Target)

| Domain | Target JSON Coverage |
|---|---|
| Transport | tempo, time signature, groove type/amount, metronome |
| Global mix | group levels, EQ, master M3 gain/clip/tone/mix, compressor, output level |
| Project settings | transpose, voice allocation intent, MIDI channel assignments |
| Tracks 1-8 | engine/preset intent, envelopes, filter, LFO, play mode, portamento, bend range, mixer sends |
| Tracks 9-16 | role-specific controls (brain/punch-in/midi-out/cv-out/audio-in/tape/fx1/fx2) |
| Patterns | notes, timing/micro, gate/length, step components, parameter locks, conditions |
| Scenes | per-track pattern selection + scene mix snapshot |
| Songs | scene order + loop |
| Assets | sample references / preset references |

Reference sources:
- `docs/OP-XY_project_breakdown.txt`
- `docs/reference/opxy_limits.md`
- `docs/reference/opxy_midi_cc_map.md`
- `docs/format/*`

Confidence note:
- Names copied from manual prose are provisional unless confirmed in `docs/format/*`.
- Master M3 is modeled with the current user-facing labels `gain`, `clip`, `tone`, `mix`; byte-level mapping can still refine value semantics/ranges.

## Normative JSON Shape (User-Controlled)

```json
{
  "schema": {
    "name": "opxy.project.user",
    "version": "0.2.0-draft"
  },
  "project": {
    "name": "",
    "transport": {
      "tempo_bpm": 120.0,
      "time_signature": "4/4",
      "groove": {
        "type": "straight",
        "amount": 0
      },
      "metronome": {
        "enabled": false,
        "level": 0
      }
    },
    "master": {
      "group_levels": {
        "percussion": null,
        "melodic": null
      },
      "eq": {
        "low": null,
        "mid": null,
        "high": null,
        "blend": null
      },
      "master_m3": {
        "gain": null,
        "clip": null,
        "tone": null,
        "mix": null
      },
      "compressor_amount": null,
      "output_level": null
    },
    "settings": {
      "global_transpose": null,
      "track_voice_allocation": [
        {
          "track": 1,
          "voices": null
        }
      ],
      "track_midi_channels": [
        {
          "track": 1,
          "channel": null
        }
      ]
    },
    "tracks": [
      {
        "track": 1,
        "role": "instrument",
        "mix": {
          "volume": null,
          "mute": null,
          "pan": null,
          "send_to_ext": null,
          "send_to_tape": null,
          "send_to_fx1": null,
          "send_to_fx2": null
        },
        "sound": {
          "engine": null,
          "preset": null,
          "play_mode": null,
          "portamento": null,
          "pitch_bend_range": null,
          "engine_params": {},
          "amp_envelope": {},
          "filter_envelope": {},
          "filter": {},
          "lfo": {}
        },
        "role_controls": {},
        "patterns": [
          {
            "pattern": 1,
            "length_steps": 16,
            "scale": null,
            "notes": [
              {
                "step": 1,
                "note": 60,
                "velocity": 100,
                "gate_ticks": 0,
                "tick_offset": 0,
                "condition": null
              }
            ],
            "step_components": [
              {
                "step": 1,
                "type": null,
                "variation": null,
                "params": {}
              }
            ],
            "parameter_locks": [
              {
                "step": 1,
                "parameter": null,
                "value": null,
                "condition": null
              }
            ]
          }
        ],
        "assets": {
          "samples": [],
          "preset_ref": null
        }
      }
    ],
    "scenes": [
      {
        "scene": 1,
        "track_patterns": [
          {
            "track": 1,
            "pattern": 1
          }
        ],
        "mix_snapshot": {
          "track_volume": [],
          "track_mute": [],
          "track_pan": [],
          "track_send_ext": [],
          "track_send_tape": [],
          "track_send_fx1": [],
          "track_send_fx2": []
        }
      }
    ],
    "songs": [
      {
        "song": 1,
        "loop": false,
        "scene_order": [1]
      }
    ]
  }
}
```

## Aux Track Role Set

For tracks 9-16, `role` should be one of:
- `brain`
- `punch_in`
- `midi_out`
- `cv_out`
- `audio_in`
- `tape`
- `fx1`
- `fx2`

## Black-Box Compiler Responsibilities (Not Authored JSON)

These stay internal:
1. Template/scaffold selection
2. Descriptor byte strategy and binary topology mapping
3. Pre-track handle offsets and track-block packing details
4. Unknown-byte preservation and round-trip safety mechanisms
5. Static device limits and hard validation constants

## Evolution Plan
1. Keep this as the user-facing contract target.
2. Map each field to canonical format docs as decode confidence improves.
3. Keep binary internals hidden behind compiler profiles, not authored JSON.
