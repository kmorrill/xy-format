# Firmware 1.1.21 preset JSON import

Date: 2026-10-23. Scope: parsed JSON acceptance, value conversion, and application to the current pattern. This is a static firmware trace, not a hardware acceptance result. Loader SHA256: `acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86` (OS `1.1.21+0`). Fresh disassembly uses the fill-aware `music-firmware/research/opxy-midi-1.1.21/inspect_firmware.py`; original firmware files are unchanged.

Evidence under `research/firmware-1.1.21/preset-import-*`:

- `main.asm`: `8d4dce40..8d4dec6c`, scalar helpers, full apply, validator/parser, parsed-JSON and disk wrappers.
- `helpers.asm`: `8d4dbb00..8d4dce40`, sample-engine classification, FX/LFO assignment, enum alias helpers.
- `json-types.asm`, `json-conversion.asm`, `lookup.asm`, `array-lookup.asm`, `tables.json`: library type predicates, scalar conversion and lookup dispatch.
- `engine.asm`, `enums.asm`, `lfo-enums.asm`: name resolver paths.
- `tuning.asm`, `octave.asm`: non-parameter application.
- `parser.asm`, `float-constructor.asm`: generic text parser, numeric token tagging and duplicate-member behavior.
- `extract.py`: reproducibly generates all 13 ranges and the table evidence using the current fill-aware helper. No legacy flat disassembly is used.

All addresses below are firmware virtual addresses. RAM offsets are relative to the live pattern, **not** offsets in a compressed `.xy` file. The parameter index is zero-based within the 58-word live sound parameter bank at `pattern+3864`.

## Entry, validation, and mutation order

`8d4de93c(preset_object, track, parsed_json)` copies the JSON into `preset_object+8`, requires root `type` to be a string, aliases `external` to `midi` (`8d4dccc4`), and resolves it through `8d5a21fc → 8d4fe904`. Unrecognized engine ID 33 returns false. Engine ID is stored at `object+128`; `8d5a21d8` marks IDs 3/4 as drum-like in `object+0`. The track is stored at `object+4`. Root property names are literal and case sensitive; periods within names are not traversal syntax. Arbitrary extra properties are not enumerated or rejected by this layer.

`8d4ddca4` validates platform/version before clearing the parameter staging bank:

1. Asserts `track < 8`; later `8d4dbcf4` also asserts the stored track is nonnegative and below 14.
2. Requires root `platform` string equal to `OP-XY`. Missing, wrong type, or different string returns false with `invalid patch platform`.
3. Requires root `version`, converts it with the JSON integer conversion, stores it at `object+180`, and rejects values below 3. There is no upper-version bound in this function. This is JSON schema version, unrelated to binary wrapper 9.19 or OS 1.1.21.
4. Clears all 232 bytes / 58 staging parameters (`object+30`). Sets indices 43,45,47,56 to `40000000`.
5. Reads engine, envelopes, FX, LFO, external MIDI overrides, then installs fixed parameter defaults described below. Returns true.

Raw JSON parsing/syntax errors precede this function; it receives a parsed value. It is not a strict JSON Schema validator: nested objects and arrays are often accessed directly, with library null/default/assert behavior. Do not claim arbitrary malformed nested input is safely rejected. Version is converted without an explicit integer-type test; floats can reach the general integer converter here, unlike ordinary Q31 parameters.

Successful validation is separate from applying the preset. `8d4dced8(object, apply_mixer_flag)` mutates the current target pattern. Disk wrapper `8d4deadc` reads JSON and fills identity/path before the same parsed-JSON wrapper; filesystem lifecycle is documented separately.

## Generic JSON text parser behavior

The disk loader constructs reader `8c04e860` and calls `8c04fe40`, which delegates to range parser `8c04fca8`. Constructor features (`8c04e61e → 8c04e838`) are two bytes1,0: comments permitted, strict object/array root disabled. Comments are token type12; object parsing skips them (`8c050bba..8c050bce`). These findings describe this firmware reader, not a recommendation for portable JSON authoring.

