# Firmware RLE, wrapper, version dispatch, and stream I/O — 2026-10-23

Source: device-derived OP-XY **1.1.21+0**, loader SHA-256
`acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86`.
The acquisition receipt is [firmware_source.json](2026-10-23_firmware_source.json).
All findings here are static firmware analysis, not new device tests.

Fresh excerpts use the locally extended Blackfin+ objdump, including its
hardware-loop instruction-length fix. `LdStAbs` controls and unsupported
instructions remain explicit; they are not silently interpreted as classic
Blackfin. Register-value comments emitted by objdump are stale hints and
are **not** used as evidence.

## Decisive correction: header and body are one RLE stream

Save entry `0x8d5847d4` constructs one writer at `0x8d58480a`, opens it at
`0x8d584812`, then calls RLE write `0x8d57cc94` for the **eight-byte header**
at `0x8d58483c`. It immediately writes the two-byte tempo at `0x8d58484a`
using the same object. No state reset separates the header and payload.
Load entry `0x8d585220` similarly reads eight decoded header bytes through
RLE read `0x8d57c60c` at `0x8d585264` before version dispatch.

Thus the exact operation is:

```
physical_file = RLE(decoded_header[8] + serialized_project_fields)
```

The corpus happened not to contain adjacent repeats inside the header or
across its last-byte/tempo boundary. This made treating physical bytes 0..7
as an uncompressed wrapper appear correct. It is not the firmware grammar.
Decoded project offsets in the existing field maps still exclude the eight
decoded header bytes and need not change.

| Decoded header offset | Firmware meaning |
|---|---|
| 0..3 | LE magic `0xAABBCCDD`, checked at `0x8d585276..280` |
| 4 | format major, written `9` at `0x8d584822..830` |
| 5 | format minor, written `19` at `0x8d584824..834` |
| 6..7 | no initialization in this save routine and no validation/use in this loader; preserve opaque bytes |

These are **file-format 9.19**, not OS version 1.1.21. The observed `03 86`
at decoded header 6..7 is not established as a meaningful identity. The
routine writes an eight-byte stack region after explicitly initializing
only its magic and two version bytes; the trailing bytes appear to be
unused C/C++ structure padding/caller-stack contents. This is a static
observation, not a guarantee that future firmware will ignore them.

## RLE state and boundary behavior

Writer `0x8d57cc94` retains a previous signed byte and run length at object
offsets `+0x20/+0x24`. Calls with length zero do nothing. Matching bytes
extend a run up to **257**, directly compared at `0x8d57cca8..ccbc`.
A different byte or a full run emits one literal; if length exceeds one,
it emits another literal and `(length−2)&255` (`0x8d57ccde..cd08`). Closing
flushes the pending final run using the same rule (`0x8d57ce42..ce68`).
No field, vector, track, or 4096-byte output-buffer boundary resets the run.

Reader `0x8d57c60c` retains a pending byte at `+4` and remaining repeat count
at `+8`. It delays literal output until it has inspected the following raw
byte. When they match, it obtains the extension byte and sets run remaining
to extension+2 (`0x8d57c6ee`). After emitting the run, it sets pending to
`−1`, so the extension does not participate in pair detection. It can
prefetch a raw byte even when a requested field has just finished.

Raw reads `0x8d57c5b0` refill a **256-byte** buffer using the fread-shaped
call `0x8fed05bc`; physical EOF becomes integer `−1`. Reader construction
`0x8d57c4fc` allocates that buffer. Open `0x8d57c530` resets both sentinel
fields and the buffer position/length and opens with the verified string
`rb` at `0x8409e0bc`.

### Errors are sticky short reads, not a validating decoder

If a requested decoded length cannot be supplied, `0x8d57c698..6d0` sets
object `+0x18` to 1 and **zero-fills the missing destination bytes**. It does
not throw or stop all subsequent field reads. The project loader checks
this sticky flag after reading the header and after dispatch. It then
closes/frees the reader and returns false on an error.

The reader does not explicitly reject a missing extension: EOF is `−1`,
and `−1+2` becomes a one-byte run. For example physical `41 41` followed by
a two-byte decoded read yields `41 00` and sets the short-read flag. The
Python codec's explicit malformed-run rejection is preferable for safe
editing; it is stricter than this firmware implementation.

