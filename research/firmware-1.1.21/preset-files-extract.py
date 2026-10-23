#!/usr/bin/env python3
"""Regenerate preset filesystem evidence using the read-only sibling helper.

Usage: python preset-files-extract.py [path/to/inspect_firmware.py]
Requires the user's original local loader and extended Blackfin+ decoder.
No hardware, firmware modifications, sample copies, or network access.
"""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

helper = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(
    '/Users/kevinmorrill/Documents/music-firmware/research/opxy-midi-1.1.21/inspect_firmware.py')
spec = importlib.util.spec_from_file_location('preset_files_firmware', helper)
fw = importlib.util.module_from_spec(spec)
spec.loader.exec_module(fw)
out = Path(__file__).resolve().parent
windows = {
 'patch-workers': (0x8d4dda00, 0x3570),
 'json-io': (0x8d4e1240, 0x34b0),
 'disk-workers': (0x8c0b0b00, 0x8a0),
 'read-json': (0x8c03fb08, 0x28c),
 'path-join': (0x8d5a48a6, 0x192),
 'parse-preset-path': (0x8d4e3924, 0x1160),
 'runtime-apply': (0x8d4dced8, 0x980),
 'basename-predicate': (0x8d4dcca0, 0x24),
 'string-rfind': (0x8d4d7624, 0xb8),
 'apply-sample-path': (0x8d4dd3d0, 0x2a0),
 'preset-identity': (0x8d573360, 0x54),
 'load-request': (0x8d4d7900, 0x248),
 'apply-dirty-flag': (0x8d573180, 0x9a),
 'save-bundle': (0x8d4e071c, 0x810),
 'cleanup-callback': (0x8d4dca38, 0x1b4),
 'directory-walk': (0x8c03ffac, 0x248),
 'write-json': (0x8c03f500, 0x372),
 'rooted-component': (0x8c03ee82, 0x1a2),
 'write-bytes': (0x8c03ecd4, 0x12c),
 'delete-preset': (0x8d4e7c00, 0x4c4),
 'rename-preset': (0x8d4e9470, 0x3b8),
 'move-preset': (0x8d4e841c, 0x1030),
}
receipt = dict(source_loader_sha256=fw.SHA256,
 helper_sha256=hashlib.sha256(helper.read_bytes()).hexdigest(),
 decoder_sha256=hashlib.sha256((fw.ROOT/'tools/bfin-plus-objdump-extended').read_bytes()).hexdigest(),
 note='Windows include supporting data and adjacent instructions. Function labels are research labels, not recovered symbols.', windows=[])
for name,(address,size) in windows.items():
 raw=fw.read(address,size)
 dest=out/f'preset-files-{name}.asm'
 dest.write_text(fw.dis(address,size))
 receipt['windows'].append(dict(file=dest.name,start=hex(address),size=size,
  bytes_sha256=hashlib.sha256(raw).hexdigest(),assembly_sha256=hashlib.sha256(dest.read_bytes()).hexdigest()))
(out/'preset-files-extract-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(f'Regenerated {len(windows)} preset filesystem evidence windows.')
