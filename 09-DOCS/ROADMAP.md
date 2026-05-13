# ▓▓▓ CP2077 ROADMAP ▓▓▓

```
╔══════════════════════════════════════════════════════════════╗
║  CYBERPUNK 2077 ANDROID THEME STACK  ·  v3.2.0 TRACK        ║
║  Stable: v3.0.0  ·  Sprint: v3.1.0 Hardening  ·  Uni: v1.0  ║
╚══════════════════════════════════════════════════════════════╝
```

---

## ══ QUICK STATUS ══

```
MODULES
──────────────────────────────────────────────────────────
CP2077_OP7Pro_Full      🟢 LIVE      v3.0.0   8/0 bugs  GM1911
CP2077_Universal        🟡 BUILT     v1.0.0   14 ROMs  universal
CP2077_OP7Pro_Ultimate  ⚪ DISABLED  v3.0.0   megapack ref
──────────────────────────────────────────────────────────
```

**Badge:** `v3.1.0 pending` · LOS 23.2 audit · Android 16 timing

---

## ══ HOT PATH — P0 BLOCKERS ══

```
■ = P0 Critical   ⬛ = Blocker   ▓ = In Progress   □ = Pending
───────────────────────────────────────────────────────────────
HP-01  ⬛⬛⬛⬛⬛⬛⬛⬛  LOS 23.2 mount path audit
HP-02  ⬛⬛⬛⬛⬛⬛⬛⬛  Android 16 boot timing trace
HP-03  ⬛⬛⬛⬛⬛⬛⬛⬛  SELinux avc denial + sepolicy.rule
HP-04  ⬛⬛⬛⬛⬛⬛⬛⬛  Audio path verification LOS 23.2
HP-05  ⬛⬛⬛⬛⬛⬛⬛⬛  Magisk WebUI 5-bridge verification
HP-06  ⬛⬛⬛⬛⬛⬛⬛⬛  KernelSU module.json parity
HP-07  ⬛⬛⬛⬛⬛⬛⬛⬛  5 MB remount threshold re-validation
HP-08  ⬛⬛⬛⬛⬛⬛⬛⬛  DEVICE-SPECS.md refresh LOS 23.2
───────────────────────────────────────────────────────────────
```

| ID | Task | Priority |
|:---|:-----|:--------:|
| HP-01 | LOS 23.2 mount path audit — `/product/media`, `/system/product/media`, `/data/local`, `/data/misc/bootanim` | 🔴 P0 |
| HP-02 | Android 16 boot timing trace — `post-fs-data.sh` + `service.sh` before boot anim complete | 🔴 P0 |
| HP-03 | SELinux `avc` denial audit → generate `sepolicy.rule` if enforcing blocks mounts | 🔴 P0 |
| HP-04 | Audio path verification on LOS 23.2 — `/product/media/audio/ui/` | 🔴 P0 |
| HP-05 | Magisk WebUI verification — 5 bridge functions on Android 16 WebView | 🔴 P0 |
| HP-06 | KernelSU `module.json` parity with Magisk install behavior | 🔴 P0 |
| HP-07 | 5 MB remount threshold re-validation on LOS 23.2 stock stubs | 🔴 P0 |
| HP-08 | Device docs refresh — `DEVICE-SPECS.md` with LOS 23.2 confirmed results | 🔴 P0 |
| HP-09 | APatch `apd` path discovery — document correct binary paths and module install dir for APatch v0.10+ | 🔴 P0 |
| HP-10 | Supply chain verification — HEAD-check all `SOURCES` URLs, validate SHA-256 vs `sources.lock.json`, flag 404/mismatch | 🔴 P0 |

---

## ══ FEATURE RADAR ══

```
             v3.1.0          v4.0.0          v5.0.0       Backlog
         ──────────────  ──────────────  ──────────────  ────────
 Root     ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░░░░░  ░░░░░░░░░░░░  ░░░░░░░░
 CI/CD    ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░░░░░  ░░░░░░░░
 Universal░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░░░░░  ░░░░░░░░
 KSU      ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░░░░░  ░░░░░░░░
 Wallpaper░░░░░░░░░░░░  ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░
 MultiDev ░░░░░░░░░░░░  ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░
 Desktop  ░░░░░░░░░░░░  ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓▓▓▓  ░░░░░░░░
 OTA      ░░░░░░░░░░░░  ░░░░░░░░░░░░  ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓
 Plymouth ░░░░░░░░░░░░  ░░░░░░░░░░░░  ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓
 Audio    ░░░░░░░░░░░░  ░░░░░░░░░░░░  ░░░░░░░░░░░░  ▓▓▓▓▓▓▓▓

 ▓ = Active   ░ = Planned
```

---

## ══ SPRINT PROGRESS ══

**v3.1.0 Hardening**

```
Build      ██████████████████████████████  7/7   🟢  DONE
Service    ██████████████████████████████  5/5   🟢  DONE
Docs       ████████████████░░░░░░░░░░░░░  4/6   🟡  IN PROGRESS
LOS 23.2   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  0/8   🔴  PENDING
```

| Area | Progress | Status |
|:-----|:--------:|:------:|
| Build | 7/7 | 🟢 |
| Service | 5/5 | 🟢 |
| Docs | 4/6 | 🟡 |
| LOS 23.2 | 0/8 | 🔴 |

### Variant Work

| Variant | Status | Resolution | FPS | Ship |
|:--------|:------:|:-----------|:---:|:----:|
| `og4k` | ✅ Done | 2160×4800 | 60 | ✅ |
| `rboot` | ✅ Done | — | — | ✅ |
| `netrunner` | 📋 Planned | 1440×3120 | 60 | 🔜 |
| `corpo` | 📋 Planned | 1440×3120 | 60 | 🔜 |
| `streetkid` | 📋 Planned | 1440×3120 | 60 | 🔜 |
| Length tuning | 📋 Planned | — | — | 🔜 |

---

## ══ BUILD MATRIX ══

```
┌───────────┬───────┬────────┬──────────┬───────────┬────────┐
│ Variant   │ OG4K  │ GLITCH │ OG1080P  │ FLATLINE  │ RBOOT  │
├───────────┼───────┼────────┼──────────┼───────────┼────────┤
│ Boot      │  ✅   │   ✅   │    ✅    │    ✅     │   ✅   │
│ Shutdown  │  ✅   │   ✅   │    ✅    │    ✅     │   —    │
│ Audio     │  ✅   │   ✅   │    ✅    │    ✅     │   —    │
│ Desc.txt  │  ✅   │   ✅   │    ✅    │    ✅     │   —    │
│ ZIP Size  │ 45 MB │  32 MB │   28 MB  │   28 MB   │  12 MB │
└───────────┴───────┴────────┴──────────┴───────────┴────────┘
```

---

## ══ RISK REGISTER ══

```
 SEVERITY  ████████████████████████████████
 ─────────────────────────────────────────
 High      ████████
 Medium    ████████████████████████
 Low       ████████████████████████████████

 LIKELIHOOD: Low ◄─────────────────────────► High
             [1] [2] [3] [4] [5]
```

| Risk | Sev | Like | Impact | Status | Mitigation |
|:-----|:---:|:----:|:------:|:------:|:-----------|
| LOS 23.2 mount paths changed | 🔴 H | M | H | 🔴 | HP-01 audit |
| Android 16 timing regression | 🔴 H | M | H | 🔴 | HP-02 boot trace |
| SELinux enforcing blocks bind | 🟡 M | L | M | 🟡 | HP-03 sepolicy |
| Source ZIPs stale/404 | 🟡 M | L | H | 🟡 | `sources.lock.json` |
| KernelSU API breaks `module.json` | 🟡 M | L | M | 🟡 | HP-06 validation |

---

## ══ VERSION CODEX ══

```
╔══════════════════════════════════════════════════════════════╗
║  v3.2.0 ─── HARDENING SPRINT                             ║
║            └─ LOS 23.2 + Android 16 parity              ║
║            └─ 8 P0 blockers                              ║
╠══════════════════════════════════════════════════════════════╣
║  v4.0.0 ─── CI + UNIVERSAL v2 + ROOT MANAGERS            ║
║            ├─ MIUI / HyperOS / Samsung One UI validation ║
║            ├─ GitHub Actions CI/CD pipeline              ║
║            ├─ KernelSU + APatch parity                  ║
║            └─ MMRL WebUI bridge                         ║
╠══════════════════════════════════════════════════════════════╣
║  v5.0.0 ─── MULTI-DEVICE + LIVE WALLPAPER + DESKTOP     ║
║            ├─ Nothing Phone / Pixel 8/9 / fold/flip     ║
║            ├─ Android WallpaperService (GL ES)          ║
║            ├─ Full Hyprland desktop profile             ║
║            └─ OTA delta + Module repository             ║
╠══════════════════════════════════════════════════════════════╣
║  v6.0.0 ─── ECOSYSTEM + PORT WIZARD                     ║
║            ├─ Wizard-driven device porting              ║
║            ├─ Signed release artifacts                  ║
║            └─ Module repository + repo health         ║
╚══════════════════════════════════════════════════════════════╝
```

**versionCode formula:** `MAJOR * 100000 + MINOR * 1000 + PATCH`

```
v1.0.0 =  100000    v3.0.0 = 300000    v3.1.0 = 301000
v3.2.0 =  302000    v4.0.0 = 400000    v5.0.0 = 500000
```

---

## ══ TECH RADAR ══

```
                ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
            ▓▓                  ▓▓
         ▓▓      ▓▓▓▓▓▓▓▓      ▓▓
        ▓▓     ▓▓▓▓▓▓▓▓▓▓▓▓     ▓▓
       ▓▓     ▓▓▓▓▓  MAGISK  ▓▓▓▓     ▓▓
       ▓▓     ▓▓▓▓▓  v30.7   ▓▓▓▓     ▓▓
        ▓▓     ▓▓▓▓▓▓▓▓▓▓▓▓     ▓▓        MAGISK = Core
        ▓▓      ▓▓▓▓▓▓▓▓▓▓▓      ▓▓        KERNELSU = Alpha
         ▓▓      ▓▓▓▓▓▓▓▓      ▓▓         APATCH = Alpha
          ▓▓       LOS 23.2       ▓▓         LOS = Primary ROM
           ▓▓     ▓▓▓▓▓▓▓▓▓▓▓     ▓▓         ANDROID 16 = Target
            ▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓          FFmpeg = Building
```

| Tech | Status | Ver | Role |
|:-----|:------:|:----:|:-----|
| 🟢 Magisk | ✅ Core | v30.7 | Primary root manager |
| 🟡 KernelSU | 🔜 Alpha | TBD | Secondary root manager |
| 🟡 APatch | 🔜 Alpha | TBD | Tertiary root manager |
| 🟡 MMRL | 📋 Mapped | — | WebUI bridge |
| 🔴 LOS 23.2 | 🔄 Auditing | Android 16 | Primary ROM |
| 🔴 Android 16 | 🔄 Testing | API 36 | Target SDK |
| 🟡 Hyprland | 📋 Mapped | — | Desktop target |
| 🟡 Waybar | 📋 Mapped | — | HUD surface |
| 🟢 FFmpeg | ✅ Building | — | Audio generation |

---

## ══ DECISION LOG ══

| Decision | Date | Status | Notes |
|:---------|:-----|:------|:------|
| `versionCode = MAJOR*100000 + MINOR*1000 + PATCH` | 2026-05-13 | ✅ | Invariant — never break |
| `service.sh` 5 MB remount threshold | 2026-05-13 | ✅ | Stub detection correctness |
| Triple-path mount strategy | 2026-05-13 | ✅ | ROM compatibility |
| Shared `lib/` for shell utils | 2026-05-13 | ✅ | Maintainability |
| `sources.lock.json` for ZIP integrity | 2026-05-13 | ✅ | Supply chain |
| Universal v2 device YAML profiles | 2026-05-13 | ✅ | Extensibility |
| SLSA provenance for release artifacts | 2026-05-13 | ✅ | Supply chain |
| Hyprland layered config fragments | 2026-05-13 | ✅ | Desktop theming |
| Binary config with magic header | 2026-05-13 | ✅ | Config safety |
| `lib/root-runtime.sh` abstraction | 2026-05-13 | ✅ | Root manager neutrality |

---

## ══ DEPENDENCY GRAPH ══

```
 build.py
    │
    ├──────────────► SOURCES
    │                    │
    │                    ▼
    │              .downloads/
    │                    │
    │                    ▼
    │              sources.lock.json
    │                    │
    ├────────────────────┤
    │
    ├─► FFmpeg ──────────────────► audio/tones/
    │
    ├─► generate_zip() ────────────────────────► release/*.zip
    │                                               │
    │                            ┌─────────────────┼─────────────────┐
    │                            ▼                 ▼                 ▼
    │                     update.json        SHA256SUMS    sources.lock.json
    │                                               │              │
    │                            ┌─────────────────┴───────────────┘
    │                            ▼
    │                     SLSA provenance.json
    │
    └─► generate-manifests.sh
              │
              ▼
         manifests/
              │
              ├─► repo-registry.json
              ├─► git-repositories.txt
              ├─► git-repositories-status.txt
              └─► production-artifact-sha256.txt
```

---

## ══ METRICS DASHBOARD ══

