# OP-XY 1.1.21 project storage, validation, and runtime normalization

Static trace dated 2026-10-23. Source is the hash-pinned device loader in
`2026-10-23_firmware_source.json`; no hardware tests were performed. Fresh
Blackfin+ disassembly is saved in `research/firmware-1.1.21/storage-*.asm`.
Addresses refer to this build only. Runtime structure offsets below are **not
wire offsets**: the serializer removes alignment, narrows fields, and packs
linked collections. This trace covers the application-level project storage
path, not every internal FAT/YAFFS driver operation.

## Read, validate, then activate

`0x8d574b38` is the outer project loader. Its arguments are a filename and an
activation flag. It:

1. Rejects a request if pending-project pointer `0x8409adf0` is already nonzero
   (diagnostic: `load project failed: already loading project, aborting %s`).
2. Selects whichever of `0x850f7d08` and `0x85638474` is not the active project
   at `0x8409adec`.
3. Calls deserializer `0x8d585220(destination, filename)`.
4. If deserialization returns false, logs a distinct deserialize failure and
   returns false without publishing the destination.
5. Calls project validation/normalization `0x8d574aac(destination)`. Failure
   similarly returns false without publishing the destination.
6. Stores the destination in the pending pointer. If activation was requested,
   calls `0x8d5717fc`; otherwise returns true with a pending project.

`0x8d5717fc` copies pending pointer to active pointer, invokes `0x8d56fa48`,
clears the pending pointer, and sets the byte at `0x8409adf5` to one.
`0x8d56fa48` resets word `0x8409adf8` and dirty byte `0x8409adf4` to zero.
The exact meaning of byte `0x8409adf5` is not established here. Successful
file reading and successful activation are distinct stages.

`0x8d574aac` visits all 16 track groups at runtime project offset `0xd7c`,
stride `0x53f44` (343,876). `0x8d5749b6` rejects a group whose pattern count
at group+`0x53f40` is zero, then visits its patterns at stride `0x53f4`
(21,492) and calls `0x8d574810(track_index, pattern)`.

This is direct counterevidence to an unconditional claim that the firmware
“asserts, not validates.” It has explicit boolean failure handling, but also
assertions and mutation during deserialization/normalization; this does not
mean arbitrary malformed input is safe.

## Pattern normalization during loading

`0x8d574810` returns true after performing these mutations. Every offset in
this table is relative to the **runtime pattern**, not the decoded image.

| Runtime field | Behavior | Instruction range |
|---|---|---|
| u32 `+0x34` | Values outside unsigned 0..4, or value 1, become 2 | `8d574824–830` |
| u8 `+0x08` | Values >=16 become 1; diagnostic calls this invalid track scale | `8d574832–84a`, `8d574990` |
| u32 `+0x20`, byte `+0x24` | Values 4 or 5 become 1, and byte becomes zero | `8d574852–868` |
| Instrument tracks 0..7, u32 `+0x18` | Invalid instrument catalog entry becomes 18 | `8d574964–972` |
| Instrument tracks 0..7, u32 `+0x28`, byte `+0x2c` | Invalid filter entry becomes 10, byte becomes zero | `8d574974–988` |
| FX tracks 14..15, u32 `+0x18` | Invalid FX catalog entry becomes 0 | `8d574954–960` |
| Instrument IDs 2, 3, or 30, eight words `+0x3864..+0x3880` | All become `0x40000000` | predicate `8d5a21a8`; assignment `8d574880–8b2` |
| All tracks, words `+0x38fc`, `+0x3900` | Both become `0x40000000` | `8d5748b6–8cc` |
| 24 sample paths, `+0x396c`, stride 128 | Exact old piano path is migrated (below) | `8d5748d4–8f0`, `8d574924–952` |
| Linked notes, head i16 `+0x4cfe`, nodes at `+0x457c` stride16 | Clear bit1 of node byte+14; next i16 is node+2, sentinel -1 | `8d5748f2–914` |

Path migration is exactly:

```
content/samples/synth/piano1.wav
    -> content/samples/synth/piano 1.wav
```

