# Top 10 Priority Tasks for Cyberpunk 2077 Workspace

**Created:** May 16, 2026
**Status:** In Progress
**Objective:** Execute foundational infrastructure tasks to unblock v3.2.0 release and establish best practices

---

## Executive Summary

These 10 tasks create the essential infrastructure for multi-root-manager support, release verification, and workspace governance. They are ordered by dependency: later tasks build on earlier ones.

| # | Task | Type | Impact | Blockers |
|---|------|------|--------|----------|
| 1 | Create `lib/root-runtime.sh` | Foundation | 5⭐ | None |
| 2 | Validate `module.prop` across modules | Quality | 5⭐ | Task 1 |
| 3 | Add atomic config write helper | Safety | 4⭐ | Task 1 |
| 4 | Replace fixed sleeps with property waits | Reliability | 4⭐ | Task 1 |
| 5 | Add `cp2077-release-verify.py` | Verification | 5⭐ | None |
| 6 | Generate `repo-registry.json` | Governance | 5⭐ | None |
| 7 | Create `cp2077-workspace-audit.sh` | Ops | 4⭐ | Task 6 |
| 8 | Extract `lib/mount-runtime.sh` | Refactor | 4⭐ | Task 1 |
| 9 | Add ZIP integrity verification gate | QA | 5⭐ | Task 5 |
| 10 | Create `devices/guacamole-los-23.2.yaml` | Integration | 4⭐ | None |

---

## Task Details

### Task 1: Create `lib/root-runtime.sh`
**Type:** Foundation | **Priority:** P0 | **Impact:** Enables tasks 2, 3, 4, 8

Create a shared shell library for root detection and root-manager discovery.

**Scope:**
- Detect active root manager (Magisk, KernelSU, APatch)
- Get module path for each manager
- Provide shell bridge dispatcher
- Support install, status, config, and webui contexts

**Files to create:**
- `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/lib/root-runtime.sh`
- `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/lib/root-runtime.sh`

**Acceptance Criteria:**
- Installer, service, config, and WebUI can all source and use root-runtime
- Each root manager detection is testable
- Works in recovery and normal boot contexts

---

### Task 2: Validate `module.prop` Across All Modules
**Type:** Quality | **Priority:** P0 | **Impact:** Enables OTA, UNI, LOS release parity

Add CI gate to validate all module.prop files.

**Scope:**
- Check required fields: `id`, `name`, `version`, `versionCode`
- Verify versionCode formula (MAJOR * 100000 + MINOR * 1000 + PATCH)
- Validate `updateJson` URLs are HTTPS and not 404
- Check for CRLF line endings (Windows corruption)
- Ensure version consistency across module.prop, build scripts, release names

**Files to create/update:**
- `CP2077-OP7Pro/.github/workflows/ci-module-lint.yml` (new)
- `CP2077-Universal/.github/workflows/ci-module-lint.yml` (new)

**Acceptance Criteria:**
- Pre-release CI fails if module.prop is invalid
- All 3 modules pass checks
- Pipeline prevents version drift

---

### Task 3: Add Atomic Config Write Helper
**Type:** Safety | **Priority:** P1 | **Impact:** Prevents config corruption

Create `/data/cp2077.conf` write helper using temp file + rename pattern.

**Scope:**
- Write to temporary file first
- Set 0644 permissions
- Atomic rename
- Retry with exponential backoff
- Fallback to direct write with warning

**Files to create:**
- `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/lib/config-atomic.sh`
- Used by: `cp2077-config.sh`, `customize.sh`, ADB control script

**Acceptance Criteria:**
- Config writes never leave partial files on device
- Write succeeds or fails cleanly (no half-written state)
- Device survives config corruption detection

---

### Task 4: Replace Fixed Sleeps with Property Waits
**Type:** Reliability | **Priority:** P1 | **Impact:** Fixes boot race conditions

Replace `sleep 5` with property waits in boot scripts.

**Scope:**
- `service.sh` waits for `init.svc.bootanim` property
- `post-fs-data.sh` waits for `ro.boot.bootloader` availability
- Both log timeout reason if property not seen within 30s
- Both have fallback to original 5s sleep if property framework fails

**Files to update:**
- `CP2077-OP7Pro/service.sh`
- `CP2077-Universal/service.sh`

**Acceptance Criteria:**
- Boot sequence is deterministic (not timing-dependent)
- Logs show property poll state
- 0 race condition hangs on subsequent boots

---

### Task 5: Add `cp2077-release-verify.py` Tool
**Type:** Verification | **Priority:** P0 | **Impact:** Blocks corrupted releases

Create release verification tool.

**Scope:**
- Verify ZIP structure and integrity (`python3 -m zipfile -t`)
- Check `module.prop` inside ZIP against expected values
- Validate embedded `update.json` (if present)
- Check source lock SHA-256 if animation variant
- Generate/compare release SHA-256

**Files to create:**
- `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/scripts/cp2077-release-verify.py`
- Used by: GitHub Actions release pipeline