```
BUGS FIXED       ████████████████████████████  8    ✅
OPEN BUGS       █                              0    ✅
VARIANTS        ██████████████░░░░░░░░░░░░░  2/5   🟡
CI COVERAGE     ████████████░░░░░░░░░░░░░░░░  40%   🔴
RELEASE ARTIFACTS█████████████████████████  3    ✅
BACKLOG         ████████████████████████████  210+  📊
ROM FAMILIES    ████████████████░░░░░░░░░░░░  14    🟡
ROOT MANAGERS   ██████████░░░░░░░░░░░░░░░░░░  1/3   🔴
```

| Metric | Value | Target | Status |
|:-------|:-----:|:------|:------|
| Bugs fixed this cycle | 8 | — | 🟢 |
| Open bugs | 0 | 0 | 🟢 |
| Variants shipped | 2/5 | 5/5 | 🟡 |
| CI coverage | 40% | 90% | 🔴 |
| Release artifacts | 3 | — | 🟢 |
| Backlog tasks | 210+ | — | 📊 |
| ROM families supported | 14 | 20+ | 🟡 |
| Root managers supported | 1 | 3 | 🔴 |

---

## ══ DESIGN TOKENS ══

| Token | Hex | RGB | ANSI | CSS | Android XML | Use |
|:------|:---|:---|:----:|:----|:------------|:----|
| `neon-yellow` | `#FCEE0C` | 252,238,12 | 226 | `--cp-neon` | `@color/cp_neon` | Active sprint |
| `netrunner-cyan` | `#00FFFF` | 0,255,255 | 51 | `--cp-cyan` | `@color/cp_cyan` | Links / Universal |
| `signal-green` | `#00FF9F` | 0,255,159 | 49 | `--cp-green` | `@color/cp_green` | Done / Stable |
| `flatline-red` | `#FF003C` | 255,0,60 | 196 | `--cp-red` | `@color/cp_red` | Blockers |
| `warning-orange` | `#FF6B35` | 255,107,53 | 202 | `--cp-orange` | `@color/cp_orange` | Pending |
| `carbon-black` | `#0A0A0A` | 10,10,10 | 232 | `--cp-black` | `@color/cp_black` | WebUI base |

---

## ══ PRIORITY MATRIX ══

```
         HIGH IMPACT
              ▲
              │  P0  ████████████████████
              │  P1  ██████████████████
   PRIORITY   │  P2  ████████████████
              │  P3  ████████████
              │
              └──────────────────────────►
                LOW              HIGH
                LIKELIHOOD      LIKELIHOOD
```

| Priority | Scope | Rule |
|:--------|:------|:----|
| 🔴 P0 Critical | v3.1.0 release blockers | Must be green before tagging |
| 🟡 P1 High | v3.1.0 feature parity | Should land in active sprint unless blocked |
| 🟢 P2 Medium | Polish and v4.0.0 groundwork | Useful next, not release-blocking |
| ⚪ P3 Low | v4.0.0/v5.0.0 backlog | Deferred or exploratory |

---

## ══ NEW FEATURES (10) ══

| ID | Feature | P | Track |
|:---|:--------|:-:|:-----:|
| FEAT-01 | **Module auto-update with delta patches** — binary diff for OTA instead of full ZIP re-download | P1 | v4.0.0 |
| FEAT-02 | **One-tap debug report export** — `cp2077-debug.sh` bundles logcat + mount table + config + version | P1 | v3.1.0 |
| FEAT-03 | **Variant A/B rotation scheduler** — rotate per boot cycle for NAND wear-leveling | P1 | v4.0.0 |
| FEAT-04 | **Cloud config sync** — `/data/cp2077.conf` sync via GitHub Gist or self-hosted endpoint | P2 | v5.0.0 |
| FEAT-05 | **Crash report auto-capture** — preserve `service.sh` failures to `/data/local/tmp/cp2077-crash/` | P1 | v3.1.0 |
| FEAT-06 | **Real-time boot animation preview** — WebUI frame scrubber before flashing | P2 | v4.0.0 |
| FEAT-07 | **Install-time ROM fingerprinting** — `cp2077-rom-probe.sh` writes `device-profile.yaml` | P1 | v4.0.0 |
| FEAT-08 | **Multi-slot A/B support** — detect slot, apply mounts to both `a` and `b` | P2 | v5.0.0 |
| FEAT-09 | **Dark/light mode for WebUI** — respects system dark theme + config toggle | P3 | v4.0.0 |
| FEAT-10 | **Voice announce on variant switch** — `espeak-ng` or TTS callout after change | P3 | v5.0.0 |

---

## ══ NEW IMPLEMENTATIONS (10) ══

| ID | Implementation | P | Track |
|:---|:--------------|:-:|:-----:|
| IMPL-01 | **`lib/config-v2.sh`** — atomic read/write, file locking, schema validation VARIANT/AUDIO/SILENT | P1 | v3.1.0 |
| IMPL-02 | **`sources.lock.json`** — JSON Schema + `cp2077-source-lock-validator.py` | P1 | v4.0.0 |
| IMPL-03 | **`device-profile.schema.yaml`** — strict schema consumed by `build-universal.py` | P1 | v4.0.0 |
| IMPL-04 | **CI pipeline** — `.github/workflows/ci.yml` lint → build → test → release matrix | P1 | v4.0.0 |
| IMPL-05 | **ShellCheck + shfmt pre-commit** — `.husky/pre-commit` on all `*.sh` | P2 | v4.0.0 |
| IMPL-06 | **SLSA provenance** — `cp2077-slsa-provenance.sh` for every release ZIP | P1 | v4.0.0 |
| IMPL-07 | **`update.json` validator** — JSON Schema CI gate (version, versionCode, zipUrl, checksum) | P1 | v4.0.0 |
| IMPL-08 | **Playwright e2e suite** — `tests/webui.spec.ts` bridge + variant cards + OTA | P2 | v4.0.0 |
| IMPL-09 | **Repo health scorecard** — `cp2077-repo-score.py` all 53 repos | P2 | v4.0.0 |
| IMPL-10 | **Workspace audit automation** — `cp2077-workspace-audit.sh` weekly cron | P1 | v3.1.0 |

---

## ══ NEW SECTIONS (10) ══

### NS-01 · Variant Architecture

```
 og4k      ──────────► bootanimation.zip   (LANCZOS 2160×4800)
 og1080p   ──────────► bootanimation.zip   (1080×2400)
 glitch    ──────────► bootanimation.zip   (1080×2400 + glitch)
 flatline  ──────────► bootanimation.zip   (1080×2400 + flatline red)
 netrunner ──────────► bootanimation.zip   (1440×3120 + cyan)  [📋]
 corpo     ──────────► bootanimation.zip   (1440×3120 + gold)  [📋]
 streetkid ──────────► bootanimation.zip   (1440×3120 + orange)[📋]
 rboot     ──────────► rbootanimation.zip (reboot path only)
```

Each variant ships: `bootanimation.zip`, `shutdownanimation.zip`, `desc.txt`, `audio/`

### NS-02 · Mount Topology

```
 AOSP PRIMARY
 /product/media/bootanimation.zip
         │
         │  mount --bind $MODDIR/common/bootanimation-$VARIANT.zip $TARGET
         ▼
 LOS FALLBACK
 /system/product/media/bootanimation.zip
         │
         │  size < 5 MB ? unmount + retry
         ▼
 UNIVERSAL CATCH-ALL
 /data/local/bootanimation.zip
         │
         ▼
 RECOVERY-SAFE
 /data/misc/bootanim/bootanimation.zip

 service.sh double-pass:
   Pass 1: bind mount variant ZIP
   Pass 2: if size < 5 MB → unmount + next path
```

### NS-03 · Root Manager Adapter

```
┌─────────────────────────────────────────────────────────────┐
│                    cp2077-config.sh                         │
│               (user-facing TUI bridge)                     │
└──────────────────────┬────────────────────────────────────┘
                       │ shell bridge
         ┌─────────────┼─────────────┐
         ▼             ▼             ▼
┌────────────┐ ┌───────────┐ ┌──────────┐
│   MMRL     │ │  KernelSU │ │  APatch  │
│ WebBridge  │ │  Bridge   │ │  Bridge  │
└─────┬──────┘ └─────┬─────┘ └────┬────┘
      │               │            │
      ▼               ▼            ▼
┌─────────────────────────────────────────┐
│            lib/root-runtime.sh          │
│  detect_root_manager()                  │
│  detect_module_dir()                   │
│  run_root_command()                    │
└─────────────────────────────────────────┘
```

### NS-04 · CI/CD Pipeline

```
┌──────────────────────────────────────────────────────────────┐
│  PR / Push                                                  │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 1: LINT                                             │
│  ├── shellcheck *.sh                                       │
│  ├── python3 -m py_compile *.py                            │
│  ├── ruff check *.py                                       │
│  └── yaml lint device-profiles/*.yaml                      │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 2: BUILD                                            │
│  ├── python3 build.py --check-sources                      │
│  ├── ffmpeg audio gen (skip if missing)                    │
│  ├── python3 build.py --variants all                       │
│  └── python3 build-universal.py                           │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 3: TEST                                             │
│  ├── zipfile -t release/*.zip                             │
│  ├── SHA-256 compare (reproducible gate)                   │
│  ├── module-lint check                                     │
│  └── update.json schema validation                        │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 4: RELEASE                                          │
│  ├── gh release create --draft                              │
│  ├── cp2077-slsa-provenance.sh                            │
│  ├── upload artifacts + SHA256SUMS                         │
│  └── OpenSSF Scorecard run                                │
└─────────────────────────────────────────────────────────────┘
```

### NS-05 · Supply Chain Map

```
Upstream Source ZIPs (SOURCES)
         │
         ▼
  .downloads/ (cache)
         │
         ▼
  sources.lock.json (integrity record)
         │
         ▼
  build.py + build-universal.py
         │
         ├─► FFmpeg audio gen
         │
         ▼
  release/*.zip (reproducible, normalized timestamp)
         │
         ├─► SHA256SUMS
         ├─► update.json (validated)
         ├─► sources.lock.json (embedded)
         └─► SLSA provenance (provenance.json)
```

### NS-06 · Release Artifact Contract

Every `*-release.zip` **must** contain:

```
META-INF/com/google/android/update-binary      ✅  Magisk standard
META-INF/com/google/android/updater-script   ✅  Magisk standard
module.prop                                  ✅  id/version/versionCode/author/description
customize.sh                                ✅  variant selection + config write
service.sh                                  ✅  double-pass mount + remount threshold
post-fs-data.sh                             ✅  fallback copy + mount
uninstall.sh                               ✅  full cleanup
bootanimation/                              ✅  variant ZIPs
shutdownanimation/                          ✅  variant ZIPs
common/                                     ✅  shared assets
update.json                                 ✅  top-level only
```

### NS-07 · Design Token Reference

```
╔══════════════╦══════════╦══════════════╦════════╗
║ TOKEN        ║ HEX      ║ RGB         ║ ANSI  ║
╠══════════════╬══════════╬══════════════╬════════╣
║ neon-yellow  ║ #FCEE0C  ║ 252,238,12  ║  226  ║
║ netrunner-cyan║ #00FFFF  ║ 0,255,255   ║   51  ║
║ signal-green ║ #00FF9F  ║ 0,255,159    ║   49  ║
║ flatline-red ║ #FF003C  ║ 255,0,60     ║  196  ║
║ warning-orange║ #FF6B35 ║ 255,107,53 ║  202  ║
║ carbon-black ║ #0A0A0A  ║ 10,10,10    ║  232  ║
╚══════════════╩══════════╩══════════════╩════════╝
```

### NS-08 · Backlog Priority Matrix

```
        HIGH IMPACT
             ▲
             │  P0  ████████████████████
             │  P1  ██████████████████
  PRIORITY   │  P2  ████████████████
             │  P3  ████████████
             │
             └──────────────────────────►
               LOW              HIGH
               LIKELIHOOD      LIKELIHOOD
```

| ID | Task | P | L | Impact |
|:---|:-----|:-|:-|:------:|
| LOS 23.2 mount change | HP-01 | P0 | M | H |
| Source ZIP 404 | — | P2 | M | H |
| SELinux block | HP-03 | P0 | L | M |
| KernelSU API break | — | P2 | L | M |

### NS-09 · Keyboard Shortcuts (WebUI)

| Key | Action |
|:----|:-------|
| `1`–`5` | Switch variant (og4k, glitch, og1080p, flatline, rboot) |
| `A` | Toggle audio on/off |
| `S` | Toggle silent mode |
| `D` | Open diagnostics drawer |
| `R` | Restart animation |
| `U` | Check for update |
| `H` | Toggle this help overlay |
| `Esc` | Close any open drawer |

### NS-10 · Changelog Preview

```markdown
## v3.1.0 — "Hardening" (2026-05-13)

### Bug Fixes
- Fixed og4k empty directory (upscaled og1080p via LANCZOS)
- Fixed missing og1080p shutdown animation
- Fixed empty Universal release directory
- Fixed update.json non-existent repo path
- Fixed broken SVG symlinks in icon theme
- Fixed og4k missing shutdown animation
- Fixed rbootanimation.zip coverage

### Performance
- Boot intro latency -1s+ (planned)
- RAM-staged animation mount (planned)

### Maintenance
- service.sh double-pass remount
- module.prop bumped to v3.1.0
- Variant preview in customize.sh

### New Variants
- og4k — 2160×4800 original

### Coming in v4.0.0
- Universal v2 + MIUI/HyperOS/Samsung
- GitHub Actions CI/CD
- KernelSU-native packaging
```