The code compares with `strcmp`-shaped helper `0x040231b4` and writes the
replacement with 96-byte formatting bound. It does not change other paths
in this normalization pass. This is a compatibility migration, not evidence
that sample data is embedded in `.xy`.

Instrument validity `0x8d4fd0b6` requires signed ID >=0, ID<33 and a nonempty
name byte at catalog `0x846df650 + id*48 + 16`. Filter validity
`0x8d4fd02e` similarly uses ID<18 and table `0x846dfc80`; FX validity
`0x8d4fd064` uses ID<18 and table `0x846df2f0`. Those populated runtime tables
are not present at these addresses in the loader segments, so the checks
establish bounds and occupancy behavior, not a complete catalog of names.

## Saving uses a snapshot and canonicalizes text buffers

`0x8d5719b4(filename)` copies **5,506,924 bytes** from the active project to
scratch project `0x85b78be0`, using copy helper `0x040201c4`. It calls
`0x8d57182a(scratch)` before `0x8d5847d4(scratch, filename)`.

The preprocessing visits all 16 groups and their active patterns. It finds
the first NUL in each of 24 sample paths and zero-fills the rest of its
96-byte buffer, including that NUL. It also zero-fills two 48-byte name
buffers after their first NUL:

| Runtime pattern offset | Buffer |
|---|---|
| `0x396c + 128*i`, i=0..23 | Sample path, 96 bytes |
| `0x454c` | First name, 48 bytes |
| `0x53c4` | Second name, 48 bytes |

The preprocessing runs on the copied project, so these specific
canonicalization writes do not directly mutate active runtime memory. Strings
already at or beyond the limit are skipped by the fill branch; the preceding
NUL search itself is not bounded in these excerpts. Off-device writers should
provide terminated paths/names rather than assume a full buffer is safe.

This distinction matters for tests: preserving all original bytes is correct
for a lossless editor, while reproducing a firmware save may zero text-buffer
suffixes and apply prior load migrations.

## Backup-before-write application workflow

The user-facing save routine is `0x8d56142c` in
`../src/main/ctls/project_utils.cpp`. It rejects an empty project name.
Its backup workflow includes:

- Derive a backup directory using helper `0x8d560580`, containing the literal
  `/backups/` (string `0x84069f44`), and ensure parent directories exist.
- Enumerate existing backups with `0x8d5612d0`: skip names beginning with `.`,
  parse numeric prefixes in base10, and build an ordered collection.
- Choose one more than the highest existing numeric prefix, or zero if none.
- If the next number is greater than 9999, remove the backup directory with
  `0x8c03e268` and recursively retry save. Otherwise prune oldest entries via
  `0x8d560bbc(...,19)` until the existing collection has at most19 entries.
- Build the backup basename using `0x8d55fdb4`, format **`%04d.xy`** with an
  eight-byte buffer (`0x84069f20`).
- If the current project file exists (`0x8c03e29c`), invoke
  `0x8c03e2f0(current_path, backup_path)`. This wrapper removes an existing
  destination before calling rename-style API `0x8fed0908`; success means the
  lower API returned zero.
- Whether that backup operation succeeds or fails, proceed to
  `0x8d5719b4(current_path)` to write the snapshot. A backup failure is logged
  as `failed to backup`, but does not abort this path.

The save caller does not branch on the return of `0x8d5719b4` in the traced
sequence. There is no temporary-file-then-rename replacement in this caller;
the existing file is moved aside before serialization of the original path.
This establishes application ordering, not FAT atomicity, crash durability,
or successful recovery after power loss. The helper splits the path into directory and basename (`0x8d5a4a38`,
using `0x8d5a4638` and `0x8d5a46b4`), then inserts `/backups/` between them.
Thus an ordinary `/fat32/projects/user/name.xy` has backup directory
`/fat32/projects/user/backups/name.xy`; the original `.xy` suffix remains
in that directory name. Edge cases such as a root-only path have not been
exercised. The complete startup recovery policy remains to be traced.

`0x8c03e080(path)` walks slash separators and calls directory creation on each
prefix, used both here and at the serializer entry. This is recursive parent
creation, not a filename sanitizer.

