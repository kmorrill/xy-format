# Known-Good Fixture Test Plan (Ranked)

## Goal
Build a complete, prioritized test inventory grounded in existing known-good `.xy` fixtures so we can systematically increase parser/writer/compiler confidence without guessing.

## Scope
- Source fixtures: `src/one-off-changes-from-default/*.xy`, `j0*` scaffolds, and generated device-pass files listed in `src/one-off-changes-from-default/op-xy_project_change_log.md`.
- Validation surfaces:
  - parser/decoder correctness
  - writer/compiler byte safety
  - crash regression safety
  - optional device-load validation for generated outputs

## Priority Rubric
- `P0`: ship/safety critical; incorrect behavior can cause crashes, invalid files, or silent corruption in common flows.
- `P1`: high-value coverage that materially improves confidence for major subsystems.
- `P2`: important but not blocking current note/multi-pattern authoring goals.
- `P3`: exploratory/edge cases and anomaly cleanup.

## Test Types
- `BYTE`: byte-exact match against known-good fixture.
- `STRUCT`: structural invariants (offsets, block counts, descriptor placement, handle table shape).
- `SEM`: semantic decode assertions (notes, gates, params, mappings).
- `CRASH`: explicit regression guard for known crash classes.
- `DEVICE`: load result recorded on hardware (`pass`/`crash`).

## Ranked Backlog

| ID | Pri | Domain | Fixtures (examples) | Assertions | Status |
|---|---|---|---|---|---|
| T001 | P0 | Container parse/round-trip safety | broad corpus sweep | `STRUCT`: parse succeeds and `to_bytes()` round-trips | Partial |
| T002 | P0 | Header transport decode | `unnamed 1/4/5/10/11/12/42/44/45/46/47/48/49` | `SEM`: tempo/groove/metronome values at canonical offsets | Partial |
| T003 | P0 | Header patch writer safety | baseline + patched outputs | `BYTE/SEM`: patched header fields only; no unintended body drift | Partial |
| T004 | P0 | Core note trig writer (single-pattern) | `unnamed 2`, `unnamed 81` | `BYTE`: exact reproduction from JSON spec | Done |
| T005 | P0 | Multi-pattern strict writer (`T1+T3`) | `unnamed 105`, `unnamed 105b`, `unnamed 102-104` | `BYTE/STRUCT`: descriptor + block rotation correctness | Partial |
| T006 | P0 | Event type selection by preset | `unnamed 91/93/94/116/117` | `SEM`: event tag matches preset/device behavior | Partial |
| T007 | P0 | Activation + adjacent preamble propagation | `unnamed 93`, `unnamed 91` | `STRUCT/CRASH`: `0x64` propagation rules, including T5 exemption | Partial |
| T008 | P0 | Crash regression harness | crash #1/#2/#3 cases in `docs/debug/crashes.md` | `CRASH`: known bad patterns rejected or corrected paths enforced | Partial |
| T009 | P0 | Pre-track descriptor/handle safety | `unnamed 6/7/102/103/104/105/105b`, `j05/j06/j07` | `STRUCT`: insertion offset variants (`0x56/0x57/0x58`), handle table integrity | Partial |
| T010 | P0 | Scaffold-preserving large topology behavior | `j06_all16_p9_blank`, `j07_all16_p9_sparsemap` | `STRUCT/SEM`: deterministic addressing and overflow packing | Partial |
| T011 | P0 | Pointer-tail and pointer-21 decode | `unnamed 65/78/79/80/86/87` | `SEM`: trustworthy `step/gate/note` extraction where currently unresolved | Partial |
| T012 | P0 | JSON compiler reproducibility gate | golden fixture set | `BYTE`: `tools/build_xy_from_json.py --expect ...` pass/fail gating | Partial |
| T013 | P0 | Generated multi-pattern device-pass stability | `mp2_v5_*`, `mp2_v7_*` (from change log) | `STRUCT/DEVICE`: generated novel files remain load-safe | Partial |
| T014 | P1 | Note event encoding variants | `unnamed 3/38/50/56/57/80/92/94/101` | `SEM/BYTE`: chords, gates, offsets, long bars, velocity handling | Partial |
| T015 | P1 | Pattern length + track scale | `unnamed 17/18/19/20/21/22` | `SEM/BYTE`: preamble length bytes + scale mapping | Partial |
| T016 | P1 | Step components single-step bank coverage | `unnamed 8/9/59-78` | `BYTE`: component insertion and alloc-byte correctness | Done/Partial |
| T017 | P1 | Step components multi-step stream | `unnamed 118/119` | `SEM/STRUCT`: repeat-block parsing and variable-length records | Partial |
| T018 | P1 | P-lock decode/mapping (hold-record path) | `unnamed 120-126`, `unnamed 35`, `unnamed 115` | `SEM`: param-id map, lane decoding, aux coverage | Partial |
| T019 | P1 | MIDI directory/header coupling | `unnamed 41`, `unnamed 54` | `STRUCT/SEM`: entry-size/count and descriptor deltas | Partial |
| T020 | P1 | Track sound parameter surface (M1-M4/filter/LFO) | `unnamed 23-33/40/82/83/84` | `SEM`: changed controls appear in expected regions/maps | Partial |
| T021 | P1 | 4-bar sequencing + density | `unnamed 101` | `SEM/STRUCT`: multi-bar note count/timing integrity | Partial |
| T022 | P1 | Inspector expectation consistency | all change-log fixtures | `SEM`: stable expected lines for known edits | Done/Partial |
| T023 | P2 | Scene/song structural decode | `unnamed 13/149/150/151/152/154/155/150b/152b/154b/155b` + dedicated scene/song captures | `STRUCT/SEM`: scene/song block localization and minimal decode | Gap |
| T024 | P2 | Mix/master control decode beyond EQ | `unnamed 14/16` + future captures | `SEM`: stable master control mapping confidence | Gap |
| T025 | P2 | Engine swap topology stress | `unnamed 34`, `unnamed 34b-34l`, `unnamed 91` | `STRUCT/SEM`: engine-id transitions + event-family implications | Gap |
| T026 | P2 | Ambiguous MIDI clock-era CC captures quarantine | `unnamed 95-99` | `SEM`: limited assertions only (non-definitive due loop contamination) | Gap |
| T027 | P3 | Metronome mute anomaly isolation | `unnamed 10` | `STRUCT`: isolate exact 4-byte header shift behavior | Gap |
| T028 | P3 | Unknown step-component type follow-up | `unnamed 119` | `SEM`: decode 14th type and add stable mapping | Gap |