The loader does **not** request EOF after consuming the expected project
fields and does not require all pending run bytes to have been consumed.
Consequently an exact-EOF requirement in the repository parser is an
authoring/audit invariant, not a claim about firmware rejection of trailing
data. No checksum or serialized total-length field appears in this path.

The writer's signed-byte initialization `previous=count=−1` also collides
with a hypothetical standalone stream beginning with `FF`. Project streams
always begin with magic `DD`, avoiding that behavior. The public generic
codec should not reproduce this irrelevant initialization quirk.

## Every accepted version and migration step

The loader first checks that major is 8 or 9 (`0x8d585282..28e`). Dispatcher
`0x8d584a40` packs `(major<<8)|minor`, accepts **8.0, 8.1, 9.0 through
9.19**, and rejects the other combinations. Read and migration switch
tables are at `0x840a2284` and `0x840a2234`.

The machine-readable [version map](../../research/firmware-1.1.21/codec-versions.json)
records all 22 accepted versions, all reader entry points, and all 21
successive conversion functions. In particular, 9.7 through 9.11 share
reader `0x8d587a58`, and 9.14/9.15 share reader `0x8d5894d8`; sharing a
reader does **not** mean the semantic migration can be skipped.

For versions older than 9.19, dispatch reads the old representation into
scratch RAM at `0x860ca684`, then repeatedly converts it into the alternate
buffer at `0x8664af1c`, swapping source/destination each iteration. The chain
is 8.0→8.1→9.0→9.1→…→9.19. It finishes by copying **0x54076c = 5,506,924
bytes** into the requested current project object (`0x8d584b4a..b58`).
The current-format path directly calls reader `0x8d595414` with the caller's
destination (`0x8d584cce..ce0`), avoiding that conversion chain.

That 5.5 MB RAM representation includes fixed-capacity arrays and alignment;
it is **not** the roughly 290 KB serialized decoded payload. The firmware
serializes selected fields and vector contents, not a raw project-memory
dump. Different RAM and serialized offsets must remain separate.

The map proves dispatch and migration order. The follow-up below inspects
every converter and all historical reader envelopes. It does **not** implement
those converters or resolve every old engine/sample semantic. The production
field walker must still gate its interpretation to 9.19 rather than silently
apply its offsets to every version accepted by stock firmware.

## Buffered writing, temporary file, close, and failure behavior

| Entry | Behavior traced |
|---|---|
| `0x8d57ca20` | Construct writer; allocate 4096-byte output capacity; initialize run state |
| `0x8d57c8f8` | Save destination name; form temporary filename; open `w+b` |
| `0x8d57c700` | Build destination-name plus `.tmp` string (`0x8409e0c0`) |
| `0x8d57cb4c` | Append one encoded byte; flush at 4096-byte buffered size |
| `0x8d57cab8` | Write buffered bytes as one item; require return count 1; reset buffer position |
| `0x8d57cd10` | Flush final pending run and bytes; fclose; then rename temporary name to destination |
| `0x8d57ce70` | Close/finalize and release writer memory |

The write call is `0x8fed0780`, fclose is `0x8fed00ae`, and the rename-shaped
two-filename call is `0x8fed0908`. Their roles are supported by argument
shapes and adjacent source/error strings, including
`../src/sequencer/rle_file_writer.cpp`, `write failed(%i)`,
`fclose failed(%i)`, and `rename failed(%i)`.

On buffered-write failure (`0x8d57cb00`), fclose failure (`0x8d57cdf8`), or
rename failure (`0x8d57cda8`), code logs the corresponding error and calls
`0x8fed2b24`, an abort-like nonreturning path. It does not return a recoverable
false result to the save serializer. The top-level serializer returns false
for the pre-save space check or failure to open the writer, and true after
normal finalization. There is no fsync call visible in this traced wrapper;
power-loss durability and filesystem atomicity cannot be inferred from a
rename alone. Upper-level backups/recovery are a separate call-chain topic.

## Reproducible evidence and bounded verification

Fresh source excerpts:

- [codec-save.asm](../../research/firmware-1.1.21/codec-save.asm)
- [codec-wrapper.asm](../../research/firmware-1.1.21/codec-wrapper.asm)
- [codec-dispatch.asm](../../research/firmware-1.1.21/codec-dispatch.asm)
- [codec-stream.asm](../../research/firmware-1.1.21/codec-stream.asm)

