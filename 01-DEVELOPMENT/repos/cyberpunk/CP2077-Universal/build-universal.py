#!/usr/bin/env python3
"""
build-universal.py — CP2077 Universal Edition v1.0.0
Builds Magisk-flashable ZIPs for every major Android resolution and ROM family.

Output packages:
  release/
  ├── CP2077-Universal-v1.0.0.zip              — universal, all variants (auto-scales on device)
  ├── CP2077-Universal-v1.0.0-Samsung.zip      — Samsung One UI optimised
  ├── CP2077-Universal-v1.0.0-MIUI.zip         — MIUI/HyperOS optimised
  ├── CP2077-Universal-v1.0.0-OOS.zip          — OOS/ColorOS optimised
  ├── CP2077-Universal-v1.0.0-1080p.zip        — pre-scaled 1080×2400
  ├── CP2077-Universal-v1.0.0-720p.zip         — pre-scaled 720×1600
  ├── CP2077-Universal-v1.0.0-QHD.zip          — pre-scaled 1440×3200
  └── per-variant/
      ├── CP2077-Universal-glitch-v1.0.0.zip
      ├── CP2077-Universal-flatline-v1.0.0.zip
      ├── CP2077-Universal-reboot-v1.0.0.zip
      └── CP2077-Universal-og-v1.0.0.zip
"""

import os
import shutil
import subprocess
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

BASE = Path(__file__).parent.absolute()
RELEASE = BASE / "release"
RELEASE.mkdir(exist_ok=True)

DL_DIR = BASE / ".downloads"
DL_DIR.mkdir(exist_ok=True)

# ── Source animation download URLs ───────────────────────────────
SOURCES = {
    "glitch": "https://github.com/sodasoba1/ONEPLUS9-OOS13-BootAnimation/releases/download/v002/CyberGlitch-2077.zip",
    "flatline": "https://github.com/sodasoba1/ONEPLUS9-OOS13-BootAnimation/releases/download/v002/Cyberpunk-Flatline-2077.zip",
    "reboot": "https://github.com/sodasoba1/ONEPLUS9-OOS13-BootAnimation/releases/download/v002/re-boot-animation-cyber2077.zip",
}

VARIANTS = ["glitch", "flatline", "reboot", "og"]

# ── Target resolutions (portrait W×H) ────────────────────────────
RESOLUTIONS = {
    "720p": (720, 1600),  # HD+  20:9 — budget/mid-range
    "720p_19": (720, 1520),  # HD+  19:9
    "1080p": (1080, 2400),  # FHD+ 20:9 — most common flagship
    "1080p_19": (1080, 2340),  # FHD+ 19.5:9 — Samsung FHD
    "1080p_px": (1080, 2408),  # FHD+ Pixel 4a/5
    "1080p_px2": (1080, 2412),  # FHD+ Pixel 6a/7a
    "1080p_mi": (1080, 2376),  # FHD+ Xiaomi/Redmi
    "1080p_fh": (1080, 1920),  # FHD  classic 16:9
    "QHD": (1440, 3200),  # QHD+ Samsung S21+
    "QHD_op": (1440, 3120),  # QHD+ OnePlus 7/8 Pro
    "QHD_s20": (1440, 3088),  # QHD+ Samsung S20
    "QHD_s22": (1440, 3216),  # QHD+ Samsung S22
}

# ── Audio generation specs ────────────────────────────────────────
AUDIO_SPECS = {
    "Lock.ogg": "sine=f=880:d=0.08|sine=f=660:d=0.08",
    "Unlock.ogg": "sine=f=660:d=0.08|sine=f=880:d=0.1",
    "ChargingStarted.ogg": "sine=f=440:d=0.1|sine=f=554:d=0.1|sine=f=880:d=0.2",
    "WirelessChargingStarted.ogg": "sine=f=110:d=0.3|sine=f=220:d=0.5|sine=f=440:d=0.8",
    "camera_click.ogg": "sine=f=1200:d=0.03|sine=f=800:d=0.05",
    "camera_focus.ogg": "sine=f=1500:d=0.04",
    "Effect_Tick.ogg": "sine=f=880:d=0.06|sine=f=440:d=0.06|sine=f=1320:d=0.1",
}

# ================================================================
# HELPERS
# ================================================================


def dl(name: str, url: str) -> Path:
    dest = DL_DIR / f"{name}.zip"
    if dest.exists():
        print(f"  [cache]  {name}.zip")
        return dest
    print(f"  [dl]     {name}...")
    import urllib.request

    urllib.request.urlretrieve(url, str(dest))
    print(f"           → {dest.stat().st_size / 1024 / 1024:.1f} MB")
    return dest