## Execution Plan (How We Chip Away)

1. Wave A (`P0` hardening, immediate)
   - Close `T005`, `T007`, `T008`, `T009`, `T010`, `T011`, `T012`.
   - Exit criteria: no known-crash regressions, strict multi-pattern fixtures gated by `--expect`, pointer-tail issue reduced or clearly fenced.

2. Wave B (`P1` breadth)
   - Close `T014` to `T022`.
   - Exit criteria: step components + p-lock mappings have explicit regression fixtures and pass in CI.

3. Wave C (`P2/P3` completion)
   - Close `T023` to `T028`.
   - Exit criteria: arrangement/mix/edge anomalies documented with either passing tests or explicit deferred rationale.

## Golden Fixture Sets (Initial)

- `golden_note_core`
  - `unnamed 1`, `unnamed 2`, `unnamed 3`, `unnamed 56`, `unnamed 81`, `unnamed 92`.
- `golden_multipattern_strict`
  - `unnamed 102`, `unnamed 103`, `unnamed 104`, `unnamed 105`, `unnamed 105b`.
- `golden_scaffold_topology`
  - `j05_t2_p3_blank`, `j06_all16_p9_blank`, `j07_all16_p9_sparsemap`.
- `golden_plocks`
  - `unnamed 120`, `unnamed 121`, `unnamed 122`, `unnamed 123`, `unnamed 124`, `unnamed 125`, `unnamed 126`.
- `golden_components`
  - `unnamed 8`, `unnamed 9`, `unnamed 59-78`, `unnamed 118`, `unnamed 119`.