- **Duplicate members:** object reader `8c050b5c` decodes a member name, gets the existing/mutable member reference with `8c053324` at `8c050c2a`, pushes that reference at `8c050c3a`, and recursively reads a value into it at `8c050c40`. There is no duplicate-key rejection or first-value preservation. Later members overwrite earlier values.
- **Trailing input:** `8c04fca8` saves the result of `readValue` (`8c0509bc`) at `8c04fd7c`, reads another token through `8c04eddc` at `8c04fd86`, then returns the original result at `8c04fda0..8c04fdac` when strict-root is off. It does not require the trailing token to be EOF and does not use that trailing read's success as the return status. Thus a valid leading JSON value can pass this layer despite extra trailing text. There is no evidence here that a higher wrapper adds an EOF check.
- **Numeric spelling:** number decoder `8c04fa00` detects decimal/exponent markers and uses float decoder `8c04f844`; that calls constructor `8c0518f4`, which explicitly writes tag3. Integer tokens use signed constructor `8c051096` when magnitude fits signed32 and unsigned constructor `8c05107e` for positive values beyond signed32 (through unsigned32). Threshold words at `11802160` are `80000000`, `7fffffff`, `ffffffff`; overflow falls back to float decoding. Consequently `12` is signed-integer tag1, but `12.0` and `12e0` are float tag3, even though mathematically equal. Ordinary Q31 import accepts the former and returns0 for the latter.
- **Null root:** the generic reader has a successful null-value branch at `8c050b38..8c050b58`; the preset wrapper subsequently fails because null has no `type` member. `8c0526cc` returns the null singleton directly for a null object, so this case does not require a malformed-object assertion. Arrays and other scalar roots are not established as safely rejected by the same path; object-member lookup asserts on nonnull/nonobject types.
- **Missing members/short arrays:** mutable member lookup (`8c05320c`, wrapper `8c053314`) and mutable array index (`8c0530e4`) can promote null to object/array and insert null values for missing positions. They do not compact arrays. Wrong nonnull container types have assertion paths. These mutations are in the copied staging JSON, not user files.

These are instruction-level findings without an on-device adversarial JSON test. Exact handling of extreme float literals, scanner locale, invalid Unicode and assertion runtime policy remains unverified; the importer report does not claim a completely emulated general JSON implementation.

## Scalar conversion rules

The library value tag at `value+4` is 0=null, 1=signed integer, 2=unsigned integer, 3=float, 4=string, 5=boolean, 6=array, 7=object. The dispatch tables were read from loader addresses `118024d0` (integer), `11802634` (float), and `11802694` (boolean).

| Helper | Behavior |
| --- | --- |
| `8d4dce40` generic Q31 import | Accepts tags 0,1,2,5 only, converts to integer, shifts left 16 **with 32-bit wrap**, interprets signed, takes `max(result,0)`. Float/string/array/object give 0. `true` becomes `00010000`, null/missing becomes 0. This is not normalized floating-point input or a saturating `0..32767` clamp. |
| `8d4dce90` ordinary integer import | Same accepted tags; integer result unchanged, other tags give 0. Subsequent byte stores retain low eight bits; no additional range clamp is present. |
| `8c051d88` general integer conversion | Null→0, signed integer unchanged, unsigned integer returned with optional assertion if too large, bool→0/1, float→ROM float-to-int conversion with checks. Strings/arrays/objects follow assertion/fallback paths. Used directly for version and loop endpoints. |
| `8c0520dc` general boolean conversion | Null false; integers nonzero; float ignores sign bit before zero test; strings true when nonempty; bool unchanged; arrays/objects based on nonempty size. Thus JSON numbers/strings are not equivalent to adapter `_boolean_value`, which accepts only actual booleans. Some boolean-result opcodes remain printed `ILLEGAL` by objdump (`10 02`); branch context and dispatch establish the tests, but these cases have not been device-probed. |
| `8d4dda70` engine playmode | String `poly`→`15555555`, `mono`→`3fffffff`, `legato`→`6aaaaaa9`; unknown string→poly; nonstring/missing→0. Case-sensitive comparisons. |
| `8d4ddb20` engine transpose | Only signed-integer tag 1 accepted; clamp integer to -36..36, encode `(n+36)*29417584+14708792` with saturated addition. Other tags/missing→`3ffffff8`. If the entire engine object is absent this helper is not called, so index52 stays 0. |
| `8d4ddbcc` external CC | Same integer-compatible predicate as generic Q31; -1→0, else `(n+1)*16647160+8323580`. Multiplication wraps, final addition saturates signed. No explicit input clamp. |
| `8d4ddc4c` external value | Same integer-compatible predicate; `n*16777215+8388607`, multiply wraps, final add saturates signed. No explicit input clamp. |

