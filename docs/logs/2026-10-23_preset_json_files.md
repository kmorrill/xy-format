# Preset JSON files: filesystem lifecycle, 2026-10-23

Firmware: backed-up OP-XY 1.1.21 loader SHA-256
`acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86`.
This is static firmware evidence and a metadata-only local file inventory; no
new device experiment, audition, or hardware write was performed.

The filesystem preset reader loads a JSON DOM, derives identity from its file
path, and applies that DOM to a runtime pattern. Saving a preset exports the
current track state to JSON, optionally copies audio into a preset directory,
and writes `patch.json` through a temporary file. Native `.xy` projects instead
serialize pattern state and external sample paths. Repeated sound state in a
project is therefore not evidence of repeated embedded JSON files.

## Evidence and reproduction

Run `python research/firmware-1.1.21/preset-files-extract.py` in the original
local environment, or pass the sibling `inspect_firmware.py` path explicitly.
The read-only helper verifies the loader hash and materializes loader fill
records; the extended decoder generates fresh assembly. The 22 windows and
byte/assembly hashes are in `preset-files-extract-receipt.json`. They include
adjacent code and provisional research labels, not recovered C++ symbols.
Do not use the earlier whole-image disassembly as replacement evidence.

The JSON field importer/exporter is independently covered by the companion
preset-import/preset-export investigation. This report owns paths, persistence,
identity, and filesystem side effects rather than duplicating its field tables.

## Actual files inspected

`preset-files-inventory.json` inventories 513 `patch.json` files under the local
`op-xy-live` tree: 247 under `full-xy-filesystem`, 225 under `generated`, and 41
under `presets`. Types: sampler 158, prism 76, wavetable 53, drum 38, hardsync 36,
axis 34, epiano 26, multisampler 26, organ 23, simple 22, dissolve 21. These are
file counts, including generated copies, not a count of unique device presets.
The searched backup and other candidate sibling directories had no additional
files named `patch.json`; this does not imply the device lacks factory presets
inside its packed filesystem.

`preset-files-latest-main-inventory.json` separately inventories 361 such files
in the clean latest-main checkout `/tmp/xy-format-preset-json-20261023`:
sampler 256, drum 53, axis 10, epiano 10, organ 9, prism 8, dissolve 6, simple 6,
hardsync 2, wavetable 1. All 1,295 region sample references in this checkout
are slash-free basenames. The two inventories are not disjoint and must not
be added to infer a unique preset total. Both contain paths, sizes, hashes,
field names and type metadata; neither embeds the preset documents or audio.

Latest-main also contains the separate factory-preset `.xy` captures described
in `src/factory-preset-captures/README.md`: batches `fp01` through `fp18` cover
142 remaining factory presets plus baseline/earlier Strings evidence. Those
are captures of applied sound state, not factory `patch.json` extraction and
not bundled factory audio. This distinction matters when comparing JSON
source files to the binary project produced after loading them.

## Read, parse, select, apply

| Address | Observed role |
| --- | --- |
| `0x8d4deadc` | Filesystem JSON load wrapper: read into object+8, derive identity strings from file path, retain full file path at object+0x14, then invoke JSON field import. |
| `0x8c03fb08` | Clear destination DOM, whole-file read via `0x8c03eb00`, construct JSON parser `0x8c04e860`, parse via `0x8c04fe40` with flag 1, log read/parse failures, destroy parser and return bool. |
| `0x8d4e3a60` | Preset path parser with `.json`, `.preset`, `patch.json`, `presets`, content and filesystem path cases. Outputs are assigned to object+0x164 and object+0x148 by the load wrapper. |
| `0x8d4de93c` | DOM import wrapper leading to `0x8d4ddca4`. |
| `0x8d4d7998` | Queued load worker, rejecting a superseded per-track request sequence before loading the file; success stored at request+0x2c. |
| `0x8d4d7a7c` | Completion callback: enter apply gate, apply loaded object via `0x8d4dced8` with request byte+0x2e, optionally call `0x8d573180` for byte+0x2d, then leave gate. |
| `0x8d573180` | Clear bit 3 of active pattern byte+0x14, mark project dirty and increment its revision. This is not a sequence-data reset. |