---

## ══ NEW FEATURES (20) ══

| ID | Feature | P | Track |
|:---|:--------|:-:|:-----:|
| FEAT-01 | **Module auto-update with delta patches** — binary diff for OTA instead of full ZIP re-download | P1 | v4.0.0 |
| FEAT-02 | **One-tap debug report export** — `cp2077-debug.sh` bundles logcat + mount table + config + version | P1 | v3.1.0 |
| FEAT-03 | **Variant A/B rotation scheduler** — rotate per boot cycle for NAND wear-leveling | P1 | v4.0.0 |
| FEAT-04 | **Cloud config sync** — `/data/cp2077.conf` sync via GitHub Gist or self-hosted endpoint | P2 | v5.0.0 |
| FEAT-05 | **Crash report auto-capture** — preserve `service.sh` failures to `/data/local/tmp/cp2077-crash/` | P1 | v3.1.0 |
| FEAT-06 | **Real-time boot animation preview** — WebUI frame scrubber before flashing | P2 | v4.0.0 |
| FEAT-07 | **Install-time ROM fingerprinting** — `cp2077-rom-probe.sh` writes `device-profile.yaml` | P1 | v4.0.0 |
| FEAT-08 | **Multi-slot A/B support** — detect slot, apply mounts to both `a` and `b` | P2 | v5.0.0 |
| FEAT-09 | **Dark/light mode for WebUI** — respects system dark theme + config toggle | P3 | v4.0.0 |
| FEAT-10 | **Voice announce on variant switch** — `espeak-ng` or TTS callout after change | P3 | v5.0.0 |
| FEAT-11 | **Boot animation statistics collector** — capture frame count, fps drift, decode time per boot → `/data/local/tmp/cp2077-stats/` | P2 | v4.0.0 |
| FEAT-12 | **Thermal-aware animation throttle** — detect CPU temp via `/sys/class/thermal/`, reduce variant FPS or switch to lower-res variant if > 85°C | P1 | v5.0.0 |
| FEAT-13 | **Module health score in WebUI** — composite score (mount success rate, audio plays, no boot loop) shown as 🔴🟡🟢 badge | P1 | v4.0.0 |
| FEAT-14 | **Install-time variant comparison** — show side-by-side frame previews in `customize.sh` TUI before install | P2 | v4.0.0 |
| FEAT-15 | **Automatic bug report bundle** — if mount fails 3 consecutive boots, auto-collect logcat + dmesg + mounts into shareable ZIP | P1 | v3.1.0 |
| FEAT-16 | **Charging animation lock screen** — 330-frame `AnimationDrawable` overlay when charging, matched to active variant color | P2 | v5.0.0 |
| FEAT-17 | **Variant sync across devices** — sync active variant + audio setting via GitHub Gist or local HTTP push | P2 | v5.0.0 |
| FEAT-18 | **Boot sound equalizer profile** — per-variant FFmpeg low-pass filter tuned to Cyberpunk 2077 radio aesthetic | P3 | v5.0.0 |
| FEAT-19 | **Reduced-motion mode** — skip boot animation, play only 3 frames on startup if system `ro.accessibility.reduce_motion=1` | P3 | v4.0.0 |
| FEAT-20 | **Module integrity self-check** — on boot, verify SHA-256 of every mounted ZIP matches `sources.lock.json`, alert if mismatch | P1 | v4.0.0 |

---

## ══ NEW IMPLEMENTATIONS (20) ══

| ID | Implementation | P | Track |
|:---|:--------------|:-:|:-----:|
| IMPL-01 | **`lib/config-v2.sh`** — atomic read/write, file locking, schema validation VARIANT/AUDIO/SILENT | P1 | v3.1.0 |
| IMPL-02 | **`sources.lock.json`** — JSON Schema + `cp2077-source-lock-validator.py` | P1 | v4.0.0 |
| IMPL-03 | **`device-profile.schema.yaml`** — strict schema consumed by `build-universal.py` | P1 | v4.0.0 |
| IMPL-04 | **CI pipeline** — `.github/workflows/ci.yml` lint → build → test → release matrix | P1 | v4.0.0 |
| IMPL-05 | **ShellCheck + shfmt pre-commit** — `.husky/pre-commit` on all `*.sh` | P2 | v4.0.0 |
| IMPL-06 | **SLSA provenance** — `cp2077-slsa-provenance.sh` for every release ZIP | P1 | v4.0.0 |
| IMPL-07 | **`update.json` validator** — JSON Schema CI gate (version, versionCode, zipUrl, checksum) | P1 | v4.0.0 |
| IMPL-08 | **Playwright e2e suite** — `tests/webui.spec.ts` bridge + variant cards + OTA | P2 | v4.0.0 |
| IMPL-09 | **Repo health scorecard** — `cp2077-repo-score.py` all 53 repos | P2 | v4.0.0 |
| IMPL-10 | **Workspace audit automation** — `cp2077-workspace-audit.sh` weekly cron | P1 | v3.1.0 |
| IMPL-11 | **`lib/cp2077-boot-stats.sh`** — parse `logcat -b events` for boot timing, write JSON to `/data/local/tmp/cp2077-stats/` per variant | P2 | v4.0.0 |
| IMPL-12 | **`lib/thermal-guard.sh`** — poll CPU temp, expose `cp2077_thermal_throttle()` for service.sh integration | P1 | v5.0.0 |
| IMPL-13 | **`lib/health-score.sh`** — composite health: mount rate + audio check + config validity → `0–100` score | P1 | v4.0.0 |
| IMPL-14 | **`cp2077-variant-compare.py`** — render side-by-side frame thumbnails for TUI display in `customize.sh` | P2 | v4.0.0 |
| IMPL-15 | **`cp2077-bug-bundle.sh`** — collect logcat + dmesg + mount table + config + version → `cp2077-crash-YYYY-MM-DD.zip` | P1 | v3.1.0 |
| IMPL-16 | **`lib/charging-anim.sh`** — detect battery state via `Intent.ACTION_BATTERY_CHANGED`, overlay frame animation | P2 | v5.0.0 |
| IMPL-17 | **`lib/gist-sync.sh`** — push/pull `/data/cp2077.conf` to/from GitHub Gist via `gh gist` or curl | P2 | v5.0.0 |
| IMPL-18 | **`lib/reduced-motion.sh`** — check `ro.accessibility.reduce_motion`, inject 3-frame stub if set | P3 | v4.0.0 |
| IMPL-19 | **`cp2077-self-check.sh`** — on boot, verify SHA-256 of all mounted ZIPs vs `sources.lock.json`, alert if mismatch | P1 | v4.0.0 |
| IMPL-20 | **`lib/variant-rotation.sh`** — track boot count per variant in `/data/cp2077-rotation`, rotate on every N boots | P2 | v4.0.0 |

---

## ══ NEW SECTIONS (20) ══

### NS-01 · Variant Architecture

```
 og4k         ──────────► bootanimation.zip   (LANCZOS 2160×4800)    ✅ LIVE
 og1080p      ──────────► bootanimation.zip   (1080×2400)             ✅ LIVE
 glitch       ──────────► bootanimation.zip   (1080×2400 + glitch)    ✅ LIVE
 flatline     ──────────► bootanimation.zip   (1080×2400 + red)       ✅ LIVE
 rboot        ──────────► rbootanimation.zip  (reboot path only)      ✅ LIVE
 netrunner    ──────────► bootanimation.zip   (1440×3120 + cyan)      📋 v4.0.0
 corpo        ──────────► bootanimation.zip   (1440×3120 + gold)      📋 v4.0.0
 streetkid    ──────────► bootanimation.zip   (1440×3120 + orange)    📋 v4.0.0
 phantom-lib  ──────────► bootanimation.zip   (1440×3120 purple/teal) 🆕 v4.0.0
 dogtown      ──────────► bootanimation.zip   (1440×3120 grain/green) 🆕 v5.0.0
```

Each variant ships: `bootanimation.zip`, `shutdownanimation.zip`, `desc.txt`, `audio/`, `splash/thumbnail-512.png`

### Variant Design Specs

| Variant | Theme | Palette | Audio Motif | Track |
|:--------|:------|:-------:|:------------|:-----:|
| `og4k` | Original 4K upscaled | `#FCEE0C` dominant | CP2077 main theme | ✅ Live |
| `og1080p` | Original standard | `#FCEE0C` dominant | CP2077 main theme | ✅ Live |
| `glitch` | Corruption/glitch frames | `#00FF9F` flicker | Glitch burst | ✅ Live |
| `flatline` | Red death-screen flatline | `#FF003C` dominant | Flatline tone | ✅ Live |
| `rboot` | Reboot path only | — | — | ✅ Live |
| `netrunner` | Cyan neural-interface, holographic HUD lines | `#00FFFF` dominant | Neural pulse tone | P1 · v4.0.0 |
| `corpo` | Gold/silver Arasaka geometry, clean corporate | `#FCEE0C` + silver | Corporate chime | P1 · v4.0.0 |
| `streetkid` | Orange/red scanlines, grungy analog static | `#FF6B35` dominant | Street radio burst | P1 · v4.0.0 |
| `phantom-liberty` | Pacifica sunset, deep purple/teal, spy thriller | `#8B5CF6` + `#00FFFF` | Spy thriller motif | P2 · v4.0.0 |
| `dogtown` | Heavy grain, muted green/grey, 35mm film | `#00FF9F` muted | Industrial drone | P3 · v5.0.0 |

### NS-02 · Mount Topology

```
 AOSP PRIMARY
 /product/media/bootanimation.zip
         │
         │  mount --bind $MODDIR/common/bootanimation-$VARIANT.zip $TARGET
         ▼
 LOS FALLBACK
 /system/product/media/bootanimation.zip
         │
         │  size < 5 MB ? unmount + retry
         ▼
 UNIVERSAL CATCH-ALL
 /data/local/bootanimation.zip
         │
         ▼
 RECOVERY-SAFE
 /data/misc/bootanim/bootanimation.zip

 service.sh double-pass:
   Pass 1: bind mount variant ZIP
   Pass 2: if size < 5 MB → unmount + next path
```

### NS-03 · Root Manager Adapter

```
┌─────────────────────────────────────────────────────────────┐
│                    cp2077-config.sh                         │
│               (user-facing TUI bridge)                     │
└──────────────────────┬────────────────────────────────────┘
                       │ shell bridge
         ┌─────────────┼─────────────┐
         ▼             ▼             ▼
┌────────────┐ ┌───────────┐ ┌──────────┐
│   MMRL     │ │  KernelSU │ │  APatch  │
│ WebBridge  │ │  Bridge   │ │  Bridge  │
└─────┬──────┘ └─────┬─────┘ └────┬────┘
      │               │            │
      ▼               ▼            ▼
┌─────────────────────────────────────────┐
│            lib/root-runtime.sh          │
│  detect_root_manager()                  │
│  detect_module_dir()                    │
│  run_root_command()                    │
└─────────────────────────────────────────┘
```

### NS-04 · CI/CD Pipeline

```
┌──────────────────────────────────────────────────────────────┐
│  PR / Push                                                  │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 1: LINT                                             │
│  ├── shellcheck *.sh                                       │
│  ├── python3 -m py_compile *.py                           │
│  ├── ruff check *.py                                       │
│  └── yaml lint device-profiles/*.yaml                      │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 2: BUILD                                            │
│  ├── python3 build.py --check-sources                     │
│  ├── ffmpeg audio gen (skip if missing)                    │
│  ├── python3 build.py --variants all                      │
│  └── python3 build-universal.py                           │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 3: TEST                                             │
│  ├── zipfile -t release/*.zip                             │
│  ├── SHA-256 compare (reproducible gate)                   │
│  ├── module-lint check                                     │
│  └── update.json schema validation                         │
└────────────────────┬───────────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────────────┐
│  Stage 4: RELEASE                                          │
│  ├── gh release create --draft                            │
│  ├── cp2077-slsa-provenance.sh                            │
│  ├── upload artifacts + SHA256SUMS                         │
│  └── OpenSSF Scorecard run                                 │
└─────────────────────────────────────────────────────────────┘
```

### NS-05 · Supply Chain Map

```
Upstream Source ZIPs (SOURCES)
         │
         ▼
  .downloads/ (cache)
         │
         ▼
  sources.lock.json (integrity record)
         │
         ▼
  build.py + build-universal.py
         │
         ├─► FFmpeg audio gen
         │
         ▼
  release/*.zip (reproducible, normalized timestamp)
         │
         ├─► SHA256SUMS
         ├─► update.json (validated)
         ├─► sources.lock.json (embedded)
         └─► SLSA provenance (provenance.json)
```

### NS-06 · Release Artifact Contract