Q31 edge examples: 32767→`7fff0000`, 32768→0, 65536→0, 65537→`00010000`, -1→0, -65535→`00010000`; a floating-point JSON `12.0`→0, integer `12`→`000c0000`. Input/parser integer-range behavior remains relevant beyond 32-bit range.

The validator logs an assertion when any staged parameter is negative; the apply copy also has an assertion/abort path for negative values. Do not emulate out-of-domain MIDI arithmetic as a safe supported interface merely because the arithmetic can be reconstructed.

## Complete 58-parameter inventory

Generic entries use `8d4dce40`. Engine fields are read if root `engine` exists; missing members within it become zero except special transpose/playmode behavior. Arrays are indexed at fixed positions, not filtered/compacted; excess members beyond eight are ignored by these loops.

| Index | JSON source / import behavior | Evidence |
| --- | --- | --- |
| 0..7 | `engine.params[0..7]`; later forcibly half for raw type drum/sampler/multisampler | `4dddf0..4dde1a`, `4dd758..4dd790` |
| 8..11 | `envelope.amp.attack/decay/sustain/release` | `4de500..4de5b8` |
| 12 | `engine.playmode`, special enum | `4dde1c..4dde3c` |
| 13 | `engine["portamento.amount"]` | `4dde40..4dde62` |
| 14 | `engine.bendrange` | `4dde66..4dde82` |
| 15 | `engine.volume` | `4dde86..4ddea0` |
| 16..23 | `fx.params[0..7]`; index21 is **not copied** into target unless engineID29 | `4de05e..4de094`, `4dd916..4dd926` |
| 24..31 | `lfo.params[0..7]` | `4de136..4de1c2` |
| 32..35 | `envelope.filter.attack/decay/sustain/release` | `4de440..4de4f8` |
| 36..37 | No JSON source; staging remains zero and is copied | staging clear and complete write inventory |
| 38..39 | Forced `40000000` at parse end and again at application | `4de374..4de384`, `4dd794..4dd7b0` |
| 40 | Forced `40000000`; application preserves old value when apply_mixer_flag=false | `4de364`, `4dd90e..4dd914` |
| 41 | Forced `60000000`; all eight track-table entries at `840366d0` equal this. Application preserves old value when flag=false | `4de368..4de37c`, `4dd748..4dd752` |
| 42..43 | `engine.modulation.modwheel.target/amount` | `4de798..4de7f0` |
| 44..45 | `engine.modulation.aftertouch.target/amount` | `4de738..4de790` |
| 46..47 | `engine.modulation.pitchbend.target/amount` | `4de6d8..4de730` |
| 48 | `engine["velocity.sensitivity"]` | `4ddedc..4ddef6` |
| 49 | `engine["portamento.type"]` | `4ddefa..4ddf1a` |
| 50 | `engine["tuning.scale"]` | `4ddf1e..4ddf38` |
| 51 | `engine.width` | `4ddec4..4dded8` |
| 52 | `engine.transpose`, special encoding | `4ddea4..4ddec0` |
| 53 | `engine["tuning.root"]` | `4ddf3c..4ddf56` |
| 54 | `engine.highpass` | `4ddf5a..4ddf6e` |
| 55..56 | `engine.modulation.velocity.target/amount` | `4de678..4de6d0` |
| 57 | No JSON source; staging remains zero and is copied | staging clear and complete write inventory |

Each modulation route has a presence test. If an entire route is absent, target stays zero and amount stays half. If the route is present but amount is missing, the amount is overwritten with zero. An empty `modulation` object alone does not overwrite default amounts.

For engineID29 (`external` alias / `midi`), a present `engine.cc` triggers four loops of four entries, after engine/envelope/FX parsing (`4de1c2..4de348`): `cc[0..3].val`→indices8..11, `[4..7].val`→16..19; `[0..3].cc`→12..15, `[4..7].cc`→20..23. The array key and controller-number key are both `cc` (`84036524`); `val` is at `84036528`. Import loads the key at `84036428+fc` (`4de1ec..4de1f0`). This matches export, with no engine.midi/engine.cc asymmetry. Missing items follow scalar conversion defaults; no compacting occurs.