The request's object starts at +0x30; track is +8, request sequence +0xc, and
file path string +0x10. Other immediate completion callbacks at `0x8d4d771c`
and `0x8d4d781c` use full-apply flag 1. The file reader itself is distinct from
remote SysEx's in-memory JSON transport: common DOM/field application does
not make every remote JSON command a file read or write. A successful JSON
parse alone also does not prove sample resolution or successful audio playback.

The full-apply function composes `object[0x164] + "/" + object[0x148]` and calls
`0x8d573360`. That setter copies at most 48 bytes into the current runtime
pattern's +0x454c identity field and marks the project dirty; getter
`0x8d5733a0` returns that same field. This establishes identity separately from
the sound values copied into the pattern. The additional 48-byte field +0x53c4
is persisted by the binary codec, but this trace did not establish that it is
a second copy of the loaded preset identity. Do not assign it that meaning
merely because its size matches.

### Identity path grammar

The splitter `0x8d4e3924` discards empty slash-separated components, including
leading, trailing and repeated separators. The ordinary branch `0x8d4e3b6c`
accepts 3 through 6 remaining components and requires the last to end in the
case-sensitive suffix `.json`. Define `parts` as those components:

```python
if parts[-2].endswith(".preset"):
    require len(parts) >= 4 and parts[-1] == "patch.json"
    name = parts[-2][:-7]
    bank = "/".join(parts[2:-2]) or "snapshot"
else:
    name = parts[-1][:-5]
    bank = "/".join(parts[2:-1]) or "snapshot"
identity = bank + "/" + name
```

The final `.json` suffix comparison is at `0x8d4e3c2a`, `.preset` suffix at
`0x8d4e3d08`, exact `patch.json` test at `0x8d4e3fc8`, and bundle minimum
component count at `0x8d4e3f80`. This ordinary identity parser does **not**
validate that the first two components are literally `fat32/presets` or
`content/presets`; filesystem scanning and callers provide separate limits.
It is not path canonicalization: `.` and `..` are not resolved by the splitter.
For example `/fat32/presets/bass.json` gives `snapshot/bass`, and
`/fat32/presets/bank/bass.preset/patch.json` gives `bank/bass`.

For more than six components, a special prepass searches for a `dlc` component
starting at index 1, then a later `presets` component starting two components
beyond that `dlc` (`0x8d4e3ad0` through `0x8d4e3b5c`). If found, the vector
rewrite `0x8d4e4068` replaces the prefix through `presets` with two synthetic
components, `x` and `presets`, retaining the tail, and resumes ordinary parsing.
Thus deep DLC package prefixes do not become the displayed bank identity.
Absent that recognizable prepass, more than six components fail the ordinary
count check. This is a vector/string operation; it does not require ROMFS data.

The file-loading wrapper ignores this identity parser's boolean return at
`0x8d4deb52`: it still assigns the output strings and invokes DOM import. In
contrast DB delete/move paths check it. Therefore an identity-path failure is
not equivalent to rejection of the JSON file contents. Outputs may already
have been partly assigned when the parser returns false; callers must not
assume transactional identity parsing.

## Sample path resolution: a nonstandard rule

`0x8d4dcca0` means `sample.rfind('/') == npos`, not POSIX relative-path testing.
It calls reverse-find `0x8d4d7624` with character `/` and start `0xffffffff`,
then compares the returned index to the same global npos value at `0x840c00b8`.
Full apply calls it around `0x8d4dd408`; the true branch at `0x8d4dd574` joins
`dirname(object.full_file_path)` with the sample string.

| JSON sample | Full-apply path operation |
| --- | --- |
| `kick.wav` | Join directory containing `patch.json` with `kick.wav`. |
| `sub/kick.wav` | Preserve the string; it already contains a slash. |
| `/fat32/samples/kick.wav` | Preserve the string. |
| `content/samples/kick.wav` | Preserve the string. |
| `<samples>/kick.wav` | Preserve the string for later shortcut resolution. |

