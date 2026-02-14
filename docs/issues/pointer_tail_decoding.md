# Issue: Pointer-Tail Note Decode Gaps

## Summary
- The inspector still reports “note data unresolved” for pointer-driven note payloads (hybrid 0x25 events and pointer-21 blocks) even though we have offsets into the per-step slabs.
- Per-voice node records at `track+0x16xx` mingle live note nodes with static lookup tables, so naïvely reading every 16-byte slice prints garbage (e.g. remnant preset tables, parameter defaults).
- Without a reliable rule for identifying real nodes and converting the `step_token` / `gate` words into track steps, the report would mis-state note positions and durations.

## Latest Investigation (2024-xx-xx)
- Triad / chord captures (`unnamed_3`, `unnamed_80`) show the pointer tail landing on:
  - `track+0x1600` → step bitmap / node headers (`0xDF00`, `voice_id`, `note`, `step_token`, `gate_ticks`).
  - `track+0x1680` and beyond → follow-on slabs whose layout still needs decoding (likely micro offset, allocator state).
  - `track+0x10F0` → parameter slabs (voice envelopes, filter state) – not directly needed for inspector output.
- Inline single-note captures (`unnamed_81`) do **not** allocate these slabs, which confirms the nodes are only present for stacked voices / pointer-driven notes.
- Pointer-21 captures (`unnamed_38`, `unnamed_39`, `unnamed_65`, `unnamed_87`) exhibit the same pointer ladder but with `count=0` or `count=1` headers; the musical data lives entirely in the slabs referenced from the tail.

## Data We Can Trust Today
- `tail_entries` already expose a clean note/velocity pair whenever the velocity byte is > 1. Those values match the change-log descriptions.
- Pointer arrays (`swap_hi`, `swap_lo`) correctly resolve to track-relative offsets; we can log these addresses without guessing at their structure.
- Inline single-note (fine tick) events are decoded correctly and already pass regression coverage.

## Blockers
- Need a deterministic rule to differentiate “live” per-voice nodes from static tables inside `track+0x16xx`.
- Require a formula for turning the `step_token` word into 0-based step indices (triad captures suggest multiples of six, but the pattern breaks on multi-pattern files).
- Gate ticks in these slabs must be verified against controlled captures (e.g., known 2-step / 4-step gates) before we surface them in the report.

## Proposed Next Steps
1. Build a corpus sweep that compares every `track+0x16xx` slice in a chord file against the baseline to isolate strictly the mutated slabs.
2. Capture additional pointer-tail examples with notes on steps {1, 5, 9, 13} and varying gates; document how `step_token` and `gate` change per step.
3. Once mapping is proven, extend `tools/inspect_xy.py` so pointer-tail events emit real `step=` / `beat=` / `gate=` values, and add regression tests for triad & chord cases.
4. Mirror the same decode path for pointer-21 events so live-recorded takes stop emitting the placeholder “note data unresolved”.

## Related Files / Work
- Code: `tools/inspect_xy.py` (tail parsing, pointer metadata).
- Docs: `docs/pointer_tail_notes.md` (structure notes), `docs/format/events.md` (canonical format summary), `docs/logs/2026-02-13_agents_legacy_snapshot.md` (full historical log).
- Tests:
  - `tests/test_inspector_outputs.py` currently fail if bogus extra notes appear; they will need extra assertions once decoding lands.
  - `tests/test_pointer_tail_characterization.py` pins current pointer-tail / pointer-21 event classification behavior for known fixtures.
