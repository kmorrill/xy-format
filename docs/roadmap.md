# Roadmap

## Now
1. Finish pointer-tail and pointer-21 decode so inspector output stops reporting unresolved note payloads.
2. Harden descriptor parsing/writing for non-`T1` multi-pattern topologies using device-authored scaffolds.
3. Add regression tests that pin current known-good multi-pattern writer behavior (`strict`, scaffold-preserving).

## Soon
1. Expand preset-to-event-type mapping for untested engines/presets.
2. Confirm track-scale and pattern-length stride behavior beyond Track 1.
3. Complete multi-step step-component decode for repeat blocks and type-specific extra bytes.

## Later
1. Decode scene/song blocks beyond current pattern/track focus.
2. Decode sample path representation and related directory structures.
3. Revisit firmware package reverse-engineering once container decompression path is available.

## Done
1. Byte-perfect container round-trip parser landed (`xy/container.py`) and validated broadly.
2. Writer root cause for `0x05`/`0x07` misalignment identified and documented.
3. Multi-pattern writer branch validated for known-good `T1+T3` paths with device-pass generated files.