[codec-probe.py](../../research/firmware-1.1.21/codec-probe.py) is a direct,
small transcription of the reader and writer state machines. It verifies
**1,120 split-call cases** (one-byte through 4096-byte chunks, runs around
257 bytes, all signed-byte classes, deterministic random inputs) against
the repository codec and reads **all 246 corpus files** as one RLE stream
with an eight-decoded-byte first read. This is independent model agreement,
not execution of the firmware binary or physical hardware validation.


## Follow-up: all historical readers and converters inspected

The expanded pass examined all 21 conversion entry points and all 17 unique
reader bodies behind the 22 accepted version routes. The evidence is the
fresh [complete legacy disassembly](../../research/firmware-1.1.21/codec-legacy.asm)
and the [22-version structural envelope](../../research/firmware-1.1.21/codec-legacy-layouts.json).
This establishes transfer sizes, count widths, capacities, ordering, and the
specific migration differences below. It is not a hardware-qualified old-file
importer, and the user-facing meanings of several historical values remain
unresolved.

### Important extraction correction

The segment helper omits loader **fill records**, which can contain repeated
instructions, not just zeroed RAM. A 36-byte hole at `0x8d591dbc..8d591ddf`
is loader record offset `1860860`, code `0xaddb0104`, fill word `0x980b9a2b`.
It repeats byte-copy instructions in the 9.11→9.12 converter. Disassembly
stopped at the preceding ordinary segment would miss part of that function.
`codec-extract.py` now overlays the recorded fill words, asserts complete
byte coverage, and hashes the reconstructed legacy region. The old whole-image
disassembly and objdump's stale register-value comments are not evidence for
these findings.

### Complete serialized envelopes

Numbers below exclude the eight-byte decoded wrapper. “Pattern prefix” means
all fixed bytes before the one-byte note count; it excludes variable vectors
and the trailing fixed bytes. Tracks always have a one-byte pattern count,
then that many patterns, for 16 tracks. Pattern storage capacity is 16 per
track. Each pattern has a one-byte note count and 12 bytes per note, followed
by **four** count-prefixed automation vectors even in format8.0.

| Versions | Global bytes | Pattern prefix | Note capacity | Automation record bytes / capacities | Bytes after vectors | Songs: entry width / capacity / tail |
|---|---:|---:|---:|---|---:|---|
| 8.0, 8.1 | 1196 | 12421 | 80 | 8 / 40,40,40,40 | 2 | 10: 4 / 32 / 0 |
| 9.0 | 1196 | 13957 | 80 | 8 / 40,40,40,40 | 2 | 10: 4 / 32 / 0 |
| 9.1, 9.2 | 1196 | 17005 | 80 | 8 / 40,40,40,40 | 2 | 10: 4 / 32 / 0 |
| 9.3 | 1204 | 17005 | 80 | 8 / 40,40,40,40 | 2 | 10: 4 / 32 / 0 |
| 9.4 | 1204 | 17005 | 80 | 8 / 40,40,40,40 | 98 | 10: 4 / 32 / 0 |
| 9.5 | 708 | 17005 | 80 | 8 / 40,40,40,40 | 98 | 10: 4 / 32 / 0 |
| 9.6 | 708 | 16997 | 80 | 8 / 128,128,128,32 | 98 | 10: 4 / 32 / 0 |
| 9.7–9.11 | 709 | 17774 | 80 | 4 / 128,128,128,32 | 96 | 10: 4 / 32 / 0 |
| 9.12 | 3917 | 17774 | 80 | 4 / 128,128,128,32 | 96 | 10: 4 / 32 / 0 |
| 9.13 | 3933 | 17774 | 80 | 4 / 128,128,128,32 | 96 | 10: 4 / 32 / 0 |
| 9.14, 9.15 | 3933 | 17774 | 120 | 4 / 128,128,128,32 | 96 | 10: 4 / 32 / 0 |
| 9.16 | 3433 | 17774 | 120 | 4 / 128,128,128,32 | 96 | 14: 1 / 96 / 0 |
| 9.17, 9.18 | 3433 | 17774 | 120 | 4 / 128,128,128,32 | 96 | 14: 1 / 96 / 2 |
| 9.19 | 3449 | 17774 | 120 | 4 / 128,128,128,32 | 96 | 14: 1 / 96 / 2 |