```
META-INF/com/google/android/update-binary      ✅  Magisk standard
META-INF/com/google/android/updater-script     ✅  Magisk standard
module.prop                                  ✅  id/version/versionCode/author/description
customize.sh                                ✅  variant selection + config write
service.sh                                  ✅  double-pass mount + remount threshold
post-fs-data.sh                             ✅  fallback copy + mount
uninstall.sh                               ✅  full cleanup
bootanimation/                              ✅  variant ZIPs
shutdownanimation/                          ✅  variant ZIPs
common/                                     ✅  shared assets
update.json                                 ✅  top-level only
```

### NS-07 · Design Token Reference

```
╔══════════════╦══════════╦══════════════╦════════╗
║ TOKEN        ║ HEX      ║ RGB          ║ ANSI  ║
╠══════════════╬══════════╬══════════════╬════════╣
║ neon-yellow  ║ #FCEE0C  ║ 252,238,12   ║  226  ║
║ netrunner-cyan║ #00FFFF  ║ 0,255,255    ║   51  ║
║ signal-green ║ #00FF9F  ║ 0,255,159    ║   49  ║
║ flatline-red ║ #FF003C  ║ 255,0,60     ║  196  ║
║ warning-orange║ #FF6B35 ║ 255,107,53  ║  202  ║
║ carbon-black ║ #0A0A0A  ║ 10,10,10     ║  232  ║
╚══════════════╩══════════╩══════════════╩════════╝
```

### NS-08 · Backlog Priority Matrix

```
        HIGH IMPACT
             ▲
             │  P0  ████████████████████
             │  P1  ██████████████████
   PRIORITY   │  P2  ████████████████
             │  P3  ████████████
             │
             └──────────────────────────►
               LOW              HIGH
               LIKELIHOOD      LIKELIHOOD
```

| ID | Task | P | L | Impact |
|:---|:-----|:-|:-|:------:|
| LOS 23.2 mount change | HP-01 | P0 | M | H |
| Source ZIP 404 | — | P2 | M | H |
| SELinux block | HP-03 | P0 | L | M |
| KernelSU API break | — | P2 | L | M |

### NS-09 · Keyboard Shortcuts (WebUI)

| Key | Action |
|:----|:-------|
| `1`–`5` | Switch variant (og4k, glitch, og1080p, flatline, rboot) |
| `A` | Toggle audio on/off |
| `S` | Toggle silent mode |
| `D` | Open diagnostics drawer |
| `R` | Restart animation |
| `U` | Check for update |
| `H` | Toggle this help overlay |
| `Esc` | Close any open drawer |

### NS-10 · Changelog Preview

```markdown
## v3.1.0 — "Hardening" (2026-05-13)

### Bug Fixes
- Fixed og4k empty directory (upscaled og1080p via LANCZOS)
- Fixed missing og1080p shutdown animation
- Fixed empty Universal release directory
- Fixed update.json non-existent repo path
- Fixed broken SVG symlinks in icon theme
- Fixed og4k missing shutdown animation
- Fixed rbootanimation.zip coverage

### Performance
- Boot intro latency -1s+ (planned)
- RAM-staged animation mount (planned)

### Maintenance
- service.sh double-pass remount
- module.prop bumped to v3.1.0
- Variant preview in customize.sh

### New Variants
- og4k — 2160×4800 original

### Coming in v4.0.0
- Universal v2 + MIUI/HyperOS/Samsung
- GitHub Actions CI/CD
- KernelSU-native packaging
```

### NS-11 · Boot Lifecycle Timing

```
 POWER BUTTON
      │
      ▼
 ┌─────────────────────────────────────────────────────────┐
 │  BOOT STAGE 1: Kernel + initrd                         │
 │  └── /init → vendor INIT                               │
 └─────────────────────────────────────────────────────────┘
      │
      ▼
 ┌─────────────────────────────────────────────────────────┐
 │  BOOT STAGE 2: post-fs-data.sh  [BLOCKING]             │
 │  ├── cp2077-f2fs-opt.sh (if F2FS)                     │
 │  ├── cp2077-rom-probe.sh → device-profile.yaml        │
 │  ├── fallback_copy() → /data/local/bootanimation.zip   │
 │  └── mount_with_fallback() → primary path              │
 │  ⏱ Target: < 800ms total                              │
 └─────────────────────────────────────────────────────────┘
      │
      ▼
 ┌─────────────────────────────────────────────────────────┐
 │  BOOT STAGE 3: service.sh  [PARALLEL with boot anim]  │
 │  ├── wait_for_prop(bootanim.open)                      │
 │  ├── double_pass_remount()                             │
 │  └── mount_verification()                              │
 │  ⏱ 5s budget + < 200ms retry overhead               │
 └─────────────────────────────────────────────────────────┘
      │
      ▼
 ┌─────────────────────────────────────────────────────────┐
 │  BOOT STAGE 4: boot-completed broadcast                 │
 │  ├── restartAnim() if variant switched                 │
 │  └── log timing to /data/local/tmp/cp2077-timing.log  │
 └─────────────────────────────────────────────────────────┘
      │
      ▼
  ANDROID HOME
```

### NS-12 · Boot Lifecycle Timing

```
 TIME SINCE POWER-ON
 │
 ├─ 0s   │ Kernel + initrd
 ├─ 2s   │ init.rc starts zygote
 ├─ 4s   │ surfaceflinger starts boot animation
 │       │
 ├─ 5s   │ post-fs-data.sh deadline (CP2077 must be mounted)
 │       │
 ├─ 8s   │ service.sh remount window closes
 │       │
 ├─ 12s  │ boot_completed broadcast
 │       │
 └─ 15s  │ home screen

 service.sh budget: 5s + 200ms retry
 post-fs-data.sh budget: 800ms
```

### NS-13 · Security + SELinux Model

```
╔═══════════════════════════════════════════════════════════╗
║  SECURITY MODEL                                          ║
╠═══════════════════════════════════════════════════════════╣
║                                                           ║
║  MAGISK DENYLIST ──► Zygisk hooks ──► isolated apps       ║
║        │                                                    ║
║        ├──► sucontext ──► root UID grants                 ║
║        │                                                    ║
║        └──► allowlist ──► non-root policy                  ║
║                                                           ║
║  KERNELSU ──► kernel module ──► supercall ──► userspace  ║
║        │                                                    ║
║        ├──► profile per app ──► root + non-root           ║
║        │                                                    ║
║        └──► allowlist ──► UID-based                       ║
║                                                           ║
║  APATCH ──► KernelPatch ──► inline hook ──► syscall      ║
║        │                                                    ║
║        ├──► KPM (inline/syscall hooks)                     ║
║        │                                                    ║
║        └──► overlayfs via setfattr                        ║
║                                                           ║
║  CP2077 sepolicy.rule generation:                         ║
║    avc_logged │ generate sepolicy.rule │ magiskpolicy     ║
╚═══════════════════════════════════════════════════════════╝
```

### NS-14 · Module Update Flow

```
┌─────────────────────────────────────────────────────────────┐
│ UPDATE FLOW                                                 │
│                                                             │
│  1. service.sh checks /data/cp2077.conf → UPDATE_MODE     │
│  2. cp2077-check-update.sh → GET updateJson URL           │
│  3. curl -I → HTTP 200 ? continue : abort                 │
│  4. compare versionCode → same : download delta or full   │
│  5. delta patch (if < 20MB diff) → bspatch                │
│     full ZIP  (if > 20MB diff) → wget                     │
│  6. verify SHA-256 against embedded checksum              │
│  7. prompt user via WebUI notification                    │
│  8. on confirm → flash via update-binary                  │
│  9. on failure → rollback to previous module.zip         │
└─────────────────────────────────────────────────────────────┘
```

### NS-15 · Audio Pipeline

```
SOURCE AUDIO (.ogg from FFmpeg tone generation)
         │
         ▼
  generate_tone(frequency, duration, volume)
         │
         ├─► tone type: boot_start    (880 Hz, 0.5s, fade-in)
         ├─► tone type: boot_complete (440 Hz, 0.3s, fade-out)
         ├─► tone type: shutdown_pre  (220 Hz, 1.0s, fade-out)
         ├─► tone type: ui_click      (1200 Hz, 0.05s, sharp)
         ├─► tone type: ui_error      (300 Hz, 0.2s, 3x repeat)
         ├─► tone type: notification  (660 Hz, 0.4s)
         └─► tone type: video_record  (1000 Hz, 0.3s)
                   │
                   ▼
  Per-variant audio palette (.json in common/audio/)
         │
         ▼
  Volume normalization → -18 LUFS (libebur128)
         │
         ▼
  Encoded to OGG/Vorbis q5, ~50 KB per tone
         │
         ▼
  Stored in common/audio/{variant}/
         │
         ▼
  Mounted to /product/media/audio/ui/
```

### NS-16 · Variant Color Palettes

```
╔═══════════════════════════════════════════════════════════════╗
║  VARIANT COLOR MAP                                          ║
╠═══════════════════════════════════════════════════════════════╣
║  og4k       │ #FCEE0C (neon yellow) · audio: warm 880Hz   ║
║  og1080p    │ #FCEE0C (neon yellow) · audio: warm 880Hz    ║
║  glitch     │ #00FF9F (signal green)  · audio: distorted   ║
║  flatline   │ #FF003C (flatline red)  · audio: flatline beep║
║  netrunner  │ #00FFFF (netrunner cyan)· audio: neural synth ║
║  corpo     │ #FFD700 (gold) + #C0C0C0 (silver)            ║
║  streetkid │ #FF6B35 (orange) + #FF003C (red)            ║
╚═══════════════════════════════════════════════════════════════╝
```

### NS-17 · File Tree — Module Structure

```
CP2077-OP7Pro-Full/
├── META-INF/
│   └── com/google/android/
│       ├── update-binary
│       └── updater-script
├── module.prop
├── customize.sh
├── post-fs-data.sh
├── service.sh
├── boot-completed.sh
├── uninstall.sh
├── sepolicy.rule
├── common/
│   ├── audio/
│   │   ├── og4k/boot_start.ogg
│   │   ├── glitch/boot_start.ogg
│   │   └── ...
│   ├── ui.sh
│   ├── root-detect.sh
│   ├── mount.sh
│   ├── config-v2.sh
│   ├── cp2077-logo.sh
│   └── fonts/
├── bootanimation/
│   ├── og4k/bootanimation.zip
│   ├── og1080p/bootanimation.zip
│   ├── glitch/bootanimation.zip
│   ├── flatline/bootanimation.zip
│   ├── netrunner/bootanimation.zip [planned]
│   ├── corpo/bootanimation.zip    [planned]
│   └── streetkid/bootanimation.zip [planned]
├── shutdownanimation/
│   ├── og4k/shutdownanimation.zip
│   ├── og1080p/shutdownanimation.zip
│   ├── glitch/shutdownanimation.zip
│   └── flatline/shutdownanimation.zip
├── rboot/
│   └── rbootanimation.zip
├── webroot/
│   ├── index.html
│   ├── style.css
│   ├── cp2077.js
│   └── assets/
│       ├── cp2077-badge.png
│       └── variants/
└── update.json
```

### NS-18 · Gist Sync Flow

```
┌──────────────────────────────────────────────────────────────┐
│  GIST SYNC FLOW                                             │
│                                                              │
│  WRIT E MODE:                                                │
│   /data/cp2077.conf  ──►  gh gist create --public/read  ──►  GIST ID
│                                  │                           │
│                                  ▼                           │
│                           /data/cp2077-gist-id             │
│                                                              │
│  READ MODE:                                                  │
│   /data/cp2077-gist-id  ──►  gh gist view  ──►  /data/cp2077.conf
│                                                              │
│  FALLBACK (no gh):                                           │
│   /data/cp2077.conf  ──►  curl to self-hosted endpoint      │
│                                                              │
│  CONFLICT RESOLUTION:                                        │
│   compare timestamps → newer wins → prompt user            │
└──────────────────────────────────────────────────────────────┘
```

### NS-19 · Thermal Guard Flow

```
cpu_temp / sys/class/thermal/thermal_zone0/temp
         │
         ▼
   ┌────────────┐
   │  < 65°C   │──► NORMAL ──► play full variant at set FPS
   └────────────┘
         │
    ┌────▼────┐
    │ 65–80°C │──► WARN ──► reduce FPS to 30, log warning
    └────────────┘
         │
    ┌────▼────┐
    │ 80–85°C │──► THROTTLE ──► switch to og1080p variant
    └────────────┘              (already mounted, just swap)
         │
    ┌────▼────┐
    │  > 85°C │──► CRITICAL ──► skip animation, 3-frame stub only
    └────────────┘              log thermal event to cp2077-crash/
```

### NS-20 · Build Variant Matrix

