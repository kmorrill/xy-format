# Firmware evidence, OP-XY 1.1.21+0

These are selected disassembly excerpts, manually audited maps and metadata
inventories from a device-derived stock OS loader. The complete firmware and
sample audio are not included. Source SHA-256:
`acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86`.

Start with the canonical [preset JSON](../../docs/format/preset_json.md),
[serialization](../../docs/format/serialization.md) and
[compatibility](../../docs/format/backward_compatibility.md) references.

| Files | Scope |
|---|---|
| `preset-import-*` | JSON parser, validation, conversions, defaults, runtime application |
| `preset-export-*` | Exporter, full field crosswalk, type registries and omissions |
| `preset-files-*` | Filesystem lifecycle, path identity, sample copying, metadata inventories |
| `codec-*` | Stream codec, wrapper, legacy readers and migration chain |
| `fields-*` | Current binary transfers and selected field consumers |
| `storage-*` | Native project lifecycle, backup/workspace handling, external sample loading |

Assembly is fresh extended Blackfin+ objdump output, preserved verbatim where
hashes are recorded. Apparent `ILLEGAL` instructions are retained and explicitly
qualified in reports. They must not be replaced with invented semantics.
Addresses are firmware virtual addresses; runtime offsets and serialized
offsets differ. The names of extraction windows are research labels, not
recovered source symbols. Adjacent instructions may occur in a window.

Extraction scripts depend on the original local loader and analysis helper/
extended decoder in the sibling `music-firmware` repository. Consult each
script's usage before reproducing; that local dependency is not distributed
here. The import/files receipts bind the generated windows to source hashes.
`preset-export-build-schema.py` regenerates the manually audited JSON map
without a device. `codec-probe.py` runs a Python transcription of stream state
against repository fixtures; it does not execute the firmware.

Inventories contain filenames, hashes, sizes and field/type metadata, not
audio or complete commercial preset documents. Local and repository inventories
overlap; their file counts must not be added as unique preset totals.

No evidence here establishes audible results, hardware acceptance of newly
authored files, complete ROM behavior, or power-loss durability. Those limits
are recorded alongside the individual findings.
