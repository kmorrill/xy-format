# Firmware Package Notes

## Scope
This is separate from `.xy` project decoding and tracks `.tfw` container exploration.

## Current Findings
- Container starts with paired 0x40-byte headers (`0xBABECAFE` / `0xBEEFCAFE`).
- Main payload begins at `0x14008`.
- Embedded data includes non-standard compression signatures (`PK`, gzip-like, zstd-like) with unsupported/custom parameters.
- A zstd frame with very large window requirements blocks stock decompression paths.

## Practical Status
- No reliable end-to-end decompression path is implemented yet.
- Treat this as optional/off-critical-path research for `.xy` format work.

## History
Detailed notes: `docs/logs/2025-02-14_firmware_package_notes.md`.