Both branches subsequently call DLC reverse-compression `0x8d5a40d0` and copy
the resulting path into the region's 96-byte path field (`0x8d4dd530`). The
record loop covers the runtime sample records handled by the full importer.
Directory extraction is `0x8d5a4638`; join is `0x8d5a48a6`. Join inserts one
separator if the left side lacks one, but does not give an absolute right side
POSIX override semantics. Shortcut expansion `0x8d5a42b0` occurs later at
sample loading, and in the preset-save copy path. Reverse compression only
recognizes registered `content/dlc/` roots; it is not general path normalization.

Consequently the adapter's previous unconditional prefixing whenever
`preset_device_path` is supplied is broader than firmware behavior. The
slash-free corpus alone cannot expose this difference. Missing resources
remain an independent external-dependency failure even when the project and
JSON syntax are valid. See the storage report for the sample-ID/path cache and
shortcut registry.

## Save, overwrite, copy audio, and clean up

The controller at `0x8c0b0eb0` first rejects the busy state, initializes a patch
object (`0x8d4db82c`), exports the current track (`0x8d4dec6c`), and calls
`0x8d4e0a40` with the destination folder. Its two visible modes select either
a new snapshot folder or the current user preset folder. Snapshot names use
`/fat32/presets/snapshot/%s (%i)%s`, date format `%i-%02i-%02i` and `.preset`;
`0x8c0b0bb0` tries numeric suffixes 1 through 99. Existing-path helper
`0x8c0b0cb0` reads the +0x454c identity, looks up its hash in the preset DB,
rejects absent/factory content candidates, and strips `/patch.json` when present.

After save, the overwrite branch calls `0x8d4e0868`, while the new branch calls
DB updater `0x8d4e8220`. The controller constructs the saved `patch.json` path
and queues a new file load via `0x8d4d8f70(track, path, 0, 0)`. Thus saving is
followed by reloading the written preset and refreshing runtime/UI state;
it is not just exporting detached text.

`0x8d4e0a40` performs the bundle save:

1. Clone the region data and normalize the folder through dirname/basename join.
   Ensure its directory exists (`0x8c03e328`, otherwise `0x8c03e06c`).
2. For each sample, `0x8d4e07e0` expands shortcuts and tests `content/dlc/`.
   DLC samples are expanded then reverse-compressed into their registered alias;
   they remain external references and are not copied into the preset folder.
3. For other samples, expand shortcuts, form `folder/basename(sample)` using
   `0x8d4e0790`, and test the destination's existence. Existing files are reused.
   Otherwise call raw copy `0x8c03e0e4` with overwrite flag 0.
4. On existing destination or successful copy, replace the region's sample value
   with its basename. On copy failure, log the error and keep the original
   reference; the control flow continues toward writing JSON. A saved JSON file
   therefore is not proof that every intended sample was copied.
5. Replace the cloned DOM's regions and write `folder/patch.json` through
   `0x8c03f624`; return that writer's boolean result.

The overwrite cleanup `0x8d4e0868` builds an allowlist containing `patch.json`
and nonempty, non-DLC region sample basenames. It invokes directory traversal
`0x8c03ffac` with callback `0x8d4dca38`. The callback checks each listed file
against the allowlist and deletes an unlisted file with `0x8c03e040` at
`0x8d4dcb74`. This is cleanup, not compression or an archive writer. Do not
assume unrelated files in an overwritten preset directory are retained.

The raw sample copy implementation, separately captured in the storage report,
uses 32 KiB chunks. It checks opening and the overwrite policy but does not
propagate every low-level write/close failure. No content hash comparison is
visible in the existing-destination reuse path.

## JSON persistence and error boundaries