## Notes
- Treat `unnamed 95-99` as non-definitive for strict value assertions due the recorded loop/post-roll caveat in the change log.
- For generated outputs that are known device-pass but intentionally non-byte-identical (for example `mp2_v5_*`, `mp2_v7_*`), prefer `STRUCT + DEVICE` assertions over strict `BYTE` equality.
- `T023` fixture curation update (2026-02-14): `unnamed 6` is byte-identical to `01_t1_p2_blank` (multi-pattern, not arrangement-specific) and `unnamed 15` matches the EQ-mid delta family (`unnamed 14/16`), so `unnamed 13` is currently the only clean song-mode candidate.
- `T023` addendum (2026-02-14): user-confirmed pair `unnamed 150` (baseline Song1/loop-off control) vs `unnamed 149` (Song2 initialized, loop-off) is now the primary controlled `Song1 vs Song2` fixture; current diffs are compact pre-track edits plus tiny Track-16 tail toggles.
- `T023` addendum (2026-02-14, second pass): `unnamed 151` (Song3 selected, loop-off) and `unnamed 152` (Scene2 initialized) add a second controlled axis and show tiny coordinated Track-16 tail toggles alongside compact pre-track edits.
- `T023` addendum (2026-02-14, third pass): combined-state fixture `unnamed 154` (Song2 + Scene2 initialized, loop-off) shows three pre-track byte flips (`0x0F/0x10/0x11`) plus a Track-16 tail structural rewrite (`insert @ +0x0163: 02 00 01 01 00 00`, tail trim `01 00 00 01`, net `+2` bytes) against `unnamed 150`.
- `T023` addendum (2026-02-14, fourth pass): `unnamed 155` is reassigned as `07` (Song2 with three arranged scenes, loop on). Against `unnamed 150`, it changes pre-track `A[0x0F:0x12]=00 00 10 -> B[0x0F:0x11]=02 01` and performs a Track-16 tail reshape (`insert @ +0x0163: 03 00 01 02 00 00 00`, tail trim `01 00 00 01`, net track16 `+3` bytes).
- `T023` addendum (2026-02-14, fifth pass): mute probes `unnamed 150b/152b/154b/155b` confirm scene mute persistence. All four add variable pre-track record payloads and apply the same Track `9..16` structural rewrite (`... 19 40 00 00 01 60 ... -> ... 11 40 00 00 01 40 00 00 01 40 00 00 01 60 ...`), while mute-specific values vary in inserted pre-track words.
- `T023` addendum (2026-02-14, sixth pass): loop pair `unnamed 154 loop` -> `unnamed 154 nl` is a clean single-byte toggle with identical size/pre-track and one changed byte at file `0x252A` (`track16+0x016E`, `00 -> 01`), making it the current best per-song loop flag candidate for Song 2 in the normalized branch. `unnamed 150` -> `unnamed 150 nl` remains branch-entangled (`+60` bytes, Tracks `9..16` rewritten), so Song-1 loop polarity is not yet isolated in that path.
- `T023` addendum (2026-02-14, seventh pass): `unnamed 150 nl` -> `unnamed 150 lp` isolates Song-1 loop within the normalized branch: same size/pre-track, only two bytes changed (`track16+0x0169: 01 -> 00`, `track16+0x016A: 00 -> 01`). Together with Song-2 toggle at `track16+0x016E`, this supports per-song loop storage in Track-16 control bytes with song-slot-specific positions.
- `T023` addendum (2026-02-14, eighth pass): `unnamed 151 nl` (Song3 loop-on intent) confirms Song3 can enter the same normalized branch (`+64`, Tracks `9..16` rewrite, pre-track length unchanged), and its track data matches `unnamed 150 lp` aside from song-selection pre-track byte. Song-3 loop byte position is still pending a clean same-branch on/off pair (`151 nl` -> `151 <loop-off>`).
- `T023` addendum (2026-02-14, ninth pass): `unnamed 151 nl` -> `unnamed 151 lp` closes Song-3 loop isolation in the normalized branch: same size/pre-track with only two byte swaps (`track16+0x0171: 00 -> 01`, `track16+0x0172: 01 -> 00`). Current loop map is now explicit for Songs 1-3 via song-slot-specific Track-16 control offsets.
- `T018` now has automated corpus mapping coverage in `tests/test_plock_mappings.py` for `unnamed 120-126`, `unnamed 35`, and `unnamed 115` (standard lanes, T1 slot signatures, and T10 9-byte header path).
- P-lock parser + value-rewrite primitives are centralized in `xy/plocks.py` and reused by tests plus `tools/extract_plocks.py`/`tools/write_plock_*.py`.
- Builder-facing p-lock authoring coverage now lives in `tests/test_plock_builder.py` (track transplant + standard single-lane/group rewrites with value-floor guardrails).
- JSON compiler reproducibility coverage now includes byte-exact fixtures:
  - single-pattern: `unnamed 2/56/57/81/92`
  - strict multi-pattern: `unnamed 102/103/104/105/105b`, `j05_t2_p3_blank`, `j06_all16_p9_blank`, `j07_all16_p9_sparsemap`
  - plus a CLI `--expect` golden matrix in `tests/test_build_xy_from_json_cli.py` for all currently reproducible JSON fixture builds.
  - plus CLI integration checks for `--dry-run`, `--expect` mismatch exit handling, and output override behavior.
- Remaining `T012` gaps (why still Partial):
  - `unnamed 3` chord/triad capture is not yet byte-reproducible via current note-event path (compact live-chord continuation variant; currently asserted as expected mismatch in JSON/CLI tests).
  - non-scaffold chord/event variants still need broader byte-golden coverage beyond the current reproducibility matrix.