## Project discovery, copying, renaming, and deletion

The browser scan loop at `0x8d55cf54` skips directory entries whose names begin
with a dot, extracts the extension via `0x8d5a4840`, and compares it to literal
`.xy` at `0x84069a8c`. Unlike the sample-reader extension selection, no case
mapping appears in this branch. It derives a display stem by subtracting the
extension length. This is browser discovery behavior, separate from direct
loading of a supplied pathname.

The scan subsequently calls `0x8d55b32e` on the stem for a separate numeric
index. That function requires at least three characters and digit-classifies
each of the first three through the C character table. It converts precisely
the first three characters in base10 and returns -1 on failure. There is no
fourth-character delimiter check: `123name` and `1234` both yield123. Failure
skips this numeric-index insertion, not necessarily the earlier browser entry
creation. These are filename conventions, not magic bytes in the project.

The browser's clone callback `0x8d55b070` takes source/destination paths and
calls `0x8c03e0e4(source, destination, 0)`. The zero flag makes the copy helper
reject an already-existing destination. Otherwise it opens the source,
ensures the destination parents exist, opens the destination, allocates a
32,768-byte buffer, and copies until the read returns zero. Source/destination
open failures return false. The clone callback logs a false result and frees
its request. The copy loop does **not** compare the write result with the read
count, distinguish EOF from read error, or test close results before returning
true (`8c03e150–1b4`). This is a raw file copy: the traced callback does not
serialize the project again or collect its sample dependencies.

Rename controller `0x8d55f4b8` first calls the normal project save routine,
builds the renamed path, and invokes the remove-destination/rename wrapper
`0x8c03e2f0` at `8d55f5a6`. It then constructs old/new backup-directory paths
and, if the old directory exists, renames that directory separately at
`8d55f71a`. Both rename failures have diagnostics. This is a sequence of file
operations, not an atomic transaction covering the project and its history.

Delete helper `0x8d5605f0` calls remove-file wrapper `0x8c03e040` for the
project, constructs its backup-directory path with `0x8d560580`, and invokes
recursive removal `0x8c03e268` for that directory. No sample-dependency
traversal appears in this helper. Full UI collision-name generation and every
export route remain outside this trace; duplicate alone does not establish a
self-contained project package.

## Workspace persistence and failure fallback

`0x8d584264(context, path)` invokes the outer loader with immediate activation.
On success it calls `0x8d584248`, which refreshes runtime state through
`0x8d584128` and saves a snapshot to `/fat32/projects/workspace.xy` via
`0x8d5719b4`. Thus loading a project can also rewrite the persistent workspace.

`0x8d58429c(context)` attempts that same flow with the workspace filename.
On failure it calls the project initializer `0x8d573c34`, calls the name/path
setup `0x8d560a28` (its literal is `unnamed`), activates pending data, and
refreshes runtime state. No numbered-backup search appears in this fallback.
The inspected path establishes fallback behavior; proving every boot entry
that reaches it would require the remaining startup call graph.

At `0x8d57e314–38c`, the periodic path inspects dirty byte `0x8409adf4`, waits
for elapsed value >1000, then submits workspace persistence via
`0x8d4d937c`. The elapsed unit is not established here. The dirty flag is
cleared only on nonzero submission result; on zero result the timer restarts.
`0x8d4d937c` constructs a type6 work item containing the path, checks for a
conflicting queued item, and posts the job. Its success is queue acceptance,
not proof that the eventual file write succeeded. Other eligibility checks
precede this excerpt; this is not a claim that every edit saves immediately.

## Auxiliary sample reads are a separate I/O path

Sample-buffer loader `0x8d4fff44` uses the path to construct/open a sample
reader (`0x8d4f66b4`), independently of the project byte-stream deserializer.
The reader extracts a filename extension and passes it through character case
mapping before selection. Strings at `0x8403cd0c` select `.wav`, `.aif`,
`.aiff`, and `.aifc`; unsupported extensions return false. WAV goes to
`0x8d4f6380` and AIFF-family to `0x8d4f62dc` via the selected reader vtable.