`0x8c03f624` constructs the JSON writer (`0x8c054852`) and serializes the DOM
through `0x8c0548c8`. It calls temporary-path helper `0x8c03f500`, then writes
the generated bytes with `0x8c03ecd4`. The path helper uses `0x8c03ee82` to retain the leading rooted component
through its next slash, appends `tmp/`, then appends the target basename. For
`/fat32/presets/bank/name.preset/patch.json` this yields
`/fat32/tmp/patch.json`, not a temporary subdirectory inside the preset folder.
For a non-rooted target it starts from an empty prefix and uses `tmp/`.

The byte writer creates the parent directory when necessary, opens with `w+b`,
writes the requested byte count, closes, and compares the returned write count
to the requested size. The close return is not used. If temporary writing fails,
JSON save logs `Failed to write tmp json file` and returns false. Otherwise it
calls `0x8c03e2f0` to replace the destination. That helper removes the destination
first, then renames the temporary file. Rename failure is logged and returned.
This is not evidence of atomic replacement or fsync/power-loss durability.

## Delete and move

The user-preset DB delete path around `0x8d4e7e5c` rejects factory content,
parses the source path, and chooses between recursively removing the containing
preset directory (`0x8d4e8000` calling `0x8c03e268`) and removing a single JSON
file (`0x8d4e80ba` calling `0x8c03e040`). It then updates/removes DB state.
The predicate `0x8d4e5dc4` selects the directory-shaped preset case.

The move path around `0x8d4e8a10` uses the filesystem rename wrapper
`0x8c03e250`, checks its boolean result, and logs the source and target on failure
at `0x8d4e8b48`. On success it constructs the destination `/patch.json` identity
for subsequent DB updates. Adjacent diagnostics explicitly cover refusing to
move factory presets, source/target path parsing and existing destination.
The entry is `0x8d4e841c`. It first resolves/parses the supplied source identity
through `0x8d4e5ed4`; failure exits through the source-parse diagnostic. The
comparison at `0x8d4e8492` rejects an unchanged bank when no replacement name
is supplied. It searches the current DB tree for the matching source path,
rejects a missing match at `0x8d4e85f8`, then rejects factory content through
`0x8d4e1214` at `0x8d4e8618`. The factory rejection is tied to the explicit
`refusing to move factory preset` diagnostic at `0x8d4e91fc`.

Destination bank directories are created component by component when missing
(`0x8d4e86d2` split, `0x8d4e8770` exists-directory check, `0x8d4e913c` mkdir).
For a bundled preset it forms the destination `.preset` directory, rejects an
existing destination directory (`0x8d4e8886`), then renames the entire source
preset directory. The alternate flat-JSON branch starts `0x8d4e8e0c` and moves
the single JSON file; associated sample dependency behavior remains the normal
external-path behavior unless a bundle save/copy is explicitly performed.
Filesystem rename failure returns an empty result. Rename entry `0x8d4e9470`
looks up the original preset by identity hash, rejects a missing path, checks
the identity parser, then calls this same move entry at `0x8d4e9672` with the
replacement name. It therefore shares the factory/content and destination
collision guards rather than using the JSON writer's remove-then-rename helper.
After successful rename it constructs the new identity, hashes it through
`0x8d4e112a`, and updates the caller-supplied identity value. Remaining DB
bookkeeping is present but not fully assigned semantic names in this report.

## Limits and implementation consequences

Confirmed improvements supported by these traces are slash-free-only sample
prefixing, preserving DLC references, separating JSON parse from runtime apply,
48-byte preset identity, and treating sound state as embedded binary data while
samples remain external resources. Device-observed region ordering should be
compared against the full-import loop, not inferred only from `hikey - 53` in a
small clean-kit subset; the parallel importer trace owns that correction.

Still open here: remaining rename/copy UI branches and precise DB invalidation
rules, +0x53c4's user-facing meaning, generic JSON
parser edge behavior (duplicate keys, numeric extremes), and packed ROMFS
internals. Filesystem lifecycle coverage does not establish the DSP meaning of
every sound parameter or power-loss safety. The companion field reports and
binary serialization coverage ledger must remain authoritative for those
separate questions.
