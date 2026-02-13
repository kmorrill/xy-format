# 2025-02-14: Firmware Package Notes

- `src/firmware/opxy_firmware_1_1_0.tfw` shows paired header blocks and a payload offset at `0x14008`.
- Mixed embedded signatures were observed (`PK`, gzip-like, zstd-like), but standard tools fail to decode the streams as-is.
- A zstd frame requiring a very large window blocks stock decode paths.
- No direct `.xy` magic was found in still-compressed regions.

This work remains exploratory and separate from core `.xy` format decoding.