The raw type test `8d4dbbcc` compares JSON type directly against `drum`, `sampler`, `multisampler`. Those types reset all eight engine parameters to half on application, regardless of parsed `engine.params`. This is a separate predicate from the engineID3/4 drum-region branch.

## FX/LFO headers and identity

Root `fx` is at ROM `84036514`; root `filter` is not a substitute. `envelope.filter` is a separate object.

- `fx.type`: string required by `8d4dd97c`; aliases from `8d4dcd3c` are `squeal`→`svf`, `body`→`ladder`, `zfilter`→`z lowpass`. Resolver `8d4fe9e4` plus validity helper `8d4fd02e`; absent/invalid gives type10 and inactive. `fx.active` uses general boolean conversion. Params are still read when an FX object is present even if the type is invalid.
- `lfo.type`: string resolution via `8d5a3544`; invalid sentinel7 gives type1 and inactive. Absent LFO also gives type1/inactive. `lfo.active` uses general boolean conversion. Params are still read for a present object.
- `8d4dbd40` writes FX ID/active to pattern+28/+2c; `8d4dbd8c` writes LFO ID/active to pattern+20/+24, before the 58-word copy, and calls engine-specific apply handlers. Registry names and the duplicated binary header are covered in the accompanying export/sound-state trace.

The engine registry resolves sampler2, drum3, organ6, epiano7, prism18, hardsync19, dissolve20, axis22, midi29, multisampler30, wavetable31 and simple32. The current registry contains no ID4 name, although the drum-like classifier accepts ID4. The export report records the registry construction proof. LFO registry includes duck6 and placeholder names for4/5 in addition to tremolo0/value1/random2/element3; an importer should not invent names for those placeholders.

## Region records: all 128 bytes

Before considering `regions`, apply calls `memset(pattern+394c,0,3072)` (`4dcfa0..4dcfc4`): **all 24 × 128-byte records are cleared**. No regions, null/empty regions, or fewer regions cannot preserve old sample tails. An array-like type predicate is used (`8c050fe0` accepts array or null); the loop ends at `min(length,24)`. Input positions map sequentially to records, not to `hikey-53`. The loop does not skip entries that are not objects.

| Record offset | JSON key / action | Default and conversion |
| --- | --- | --- |
| `00..03` | `framecount` | ordinary integer helper, missing0; stored word |
| `04..07` | `sample.start` | ordinary integer, missing0 |
| `08..0b` | `sample.end` | missing **-1**, present ordinary integer (including null→0) |
| `0c..0f` | `loop.start` | general integer conversion, missing0 |
| `10..13` | `loop.end` | missing **-1**, present general integer |
| `14..17` | sampler `loop.crossfade`; drum selected fade | See below |
| `18` | `pitch.keycenter`, plus drum `transpose` | ordinary integer low8; missing0, addition wraps low8 |
| `19` | No JSON store | remains zero |
| `1a` | `hikey` | ordinary integer low8, missing0; does not select record index |
| `1b` bits0..5 | Drum `playmode` | Drum branch only; gate0, oneshot1, group2, loop3; missing/nonstring/unknown1. Sampler retains0. |
| `1b` bit6 | inverse `loop.enabled` | Missing means enabled (bit clear); present general boolean inverted |
| `1b` bit7 | `loop.onrelease`; overwritten by drum fade direction | General boolean; drum replaces with `fade.in < fade.out` |
| `1c` | `tune` | ordinary integer low8, independent of transpose |
| `1d` | `gain` | ordinary integer low8 |
| `1e` | Drum `pan` | ordinary integer low8; sampler remains0 |
| `1f` | `reverse` | general boolean |
| `20..7f` | `sample` path string | No string→empty path. Path copied with limit96 and lastbyte forced zero, at most95 bytes plus NUL. |

Common field stores are `4dd1b0..4dd332`; drum override is `4dd36c..4dd422`; string copy is `4dd424..4dd552`. `hikey`, keycenter, tune, gain, pan are not clamped to normal UI ranges here. Negative and oversized integers retain their low byte. `framecount` has no visible nonnegative validation at this layer.