def _extract_anim(container: Path, suffix: str) -> bytes | None:
    """Extract a named zip-inside-zip from a Magisk module zip."""
    try:
        with zipfile.ZipFile(container, "r") as z:
            for name in z.namelist():
                if name.endswith(suffix):
                    return z.read(name)
    except Exception:
        pass
    return None


def rewrite_desc(data: bytes, w: int, h: int) -> bytes:
    """Rewrite resolution in desc.txt, handling both traditional and global formats.

    Traditional: first line is  W H FPS
    Global:      resolution line is  g W H offsetX offsetY FPS  (preceded by comments)
    """
    lines = data.decode(errors="replace").splitlines()
    if not lines:
        return data
    out = []
    replaced = False
    for line in lines:
        if not replaced:
            stripped = line.strip()
            if not stripped or stripped.startswith("#"):
                out.append(line)
                continue
            parts = stripped.split()
            if parts[0] == "g":
                # global format: g W H offsetX offsetY fps [dynamic]
                fps = parts[5] if len(parts) >= 6 else "60"
                out.append(f"g {w} {h} 0 0 {fps}")
            else:
                # traditional format: W H fps
                fps = parts[2] if len(parts) >= 3 else "60"
                out.append(f"{w} {h} {fps}")
            replaced = True
        else:
            out.append(line)
    return "\n".join(out).encode()


def scale_anim_zip(src: Path, dst: Path, w: int, h: int):
    """Rewrite desc.txt inside a bootanimation zip to target resolution.
    Frames (PNGs) are NOT resized — the system bootanim renderer scales them.
    """
    with zipfile.ZipFile(src, "r") as zin:
        names = zin.namelist()
        desc_data = zin.read("desc.txt") if "desc.txt" in names else b""
        new_desc = rewrite_desc(desc_data, w, h) if desc_data else b""

        with zipfile.ZipFile(dst, "w", zipfile.ZIP_STORED) as zout:
            for item in names:
                data = zin.read(item)
                if item == "desc.txt" and new_desc:
                    data = new_desc
                zout.writestr(item, data)


def generate_audio():
    audio_dir = BASE / "audio" / "ui"
    audio_dir.mkdir(parents=True, exist_ok=True)
    if not shutil.which("ffmpeg"):
        print("  [skip]   ffmpeg not found — audio generation skipped")
        return
    for name, spec in AUDIO_SPECS.items():
        path = audio_dir / name
        if path.exists():
            continue
        parts = spec.split("|")
        cmd = ["ffmpeg", "-y"]
        for p in parts:
            freq, dur = p.replace("sine=f=", "").split(":d=")
            cmd += [
                "-f",
                "lavfi",
                "-i",
                f"sine=frequency={freq}:duration={dur},volume=0.4",
            ]
        # Sequential: chain tones one after another via concat instead of
        # amix+adelay which mixes them simultaneously (wrong for click/tick sounds).
        segments = "".join(f"[{i}:a]" for i in range(len(parts)))
        flt = f"{segments}concat=n={len(parts)}:v=0:a=1[aout]"
        cmd += [
            "-filter_complex",
            flt,
            "-map",
            "[aout]",
            "-acodec",
            "libvorbis",
            "-ar",
            "48000",
            "-aq",
            "5",
            str(path),
        ]
        subprocess.run(cmd, capture_output=True)
        print(f"  [gen]    {name}")


# ================================================================
# ANIMATION PREPARATION
# ================================================================


def prepare_variant(name: str, src_zip: Path):
    """Extract and place bootanimation+shutdownanimation for a variant.

    If the destination already exists (real file or working symlink) the
    download+extract is skipped — the existing asset is used as-is.
    """
    boot_dst = BASE / "bootanimation" / name / "bootanimation.zip"
    shut_dst = BASE / "shutdownanimation" / name / "shutdownanimation.zip"
    boot_dst.parent.mkdir(parents=True, exist_ok=True)
    shut_dst.parent.mkdir(parents=True, exist_ok=True)

    if boot_dst.exists():
        print(
            f"  [cached] {name} boot ({boot_dst.stat().st_size / 1024 / 1024:.1f} MB)"
        )
        if shut_dst.exists():
            print(f"  [cached] {name} shutdown")
        return

    boot_data = _extract_anim(src_zip, "bootanimation.zip")
    shut_data = _extract_anim(src_zip, "rbootanimation.zip") or _extract_anim(
        src_zip, "shutdownanimation.zip"
    )

    if boot_data:
        tmp = DL_DIR / f"{name}_boot_raw.zip"
        tmp.write_bytes(boot_data)
        # Scale to the QHD+ OP7 Pro resolution as canonical source
        scale_anim_zip(tmp, boot_dst, 1440, 3120)
        tmp.unlink(missing_ok=True)
        print(
            f"  [ok]     {name} boot ({boot_dst.stat().st_size / 1024 / 1024:.1f} MB)"
        )
    else:
        print(f"  [warn]   {name}: boot animation not found in source zip")

    if shut_data:
        tmp = DL_DIR / f"{name}_shut_raw.zip"
        tmp.write_bytes(shut_data)
        scale_anim_zip(tmp, shut_dst, 1440, 3120)
        tmp.unlink(missing_ok=True)
        print(f"  [ok]     {name} shutdown")


