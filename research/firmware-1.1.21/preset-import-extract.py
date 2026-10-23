#!/usr/bin/env python3
"""Reproduce static preset-import evidence from the local read-only backup helper."""
from pathlib import Path
import importlib.util
import json
import struct

ROOT = Path(__file__).resolve().parents[2]
HELPER = ROOT.parent / 'music-firmware/research/opxy-midi-1.1.21/inspect_firmware.py'
spec = importlib.util.spec_from_file_location('firmware_reader', HELPER)
f = importlib.util.module_from_spec(spec)
spec.loader.exec_module(f)
OUT = Path(__file__).resolve().parent
RANGES = {
    'main': (0x8d4dce40, 0x1e2c),
    'helpers': (0x8d4dbb00, 0x1340),
    'json-types': (0x8c050f70, 0x210),
    'json-conversion': (0x8c051c90, 0x590),
    'tuning': (0x8d5a9ef0, 0x190),
    'engine': (0x8d5a21d8, 0x170),
    'lookup': (0x8c0526cc, 0x150),
    'array-lookup': (0x8c0530e4, 0x3a0),
    'enums': (0x8d4fe8d0, 0x250),
    'lfo-enums': (0x8d5a3544, 0x140),
    'octave': (0x8d57ad90, 0xb0),
    'parser': (0x8c04e500, 0x2a00),
    'float-constructor': (0x8c0518f4, 0x48),
}
for name, (address, size) in RANGES.items():
    (OUT / f'preset-import-{name}.asm').write_text(f.dis(address, size))
tables = {'firmware_sha256': f.SHA256,
          'ranges': {name: {'address': hex(a), 'size': n} for name, (a, n) in RANGES.items()}}
for key, address in [('integer_dispatch',0x118024d0),('float_dispatch',0x11802634),
                     ('bool_dispatch',0x11802694),('track_parameter41_defaults',0x840366d0)]:
    tables[key] = [hex(n) for n in struct.unpack('<8I', f.read(address,32))]
tables['integer_token_limits'] = list(struct.unpack('<3I', f.read(0x11802160,12)))
tables['string_bytes'] = {'0x84036260': f.read(0x84036260,0x480).decode('utf8','backslashreplace')}
(OUT / 'preset-import-tables.json').write_text(json.dumps(tables, indent=2)+'\n')
print(f'Wrote {len(RANGES)} fresh disassembly ranges and table evidence')