Sampler crossfade (`4dd690..4dd6e8`) is zero when framecount is zero. Otherwise it converts integer crossfade to float, multiplies by float `2^31`, divides by **unsigned** framecount converted to float, converts to integer, then takes max with0. The external ROM primitives are not present in this loader; the operation identities match their uses in library conversions and the corresponding exporter, but exact overflow/rounding/NaN edges require ROM or device evidence. Do not substitute sample.end as denominator when framecount is absent: framecount defaults0, producing0.

For engine IDs3/4 the drum branch replaces the shared crossfade/fade word with `max(fade.in,fade.out,0)`, and replaces bit7 with `fade.in < fade.out`. Equal fades select the fade.in direction. Drum transpose adds to keycenter; it never replaces tune.

Path helper `4dcca0 → 4d7624` reverse-finds `/` and compares to `npos` (`840c00b8=ffffffff`). True means **no slash anywhere**. Only basename `kick.wav` joins dirname of the source patch file (`object+14`, helpers `5a4638/5a48a6`); `sub/kick.wav`, `<samples>/...`, `content/...`, and `/fat32/...` do not take that join. All pass through `5a40d0` normalization. The filesystem report traces these helpers in full.

## Tuning, octave, and remaining state

After region/FX/LFO/parameter application, apply calls track helpers `5978f8` and `597794`, then reads root `octave` through ordinary integer helper and calls `57ad90`, which clamps octave to -4..4 before `571144`. Tuning at `pattern+5394` is always cleared for48bytes. If root engine contains `tuning` and the library length reports exactly12, it indexes12 elements, converts each through general float conversion `8c052038`, packs with `8d5a9f18`, and writes12words. There is no explicit is-array check at that tuning branch, so a 12-member object is not established as a supported alternate schema.

`5a9f18` calls ROM `040175a4`, float-to-int `04020fd8`, retains signed low16 as integer part, subtracts its float from the input, adds float `0.005`, multiplies by100, converts to integer, and packs low16 of that result beneath the integer part. The external first ROM operation's exact rounding (likely floor) is not recovered in this image; do not present a bit-exact Python model for negative or boundary tuning values until that is established. The packed structure, constants and all call sites are confirmed. The second48-byte pattern tail at `+53c4` is not written by this importer.

The final apply sets global dirty byte `8409adf5=1`. No audio acceptance or device save/readback was performed by this research.

## Differences from upstream adapter at 7a74acc

Comparison target: `/tmp/xy-format-preset-json-20261023/xy/patch_json.py`. These are differences between its limited editing API and device preset replacement; not every difference must be imposed on existing partial-update methods.

1. A full preset import needs validation and replacement semantics. Current partial calls preserve omitted parameters, unused sample records, absent FX/LFO and tuning; firmware clears/redefaults them with the explicit exceptions above.
2. `_integer_value` rounds floats and excludes bool; generic firmware numeric helpers exclude floats and accept bool. `_integer_array` drops invalid elements and shifts later positions, whereas firmware retains positions and converts each independently. `_optional_q16` lacks 32-bit shift/wrap and max0 behavior.
3. Engine playmode lacks legato and rejects unknown strings, while firmware handles both. Missing transpose and modulation-route defaults need presence-sensitive treatment.
4. Drum mapping chooses a voice by hikey; firmware uses ordinal region order. Adapter treats transpose as tune; firmware adds it to keycenter independently of tune. Adapter reads only fade.out and omits the shared fade direction bit.
5. Sample.end falls back to framecount instead of missing sentinel -1. Loop.end missing must become -1 on full import. Crossfade denominator fallback to sample.end is not firmware behavior. Sampler adapter reads just the first region, while firmware supports24.
6. Sample paths are blindly prefixed by preset path. Firmware prefixes only names with no slash; path normalization/compression has additional rules.
7. Existing confirmed-state helper omits engine transpose, octave, tuning, and external CC/value mapping; full importer should distinguish these supported fields from opaque state it cannot reconstruct.
8. Firmware raw sample-type names force params0..7 to half, while adapter writes provided engine.params. Existing narrow editing API may legitimately retain its behavior, but it must not be advertised as the full device importer.

The report covers every input field and every byte written by the parsed-preset apply function. Remaining uncertainties are external ROM arithmetic edge behavior, JSON library assertions on malformed/range-exceeding nested input, and runtime/audible consequences of downstream engine handlers. Those are separate from the directly traced import layout and defaults.
