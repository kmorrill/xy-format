# hypothesis_tests.py

`tools/hypothesis_tests.py` runs repeatable, corpus-backed checks so we can separate confirmed format behavior from assumptions.

## Commands

- `python tools/hypothesis_tests.py h4-signature`
  - Checks whether every parsed track block still uses the canonical signature shape (`00 00 01 ?? FF 00 FC 00`).

- `python tools/hypothesis_tests.py h10-padding`
  - Checks whether type-`0x05` blocks keep the `08 00` padding word at `body[10:12]`.

- `python tools/hypothesis_tests.py h2-preamble`
  - Reports per-track distinct values for preamble `byte[0]` and how often each track differs from baseline (`unnamed 1`).

- `python tools/hypothesis_tests.py h2-automaton`
  - Tests whether preamble `byte[0]` can be modeled as a small deterministic state machine.
  - Compares several context-key sets (track/clone/prev-active/etc.) and reports:
    - majority-vote accuracy by key set
    - ambiguous key/row rates
    - top conflict keys
  - Also evaluates two explicit rule candidates against corpus logical entries:
    - `prev_active` propagation rule
    - `prev_has_event` propagation rule (event-gated)

- `python tools/hypothesis_tests.py h7-pretrack`
  - Diffs pre-track regions against baseline pre-track and summarizes edit signatures (insert/replace/delete patterns).

- `python tools/hypothesis_tests.py h7-compositional`
  - Tests whether pre-track changes are mostly explainable as a small set of repeated structural edit atoms.
  - Reports:
    - op-count distribution per file
    - frequent insertion/replacement sites
    - coverage by top scripts/atoms
    - a coarse support verdict for the compositional hypothesis

- `python tools/hypothesis_tests.py h8-t5-exemption`
  - Tests the Track-5 preamble exemption hypothesis using logical-entry mapping
    (so multi-pattern block rotation does not confound track identity).
  - Reports:
    - leader T5/T6 preamble distributions
    - how often leader T5 follows active T4 and its resulting preamble
    - how often leader T6 follows active T5 and its resulting preamble

- `python tools/hypothesis_tests.py event-models`
  - Extracts parseable note events from corpus files, serializes the same logical note lists with six competing serializer hypotheses, and scores byte-level matches.

- `python tools/hypothesis_tests.py event-dispatch`
  - Focused test of the two primary serializer families:
    - writer-style (`build_event` path)
    - compact continuation serializer (`0x00/0x01/0x04` style)
  - Reports exact-match partition (`both`, `compact_only`, `writer_only`, `neither`) and simple dispatch-rule candidates on decisive cases.

## Input Selection

By default the script scans:

- `src/one-off-changes-from-default/*.xy`
- `src/*.xy`

You can override or add patterns:

```bash
python tools/hypothesis_tests.py event-models \
  --glob 'src/one-off-changes-from-default/unnamed 8*.xy'
```

## Why This Exists

The goal is to move from "plausible story" reverse engineering toward falsifiable tests:

1. Parse real corpus artifacts.
2. Apply explicit hypotheses.
3. Measure exact and near-exact byte matches.
4. Keep only models that survive corpus evidence.
