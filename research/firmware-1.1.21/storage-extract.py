#!/usr/bin/env python3
"""Reproduce storage trace excerpts from the user's local OP-XY loader analysis.

No firmware data is downloaded or modified. Requires already extracted segments
and the extended Blackfin+ objdump. All generated files are static evidence,
not executable firmware patches. Usage: python storage-extract.py [analysis_dir]
"""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(
    '/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis')
OUT = Path(__file__).resolve().parent
SEGS = [(int(x['base'], 16), Path(x['path']))
        for x in json.loads((ROOT / 'segments.json').read_text())]
WINDOWS = {
    'storage-load': (0x8d574aac, 0x1ec),
    'storage-validation': (0x8d574810, 0x328),
    'storage-save-utils': (0x8d5612d0, 0x668),
    'storage-snapshot': (0x8d5717fc, 0x208),
    'storage-filesystem-wrappers': (0x8c03e040, 0x300),
    'storage-path-backup': (0x8d55fdb4, 0x40),
    'storage-path-project': (0x8d560580, 0x70),
    'storage-catalog-predicates': (0x8d4fd02e, 0xbe),
    'storage-engine-predicate': (0x8d5a21a8, 0x30),
    'storage-backup-retention': (0x8d560bbc, 0x128),
    'storage-workspace-persist': (0x8d584248, 0x94),
    'storage-workspace-periodic': (0x8d57e306, 0x92),
    'storage-workspace-queue': (0x8d4d937c, 0x114),
    'storage-sample-interface': (0x8d4d35b4, 0x1c8),
    'storage-sample-reader': (0x8d4f62dc, 0x88),
    'storage-sample-reader-select': (0x8d4f66b4, 0x1aa),
    'storage-sample-buffer': (0x8d4fff44, 0x214),
    'storage-dirty-reset': (0x8d56fa48, 0x18),
    'storage-project-scan': (0x8d55cf54, 0x400),
    'storage-project-number': (0x8d55b32e, 0xc2),
    'storage-project-clone': (0x8d55b070, 0xf4),
    'storage-project-rename': (0x8d55f4b8, 0x39c),
    'storage-project-delete': (0x8d5605f0, 0x110),
    'storage-copy-file': (0x8c03e0e4, 0x16c),
    'storage-path-split': (0x8d5a4638, 0x4aa),
    'storage-shortcut-resolve': (0x8d5a42b0, 0x28c),
    'storage-shortcut-compress': (0x8d5a40d0, 0x1e0),
    'storage-shortcut-static-init': (0x8d5a3f2a, 0x6e),
    'storage-sample-cache-load': (0x8d50362c, 0xf4),
    'storage-sample-cache-release': (0x8d503720, 0x138),
}
receipt = {'source_loader_sha256':
           'acc409d12a73fcf69f17a63084af765c90fee802271c854b4d3eeb6b2c970f86',
           'decoder_sha256': hashlib.sha256((ROOT / 'tools/bfin-plus-objdump-extended').read_bytes()).hexdigest(),
           'windows': []}
for name, (address, length) in WINDOWS.items():
    for base, path in SEGS:
        if base <= address and address + length <= base + path.stat().st_size:
            raw = path.read_bytes()[address-base:address-base+length]
            assembly = subprocess.check_output([
                str(ROOT / 'tools/bfin-plus-objdump-extended'), '-D', '-b',
                'binary', '-m', 'bfin', f'--adjust-vma={base}',
                f'--start-address={address}', f'--stop-address={address+length}',
                str(path)], text=True)
            (OUT / f'{name}.asm').write_text(assembly)
            receipt['windows'].append({'name': name, 'start': hex(address),
                                       'size': length,
                                       'bytes_sha256': hashlib.sha256(raw).hexdigest()})
            break
    else:
        raise ValueError(f'Unmapped window {name}: {address:x}+{length:x}')
(OUT / 'storage-extract-receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')
print(f'Regenerated {len(WINDOWS)} evidence windows.')