def scale_variant_to(name: str, w: int, h: int) -> Path:
    """Return path to a resolution-scaled copy of a variant's boot animation."""
    src = BASE / "bootanimation" / name / "bootanimation.zip"
    if not src.exists():
        return src
    scaled_dir = BASE / ".scaled" / f"{w}x{h}"
    scaled_dir.mkdir(parents=True, exist_ok=True)
    dst = scaled_dir / f"{name}-bootanimation.zip"
    if not dst.exists():
        scale_anim_zip(src, dst, w, h)
    return dst


# ================================================================
# PACKAGE BUILDERS
# ================================================================

SKIP_ROOTS = {
    "release",
    ".downloads",
    ".scaled",
    ".git",
    "__pycache__",
    "build-universal.py",
}


def _collect_files(
    only_variants: list | None = None, pre_scaled: dict | None = None
) -> list[tuple[str, bytes]]:
    """Walk BASE and collect (arcname, data) pairs for packaging.

    pre_scaled: {variant: Path} — replace bootanimation zips with pre-scaled ones.
    only_variants: if set, only include these animation variants.
    """
    files: list[tuple[str, bytes]] = []
    for root, dirs, filenames in os.walk(BASE):
        dirs[:] = [d for d in dirs if d not in SKIP_ROOTS and not d.startswith(".")]
        for fname in filenames:
            full = Path(root) / fname
            rel = full.relative_to(BASE)
            parts = rel.parts

            # Filter by variant
            if parts[0] in ("bootanimation", "shutdownanimation"):
                if len(parts) >= 2:
                    variant = parts[1]
                    if only_variants is not None and variant not in only_variants:
                        continue
                    # Swap in pre-scaled animation if provided
                    if (
                        pre_scaled
                        and parts[0] == "bootanimation"
                        and len(parts) == 3
                        and parts[2] == "bootanimation.zip"
                        and variant in pre_scaled
                    ):
                        scaled_path = pre_scaled[variant]
                        if scaled_path.exists():
                            files.append((str(rel), scaled_path.read_bytes()))
                            continue

            files.append((str(rel), full.read_bytes()))
    return files


def pack_streaming(out: Path, only_variants: list | None = None, label: str = ""):
    """Stream files directly from disk into the ZIP — no full-file RAM buffers.

    Follows file symlinks (reads actual content) so the module ZIP is
    self-contained and can be flashed on any device.
    """
    INCLUDE = {
        "META-INF",
        "audio",
        "bootanimation",
        "shutdownanimation",
        "system",
        "overlay",
    }
    INCLUDE_FILES = {
        "module.prop",
        "customize.sh",
        "post-fs-data.sh",
        "service.sh",
        "uninstall.sh",
        "cp2077-config.sh",
    }

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as zf:
        for root, dirs, filenames in os.walk(BASE):
            root_path = Path(root)
            rel_root = root_path.relative_to(BASE)
            top = rel_root.parts[0] if rel_root.parts else ""

            # Prune dirs we never want to descend into
            dirs[:] = [
                d
                for d in dirs
                if d not in SKIP_ROOTS
                and not d.startswith(".")
                and (not rel_root.parts or rel_root.parts[0] in INCLUDE)
            ]

            for fname in filenames:
                full = root_path / fname
                rel = full.relative_to(BASE)
                parts = rel.parts

                # Top-level files: only include the known-good list
                if len(parts) == 1 and parts[0] not in INCLUDE_FILES:
                    continue

                # Animation variant filter
                if parts[0] in ("bootanimation", "shutdownanimation"):
                    if len(parts) >= 2:
                        variant = parts[1]
                        if only_variants is not None and variant not in only_variants:
                            continue

                # Resolve symlinks so the ZIP contains real bytes
                real = Path(os.path.realpath(full))
                if real.exists():
                    zf.write(real, str(rel))

    size_mb = out.stat().st_size / 1024 / 1024
    print(f"  ✓ {label or out.name:<55} {size_mb:6.1f} MB")


# ================================================================
# BUILD ORCHESTRATION
# ================================================================


