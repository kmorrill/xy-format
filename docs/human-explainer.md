# Human Explainer: How `.xy` Project Files Work

## Who This Is For
This is for engineers who know basic C/C++ structs but are new to this repo
and to OP-XY reverse engineering.

Goal: give you a practical mental model fast, without requiring byte-level
mastery on day one.

## TL;DR
An `.xy` file is best understood as:

1. Header (global/project settings)
2. Pre-track descriptor area (multi-pattern topology/index metadata)
3. Track blocks (actual per-track/per-pattern payloads)

Multi-pattern behavior is mostly:

1. Extra logical blocks for tracks that have pattern B/C/etc
2. Descriptor bytes that tell firmware the pattern topology

Note trigs, p-locks, and step components live in track block bodies as typed,
variable-length payloads.

## Big Picture Layout

At a high level:

```text
[header][pre-track region][track block 1][track block 2]...[track block N]
```

Track blocks are discovered by a signature, and each block has:

```text
[4-byte preamble][variable-length body]
```

So this is not a fixed array of one giant struct per track-pattern.

## What The Pre-Track Descriptor Does

Think of the descriptor area as an index or topology header.

It tells firmware things like:

1. Which tracks have multiple patterns
2. How many patterns those tracks have (commonly as maxslot = count - 1)
3. Which descriptor branch/family to use for decoding block layout

It does not contain note-by-note musical details.

### Where it sits

In current docs/tooling, variable descriptor bytes are read from the pre-track
region starting around offset `0x56` up to the start of the handle table.

## What A Block Is

A block is one serialized unit for one logical track-pattern entry.

A block has:

1. A 4-byte preamble
2. A variable-length body

The body can contain different payload families, so blocks are
"polymorphic-like" in practice.

## Leader vs Clone (Device Terms)

When a track has multiple patterns:

1. Pattern 1 block is called the leader
2. Pattern 2+ blocks are called clones

These are all still blocks, but firmware does not always treat them the same.

Important: "clone" here is about device-authored serialized role, not a
tooling shortcut.

### Why We Treat Them As Distinct Roles (Corpus Evidence)

This is not just naming preference. We see repeated structural differences:

1. Different preamble patterns
- Leaders usually carry pattern-count semantics in `pre1` (for example `0x02`,
  `0x03`, `0x08`, `0x09`).
- Clones usually have `pre0 = 0x00`.
- Example (`01_t1_p2_blank`): leader preamble `b5 02 10 f0`, clone preamble
  `00 8a 10 f0`.
- Example (`05_t5_p2_blank`): leader preamble `2e 02 10 f0`, clone preamble
  `00 86 10 f0`.

2. Different descriptor-branch outcomes for the same topology
- In `T2x2`, leader-active (`r01`) and clone-active (`r02`) take different
  descriptor branches (short-form vs long-form).
- Same pattern appears in other tracks (`r05/r06`, `r09/r10` style pairs).
- That means "which slot is active" matters, not just "this track has 2 patterns."

3. Different length behavior in deep multi-pattern files
- In `n110_9pat_8track_notes.xy`, non-last clones are typically 1 byte shorter
  than the last clone in a track set.
- This is a consistent role-based length rule, not random noise.

4. Different chain behavior in `pre1` for clones
- Clone `pre1` behaves like a chain/class byte, not a literal pattern count.
- It can fold to `0x64` in propagation branches (with known exception families).

Plain-English version: leader and clone are both "instances of blocks," but
they are different subclasses in how firmware serializes and links them.

## Are Clones Byte-Identical?

Sometimes they are very close. Sometimes not.

Clones can vary by:

1. Active vs inactive body type (`0x07` vs `0x05`)
2. Presence of note events
3. Tail/trim behavior in some multi-pattern branches
4. Preamble byte differences

So "clone" means "later pattern entry for same track," not guaranteed
byte-for-byte copy.

Color from corpus:

1. In some captures, leader and clones are nearly the same body with small
   differences (for example note bytes), which is why "clone" feels intuitive.
2. In other captures, preamble/state/trim differences are the important part.
3. So "clone" is best understood as a serialization role with shared ancestry,
   not "always a literal duplicate."

## What Kinds Of Payloads We See In Block Bodies

At high level, these payload families exist:

1. Core track/engine/preset/settings bytes
2. Note event payloads (note trigs)
3. Step component payloads (Pulse/Hold/etc)
4. P-lock automation payloads (parameter locks)
5. Tail/pointer-ish regions (some still partially decoded)

Different families have different internal syntax and lengths.

## How Note Trigs Are Stored

Note trigs are event records, not just a simple fixed 16-step on/off bitmask.