```
┌────────────┬────────┬───────────┬──────────┬───────────┬────────┬──────────┐
│ VARIANT    │ DESC   │ RES       │ FPS      │ FRAMES    │ AUDIO  │ ZIP SIZE │
├────────────┼────────┼───────────┼──────────┼───────────┼────────┼──────────┤
│ og4k      │ global │ 2160×4800 │ 60       │ 228       │ .ogg   │  45 MB  │
│ og1080p   │ global │ 1080×2400 │ 60       │ 228       │ .ogg   │  28 MB  │
│ glitch    │ global │ 1080×2400 │ 60       │ 228       │ .ogg   │  32 MB  │
│ flatline  │ global │ 1080×2400 │ 60       │ 228       │ .ogg   │  28 MB  │
│ netrunner │ global │ 1440×3120 │ 60       │ 180       │ .ogg   │  35 MB  │
│ corpo     │ global │ 1440×3120 │ 60       │ 180       │ .ogg   │  35 MB  │
│ streetkid │ global │ 1440×3120 │ 60       │ 180       │ .ogg   │  35 MB  │
│ rboot     │ global │ 1080×2400 │ 60       │ 15        │ none   │  12 MB  │
└────────────┴────────┴───────────┴──────────┴───────────┴────────┴──────────┘
```

---

## ══ NEW TOOLS (10) ══

| ID | Tool | P | Track |
|:---|:-----|:-:|:-----:|
| TOOL-01 | **`cp2077-boot-stats.sh`** — parse `logcat -b events` forDisplayed, compute delta from `ro.boottime.init`, run 5x, report mean + stddev | P1 | v4.0.0 |
| TOOL-02 | **`cp2077-source-audit.py`** — compare `.downloads/`, `SOURCES`, `sources.lock.json`, and ZIP contents for integrity | P2 | v4.0.0 |
| TOOL-03 | **`cp2077-rom-probe.sh`** — ADB introspection: `/system/build.prop`, `/vendor/build.prop`, `getprop`, `ls /product/media/` → YAML | P2 | v4.0.0 |
| TOOL-04 | **`cp2077-frame-inspector.py`** — terminal ANSI preview of bootanimation frames: list parts, show frame thumbs via ImageMagick | P3 | v3.1.0 |
| TOOL-05 | **`cp2077-zip-diff.py`** — compute binary diff between two release ZIPs, generate patch for OTA delta | P3 | v4.0.0 |
| TOOL-06 | **`cp2077-palette-gen.py`** — generate SVG/PNG palette strip and CSS vars from `lib/design-tokens.json` | P3 | v4.0.0 |
| TOOL-07 | **`cp2077-wallpaper-extract.py`** — extract dominant colors from wallpapers via ImageMagick, output cybrcolors-compatible JSON | P3 | v4.0.0 |
| TOOL-08 | **`cp2077-release-drafter.sh`** — auto-generate GitHub release body from `CHANGELOG-*.md` filtered by commit range | P3 | v4.0.0 |
| TOOL-09 | **`cp2077-lint-module.sh`** — offline module lint: check required files, executable bits, CRLF, module.prop schema, META-INF completeness | P2 | v4.0.0 |
| TOOL-10 | **`cp2077-ota-check.sh`** — check update JSON URL, compare versionCode, download + verify checksum, report if update available | P2 | v4.0.0 |

---

## ══ EXECUTION BACKLOG ══

### P0 Hardening ✓
- [x] `detect_root_manager()` → `lib/root-detect.sh`
- [x] `mount_with_fallback()` → `lib/mount.sh`
- [x] `ansi()` + `cp2077_logo()` → `lib/ui.sh`
- [x] Fixed sleeps → `wait_for_prop()`
- [x] `module.prop` `updateJson` validation in CI
- [x] Boot-time mount verification + retry logging
- [x] Atomic `/data/cp2077.conf` write helper
- [x] Config schema validation
- [x] `python3 -m zipfile -t` CI gate

### P1 Feature Parity ✓
- [x] `cp2077-config.sh` arrow-key TUI
- [x] Boot-counter A/B rotation
- [x] Audio ducking/fade-out
- [x] RAM-staged animation mount
- [x] `cp2077-health-dashboard.sh` ANSI TUI
- [x] `cp2077-version-bumper.py`
- [x] GitHub Actions artifact retention
- [x] Parallel variant packaging
- [x] `cp2077-frame-inspector.py`
- [x] `cp2077-archive-audit.py`

### P2 Build/QA/Tooling
- [ ] `shellcheck` pre-commit hook
- [ ] `cp2077-ci-local.sh`
- [ ] Parallel hash in `generate-manifests.sh`
- [ ] Per-variant audio tone table
- [ ] `cp2077-zip-diff.py`
- [ ] `cp2077-palette-gen.py`
- [ ] `cp2077-wallpaper-extract.py`
- [ ] `build-universal.py --res-matrix`
- [ ] `cp2077-module-lint.py`

### P3 Device Expansion
- [ ] Universal v2
- [ ] KernelSU-native track
- [ ] APatch-native pass
- [ ] AnyKernel3 package
- [ ] TWRP direct-write installer
- [ ] Pixel 8/9 port
- [ ] Samsung One UI validation
- [ ] MIUI/HyperOS validation
- [ ] Resolution auto-scaling
- [ ] Dynamic FPS selection

---

## ══ RELEASE MATRIX ══

```
┌──────────────────────────┬──────┬─────────┬──────┬──────────────┐
│ Module                   │ Ver  │ Status  │ Code │ Notes        │
├──────────────────────────┼──────┼─────────┼──────┼──────────────┤
│ CP2077_OP7Pro_Full       │ v3.0.0│ 🟢 LIVE │300000│ GM1911 active│
│ CP2077_Universal         │ v1.0.0│ 🟡 BUILT│100000│ 14 ROM fams  │
│ CP2077_OP7Pro_Ultimate  │ v3.0.0│ ⚪ DIS  │300000│ megapack ref │
└──────────────────────────┴──────┴─────────┴──────┴──────────────┘
Path: 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/
```

---

## ══ BUG REGISTER ══

| ID | Sev | Issue | Fix |
|:---|:---|:-----|:---|
| BUG-01 | H | og4k directory empty | Upscaled og1080p via Pillow LANCZOS |
| BUG-02 | M | Full module lacked og1080p shutdown | Added `shutdownanimation/og1080p/` |
| BUG-03 | M | Universal release empty, OTA 404 | Built `CP2077-Universal-v1.0.0.zip` |
| BUG-04 | L | update.json non-existent path | Fixed root `releases/update-*.json` |
| BUG-05 | L | Legacy v1.0 repo undocumented | Added to manifests and docs |
| BUG-06 | L | Broken SVG symlinks in icon theme | Removed dangling symlinks |
| BUG-07 | M | og4k no matching shutdown | Added `shutdownanimation/og4k/` |
| BUG-08 | L | rboot coverage unverified | Verified on LOS 23.2 |

---

## ══ IMPLEMENTATION TRACKS ══

### CI/CD
- [ ] Parallel build matrix
- [ ] ZIP integrity gate
- [ ] Shell/Module lint jobs
- [ ] KernelSU `module.json` validation
- [ ] Reproducible build (SHA-256 compare twice)
- [ ] `gh release create` automation

### Automation
- [ ] Upstream sync checker
- [ ] One-command release tagging
- [ ] Hotfix delta generator
- [ ] Device compat matrix generator
- [ ] Workspace audit script
- [ ] README regeneration from build constants

### Developer Experience
- [ ] VS Code tasks (build, lint, frame inspect, single-variant)
- [ ] Docker/Arch build container
- [ ] `shfmt` + Python linter integration
- [ ] `.editorconfig` workspace standard
- [ ] Device debug shell bundle

---

## ══ GITHUB RESEARCH — REPO OPERATIONS ══

| ID | P | Repos | Task |
|:--|:-:|:----:|:-----|
| GH-OPS-001 | P1 | 53 | Generate `repo-registry.json` from `git-repositories.txt` |
| GH-OPS-002 | P1 | all | `scripts/check-github-remotes.sh` HTTP 200/301 + branch check |
| GH-OPS-003 | P1 | CP2077 | Release workflow inputs: version, variants, audio, retention, draft |
| GH-OPS-004 | P1 | releases/ | SLSA provenance for every release ZIP |
| GH-OPS-005 | P1 | root | OpenSSF Scorecard weekly + SARIF publish |
| GH-OPS-006 | P1 | shell/py/web | CodeQL + SARIF for ShellCheck + Python |
| GH-OPS-007 | P1 | all workflows | Pin actions by SHA + upgrade cadence doc |
| GH-OPS-008 | P1 | 99-MANIFESTS/ | Manifest freshness badge CI job |
| GH-OPS-009 | P2 | all nested | `WHY-CLONED.md` per clone |
| GH-OPS-010 | P2 | all nested | `repo-health.md` (dirty, commit date, ahead/behind) |
| GH-OPS-011 | P2 | MMRL | MMRL metadata generation with screenshots |
| GH-OPS-012 | P2 | releases/ | Changelog generator (feat/fix/docs/build/security/compat) |
| GH-OPS-013 | P3 | all artifacts | Enforce upload-artifact retention by type |
| GH-OPS-014 | P3 | root | GitHub issue templates |
| GH-OPS-015 | P3 | root | PR templates |
| GH-OPS-016 | P3 | git-repositories.txt | Category-level ownership |
| GH-OPS-017 | P3 | ref repos | Stale-reference dashboard |
| GH-OPS-018 | P3 | README/ROADMAP | Auto-gen repo count + size badges |
| GH-OPS-019 | P3 | root | GitHub discussions plan |
| GH-OPS-020 | P4 | root | `.github/FUNDING.yml` |

---

## ══ KERNEL DEVELOPMENT ══

**Device:** OnePlus 7 Pro `GM1911` / `guacamole` · SM8150 (SD 855)

| Kernel | Path | Status | Purpose |
|:------|:-----|:------|:--------|
| `neptune-kernel-sm8150` | `kernel/` | Staged | Primary custom kernel target |
| `blu-spark-kernel-op7` | `kernel/` | Reference | Patch source |
| `kernelsu-lineageos-guacamole` | `kernel/` | Planned | KernelSU LOS 23.2 |
| `oneplus-7-pro-lineage-kernel-sm8150` | `kernel/` | Reference | LOS source ref |
| `magisk_patched-30700_rLeMH.img` | `kernel/` | Active | Current on-device |
| `boot.img` | `kernel/` | Backup | Stock before patching |
| `kali-nethunter-kernel-builder` | `kernel/` | Pending | NetHunter toolchain |

**Tasks:**
- [ ] Audit boot timing (Neptune vs stock) via `simpleperf`
- [ ] Build `kernelsu-lineageos-guacamole` + verify CP2077 parity
- [ ] `boot.img` SHA-256 → boot image registry
- [ ] Cherry-pick EAS + TCP BBR from blu-spark → Neptune
- [ ] NetHunter kernel builder timing test
- [ ] Rename + version boot image
- [ ] CP2077 install test under KernelSU

---

## ══ NETHUNTER + SECURITY ══

| Item | Status | Notes |
|:-----|:------|:------|
| NetHunter kernel (guacamole) | Staged | `kali-nethunter-kernel-builder` |
| `hightech-kali-nethunter-suite` | Research | Uncatalogued |
| `security-repos/` | Research | Uncatalogued |
| `netrunner-nh` variant | Planned | Kali visual language |

**Tasks:**
- [ ] Verify CP2077 mount under NetHunter kernel
- [ ] Design `netrunner-nh` variant
- [ ] Catalogue `hightech-kali-nethunter-suite`
- [ ] Dual-slot setup research
- [ ] Audit `security-repos/`

---

## ══ PERFORMANCE + BENCHMARKING ══

| Benchmark | Target | Status |
|:----------|:-------|:------|
| Cold boot baseline (no module) | TBD | ⏳ |
| Cold boot glitch +2.0s | < +2.0s | ⏳ |
| Cold boot og4k +2.5s | < +2.5s | ⏳ |
| `post-fs-data.sh` execution | < 800ms | ⏳ |
| `service.sh` first-pass overhead | 5s + < 200ms | ⏳ |
| Variant hot-swap | < 3s | ⏳ |
| Frame-drop rate | < 2/boot | ⏳ |
| Battery drain vs baseline | < +0.5% | ⏳ |

---

## ══ COMMUNITY + DISTRIBUTION ══

| Channel | Status | Action |
|:--------|:------|:-------|
| GitHub Releases | 🟢 Active | Automate via `gh release create` |
| XDA Developers | ⏸ Pending | Post OP7 Pro forum thread |
| Magisk Modules Alt Repo | ⏸ Pending | Submit `module.json` PR |
| MMRL listing | ⏸ Pending | Add `mmrl.json` |
| Telegram | 📋 Planned | v4.0.0 channel |
| Kali NetHunter forums | 📋 Planned | `netrunner-nh` post |

---

## ══ WORKSPACE MAINTENANCE ══

| Task | Frequency | Command |
|:-----|:----------|:--------|
| Manifests | Post-release | `bash 99-MANIFESTS/generate-manifests.sh` |
| Repo sync | Weekly | `bash scripts/check-repos.sh` |
| Symlinks | Weekly | `find 02-PRODUCTION -type l ! -exec test -e {} \; -print` |
| Quarantine | Monthly | `file 10-QUARANTINE-invalid-downloads/**/*` |
| Size | Monthly | `du -sh /home/arch/cyberpunk-2077` |

---

## ══ SPLASH + SYSTEM UI THEMING ══

| Asset | Path | Status |
|:------|:-----|:-------|
| Module thumbnail | `splash/module-thumbnail.png` | ✅ 512×512 PNG |
| About page | `splash/about/` | ✅ Present |
| Boot splash | `splash/boot/` | ✅ Present |
| Splash pack | `06-UI-THEMES-ANIMATIONS/themes/CP2077-splash-assets/` | 📋 Audit needed |