Every song and every automation vector starts with its own one-byte count.
Old eight-byte automation items are copied as six meaningful bytes into
padded eight-byte runtime items; the narrowing converter reads two words and
retains each low halfword. Do not treat the last two old bytes as a new field
without further evidence. The latest fourth vector is sustain, independently
confirmed in the [field-consumer report](2026-10-23_firmware_fields.md).

The current9.19 envelope consumes exactly all bytes of 245 structurally valid
corpus projects. The remaining `bleez34.xy` is already a known malformed
project. All 246 still pass the codec state-machine comparison above, which
is a compression test and does not imply a valid project structure. There
are no historical corpus projects here with which to qualify older envelopes.

The fixed region changes include lock storage 8192→10752 bytes, lock flags
512→1024, the parameter region256→232, and sample-related blocks
768→(768+1536)→2304→3072. The machine-readable envelope records the exact
sequence of direct read widths, so these differences are reviewable without
relying on a guessed shared offset map.

### Every migration step

Addresses refer to the `0x8d` executable region. Common conversion machinery
copies globals, visits each stored pattern in all16 track containers,
reconstructs notes/vectors into destination capacities, then copies or converts
songs. The table records departures from that common template. A memcpy size
is a RAM-structure size, not a decoded-file length.

| Conversion / entry | Concrete difference traced |
|---|---|
| 8.0→8.1 `58d8e0` | The entire function is a 3,847,700-byte memcpy and returns at `58d8fe`. The following sample helpers are separate functions, not extra work in this converter. |
| 8.1→9.0 `58ed00` | Adds1536 bytes per pattern for24×64-byte sample paths. Helper `58eb20` clears the region and populates it through legacy drum/synth name resolution. Pattern RAM stride grows15020→16556. Helper `58ec48` also replaces zero values in two parameter words with `0x40000000` and `0x5999999a`; those parameter names are unresolved. |
| 9.0→9.1 `58f19c` | Rebuilds the lock/flag storage:8192→10752 and512→1024 bytes. Parameter block shrinks256→232. Explicit clearing at `58f3de` and `58f484`, followed by old-row/parameter reindexing at `58f49a..58f4ba`. The exact semantic name of every remapped lock column is not established. |
| 9.1→9.2 `58f6e4` | Consolidates separate768+1536 sample regions into2304 bytes, preserving total wire-prefix size. Clears2304 bytes at `58f9f8`; rebuilds sample metadata and paths through sample/asset helper calls (`4f66b4`, `4f5e1a`, `4f5d86`, `5a4e22`). Asset-dependent details require those helpers and original sample inventory; this is not merely a byte splice. |
| 9.2→9.3 `58fd04` | Inserts eight global bytes at RAM+`0x2c`, copied from ROM `840a4204`: `04 02 01 01 02 02 06 06`. All pattern wire sizes stay fixed. |
| 9.3→9.4 `59020c` | Adds two48-byte trailing pattern arrays. Both are explicitly zeroed (`59053e`, `590550`). The first is today's12-word tuning array. The second remains unnamed; all later converters copy it unchanged. |
| 9.4→9.5 `59064c` | Reorganizes globals1204→708. The old1152-byte scene area uses16×72-byte records; the new608-byte area uses16×38. Copies two16-byte subarrays and selected word/byte metadata, and moves three16-byte global arrays out of the old structure. Pattern serialization stays the same. |
| 9.5→9.6 `590b04` | Expands four automation capacities40,40,40,40→128,128,128,32; eight-byte wire items remain. Removes an eight-byte block from the fixed prefix. Converter also quantizes an old parameter into a new normalized enum at `590f02` onward; its user-facing identity remains unresolved. |
| 9.6→9.7 `591128` | Narrows each automation item8→4 bytes using `591044` and `5910b8`, retaining the low16 bits of both old words. Sample block2304→3072. Adds an8+1-byte automation-control block before step components, removes the old two-byte post-vector field, and adds one global byte. |
| 9.7→9.8 `591778` | Same reader/layout. For patterns with nonzero RAM+`0x2c`, transforms word+`0x38a4` via nonlinear helper `591708`. Clears one byte per128-byte sample slot, starting RAM+`0x396b`, across24 slots. Parameter identity is unresolved. |
| 9.8→9.9 `591844` | Same reader/layout. Conditional engine10 migration applies helper `58d9bc` to two parameter words and remaps a quantized enum3→1 using scale `0x2aaaaaaa` and midpoint `0x15555555`. |
| 9.9→9.10 `591960` | Same reader/layout. Visits the last two track groups (indices14,15), replacing a parameter with `INT_MAX - sat(2*(max(old,0x40000000)-0x40000000))`. Logging says `convert %.3f => %.3f`; effect parameter name is not established. |
| 9.10→9.11 `591ab8` | Same reader/layout, engine-specific LFO conversion. Engine19 is named **hardsync** by its log string and swaps parameter words+4/+8. Engine22 is named **fmstrings** and rotates+4/+8/+12. Associated LFO enum remappings are1↔2 and1→2→3→1. This must not be skipped merely because the wire reader is shared. |
| 9.11→9.12 `591d44` | Expands scenes16→100 at38 bytes each and inserts a16-byte global array. Clears all100 new records, initializes u16 fields+32=`0x00f0`,+34=`0x00fc`, byte+36=8, and copies the original16 records. Globals709→3917. |
| 9.12→9.13 `592354` | Adds another16-byte global array; globals3917→3933. Copies all pattern/vector fields with unchanged wire widths. |
| 9.13→9.14 `59293c` | Raises note capacity80→120 and reconstructs the note container with16-byte RAM nodes. Wire note records remain12 bytes. RAM grows by256×40×16 bytes; wire length only grows if more notes are actually stored. |
| 9.14→9.15 `5930d4` | Same reader/layout. For track index8 (Brain), converts global bytes+8,+10,+9 into three normalized parameter words in every stored pattern. Multipliers/midpoints are `3fffffff/1fffffff`, `0aaaaaaa/05555555`, and `12492492/09249249`. |
| 9.15→9.16 `5931a0` | Converts100 scene records38→33 bytes: copies two16-byte arrays and sets the final active byte when any copied slot is nonzero. Converts10 songs of up to32 u32 scene IDs into a14-song container of up to96 u8 IDs; retains each ID's low byte. Clears the new1456-byte song container first; the four new songs remain empty. Globals3933→3433. |
| 9.16→9.17 `5938c4` | Rebuilds packed global/pattern flag bytes using `PACK`/`DEPOSIT` (`5939a0..b8`, `593c22..68`). Song reader gains two trailing bytes per song even though globals/pattern-prefix sizes stay fixed. Converter copies the1456-byte RAM song area, whose new tail bytes were initialized during the preceding migration. Individual bit meanings remain partially unresolved. |
| 9.17→9.18 `593ebc` | Reconstructs packed pattern configuration and note containers, preserving wire sizes. For engine3 and a selected parameter mode0, applies `sat((sat(old-0x40000000) >> 1)+0x40000000)` to the next parameter word (`594554..570`). The mode is extracted from the previous word with the signed nine-bit extraction control `0x1509`. |
| 9.18→9.19 `5945e4` | Expands globals3433→3449; initializes new RAM byte+8, word+`0x0c`, and16-byte region+`0x0e`, relocates old global bytes/arrays, and copies the full current pattern structure. Includes the same conditional engine3 normalized-word adjustment as the preceding converter. |

### Asset-dependent migration call chain

Format8.1→9.0 calls `58eb20` to build24 fixed64-byte sample path slots.
The drum branch calls `58ddc0` repeatedly with the selected legacy kit and
slot index; its branches choose either `58dbec` (prefix
`content/legacy_samples/`) or `58dcb4` (prefix `content/samples/`). The synth
branch calls `58e338`; helper `58dd7c` uses `content/samples/synth/`.
The prefixes are literal ROM strings at `840a4258`, `840a4270`, `840a4284`.
These routines construct paths, including kit/name components and numeric
suffixes; seeing those prefixes alone does **not** prove a file was renamed
or copied on disk. The subsequent9.1→9.2 sample conversion opens/inspects
assets to rebuild their metadata. Old-file conversion therefore needs the
sample content as well as the `.xy` bytes to reproduce every field exactly.

Remaining work is explicit: historical semantic importers are not implemented;
not every old parameter remapping or packed flag has a public name; sample
resolution needs original content; and the second trailing48-byte array is
still opaque. Every serialized region and every historical conversion entry
has been examined, but this is not a claim that every runtime behavior or
arbitrary corrupt-input case has been fully emulated.