Typical note payload contains:

1. Event type
2. Note count
3. Timing/tick fields
4. Gate encoding
5. Note number (MIDI pitch)
6. Velocity

If there are no notes, an entry can remain inactive and skip event payloads.

## How Step Components Are Stored

Step components use typed records with variable-length entries.

They are not encoded the same way as note events, but they follow the same
container idea: typed payload data inside a track block body.

## How P-Locks Are Stored

P-locks are also block-body payloads, using lane/entry formats that vary by
slot family:

1. Common tracks: standard compact entry format
2. Track 1: special wider format
3. Some aux slots (for example T10): distinct format variants

Again: same container, different payload grammar.

## Preamble Bytes (4-byte block header)

Current practical model of preamble bytes:

1. `byte[0]` (`pre0`): role/state class marker
2. `byte[1]` (`pre1`): pattern-count or clone-chain class byte
3. `byte[2]` (`pre2`): bar-length byte (`0x10`=1 bar, `0x20`=2 bars, etc.)
4. `byte[3]` (`pre3`): usually `0xF0` tag in known corpus

### Byte-by-byte detail

1. `pre0` (`byte[0]`)
- This is the most "state-machine-like" byte.
- It acts like a class/role marker for the block in serializer logic.
- Common values you will see:
  - baseline slot-class values like `0xD6`, `0x8A`, `0x86`, `0x2E`, `0x83`, `0x85`
  - `0xB5` on Track 1 in multi-pattern mode
  - `0x00` on clone blocks (pattern 2+ entries)
  - `0x64` in propagation branches after active/event-bearing entries

2. `pre1` (`byte[1]`)
- For leader/regular blocks, this often carries the pattern count for that track.
  - examples: `0x01` (single pattern), `0x02`, `0x03`, `0x08`, `0x09`
- For clone blocks, this is not a simple count. It behaves like a chain/routing
  class byte, often derived from neighboring slot families (or `0x64` in some
  propagation cases).

3. `pre2` (`byte[2]`)
- Encodes bar length in steps-per-bar chunks:
  - `0x10` = 1 bar
  - `0x20` = 2 bars
  - `0x30` = 3 bars
  - `0x40` = 4 bars
- Rule of thumb in code/docs: `bar_count = pre2 >> 4`.

4. `pre3` (`byte[3]`)
- In known-good corpus blocks this is effectively a constant tag byte `0xF0`.
- If this does not look right, parsing/synchronization is usually wrong.

### Real examples

1. `d6 01 10 f0`
- Typical single-pattern baseline style entry.
- `pre1=01` (1 pattern), `pre2=10` (1 bar).

2. `b5 02 10 f0`
- Multi-pattern Track 1 leader example.
- `pre0=b5` (multi-pattern T1 marker), `pre1=02` (2 patterns).

3. `00 8a 10 f0`
- Clone example.
- `pre0=00` marks clone role; `pre1` carries chain-class value.

### Why this matters

Preamble bytes are the earliest per-block "control metadata." They influence:

1. how firmware interprets block role (regular/leader/clone-like state),
2. expected pattern-count context for that track,
3. bar-length interpretation,
4. and some transition behavior between neighboring blocks.

That is why tiny preamble mismatches can make otherwise-correct bodies fail.

`pre0` behavior is modeled as a state machine with branch exceptions.

See: `docs/issues/preamble_state_machine.md`

## Example Ordering (Why Descriptor Matters)

Single-pattern project:

1. `T1P1`
2. `T2P1`
3. `T3P1`
4. ...

If Track 5 has 2 patterns:

1. `T1P1`
2. `T2P1`
3. `T3P1`
4. `T4P1`
5. `T5P1` (leader)
6. `T5P2` (clone)
7. `T6P1`
8. ...

So descriptor + preamble + block order together tell firmware how to walk
logical track-pattern entries.

## What We Are Modeling In This Repo

Working serializer model:

1. Baseline scaffold bytes
2. Plus small compositional structural edits
3. Plus branchy descriptor/preamble state machine decisions

This model explains most corpus files, but not all branches yet.

## What Is Still Open

Major remaining open items:

1. Full trigger conditions for some descriptor branches (`0x40` families)
2. A few activation-state-dependent branch splits
3. Final decode of some pointer-tail regions

## Practical Ramp-Up Path

If you want to go deeper, read in this order:

1. `docs/human-explainer.md` (this file)
2. `docs/format/descriptor_encoding.md`
3. `docs/format/multi_pattern_block_rotation.md`
4. `docs/format/track_blocks.md`
5. `docs/format/events.md`
6. `docs/format/plocks.md`
7. `docs/format/step_components.md`