---

## ══ DEVICE TEST LAB ══

**Device:** OP7 Pro GM1911 · LOS 23.2 · Android 16 · Magisk v30.7

| Test | glitch | flatline | reboot | og1080p | og4k |
|:-----|:------:|:--------:|:------:|:--------:|:----:|
| Boot anim plays | ✅ | ✅ | ✅ | ✅ | ✅ |
| Shutdown plays | ✅ | ✅ | ✅ | ✅ | ✅ |
| rboot mounted | ✅ | ✅ | ✅ | ✅ | ✅ |
| Audio on boot | ✅ | ✅ | ✅ | ✅ | ✅ |
| Variant switch | ✅ | ✅ | ✅ | ✅ | ✅ |
| Uninstall clean | ✅ | — | — | — | — |
| service.sh remount | ✅ | — | — | — | — |
| WebUI (LOS 23.2) | ⏳ | — | — | — | — |
| KernelSU install | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |
| APatch install | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ |

---

## ══ APK + NATIVE ANDROID ══

**Path:** `04-ANDROID/` · Target: Android 16 · API 36 · `arm64-v8a`

| Path | Contents | Status |
|:-----|:---------|:-------|
| `apk/livewallpaper-invalid-source-files/` | HTML fakes | 🚫 quarantine |
| `arm64/` | Native binaries | 📋 Inventory needed |
| `device/sdcard-Download/` | Staged files | Working |
| `android-tools` | ADB/fastboot | In use |

---

## ══ REPO AUDIT FINDINGS ══

> Audited 30+ cloned repositories across 6 categories. Best-of-breed picks.

### Module + Root Ecosystem

| Source | Pattern | Use It For |
|:-------|:--------|:----------|
| Magisk | `util_functions.sh` + `customize.sh` `SKIPUNZIP=1` | Installer pattern |
| Magisk | `post-fs-data.sh` → `service.sh` → `boot-completed.sh` | Boot lifecycle |
| Magisk | `module.prop` strict `^[a-zA-Z][a-zA-Z0-9._-]+$` | ID enforcement |
| KernelSU | Binary config magic header `0x4B53554D` + atomic rename | Config persistence |
| KernelSU | `js/index.js` API: `exec()`, `toast()`, `moduleInfo()` | WebUI bridge |
| KernelSU | `ksud` CLI subcommands + `--help` | CLI design |
| APatch | `overlayfs` via `setfattr` | Alt mount strategy |
| MMRL | `MMRLWebUIInterface` + `runTry()` | WebUI error safety |
| MMRL | `PREFER_MODULE` / `WX` / `KSU` engine selection | WebUI routing |
| zygisk-module-sample | `REGISTER_ZYGISK_MODULE()` + `Api` methods | Zygisk |

### Bootanimation Reference

| Source | Pattern | Use It For |
|:-------|:--------|:----------|
| ONEPLUS9-OOS13 | `g 1080 2400 0 0 60` global desc.txt | desc.txt standard |
| ONEPLUS9-OOS13 | Nested `bootanimation.zip` + `rbootanimation.zip` | Module packaging |
| POCO-Magisk | 5-path detection + size verification | Robust mount |
| POCO-Magisk | Multilingual `customize.sh` (EN/RU/ES/FR/PT/ZH) | i18n |
| AndroidCyberpankIcons | 330-frame `AnimationDrawable` 40ms/frame | Lock screen charging |

### Linux Theming

| Source | Pattern | Use It For |
|:-------|:--------|:----------|
| cybrcolors | 11-color × 3-tier HSL palette | CP2077 palette base |
| hyprdots | `wallbash.sh` ImageMagick wallpaper extraction | Dynamic theming |
| hyprdots | `themepatcher.sh` + backup/restore | Theme installation |
| mechabar | `@define-color` CSS semantic layers | Waybar CSS |
| adi1090x/widgets | `defpoll` + `defwidget` EWW dashboard | Widget system |
| adi1090x/rofi | 7 launcher types + 15 color schemes | Rofi theming |
| proxzima-plymouth | `Plymouth.SetRefreshFunction()` frame loop | Plymouth scripts |
| Cyberpunk-Neon | Waybar Nerd Font arrow separators | Waybar layout |
| K-DE-Cyberpunk-Neon | Full KDE Plasma: color + GTK + Qt + SDDM | KDE desktop |
| catppuccin | 4-flavor × 26-color palette, 100+ ports | Universal theme |

### Kernel + Device

| Source | Pattern | Use It For |
|:-------|:--------|:----------|
| AnyKernel3 | `ak3-core.sh` `dump_boot()`/`flash_boot()` | Kernel packaging |
| neptune-kernel | Git-based naming `$(git rev-parse HEAD)` | Version tracking |
| AnyKernel3 | 7z mx9 + zipalign -v4 | ZIP compression |
| blu-spark | F2FS extension list optimization | Storage perf |
| lineage-device-guacamole | A/B partition layout | Seamless updates |
| lineage-device-sm8150-common | Split `private/public/vendor` sepolicy | SELinux modularity |

### Top 10 Adoptions

| # | From | Adopt | Why |
|:-:|:-----|:------|:----|
| 1 | KernelSU | `lib/root-runtime.sh` root abstraction | Root neutrality |
| 2 | Magisk | `util_functions.sh` pattern | Installer quality |
| 3 | hyprdots | `wallbash.sh` wallpaper color extraction | Desktop theming |
| 4 | POCO | 5-path bootanimation detection + size verify | Mount robustness |
| 5 | KernelSU | Binary config with magic header | Config safety |
| 6 | AnyKernel3 | `ak3-core.sh` | Kernel packaging |
| 7 | mechabar | CSS semantic layers for Waybar | Desktop CSS |
| 8 | cybrcolors | 3-tier HSL shading | Color depth |
| 9 | proxzima-plymouth | `Plymouth.SetRefreshFunction()` | Plymouth boot |
| 10 | APatch | `overlayfs` via `setfattr` | Alt mount |

### Audit Action Items

| ID | Task | P | Source |
|:---|:-----|:-:|:-------|
| AUDIT-01 | Port KernelSU `js/index.js` bridge → `webroot/` JavaScript | P1 | KernelSU |
| AUDIT-02 | Add `wallbash.sh` to `05-LINUX/` | P2 | hyprdots |
| AUDIT-03 | Build full Plymouth theme | P2 | proxzima-plymouth |
| AUDIT-04 | Add EWW dashboard widgets | P3 | adi1090x/widgets |
| AUDIT-05 | 5-path mount detection in `service.sh` | P1 | POCO |
| AUDIT-06 | Multilingual support in `customize.sh` | P2 | POCO |
| AUDIT-07 | Port cybrcolors 3-tier palette → `lib/design-tokens.json` | P1 | cybrcolors |
| AUDIT-08 | `lib/ansi-colors.sh` matching cybrcolors | P1 | cybrcolors |
| AUDIT-09 | F2FS extension optimization in `service.sh` | P3 | blu-spark |
| AUDIT-10 | Binary config magic header `0x435032303737` | P1 | KernelSU |

---

## ══ TASKS (100) ══

### T-Build · 1–15

| ID | Task | P | Track |
|:---|:-----|:-:|:-----:|
| T-01 | Add `--check-sources` HEAD-check gate before downloading ZIPs | P1 | v4.0.0 |
| T-02 | Add source URL HTTP 200/301 validation | P1 | v4.0.0 |
| T-03 | Implement `sources.lock.json` schema | P1 | v4.0.0 |
| T-04 | Add `cp2077-source-lock-validator.py` CI gate | P1 | v4.0.0 |
| T-05 | Enforce reproducible ZIP metadata | P1 | v4.0.0 |
| T-06 | Parallel variant packaging with `concurrent.futures` | P2 | v4.0.0 |
| T-07 | `build-universal.py --res-matrix` 720/1080/1440/4K | P2 | v4.0.0 |
| T-08 | Max artifact size 350 MB warning at 90% | P2 | v4.0.0 |
| T-09 | Build matrix JSON (variant/audio/SHA/size/elapsed) | P2 | v4.0.0 |
| T-10 | Cache integrity manifest for `.downloads/` | P2 | v4.0.0 |
| T-11 | `zipfile -t` CI gate for every release artifact | P1 | v4.0.0 |
| T-12 | `python3 build.py --dry-run` | P3 | v3.1.0 |
| T-13 | LANCZOS scaling in `build-universal.py` | P1 | v4.0.0 |
| T-14 | Validate desc.txt `g W H` or `W H fps` in CI | P2 | v4.0.0 |
| T-15 | Normalized timestamp `1980-01-01` for stable SHA-256 | P1 | v4.0.0 |

### T-CI · 16–30

| ID | Task | P |
|:---|:-----|:-|
| T-16 | Create `.github/workflows/ci.yml` lint→build→test→release | P1 |
| T-17 | `shellcheck` job for all `*.sh` | P1 |
| T-18 | `ruff check` Python lint job | P2 |
| T-19 | CodeQL + SARIF for ShellCheck + Python | P1 |
| T-20 | `shellcheck` pre-commit via `.husky/` | P2 |
| T-21 | `shfmt` pass in pre-commit hook | P3 |
| T-22 | Pin Actions by SHA + upgrade cadence doc | P1 |
| T-23 | Manifest freshness badge CI job | P1 |
| T-24 | OpenSSF Scorecard weekly + SARIF | P1 |
| T-25 | Artifact retention: 7d CI / 30d RC / 90d stable | P2 |
| T-26 | Reproducible build gate: SHA-256 compare twice | P1 |
| T-27 | `gh release create --draft` CI automation | P1 |
| T-28 | SLSA provenance via `slsa-github-generator` | P1 |
| T-29 | `cp2077-ci-local.sh` for `act` | P3 |
| T-30 | Nightly dry-run with `--check-sources` | P3 |

### T-Module · 31–45

| ID | Task | P |
|:---|:-----|:-|
| T-31 | `lib/config-v2.sh` atomic read/write + schema | P1 |
| T-32 | `lib/root-runtime.sh` root abstraction layer | P1 |
| T-33 | KernelSU `module.json` CI validation | P1 |
| T-34 | APatch install test flow + `apd` docs | P1 |
| T-35 | Root smoke test: install/status/remount/WebUI/disable/uninstall | P1 |
| T-36 | `update.json` JSON Schema CI validator | P1 |
| T-37 | `module-lint` check: files/perms/CRLF/META-INF | P2 |
| T-38 | `ASH_STANDALONE=1` compatibility testing | P2 |
| T-39 | MMRL metadata: icon + screenshots + categories | P1 |
| T-40 | `cp2077-root-smoke.sh` Magisk/KSU/APatch/MMRL | P1 |
| T-41 | WebUI bridge adapter: MMRL/KSU/APatch/mock | P1 |
| T-42 | `cp2077-webui-test.html` + Playwright smoke | P2 |
| T-43 | `cp2077-health-dashboard.sh` ANSI TUI | P2 |
| T-44 | `cp2077-version-bumper.py` atomic release bump | P2 |
| T-45 | `cp2077-debug.sh` logcat + mount table + config bundle | P1 |

### T-Variants · 46–55

| ID | Task | P |
|:---|:-----|:-|
| T-46 | `netrunner`: cyan, 1440×3120, 60 fps | P1 |
| T-47 | `corpo`: gold/silver, 1440×3120, 60 fps | P1 |
| T-48 | `streetkid`: orange/red, 1440×3120, 60 fps | P1 |
| T-49 | Boot intro length tuning -1s+ | P2 |
| T-50 | Audio ducking/fade-out via FFmpeg envelope | P2 |
| T-51 | RAM-staged mount via tmpfs (>8 GB RAM) | P2 |
| T-52 | Per-variant audio tone table | P3 |
| T-53 | Variant A/B rotation scheduler | P2 |
| T-54 | `cp2077-frame-inspector.py` terminal preview | P3 |
| T-55 | `cp2077-archive-audit.py` workspace ZIP scanner | P3 |

### T-Device · 56–65

| ID | Task | P |
|:---|:-----|:-|
| T-56 | LOS 23.2 mount path audit (HP-01) | P0 |
| T-57 | Android 16 boot timing trace (HP-02) | P0 |
| T-58 | `avc` denial → `sepolicy.rule` (HP-03) | P0 |
| T-59 | Audio path `/product/media/audio/ui/` (HP-04) | P0 |
| T-60 | WebUI 5-bridge on Android 16 (HP-05) | P0 |
| T-61 | 5 MB remount threshold LOS 23.2 (HP-07) | P0 |
| T-62 | `cp2077-rom-probe.sh` device interrogation | P2 |
| T-63 | `devices/*.yaml` ROM profile registry | P1 |
| T-64 | `cp2077-device-profile-gen.sh` → YAML | P2 |
| T-65 | Multi-slot A/B support | P2 |

### T-Desktop · 66–75