**Acceptance Criteria:**
- Every release ZIP must pass verification before upload
- Detects corrupted downloads, missing metadata, and version mismatches
- Exit code 0 only on full pass

---

### Task 6: Generate `repo-registry.json`
**Type:** Governance | **Priority:** P0 | **Impact:** Single source of truth for repos

Generate structured registry of all cloned repositories.

**Scope:**
- Parse `99-MANIFESTS/git-repositories.txt`
- Run git status on each repo
- Collect: path, remote, branch, dirty count, last commit, purpose, sync tier
- Output as JSON for consumption by scripts and docs

**Files to create:**
- `99-MANIFESTS/repo-registry.json`
- `99-MANIFESTS/repo-registry-schema.json`
- Update `99-MANIFESTS/generate-manifests.sh` (step 5)

**Acceptance Criteria:**
- Registry is complete and up-to-date
- Enables audit and CI scripts to reference repos by ID
- Replaces ad-hoc repo lookups in scripts

---

### Task 7: Create `cp2077-workspace-audit.sh`
**Type:** Ops | **Priority:** P1 | **Impact:** Early warning system for issues

Create workspace health check script.

**Scope:**
- Check manifest freshness (not older than 7 days)
- Scan for stale repos (not updated in 30 days)
- Find broken symlinks in animations/wallpapers
- Detect quarantine leaks (no reference to 10-QUARANTINE/*)
- Verify no cloned .git/ internals in tracked files
- Report dirty state for each nested repo

**Files to create:**
- `99-MANIFESTS/cp2077-workspace-audit.sh`
- Used by: CI gates, pre-release checklist, developer workflow

**Acceptance Criteria:**
- Script runs in < 30s
- Produces human-readable output
- Exit code non-zero on detected issues

---

### Task 8: Extract `lib/mount-runtime.sh`
**Type:** Refactor | **Priority:** P1 | **Impact:** Reduces code duplication

Extract shared mount/copy logic from `post-fs-data.sh` and `service.sh`.

**Scope:**
- Bind mount function with retry logic
- Copy fallback ZIP with validation
- Remount threshold checker (5 MB rule)
- Shared logging for all mount operations

**Files to create:**
- `CP2077-OP7Pro/lib/mount-runtime.sh`
- `CP2077-Universal/lib/mount-runtime.sh`

**Acceptance Criteria:**
- Both `post-fs-data.sh` and `service.sh` use single mount implementation
- 200 lines of duplicate code removed
- Mount behavior unchanged (regression test passes)

---

### Task 9: Add ZIP Integrity Verification Gate
**Type:** QA | **Priority:** P0 | **Impact:** Prevents distribution of corrupted artifacts

Add release pipeline gate to verify all ZIPs.

**Scope:**
- GitHub Actions step that calls `cp2077-release-verify.py` on all release ZIPs
- Pre-upload verification in `release.yml`
- Blocks release if any ZIP fails
- Generates verification report

**Files to create/update:**
- `.github/workflows/release.yml` — add verify step
- `releases/RELEASE-VERIFICATION.md` — document process

**Acceptance Criteria:**
- Releases cannot be published with corrupted ZIPs
- Verification report is human-readable and machine-parseable
- All release ZIPs in production currently pass verification

---

### Task 10: Create `devices/guacamole-los-23.2.yaml`
**Type:** Integration | **Priority:** P1 | **Impact:** Enables Universal multi-device support

Create device profile for LOS 23.2 on OnePlus 7 Pro.

**Scope:**
- Boot animation paths (all 7 known paths)
- Shutdown animation paths
- Audio paths and format expectations
- ROM family properties for detection
- SELinux mode and relevant denials
- Test status and notes

**Files to create:**
- `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/devices/guacamole-los-23.2.yaml`
- Used by: Universal installer for device detection logic

**Acceptance Criteria:**
- Profile has been tested on actual device
- All paths are verified to exist and be writable
- Profile format is consumable by installer shell code

---

## Implementation Strategy

1. **Phase 1 (Shared Infrastructure):** Tasks 1, 5, 6 in parallel
   - Foundation (root runtime)
   - Verification tool (release-verify.py)
   - Registry (repo-registry.json)

2. **Phase 2 (Safety & Reliability):** Tasks 2, 3, 4, 8 in sequence
   - Module validation
   - Config safety
   - Boot reliability
   - Mount extraction

3. **Phase 3 (Ops & Integration):** Tasks 7, 9, 10 in parallel
   - Workspace audit
   - Release gate
   - Device profile

---

## Expected Outcomes

Upon completion, the workspace will have:

✅ **Infrastructure**
- Shared libraries for boot, config, mount, and root detection
- Single source of truth for repository registry

✅ **Quality**
- Automated validation of module metadata
- Release ZIP integrity verification
- Device profile-driven Universal installer

✅ **Reliability**
- Deterministic boot sequence (no race conditions)
- Atomic config updates
- Workspace health monitoring

✅ **Governance**
- Reproducible release process
- Audit trail for all changes
- Clear ownership and responsibilities

---

**Next Step:** Execute Task 1 (Create `lib/root-runtime.sh`)
