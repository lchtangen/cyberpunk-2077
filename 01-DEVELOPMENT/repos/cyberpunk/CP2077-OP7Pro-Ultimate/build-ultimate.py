#!/usr/bin/env python3
"""build-ultimate.py — CP2077-OP7Pro Ultimate All-In-One v3.0.0"""
import zipfile, os
from pathlib import Path

BASE   = Path(__file__).parent.absolute()
OUTPUT = BASE / 'release'
OUTPUT.mkdir(exist_ok=True)

EXCLUDES = {'.git', '__pycache__', 'release', '.gitignore', '.gitattributes',
            'build-ultimate.py', '.downloads'}


def build():
    out_zip = OUTPUT / 'CP2077-OP7Pro-v3.0.0-ultimate-all-in-one.zip'
    total_bytes = 0

    with zipfile.ZipFile(out_zip, 'w', zipfile.ZIP_DEFLATED) as zf:
        for root, dirs, files in os.walk(BASE):
            dirs[:] = [d for d in dirs if d not in EXCLUDES]
            rel_root = os.path.relpath(root, str(BASE))
            if rel_root == '.':
                rel_root = ''
            for f in files:
                if f in EXCLUDES:
                    continue
                full = os.path.join(root, f)
                rel  = os.path.join(rel_root, f) if rel_root else f
                zf.write(full, rel)
                sz = os.path.getsize(full)
                total_bytes += sz
                if sz > 10 * 1024 * 1024:
                    print(f'  large: {rel} ({sz / 1024 / 1024:.1f} MB)')

    size_mb = out_zip.stat().st_size / 1024 / 1024
    print(f'\nUltimate All-In-One package built:')
    print(f'  {out_zip.name}')
    print(f'  Compressed size: {size_mb:.1f} MB  '
          f'(raw: {total_bytes / 1024 / 1024:.1f} MB)')


if __name__ == '__main__':
    build()