| ID | Task | P |
|:---|:-----|:-|
| T-66 | Merge `cybrland` + `cyber-hyprland-theme` | P2 |
| T-67 | Terminal palette: Kitty + Alacritty + WezTerm | P2 |
| T-68 | Recolor Papirus assets `#FCEE0C` | P3 |
| T-69 | `cp2077-hud-toggle.sh` Waybar/eww | P2 |
| T-70 | Waybar HUD: CPU/RAM/net/battery | P2 |
| T-71 | Plymouth theme activation docs | P2 |
| T-72 | `hyprlock` CP2077 lock-screen | P3 |
| T-73 | `cp2077-hyprland/` layered config | P2 |
| T-74 | CP2077 Rofi: launcher + power + screenshot + variant | P2 |
| T-75 | `cp2077-plymouth-preview.sh` | P3 |

### T-Release · 76–85

| ID | Task | P |
|:---|:-----|:-|
| T-76 | SLSA provenance per release ZIP | P1 |
| T-77 | `cp2077-release-verify.py` checksum + provenance + update.json | P1 |
| T-78 | Changelog generator feat/fix/docs/build/security/compat | P2 |
| T-79 | Detached signature/checksum bundle for stable ZIPs | P2 |
| T-80 | Release quality gate workflow | P1 |
| T-81 | GitHub issue templates | P3 |
| T-82 | PR templates | P3 |
| T-83 | Download stats → `releases/download-stats.json` | P3 |
| T-84 | OTA delta update via binary diff patches | P2 |
| T-85 | Module soft disable/enable scripts | P3 |

### T-Workspace · 86–95

| ID | Task | P |
|:---|:-----|:-|
| T-86 | `generate-manifests.sh` as final `build.py` step | P1 |
| T-87 | Broken-symlink detection in workspace audit | P2 |
| T-88 | CI quarantine file-type assertion | P2 |
| T-89 | `cp2077-workspace-audit.sh` weekly cron | P1 |
| T-90 | `repo-registry.json` from `git-repositories.txt` | P1 |
| T-91 | `WHY-CLONED.md` per clone | P2 |
| T-92 | `repo-health.md` per cloned repo | P3 |
| T-93 | `cp2077-repo-score.py` scoring all 53 repos | P2 |
| T-94 | Workspace size → `workspace-size-history.txt` | P3 |
| T-95 | `cp2077-research-map.py` linking tasks → repos | P3 |

### T-Misc · 96–100

| ID | Task | P |
|:---|:-----|:-|
| T-96 | Extended audio pack: Notification/VideoRecord/Screenshot/LowBattery | P2 |
| T-97 | Loudness normalization -18 LUFS | P3 |
| T-98 | `cp2077-palette-gen.py` design token assets | P3 |
| T-99 | `cp2077-zip-diff.py` hotfix patch verifier | P3 |
| T-100 | Dependency update reminders Python + Actions | P3 |

---

## ══ PHASED ROADMAP — 10 PHASES, 100+ TASKS ══

### Phase Overview

```
Phase      Focus                      Tasks   P0   P1   P2   P3
────────  ──────────────────────────  ─────   ──   ──   ──   ──
 1 ██████ v3.1.0 Hardening          16      8    8    —    —
 2 ░░░░░░ v4.0.0 CI Foundations     20      —   10    6    4
 3 ░░░░░░ v4.0.0 Universal v2       15      —    6    5    4
 4 ░░░░░░ v4.0.0 Root Managers      12      —    8    3    1
 5 ░░░░░░ v4.0.0 Desktop Theme      10      —    —    7    3
 6 ░░░░░░ v5.0.0 Live Wallpaper      8      —    —    5    3
 7 ░░░░░░ v5.0.0 Multi-Device       10      —    4    5    1
 8 ░░░░░░ v5.0.0 OTA + Distribution   8      —    —    6    2
 9 ░░░░░░ v6.0.0 Port Wizard          5      —    —    4    1
10 ░░░░░░ v6.0.0 Ecosystem           4      —    —    1    3
                                             8   36   42   22
```

### Phase 1 — v3.1.0 Hardening 🟢 Active

| ID | Task | P | Status |
|:---|:-----|:-|:------:|
| PH1-01 | LOS 23.2 mount path audit | P0 | 🔴 |
| PH1-02 | Android 16 boot timing trace | P0 | 🔴 |
| PH1-03 | SELinux `avc` denial → `sepolicy.rule` | P0 | 🔴 |
| PH1-04 | Audio path verification LOS 23.2 | P0 | 🔴 |
| PH1-05 | Magisk WebUI 5-bridge verification | P0 | 🔴 |
| PH1-06 | KernelSU `module.json` parity | P0 | 🔴 |
| PH1-07 | 5 MB remount threshold re-validation | P0 | 🔴 |
| PH1-08 | Device docs refresh `DEVICE-SPECS.md` | P0 | 🔴 |
| PH1-09 | `lib/config-v2.sh` atomic + schema | P1 | 🟡 |
| PH1-10 | `cp2077-workspace-audit.sh` weekly | P1 | 🟡 |
| PH1-11 | Manifest gen in `build.py` final step | P1 | 🟡 |
| PH1-12 | `cp2077-debug.sh` logcat bundle | P1 | 🟡 |
| PH1-13 | `cp2077-health-dashboard.sh` ANSI TUI | P2 | 🟡 |
| PH1-14 | `cp2077-version-bumper.py` atomic bump | P2 | 🟡 |
| PH1-15 | Terminal color palette Kit/Ala/Wez | P1 | 🟡 |
| PH1-16 | Broken-symlink detection in audit | P1 | 🟡 |

### Phase 2 — v4.0.0 CI Foundations

| ID | Task | P |
|:---|:-----|:-|
| PH2-01 | CI pipeline `.github/workflows/ci.yml` | P1 |
| PH2-02 | `shellcheck` + `shfmt` pre-commit | P2 |
| PH2-03 | CodeQL + SARIF upload | P1 |
| PH2-04 | Reproducible build SHA-256 gate | P1 |
| PH2-05 | `sources.lock.json` + validator | P1 |
| PH2-06 | `update.json` JSON Schema validator | P1 |
| PH2-07 | SLSA provenance generator | P1 |
| PH2-08 | OpenSSF Scorecard weekly | P1 |
| PH2-09 | Manifest freshness badge | P1 |
| PH2-10 | Actions pin-by-SHA + upgrade doc | P1 |
| PH2-11 | `module-lint` check | P2 |
| PH2-12 | Artifact retention policy | P2 |
| PH2-13 | `cp2077-ci-local.sh` `act` wrapper | P3 |
| PH2-14 | Nightly dry-run build | P3 |
| PH2-15 | Dependency update reminders | P3 |
| PH2-16 | Build matrix JSON output | P2 |
| PH2-17 | `zipfile -t` CI gate | P1 |
| PH2-18 | `gh release create --draft` automation | P1 |
| PH2-19 | `cp2077-release-verify.py` | P1 |
| PH2-20 | `sources.lock.json` embedded in ZIP | P1 |

### Phase 3 — v4.0.0 Universal v2

| ID | Task | P |
|:---|:-----|:-|
| PH3-01 | MIUI/HyperOS path matrix validation | P1 |
| PH3-02 | Samsung One UI validation | P1 |
| PH3-03 | `build-universal.py --res-matrix` | P1 |
| PH3-04 | `devices/*.yaml` ROM profile registry | P1 |
| PH3-05 | `cp2077-device-profile-gen.sh` → YAML | P2 |
| PH3-06 | Dynamic density/FPS at install time | P2 |
| PH3-07 | Resolution auto-scaling LANCZOS | P2 |
| PH3-08 | 5-path detection + size verification | P1 |
| PH3-09 | Per-device profile archive | P2 |
| PH3-10 | ROM detection 14 → 20+ families | P1 |
| PH3-11 | `device-profile.schema.yaml` | P1 |
| PH3-12 | `cp2077-rom-probe.sh` | P2 |
| PH3-13 | Extended audio pack v2 | P2 |
| PH3-14 | Loudness normalization -18 LUFS | P3 |
| PH3-15 | Variant-specific audio tone palettes | P3 |

### Phase 4 — v4.0.0 Root Managers

| ID | Task | P |
|:---|:-----|:-|
| PH4-01 | `lib/root-runtime.sh` | P1 |
| PH4-02 | KernelSU `module.json` CI validation | P1 |
| PH4-03 | APatch install test flow + docs | P1 |
| PH4-04 | `cp2077-root-smoke.sh` | P1 |
| PH4-05 | KernelSU `js/index.js` → `webroot/` | P1 |
| PH4-06 | MMRL `MMRLWebUIInterface` + `runTry()` | P1 |
| PH4-07 | WebUI bridge adapter | P1 |
| PH4-08 | Playwright `tests/webui.spec.ts` | P2 |
| PH4-09 | `cp2077-webui-test.html` smoke | P2 |
| PH4-10 | Binary config `0x435032303737` | P1 |
| PH4-11 | `ASH_STANDALONE=1` testing | P2 |
| PH4-12 | Root smoke test per release | P1 |

### Phase 5 — v4.0.0 Desktop Theme

| ID | Task | P |
|:---|:-----|:-|
| PH5-01 | Merge `cybrland` + `cyber-hyprland-theme` | P2 |
| PH5-02 | Layered `cp2077-hyprland/` config | P2 |
| PH5-03 | Waybar HUD: CPU/RAM/net/battery | P2 |
| PH5-04 | `cp2077-hud-toggle.sh` | P2 |
| PH5-05 | Full Plymouth theme | P2 |
| PH5-06 | CP2077 Rofi variants | P2 |
| PH5-07 | `cp2077-plymouth-preview.sh` | P3 |
| PH5-08 | `hyprlock` lock-screen theme | P3 |
| PH5-09 | `wallbash.sh` dynamic colors | P3 |
| PH5-10 | Recolor Papirus `#FCEE0C` | P3 |

### Phase 6 — v5.0.0 Live Wallpaper

| ID | Task | P |
|:---|:-----|:-|
| PH6-01 | `livewallpaper-design-spec.md` Kotlin+GL ES 3.0 | P2 |
| PH6-02 | Android Studio scaffold `CP2077-LiveWallpaper/` | P2 |
| PH6-03 | Rain/glitch GLSL shader 5 fps screen-off | P2 |
| PH6-04 | Battery-aware renderer | P3 |
| PH6-05 | `arm64-v8a` only, `minSdk 26`, `targetSdk 36` | P2 |
| PH6-06 | F-Droid wallpaper research + `SOURCES.md` | P3 |
| PH6-07 | Icon pack APK via `aapt2` | P3 |
| PH6-08 | Magisk Manager UI overlay feasibility | P3 |

### Phase 7 — v5.0.0 Multi-Device

| ID | Task | P |
|:---|:-----|:-|
| PH7-01 | Nothing Phone glyph sync | P2 |
| PH7-02 | Pixel 8/9 dedicated port | P2 |
| PH7-03 | Fold/flip layout variants | P2 |
| PH7-04 | Tablet variant 1920×1200 / 2560×1600 | P3 |
| PH7-05 | Multi-slot A/B support | P2 |
| PH7-06 | `netrunner-nh` NetHunter variant | P2 |
| PH7-07 | AnyKernel3 prototype + rollback docs | P2 |
| PH7-08 | TWRP direct-write installer test plan | P3 |
| PH7-09 | Device compatibility matrix generator | P2 |
| PH7-10 | `cp2077-device-profile-gen.sh` ADB → YAML | P2 |

### Phase 8 — v5.0.0 OTA + Distribution

| ID | Task | P |
|:---|:-----|:-|
| PH8-01 | OTA delta update via binary diff | P2 |
| PH8-02 | Module repository via MMRL | P2 |
| PH8-03 | On-device update notification | P3 |
| PH8-04 | XDA Developers forum thread | P2 |
| PH8-05 | Magisk Modules Alt Repo PR | P2 |
| PH8-06 | MMRL `mmrl.json` submission | P2 |
| PH8-07 | Download stats → `download-stats.json` | P3 |
| PH8-08 | Signed release + detached checksum | P2 |

### Phase 9 — v6.0.0 Port Wizard

| ID | Task | P |
|:---|:-----|:-|
| PH9-01 | `cp2077-port-wizard.sh` → `device-profile.yaml` | P2 |
| PH9-02 | `cp2077-device-profile-gen.sh` ADB → YAML | P2 |
| PH9-03 | Boot path auto-detection `adb shell getprop` | P2 |
| PH9-04 | SELinux policy auto-generation | P3 |
| PH9-05 | Automated `module.prop` + `update.json` | P3 |

### Phase 10 — v6.0.0 Ecosystem

| ID | Task | P |
|:---|:-----|:-|
| PH10-01 | `cp2077-repo-score.py` all repos | P2 |
| PH10-02 | `cp2077-research-map.py` tasks → repos | P3 |
| PH10-03 | `RESEARCH-SOURCES.md` per repo | P3 |
| PH10-04 | Quarterly root-ecosystem sync | P3 |

### Phase Task Summary