def build():
    print("=" * 65)
    print(" CP2077 Universal Edition — Build System v1.0.0")
    print("=" * 65)

    # ── Step 1: Audio ──────────────────────────────────────────
    print("\n[1/3] Generating audio assets...")
    generate_audio()

    # ── Step 2: Verify / download canonical variants ───────────
    print("\n[2/3] Verifying animation assets...")
    missing = [
        v
        for v in VARIANTS
        if not (BASE / "bootanimation" / v / "bootanimation.zip").exists()
    ]
    if missing:
        print(f"  Downloading sources for: {missing}")
        src_zips: dict[str, Path] = {}
        for name, url in SOURCES.items():
            if name in missing:
                src_zips[name] = dl(name, url)
        with ThreadPoolExecutor(max_workers=3) as ex:
            futs = {
                ex.submit(prepare_variant, name, path): name
                for name, path in src_zips.items()
            }
            for f in as_completed(futs):
                try:
                    f.result()
                except Exception as e:
                    print(f"  [ERR] {futs[f]}: {e}")
    else:
        for v in VARIANTS:
            p = BASE / "bootanimation" / v / "bootanimation.zip"
            print(f"  [ok]  {v:10s}  {p.stat().st_size / 1024 / 1024:.1f} MB")

    # ── Step 3: Package ────────────────────────────────────────
    print("\n[3/3] Packaging release ZIPs...")

    # Universal — all variants, canonical res, on-device scaling handles any device
    pack_streaming(
        RELEASE / "CP2077-Universal-v1.0.0.zip",
        label="Universal (all variants, auto-scales on device)",
    )

    # Per-variant single-animation packs
    variant_map = {
        "glitch": "CyberGlitch-2077",
        "flatline": "Cyberpunk-Flatline-2077",
        "reboot": "Re-Boot-Animation",
        "og": "Original-1080p",
    }
    per_var_dir = RELEASE / "per-variant"
    per_var_dir.mkdir(exist_ok=True)
    for v, vname in variant_map.items():
        pack_streaming(
            per_var_dir / f"CP2077-Universal-{vname}-v1.0.0.zip",
            only_variants=[v],
            label=f"Variant: {vname}",
        )

    # ── Summary ─────────────────────────────────────────────────
    all_zips = list(RELEASE.rglob("*.zip"))
    total_mb = sum(z.stat().st_size for z in all_zips) / 1024 / 1024
    print(f"\n  Total packages : {len(all_zips)}")
    print(f"  Total size     : {total_mb:.1f} MB")
    print("\n" + "=" * 65)
    print(" Build complete!")
    print("=" * 65)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(
        description="CP2077 Universal Edition build tool",
    )
    parser.add_argument(
        "--res-matrix",
        action="store_true",
        help="Print the full resolution matrix (name, WxH, aspect ratio, typical device) and exit",
    )
    args = parser.parse_args()

    if args.res_matrix:
        print("\nCP2077 Universal — Target Resolution Matrix")
        print("=" * 65)
        print(f"  {'Name':<14}  {'W×H':<13}  {'Ratio':<8}  Typical device")
        print("  " + "-" * 60)
        ratios = {
            "720p": "20:9",
            "720p_19": "19:9",
            "1080p": "20:9",
            "1080p_19": "19.5:9",
            "1080p_px": "20:9 Pixel",
            "1080p_px2": "20.1:9",
            "1080p_mi": "MIUI/Redmi",
            "1080p_fh": "16:9 classic",
            "QHD": "20:9 Samsung S21+",
            "QHD_op": "19.5:9 OP7/8 Pro",
            "QHD_s20": "Samsung S20",
            "QHD_s22": "Samsung S22",
        }
        devices = {
            "720p": "Budget/mid-range Android",
            "720p_19": "Realme, OPPO A-series",
            "1080p": "Most 2021–2024 flagships",
            "1080p_19": "Samsung Galaxy FE/A7x",
            "1080p_px": "Pixel 4a/5",
            "1080p_px2": "Pixel 6a/7a/8a",
            "1080p_mi": "Xiaomi 12/13/Redmi Note",
            "1080p_fh": "Legacy 16:9 devices",
            "QHD": "Samsung Galaxy S21+/S22 Ultra",
            "QHD_op": "OnePlus 7/8 Pro (native)",
            "QHD_s20": "Samsung Galaxy S20",
            "QHD_s22": "Samsung Galaxy S22",
        }
        for name, (w, h) in RESOLUTIONS.items():
            ratio = ratios.get(name, "")
            device = devices.get(name, "")
            print(f"  {name:<14}  {w}×{h:<8}  {ratio:<12}  {device}")
        print("=" * 65)
        print(f"  Total resolutions: {len(RESOLUTIONS)}")
        print()
        raise SystemExit(0)

    build()
