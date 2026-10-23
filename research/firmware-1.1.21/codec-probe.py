"""Executable transcription of the 1.1.21 RLE reader/writer state machines.

This is a static-analysis model, not firmware execution or a device test.
Run from any directory; compares against the current repository codec.
"""
from pathlib import Path
import json
import random
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from xy.rle import decode, encode


class Reader:
    """0x8d57c60c; raw-byte helper 0x8d57c5b0 returns -1 on EOF."""
    def __init__(self, raw):
        self.raw, self.pos = raw, 0
        self.previous = self.run_left = -1
        self.error = False

    def get(self):
        if self.pos == len(self.raw):
            return -1
        b = self.raw[self.pos]
        self.pos += 1
        return b

    def read(self, n):
        out = bytearray()
        while len(out) < n:
            if self.run_left > 0:
                if self.previous != -1:
                    out.append(self.previous)
                self.run_left -= 1
                if self.run_left > 0:
                    continue
                self.previous = -1
            current = self.get()
            if current == self.previous:
                self.run_left = self.get() + 2
            else:
                if self.previous != -1:
                    out.append(self.previous)
                self.previous = current
            if current == -1:
                break
        if len(out) < n:
            self.error = True
            out.extend(bytes(n - len(out)))
        return bytes(out)


class Writer:
    """0x8d57cc94; final-run flush 0x8d57ce42."""
    def __init__(self):
        self.previous = self.count = -1
        self.raw = bytearray()

    def flush_run(self):
        if self.count > 0:
            self.raw.append(self.previous & 255)
            if self.count > 1:
                self.raw.extend((self.previous & 255, (self.count - 2) & 255))

    def write(self, data):
        for value in data:
            # Firmware loads signed char; the output modulo256 is identical.
            value = value if value < 128 else value - 256
            if value == self.previous and self.count < 257:
                self.count += 1
            else:
                self.flush_run()
                self.previous, self.count = value, 1

    def finish(self):
        self.flush_run()
        return bytes(self.raw)


def main():
    rng = random.Random(913)
    cases = [bytes([value]) * n for value in [0, 1, 127, 128, 255]
             for n in [0, 1, 2, 3, 254, 255, 256, 257, 258, 513, 514, 515]]
    cases += [bytes(rng.randrange(4) for _ in range(rng.randrange(1000)))
              for _ in range(100)]
    # Actual streams start with magic. A raw standalone FF stream collides
    # with the writer's signed-char -1 sentinel on its very first byte.
    cases = [bytes.fromhex('ddccbbaa09130386') + data for data in cases]
    checked = 0
    for data in cases:
        for chunk in [1, 2, 3, 8, 31, 256, 4096]:
            writer = Writer()
            for i in range(0, len(data), chunk):
                writer.write(data[i:i + chunk])
            assert writer.finish() == encode(data)
            reader = Reader(encode(data))
            out = b''.join(reader.read(min(chunk, len(data) - i))
                           for i in range(0, len(data), chunk))
            assert out == data and not reader.error
            checked += 1
    files = list(sorted((ROOT / 'src').rglob('*.xy')))
    for path in files:
        raw = path.read_bytes()
        expected = decode(raw)
        reader = Reader(raw)
        out = reader.read(8) + reader.read(len(expected) - 8)
        assert out == expected and not reader.error, path
    return {'model': 'static transcription; not device execution',
            'state_machine_chunk_checks': checked,
            'corpus_files_whole_stream_checked': len(files),
            'truncated_pair_read2': Reader(b'AA').read(2).hex(),
            'truncated_literal_read2': Reader(b'A').read(2).hex()}


if __name__ == '__main__':
    print(json.dumps(main(), indent=2))
