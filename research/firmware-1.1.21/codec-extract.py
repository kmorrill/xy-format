"""Regenerate codec evidence from the locally acquired 1.1.21 loader segments.

Requires the read-only inspect_firmware.py helper and extended objdump named
in the acquisition receipt. Does not modify those shared research assets.
"""
from pathlib import Path
import argparse
import hashlib
import importlib.util
import json
import re
import struct
import subprocess
import tempfile

RANGES = {
    'codec-stream.asm': (0x8d57c4fc, 0x9cc),
    'codec-dispatch.asm': (0x8d584a40, 0x7e0),
    'codec-wrapper.asm': (0x8d585220, 0x298),
    'codec-save.asm': (0x8d5847d4, 0x26a),
}
LEGACY_RANGE = (0x8d5854f4, 0x8d595700)


def extract_legacy(firmware, records_path, out):
    """Include loader fill records, which may themselves contain instructions."""
    start, end = LEGACY_RANGE
    data = bytearray(end - start)
    covered = bytearray(end - start)

    def overlay(address, content):
        lo, hi = max(start, address), min(end, address + len(content))
        if lo < hi:
            data[lo-start:hi-start] = content[lo-address:hi-address]
            covered[lo-start:hi-start] = b'\1' * (hi-lo)

    for address, path in firmware.SEGS:
        if address < end and address + path.stat().st_size > start:
            overlay(address, path.read_bytes())
    fills = []
    for record in json.loads(records_path.read_text()):
        address = int(record['target'], 16)
        size = record['count']
        if int(record['code'], 16) & 0x100 and address < end and address + size > start:
            pattern = struct.pack('<I', record['argument'])
            overlay(address, (pattern * ((size + 3) // 4))[:size])
            fills.append(record)
    if not all(covered):
        raise ValueError(f'Unmapped legacy byte at {hex(start + covered.index(0))}')
    with tempfile.TemporaryDirectory(prefix='xy-codec-') as directory:
        image = Path(directory) / 'legacy.bin'
        image.write_bytes(data)
        asm = subprocess.check_output([
            str(firmware.ROOT / 'tools/bfin-plus-objdump-extended'),
            '-D', '-b', 'binary', '-m', 'bfin', f'--adjust-vma={start}',
            f'--start-address={start}', f'--stop-address={end}', str(image)], text=True)
        (out / 'codec-legacy.asm').write_text(asm.replace(str(image), 'loader-reconstructed-legacy.bin'))
    return {'file': 'codec-legacy.asm', 'address': hex(start), 'bytes': end-start,
            'sha256': hashlib.sha256(data).hexdigest(),
            'fill_records_applied': fills}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--helper', type=Path, default=Path(
        '/Users/kevinmorrill/Documents/music-firmware/research/'
        'opxy-midi-1.1.21/inspect_firmware.py'))
    ap.add_argument('--records', type=Path, default=Path(
        '/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/os.ldr.records.json'))
    args = ap.parse_args()
    spec = importlib.util.spec_from_file_location('firmware', args.helper)
    firmware = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(firmware)
    out = Path(__file__).resolve().parent
    ranges = []
    for name, (address, length) in RANGES.items():
        (out / name).write_text(firmware.dis(address, length))
        ranges.append({'file': name, 'address': hex(address), 'bytes': length,
                       'sha256': hashlib.sha256(firmware.read(address, length)).hexdigest()})
    ranges.append(extract_legacy(firmware, args.records, out))
    reader_branches = struct.unpack('<20I', firmware.read(0x840a2284, 80))
    converter_branches = struct.unpack('<20I', firmware.read(0x840a2234, 80))

    def first_relative_call(address, length):
        return '0x' + re.search(r'CALL 0x0x([0-9a-f]+)',
                               firmware.dis(address, length)).group(1)

    rows = [
        {'version': '8.0', 'reader': '0x8d585b48', 'next_version': '8.1',
         'converter': '0x8d58d8e0'},
        {'version': '8.1', 'reader': '0x8d5862c8', 'next_version': '9.0',
         'converter': '0x8d58ed00'},
    ]
    for minor, (reader_branch, converter_branch) in enumerate(
            zip(reader_branches, converter_branches)):
        rows.append({
            'version': f'9.{minor}',
            'reader': first_relative_call(reader_branch, 24),
            'reader_branch': hex(reader_branch),
            'next_version': f'9.{minor+1}' if minor < 19 else None,
            'converter': first_relative_call(converter_branch, 50) if minor < 19 else None,
            'converter_branch': hex(converter_branch),
        })
    versions = {'firmware': '1.1.21+0', 'format_latest': '9.19',
                'read_dispatch_table': '0x840a2284',
                'migration_dispatch_table': '0x840a2234', 'versions': rows}
    (out / 'codec-versions.json').write_text(json.dumps(versions, indent=2) + '\n')
    (out / 'codec-ranges.json').write_text(json.dumps(ranges, indent=2) + '\n')
    print(f'Wrote {len(ranges)} disassembly excerpts and {len(rows)} version mappings.')


if __name__ == '__main__':
    main()