The sample-buffer load then:

1. Requires channel count 1 or 2 (`8d4fffe0–50001c`).
2. Gets length and sample-rate metadata through reader virtual methods.
3. Clamps frame length to **882,000** (`8d500040–05c`), with the diagnostic
   `sample %s too long: %d max: %d` if longer.
4. Allocates the sample buffer; allocation failure returns false with
   `failed to load %s, out of sample memory`.
5. Reads exactly `frame_count * channels` sample values and requires that exact
   count in the return value. A short result clears loaded-count state and
   returns false (`8d5000a4–0fe`), with `read_samples failed %s`.
6. Releases the reader on both success and failure.

The sample-interface transfer `0x8d4d35b4` separately asserts master-CPU context
and `strlen(path) < 96` (`8d4d3660–3682`, assertions at `8d4d3750/3768`). It
transmits each path with a one-byte length plus accompanying metadata; this is
an internal sample-management message and is not the `.xy` format or public
MIDI protocol. A 96-byte field is therefore storage capacity, not permission
for a 96-character unterminated pathname.

### Path resolution and sample ownership

`0x8d50362c` looks up a sample ID in the runtime ID-to-path map rooted at
`0x84a4d740`, takes the stored string at the found node+`0x10`, and expands
shortcuts with `0x8d5a42b0` before passing the resulting path to buffer loader
`0x8d50013a` -> `0x8d4fff44`. A missing map entry logs `no path for sample %u`
and calls the panic-like `0x8fed2b24`; this differs from a registered pathname
whose file fails to open, which returns the buffer-load failure. Failed loads
release the constructed buffer. Project deserialization and dependency loading
therefore have distinct failure paths.

The shortcut registry at `0x86bd60f4` contains pairs of strings with stride56.
The static table at `0x840a73fc` supplies six entries, appended by the loop
`8d5a3f2a–3f96`:

| Shortcut | Expansion |
|---|---|
| `<samples>` | `content/samples` |
| `<presets>` | `content/presets` |
| `<patterns>` | `content/patterns` |
| `<beats>` | `content/beats` |
| `<wavetables>` | `content/wavetables` |
| `<tunings>` | `content/tunings` |

`0x8d5a42b0` only attempts expansion if the input starts with `<`, extracts
through `>`, compares the whole shortcut with registry entries, and concatenates
the mapped root with the remaining suffix. For example,
`<samples>/synth/example.wav` resolves to `content/samples/synth/example.wav`.
Inputs without an opening shortcut, without its closing delimiter, or without
a matching registry entry are copied unchanged. Runtime DLC mappings precede
the six fixed entries; their full discovery rules are not decoded here.
The companion `0x8d5a40d0` handles paths beginning `content/dlc/`, searches
registry roots with a following slash boundary, and substitutes the registered
shortcut. These are pathname transformations, not evidence that the file embeds
DLC or sample audio.

Release helper `0x8d503720` refuses removal (returns false) while the signed
word at sample-entry+8 is positive. Otherwise it removes matching path-map
entries; if entry byte+13 indicates ownership and pointer+4 is nonzero, it
destroys and frees that sample buffer, then returns true. This establishes a
retention/ownership gate; the complete acquisition/refcount policy and memory
budget remain unresolved. The low-level ROMFS/FAT mount, resampling, cache
relinking, and audio render internals are deliberately not inferred from these
wrappers. No project-loader success branch by itself demonstrates audible
sample playback.

## Evidence boundary and remaining work

Confirmed here: double-buffered load publication, separate deserialize and
validation failures, zero-pattern rejection, per-pattern normalization,
version-specific piano migration, snapshot save preparation, text-buffer
canonicalization, numbered backup retention, rename-before-write ordering.

Not established here: filesystem power-loss semantics/fsync, every startup recovery
entry, all filename sanitization/export rules, complete sample cache/path mounting
behavior, DLC registry discovery, and meanings of every normalized field. Container/RLE/version
handling and wire-to-runtime layout are separate parallel traces. No statement
in this document treats static disassembly as a hardware test.
