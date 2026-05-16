#!/usr/bin/env python3
"""
scale-animation.py — Standalone bootanimation scaler
Usage: python3 scale-animation.py input.zip output.zip WIDTH HEIGHT

Rewrites desc.txt inside a bootanimation.zip to target resolution.
PNG frames are NOT resized (the Android bootanim renderer scales them).
"""
import sys, zipfile


def scale(src: str, dst: str, w: int, h: int):
    with zipfile.ZipFile(src, 'r') as zin:
        names = zin.namelist()
        if 'desc.txt' not in names:
            print(f'No desc.txt found in {src}')
            sys.exit(1)

        desc_raw = zin.read('desc.txt').decode(errors='replace')
        lines = desc_raw.splitlines()
        parts = lines[0].split()
        fps = parts[2] if len(parts) >= 3 else '60'
        old_w, old_h = parts[0], parts[1]
        lines[0] = f'{w} {h} {fps}'
        new_desc = '\n'.join(lines).encode()

        print(f'  Source    : {src}')
        print(f'  Target    : {dst}')
        print(f'  Resolution: {old_w}×{old_h} → {w}×{h}  (fps={fps})')

        with zipfile.ZipFile(dst, 'w', zipfile.ZIP_STORED) as zout:
            for item in names:
                data = new_desc if item == 'desc.txt' else zin.read(item)
                zout.writestr(item, data)

        import os
        print(f'  Output    : {os.path.getsize(dst) / 1024 / 1024:.1f} MB')
        print('Done.')


if __name__ == '__main__':
    if len(sys.argv) != 5:
        print('Usage: scale-animation.py input.zip output.zip WIDTH HEIGHT')
        sys.exit(1)
    scale(sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4]))
