# build_xy_from_json.py

`tools/build_xy_from_json.py` compiles an agent-editable JSON spec into a binary `.xy` file.

It uses existing writer paths in this repo:
- one-pattern form (`patterns` length = 1 for every listed track) -> `append_notes_to_tracks`
- multi-pattern form (`patterns` length >= 2 for every listed track) -> `build_multi_pattern_project`

## Usage
- `python tools/build_xy_from_json.py <spec.json>`
- `python tools/build_xy_from_json.py <spec.json> --output output/my_project.xy`
- `python tools/build_xy_from_json.py <spec.json> --dry-run`
- `python tools/build_xy_from_json.py <spec.json> --expect <target.xy>`

Relative `template` and `output` paths in the spec are resolved relative to the spec file location.

## Spec Schema (v1)

Top-level fields:
- `version` (`int`, required): currently `1`
- `mode` (`"multi_pattern"`, required)
- `template` (`string`, required): source `.xy` scaffold
- `output` (`string`, optional): output path (can be overridden by CLI `--output`)
- `descriptor_strategy` (`"strict"` | `"heuristic_v1"`, optional; default `strict`)
- `header` (`object`, optional):
  - `tempo_tenths` (`0..65535`)
  - `groove_type` (`0..255`)
  - `groove_amount` (`0..255`)
  - `metronome_level` (`0..255`)
- `tracks` (`array`, required)

Track entry:
- `track` (`1..16`)
- `patterns` (`array`, at least 1)
  - each item is either:
    - `null` (blank pattern), or
    - note array

Form rules:
- If all listed tracks have exactly 1 pattern entry, compiler uses the one-pattern path.
- If all listed tracks have at least 2 pattern entries, compiler uses multi-pattern builder path.
- Mixed counts (`1` on some tracks, `>=2` on others) are rejected.

Note object fields:
- `step` (`>=1`, required)
- `note` (`0..127`, required)
- `velocity` (`0..127`, optional; default `100`)
- `tick_offset` (`>=0`, optional; default `0`)
- `gate_ticks` (`>=0`, optional; default `0`)

## Example: one-pattern form

```json
{
  "version": 1,
  "mode": "multi_pattern",
  "template": "src/one-off-changes-from-default/unnamed 1.xy",
  "output": "output/json_single_t3.xy",
  "header": {
    "tempo_tenths": 1240
  },
  "tracks": [
    {
      "track": 3,
      "patterns": [
        [
          { "step": 1, "note": 36, "velocity": 104, "gate_ticks": 720 },
          { "step": 5, "note": 36, "velocity": 102, "gate_ticks": 720 },
          { "step": 9, "note": 43, "velocity": 106, "gate_ticks": 720 },
          { "step": 13, "note": 41, "velocity": 104, "gate_ticks": 720 }
        ]
      ]
    }
  ]
}
```

## Example: multi_pattern

```json
{
  "version": 1,
  "mode": "multi_pattern",
  "template": "src/one-off-changes-from-default/unnamed 1.xy",
  "output": "output/json_multi_t1_t3.xy",
  "descriptor_strategy": "strict",
  "tracks": [
    {
      "track": 1,
      "patterns": [
        null,
        [{ "step": 1, "note": 60, "velocity": 100 }]
      ]
    },
    {
      "track": 3,
      "patterns": [
        null,
        [{ "step": 2, "note": 52, "velocity": 100 }]
      ]
    }
  ]
}
```

## Safety Notes
- This compiler does not invent a new binary writer path; it wraps existing constrained authoring code.
- Multi-pattern form + `strict` follows the same validated descriptor constraints as current builder code.
- Output is parsed back through `XYProject` to confirm structural round-trip integrity before write.

## Byte-Match Verification
Use `--expect` to compare compiled output against an existing `.xy`:

- On match: prints `expect match: yes` and SHA1.
- On mismatch: prints size/SHA1 for both files and the first differing byte offset.
- Exit code is `2` when `--expect` is set and bytes do not match.

Example (known corpus match):
- `python tools/build_xy_from_json.py .tmp/spec_match_unnamed2.json --expect "src/one-off-changes-from-default/unnamed 2.xy" --dry-run`
- `python tools/build_xy_from_json.py .tmp/spec_match_mp_t1_t3.json --expect "src/one-off-changes-from-default/unnamed 105.xy" --dry-run`
