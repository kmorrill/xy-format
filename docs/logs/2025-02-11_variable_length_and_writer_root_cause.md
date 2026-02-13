# 2025-02-11: Variable-Length Encoding and Writer Root Cause

## Firmware Assertion
- Crash site: `serialize_latest.cpp` (`num_patterns > 0`).
- Triggered early in deserialization, indicating structural misread rather than semantic event mismatch.

## Variable-Length Track Block Rule (Verified)
- `type=0x05`: includes 2-byte padding.
- `type=0x07`: no padding.
- Same logical parameter payload, shifted by 2 bytes.

## Root Cause (Solved)
- Writer changed active type semantics but left stale `0x05` padding in place.
- This misaligned downstream reads and caused assertion failure.

## Additional Session Notes
- Shift propagation behavior across subsequent blocks was verified.
- No checksum was observed in tempo-only edits.
- Handle table correction: 12 entries x 3 bytes.