| Phase | P0 | P1 | P2 | P3 | Total |
|:-----:|:--:|:--:|:--:|:--:|:-----:|
| 1 v3.1.0 | 8 | 8 | 0 | 0 | **16** |
| 2 CI | 0 | 10 | 6 | 4 | **20** |
| 3 Universal v2 | 0 | 6 | 5 | 4 | **15** |
| 4 Root Managers | 0 | 8 | 3 | 1 | **12** |
| 5 Desktop | 0 | 0 | 7 | 3 | **10** |
| 6 Wallpaper | 0 | 0 | 5 | 3 | **8** |
| 7 Multi-Device | 0 | 4 | 5 | 1 | **10** |
| 8 OTA | 0 | 0 | 6 | 2 | **8** |
| 9 Port Wizard | 0 | 0 | 4 | 1 | **5** |
| 10 Ecosystem | 0 | 0 | 1 | 3 | **4** |
| **Total** | **8** | **36** | **42** | **22** | **108** |

### Top 10 Critical Path

| Rank | Task | Phase |
|:----:|:-----|:-----:|
| 1 | LOS 23.2 mount path audit | PH1-01 |
| 2 | Android 16 boot timing trace | PH1-02 |
| 3 | CI pipeline `.github/workflows/ci.yml` | PH2-01 |
| 4 | `lib/root-runtime.sh` root abstraction | PH4-01 |
| 5 | `sources.lock.json` + validator | PH2-05 |
| 6 | `lib/config-v2.sh` atomic config | PH1-09 |
| 7 | 5-path mount + size verification | PH3-08 |
| 8 | KernelSU `module.json` parity | PH1-06 |
| 9 | `cp2077-root-smoke.sh` smoke tests | PH4-04 |
| 10 | MMRL WebUI bridge adapter | PH4-06 |

---

## ══ DEVICE EXPANSION TARGETS ══

```
╔═══════════════════════════════════════════════════════════════════════╗
║  CURRENT                           PLANNED (v5.0.0)                   ║
║  ───────                           ────────────────                    ║
║  OnePlus 7 Pro GM1911 (primary)    OnePlus 12 (ColorOS 14)             ║
║  Universal (14 ROM families)       Pixel 8 / Pixel 9                   ║
║                                    Nothing Phone 2 (glyph sync)        ║
║                                    Samsung Galaxy S24 (One UI 7)       ║
║                                    Xiaomi 14 (HyperOS 2)               ║
║                                    Fold / tablet displays              ║
╚═══════════════════════════════════════════════════════════════════════╝
```

| Device | Resolution | ROM | Root | Priority | Track |
|:-------|:----------:|:----|:----:|:--------:|:-----:|
| OnePlus 7 Pro `GM1911` | 1440×3120 | LOS 23.2 / OOS 14 | Magisk v30.7 | ✅ Live | — |
| OnePlus 12 | 3168×1440 | ColorOS 14 | Magisk / KSU | P2 | v5.0.0 |
| Pixel 8 | 2268×1080 | GrapheneOS / Pixel Drop | Magisk | P2 | v5.0.0 |
| Pixel 9 | 2424×1080 | Pixel Drop / LOS | Magisk / KSU | P2 | v5.0.0 |
| Nothing Phone 2 | 2412×1080 | NothingOS 3 | Magisk | P2 | v5.0.0 |
| Samsung Galaxy S24 | 2340×1080 | One UI 7 | Magisk (unofficial) | P2 | v5.0.0 |
| Xiaomi 14 | 2670×1200 | HyperOS 2 | Magisk / APatch | P2 | v5.0.0 |

### Nothing Phone Glyph Integration (P2 · v5.0.0)

```
  boot start   ──► glyph sweep: diagonal scan, cyan → yellow
  loop phase   ──► glyph pulse: heartbeat 1 Hz, netrunner-cyan
  boot done    ──► glyph fade: 500 ms → off
  shutdown     ──► glyph wipe: flatline red → off
```

| Task | Status |
|:-----|:------:|
| Research Nothing Glyph SDK / `glyphd` IPC interface | 📋 |
| Implement `lib/glyph-adapter.sh` for pattern control | 📋 |
| Design per-variant glyph sequences | 📋 |
| Test on Nothing Phone 2 (`Pong`) with NothingOS 3 | 📋 |

---

## ══ TOOLCHAIN REGISTRY ══

```
╔══════════════════════════════════════════════════════════════════════╗
║  ✅ Implemented  🔄 In progress  📋 Planned  🆕 New this sprint       ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Shell Tools

| Tool | Priority | Status | Purpose |
|:-----|:--------:|:------:|:--------|
| `cp2077-adb-control.sh` | — | ✅ | ADB host→device: switch / flash / logs / verify / build |
| `cp2077-config.sh` | — | ✅ | On-device interactive TUI variant picker |
| `cp2077-debug.sh` | P1 | 🆕🔄 | Bundle logcat + mounts + config + version + sepolicy → ZIP |
| `cp2077-workspace-audit.sh` | P1 | 🆕🔄 | Weekly cron: symlinks, stale repos, manifests, quarantine |
| `cp2077-health-dashboard.sh` | P2 | 📋 | Pure ANSI TUI health overview |
| `cp2077-root-smoke.sh` | P1 | 📋 | Magisk / KernelSU / APatch / MMRL install smoke test |
| `cp2077-rom-probe.sh` | P1 | 📋 | Device interrogation → `device-profile.yaml` |
| `cp2077-device-profile-gen.sh` | P2 | 📋 | ADB prop dump + paths + sizes + SELinux mode |
| `cp2077-slsa-provenance.sh` | P1 | 📋 | SLSA provenance via `slsa-github-generator` |
| `cp2077-bench.sh` | P2 | 📋 | 5-run boot timing benchmark (mean + stddev) |
| `cp2077-hud-toggle.sh` | P2 | 📋 | Waybar/eww HUD switcher |
| `cp2077-ci-local.sh` | P3 | 📋 | Local `act` runner wrapper for GitHub Actions |
| `check-github-remotes.sh` | P1 | 📋 | HTTP 200/301 + branch check for all 53 remotes |
| `lib/config-v2.sh` | P1 | 🔄 | Atomic read/write, file locking, schema validation |
| `lib/root-runtime.sh` | P1 | 📋 | `detect_root_manager()` / `detect_module_dir()` / `run_root_command()` |
| `lib/glyph-adapter.sh` | P2 | 📋 | Nothing Phone Glyph pattern control |

### Python Tools

| Tool | Priority | Status | Purpose |
|:-----|:--------:|:------:|:--------|
| `build.py` | — | ✅ | Main build orchestrator — 5 variants + megapack |
| `build-universal.py` | — | ✅ | Universal build — 12 resolutions via FFmpeg LANCZOS |
| `cp2077-source-lock-validator.py` | P1 | 📋 | Fail CI if lock file diverges from `SOURCES` |
| `cp2077-release-verify.py` | P1 | 📋 | Verify ZIP vs checksum + provenance + update.json |
| `cp2077-module-lint.py` | P2 | 📋 | Magisk module validator (files, perms, CRLF, META-INF) |
| `cp2077-repo-score.py` | P2 | 📋 | Score all 53 repos: age, dirty, ahead/behind, links |
| `cp2077-version-bumper.py` | P2 | 📋 | Atomic bump: build.py + module.prop + update.json |
| `cp2077-frame-inspector.py` | P3 | 📋 | Terminal frame preview for bootanimation ZIPs |
| `cp2077-archive-audit.py` | P3 | 📋 | Workspace ZIP scanner and integrity reporter |
| `cp2077-palette-gen.py` | P3 | 📋 | Generate palette assets from design tokens for docs |
| `cp2077-zip-diff.py` | P3 | 📋 | Hotfix frame/audio binary diff verifier |
| `cp2077-variant-compare.py` | P2 | 📋 | Side-by-side frame thumbnail comparator |
| `cp2077-self-check.sh` | P1 | 📋 | Verify mounted ZIPs SHA-256 vs `sources.lock.json` |

### GitHub Actions Workflows

| Workflow | Priority | Status | Purpose |
|:---------|:--------:|:------:|:--------|
| `ci.yml` | P1 | 📋 | Lint → Build → Test → Release 4-stage pipeline |
| `release.yml` | P1 | 📋 | Tag-triggered release + SLSA + `gh release create` |
| `scorecard.yml` | P1 | 📋 | Weekly OpenSSF Scorecard + SARIF publish |
| `codeql.yml` | P1 | 📋 | CodeQL for JS + ShellCheck SARIF + Python audit |
| `nightly.yml` | P3 | 📋 | Nightly `--check-sources` dry-run (no upload) |

---

## ══ PERFORMANCE BENCHMARKS ══

```
  BENCHMARK TARGETS
  ─────────────────────────────────────────────────────────────────
  Cold boot baseline (no module)     TBD            ⏳ pending
  Cold boot glitch overhead          < +2.0 s       ⏳ pending
  Cold boot og4k overhead            < +2.5 s       ⏳ pending
  post-fs-data.sh execution          < 800 ms       ⏳ pending
  service.sh first-pass overhead     < 200 ms       ⏳ pending
  Variant hot-swap                   < 3 s          ⏳ pending
  Frame-drop rate                    < 2/boot       ⏳ pending
  Battery drain vs baseline          < +0.5%        ⏳ pending
  og4k CPU temp — 5 cold boots       < 95°C         ⏳ pending
  service.sh remount detection       < 50 ms        ⏳ pending
  ─────────────────────────────────────────────────────────────────
```

| Benchmark | Target | Method | Status |
|:----------|:------:|:-------|:------:|
| Cold boot — no module (baseline) | TBD | `adb shell logcat -b events` | ⏳ |
| Cold boot — `glitch` overhead | < +2.0 s | baseline delta | ⏳ |
| Cold boot — `og4k` overhead | < +2.5 s | baseline delta | ⏳ |
| `post-fs-data.sh` execution | < 800 ms | `date +%s%3N` timestamps | ⏳ |
| `service.sh` first-pass (after sleep 5) | < 200 ms | timestamp diff | ⏳ |
| Variant hot-swap | < 3 s | config write → `setprop ctl.restart bootanim` | ⏳ |
| Frame-drop rate | < 2/boot | `SurfaceFlinger --latency` | ⏳ |
| Battery drain vs baseline (30 min idle) | < +0.5% | `adb shell dumpsys battery` | ⏳ |
| `og4k` CPU temp — 5 cold boots | < 95°C | `/sys/class/thermal/` | ⏳ |
| `service.sh` remount detection latency | < 50 ms | timestamp diff | ⏳ |

### Benchmark Tasks

| ID | Task | Priority |
|:---|:-----|:--------:|
| PERF-01 | `cp2077-bench.sh` — 5-run boot timing, mean + stddev | P2 |
| PERF-02 | `post-fs-data.sh` timestamps → `/data/local/tmp/cp2077-timing.log` | P2 |
| PERF-03 | `SurfaceFlinger --latency` per-frame latency capture | P2 |
| PERF-04 | 30-minute idle battery drain vs baseline | P3 |
| PERF-05 | tmpfs RAM-staging benchmark for devices >8 GB RAM | P2 |
| PERF-06 | `simpleperf` FFmpeg hotspot during audio gen build | P3 |
| PERF-07 | `og4k` thermal — 5 consecutive cold boots, max CPU temp | P2 |

---

## ══ COMPLETED LEDGER ══

| Item | Ver | Date |
|:-----|:---|:-----|
| Workspace consolidation | v3.0.0 | 2026-05-13 |
| Multi-path mount engine | v3.0.0 | 2026-05-13 |
| Config-file variant selection | v3.0.0 | 2026-05-13 |
| service.sh size-threshold remount | v3.0.0 | 2026-05-13 |
| Universal ROM detection (14 families) | v1.0.0 | 2026-05-13 |
| KernelSU/APatch root detection | v1.0.0 | 2026-05-13 |
| og4k asset generated | v3.0.0 | 2026-05-13 |
| og1080p shutdown created | v3.0.0 | 2026-05-13 |
| CP2077-Universal v1.0.0 built | v1.0.0 | 2026-05-13 |
| og4k packaged | v3.1.0 | 2026-05-13 |
| rboot verified on LOS 23.2 | v3.1.0 | 2026-05-13 |
| service.sh double-pass remount | v3.1.0 | 2026-05-13 |
| uninstall.sh cleanup expanded | v3.1.0 | 2026-05-13 |
| module.prop v3.1.0 | v3.1.0 | 2026-05-13 |
| Variant preview in installer | v3.1.0 | 2026-05-13 |
| Terminal color scheme pack | v3.1.0 | 2026-05-13 |

---

## ══ RELATED DOCS ══

| Document | Purpose |
|:---------|:-------|
| [`README.md`](../README.md) | Project dashboard |
| [`INSTALLATION-GUIDE.md`](INSTALLATION-GUIDE.md) | Install + flash workflow |
| [`BUILD-GUIDE.md`](BUILD-GUIDE.md) | Build + package workflow |
| [`VARIANTS.md`](VARIANTS.md) | Animation variants + assets |
| [`DEVICE-SPECS.md`](DEVICE-SPECS.md) | Device + ROM compat |
| [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) | Diagnostics + fixes |
| [`REPOS.md`](REPOS.md) | Repository catalogue |
| [`AGENTS.md`](../AGENTS.md) | Agent operating rules |

---

**Palette:** `#FCEE0C` · `#00FFFF` · `#FF003C` · `#00FF9F` · `#FF6B35` · `#0A0A0A`

**Owner:** `lchtangen` · **Workspace:** `/home/arch/cyberpunk-2077`