# Backward compatibility and format upgrades

**OP-XY firmware 1.1.21+0 loads older `.xy` files through version-specific
readers and a chain of in-memory migrations. Its native writer always saves
format 9.19.** It does not preserve the input format when saving, and the
traced writer has no older-format export path.

These findings come from static inspection of the device-derived stock loader,
not tests on every historical firmware release. The exact source is pinned in
the [firmware receipt](../logs/2026-10-23_firmware_source.json). All addresses
below refer to that build.

## Format version is separate from firmware version

The whole file is one RLE stream. After decoding, the first eight bytes are:

| Decoded header bytes | Meaning |
|---|---|
| 0–3 | Magic `DD CC BB AA` |
| 4 | File-format major |
| 5 | File-format minor |
| 6–7 | Opaque bytes, ignored by this loader |

`09 13` means **format 9.19**: `0x13` is decimal 19. It does not mean firmware
9.19, firmware 1.1.21, or an exact release/build identity. Several firmware
releases could use the same format; this investigation does not establish
which release first wrote every historical format. Header bytes 6–7 do not
provide that missing mapping.

These are decoded offsets. Do not read an arbitrary physical file at byte 4
or split its compressed stream at byte 8 to determine the version. See
[header details](header.md) and [serialization grammar](serialization.md).

## Compatibility supported by the inspected firmware

| Stored format | Firmware 1.1.21+0 behavior |
|---|---|
| 8.0, 8.1 | Read the matching old layout, then migrate through 9.19 |
| 9.0 through 9.18, inclusive | Read the matching layout, then apply every subsequent migration |
| 9.19 | Read directly into the current project representation |
| Any other version, including 8.2, 9.20 or 10.0 | Reject; no nearest-version fallback |

There are **22 accepted format versions**, backed by **17 distinct reader
bodies** and **21 successive converters**. This is an explicit supported set,
not a rule that every numerically older file must be accepted. Recognizing a
version also does not guarantee a malformed project or missing sample assets
will load successfully.

## What happens during loading

1. The loader `0x8d585220` reads the eight decoded header bytes, checks stream
   errors and magic, and accepts only major 8 or 9 at this stage.
2. Dispatcher `0x8d584a40` forms `(major << 8) | minor` and selects the exact
   reader. The dispatch table is at `0x840a2284`.
3. For an old format, that reader reconstructs the old runtime representation
   in scratch RAM. The dispatcher applies converters in order, alternating
   between two scratch buffers. The conversion table is at `0x840a2234`.
4. Once the representation reaches 9.19, the dispatcher copies the current
   runtime project into the requested destination. A 9.19 input instead uses
   reader `0x8d595414` directly and skips the historical converters.
5. The outer loader checks success, validates/normalizes the resulting tracks,
   then publishes the pending project and, when requested, activates it.
   This last validation stage is separate from format migration.

The migration chain is:

```text
8.0 → 8.1 → 9.0 → 9.1 → … → 9.18 → 9.19
```

For example, a 9.16 file uses its own reader and then runs **9.16→9.17,
9.17→9.18 and 9.18→9.19**. It is not parsed with current offsets, nor upgraded
by simply changing its header. A file starting at 9.18 runs only the last
converter; one starting at 8.0 runs all 21.

The final runtime copy is 5,506,924 bytes. That is an allocated RAM structure
with fixed-capacity storage, not the decoded `.xy` payload length. Migration
operates on reconstructed objects rather than directly patching compressed
file bytes.

## Migrations change both layout and meaning

Sharing a reader does not mean a migration can be omitted. Formats 9.7–9.11
share a reader, but their converters still adjust parameter meanings.
Representative changes from the inspected chain:

| Transition | What changes |
|---|---|
| 8.1→9.0 | Constructs sample paths from legacy kit/synth identities |
| 9.1→9.2 | Rebuilds sample metadata using referenced sample assets |
| 9.3→9.4 | Adds two 48-byte tail fields, initially zero |
| 9.6→9.7 | Narrows controller records from 8 to 4 bytes and expands sample records |
| 9.10→9.11 | Remaps Hardsync/FM Strings parameter order and associated LFO selections |
| 9.11→9.12 | Expands scene storage from 16 to 100 records |
| 9.13→9.14 | Raises note capacity from 80 to 120 while keeping 12-byte wire notes |
| 9.15→9.16 | Changes scene records from 38 to 33 bytes; replaces 10 songs with 14 and narrows song scene IDs |
| 9.16→9.17 | Adds two serialized bytes per song and rebuilds packed flags |
| 9.18→9.19 | Expands/reorganizes globals and adjusts a conditional drum parameter |

Some historical conversions need the original sample content, not just `.xy`
bytes. Changing a filename prefix during conversion does not itself prove
samples are copied or renamed on disk. Some parameter/flag meanings remain
unnamed even though their transformation instructions have been inspected.

The complete per-transition table is in the
[firmware migration report](../logs/2026-10-23_firmware_codec_versions.md#every-migration-step).
Machine-readable evidence includes the
[reader/converter map](../../research/firmware-1.1.21/codec-versions.json) and
[all 22 structural layouts](../../research/firmware-1.1.21/codec-legacy-layouts.json).

## What happens when the project is saved again

Writer `0x8d5847d4` explicitly writes major **9** and minor **19** at
`0x8d584822–834`, followed by the current field layout. It has no input-version
selection branch. Thus this firmware's load-and-save path is:

```text
old file → old reader → migrations → current RAM state
         → current serializer → format 9.19 file
```

The deserializer's migration changes RAM; it does not itself overwrite the
source file. However, a higher-level project-load path (`0x8d584264`) also
saves the activated project to `/fat32/projects/workspace.xy`. Consequently,
loading an old named project can produce a current-format workspace without
rewriting that named source. Saving to the original project path is a separate
operation and replaces that file with the current-format serialization.

User-facing save normally moves the prior named project into its backup
hierarchy before writing; the stream writer uses a `.tmp` file and rename.
Backup failure can be logged without preventing the new save, so a backup is
not a guaranteed preservation mechanism. See the
[storage lifecycle](../logs/2026-10-23_firmware_storage.md) for exact ordering,
workspace behavior and failure boundaries.

There is **no traced downgrade converter or “save as older format” option**
in this writer. Whether an older OS can open a newly saved 9.19 project depends
on that OS's own reader/dispatch table; the evidence here cannot promise it.
The inspected OS rejects unknown future versions. Retain an original copy if
the project must remain usable on an older OS. Merely changing the version
bytes neither reverses migrations nor reconstructs an older layout.

## Firmware support versus `xy-format` support

| Component | Current repository behavior |
|---|---|
| `xy.rle.decode_project` | Decodes the stream and returns the header/payload; does not run migrations |
| `xy.rle.encode_project` | Encodes the supplied header/payload; does not upgrade, downgrade or validate their version/layout pairing |
| `xy.serialization.parse_image` | Walks an already-decoded **9.19** payload; receives no version header |
| `xy.preset_state.inspect_preset_state` | Checks 9.19 before using the count-driven layout walker |
| `ImageProject` and legacy inspectors | Retain older layout assumptions; they are not implementations of this migration chain |
| Legacy maps and disassembly | Document old readers/converters; are not an implemented Python importer |

In particular, successfully decompressing an 8.x or older 9.x file does not
make it safe to pass its payload to the current layout walker. Implementing
old-file import requires the corresponding reader, every later converter,
relevant assets and qualification against historical files. All 893 current
`src/**/*.xy` corpus headers are 9.19, so they cannot validate historical import behavior.

The practical compatibility rule is: **load known old versions through their
exact readers and upgrade in order; write the current format; never infer
forward or downgrade support from backward compatibility.**
