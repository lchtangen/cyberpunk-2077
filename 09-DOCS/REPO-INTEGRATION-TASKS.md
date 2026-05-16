# GitHub Repository Integration Tasks

**Document:** Actionable integration tasks for GitHub repos  
**Target:** Phase 1 & 2 implementation roadmap  
**Status:** Ready to execute

---

## HIGH PRIORITY: Week 1

### Task 1.1: Compare Boot Animation Build Strategy
**Repo:** `rhythmcache/Video-to-BootAnimation-Creator-Script`  
**Effort:** 1 hour  
**Goal:** Extract FFmpeg LANCZOS scaling logic; verify against `build.py`

**Steps:**
```bash
# Clone to temporary location
git clone --depth 1 https://github.com/rhythmcache/Video-to-BootAnimation-Creator-Script /tmp/video-to-anim

# Find FFmpeg LANCZOS calls
grep -r "LANCZOS\|scale\|fps" /tmp/video-to-anim --include="*.py" --include="*.sh"

# Compare with your build.py
cd /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
grep -n "LANCZOS\|scale\|fps" build.py
```

**Expected findings:**
- FFmpeg command syntax (yours uses `-vf scale=...` with LANCZOS)
- Frame-rate handling (yours defaults to 60 fps)
- Color space conversion (if any)

**Outcome:** Document differences in `09-DOCS/BUILD-SYSTEM-NOTES.md` if found

---

### Task 1.2: Diff ENEIZEM Module Against Yours
**Repo:** `ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO`  
**Effort:** 1.5 hours  
**Goal:** Study variant selection logic and mount paths

**Steps:**
```bash
# Clone ENEIZEM module
git clone --depth 1 https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO /tmp/eneizem-cp2077

# Extract and diff customize.sh
diff -u /tmp/eneizem-cp2077/customize.sh \
         01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/customize.sh \
         | head -100

# Check their module.prop
cat /tmp/eneizem-cp2077/module.prop
grep -A 5 "version\|versionCode" 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/module.prop
```

**Document findings:**
- [ ] Variant selection pattern (how do they store chosen variant?)
- [ ] Mount path strategy (which `/product/media/` paths do they mount?)
- [ ] Audio integration (if any)
- [ ] Config file format (do they use `cp2077.conf`?)

**Checklist:**
- [ ] Review their `lib/` functions (if present)
- [ ] Note any clever shell techniques you could borrow
- [ ] Compare `post-fs-data.sh` mount strategies

---

### Task 1.3: Validate Design Token Consistency
**Repo:** `Roboron3042/Cyberpunk-Neon`  
**Effort:** 1 hour  
**Goal:** Cross-check your color palette against canonical source

**Steps:**
```bash
# Clone Roboron3042 palette
git clone --depth 1 https://github.com/Roboron3042/Cyberpunk-Neon /tmp/cyber-neon

# Extract color definitions
find /tmp/cyber-neon -name "*.yml" -o -name "*.json" -o -name "*.txt" | grep -i color

# Your current palette (from CLAUDE.md)
echo "Your design tokens:"
grep -A 10 "Design tokens" /home/arch/dev/projects/cyberpunk-2077/CLAUDE.md | grep -- "--"
```

**Expected mapping:**
| Your Token | Value | Roboron3042 Match |
|-----------|-------|------------------|
| `--yellow` | `#FCEE0C` | primary accent |
| `--cyan` | `#00FFFF` | secondary |
| `--red` | `#FF003C` | danger |
| `--green` | `#00FF9F` | success |
| `--bg` | `#0A0A0A` | background |

**Outcome:**
- [ ] Create file `09-DOCS/design-tokens-canonical.md` with source URLs
- [ ] Flag any divergences for correction
- [ ] Note hex values for CSS/ANSI exports

---

### Task 1.4: Check K-DE-Cyberpunk-Neon Submodule Status
**Repo:** `UtkarshKunwar/K-DE-Cyberpunk-Neon` (your submodule)  
**Effort:** 30 min  
**Goal:** Ensure submodule HEAD is up-to-date

**Steps:**
```bash
cd /home/arch/dev/projects/cyberpunk-2077/06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon

# Check current status
git status
git log --oneline -5

# Fetch latest from upstream
git fetch origin

# Check for unmerged commits
git log --oneline origin/main..main  # if ahead
git log --oneline main..origin/main  # if behind

# Update if needed
git pull origin main
```

**Document:**
- Current commit hash
- Any divergences from upstream
- Upstream activity (last commit date, open PRs if any)

---

## HIGH PRIORITY: Week 2

### Task 2.1: Study Waybar/eww Configuration Patterns
**Repos:** `prasanthrangan/hyprdots`, `scherrer-txt/cybrland`  
**Effort:** 2 hours  
**Goal:** Extract Waybar/eww configs; identify improvements for Linux host setup

**Steps:**
```bash
# Clone both for reference
git clone --depth 1 https://github.com/prasanthrangan/hyprdots /tmp/hyprdots
git clone --depth 1 https://github.com/scherrer-txt/cybrland /tmp/cybrland

# Extract Waybar config
diff /tmp/hyprdots/.config/waybar/config.jsonc \
     /tmp/cybrland/.config/waybar/config \
     2>/dev/null | head -50

# Compare with your setup (if exists)
ls -la /home/arch/.config/waybar/ 2>/dev/null || echo "No local waybar config"
```

**Checklist:**
- [ ] Waybar modules (identify useful additions: clock, weather, updates)
- [ ] Notification styling (dunst config)
- [ ] Rofi launcher theming
- [ ] eww widget configuration (if using)
- [ ] Color variable injection patterns

**Outcome:**
- [ ] Document recommended Waybar modules
- [ ] Create optional Waybar theme snippet for cyberpunk colors
- [ ] Flag any missing features in current Linux host setup

---

### Task 2.2: Evaluate MMT-Extended Utilities
**Repo:** `Zackptg5/MMT-Extended`  
**Effort:** 1.5 hours  
**Goal:** Decide whether to integrate or keep custom approach

**Steps:**
```bash
git clone --depth 1 https://github.com/Zackptg5/MMT-Extended /tmp/mmt-extended

# Extract utility functions
grep -E "^[a-z_]+\(\)" /tmp/mmt-extended/common/system.prop
grep -E "^[a-z_]+\(\)" /tmp/mmt-extended/common/post-fs-data.sh | head -20

# Compare file sizes
wc -l /tmp/mmt-extended/common/*.sh
wc -l /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/customize.sh
```

**Key utilities to evaluate:**
- `mount_mask()` vs your mount logic
- `uninstall_module()` cleanup pattern
- `pm_reinstall()` if you ever need it
- Busybox abstraction layer

**Decision framework:**
- **Integrate:** If you find 3+ utility functions that would reduce your code significantly
- **Skip:** If your custom approach is simpler or uses fewer dependencies

---

### Task 2.3: Cross-Reference GitHub Actions Workflows
**Repos:** `SAPTeamDEV/Magisk-Module-Template`, `Woomymy/Magisk-Module-GH-Actions-Template`  
**Effort:** 1 hour  
**Goal:** Identify improvements or missing features in your CI/CD

**Steps:**
```bash
# Clone templates
git clone --depth 1 https://github.com/SAPTeamDEV/Magisk-Module-Template /tmp/sap-template
git clone --depth 1 https://github.com/Woomymy/Magisk-Module-GH-Actions-Template /tmp/woomymy-template

# Compare release workflows
diff /tmp/sap-template/.github/workflows/release.yml \
     /tmp/woomymy-template/.github/workflows/release.yml \
     2>/dev/null | head -50

# Check yours
cat /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/.github/workflows/release.yml | head -50
```

**Checklist:**
- [ ] Tag-triggered vs. manual release patterns
- [ ] Artifact signing (do they sign release zips?)
- [ ] Draft release auto-generation
- [ ] Changelog automation
- [ ] update.json generation step

**Outcome:**
- [ ] Document any workflow improvements to backport
- [ ] Note their secrets/environment setup (do they use GitHub Secrets?)

---

## MEDIUM PRIORITY: Month 2

### Task 3.1: Plan Lawnchair Launcher Integration (Optional)
**Repo:** `LawnchairLauncher/lawnchair`  
**Effort:** Research only (no implementation yet)  
**Goal:** Evaluate Material 3 color integration for future launcher customization

**Steps:**
```bash
git clone --depth 1 https://github.com/LawnchairLauncher/lawnchair /tmp/lawnchair

# Find color/theme configuration
find /tmp/lawnchair -name "*color*" -o -name "*theme*" | grep -i kotlin
grep -r "Material.*Color\|theme" /tmp/lawnchair/src --include="*.kt" | head -20
```

**Document:**
- How Lawnchair applies Material 3 colors
- Whether your cyberpunk palette can override defaults
- Effort estimate for Material 3 color sync

---

### Task 3.2: Explore ZygiskNext for Future Modules
**Repo:** `Dr-TSNG/ZygiskNext`  
**Effort:** Research only  
**Goal:** Understand Zygisk capabilities for future system-level customization

**Steps:**
```bash
git clone --depth 1 https://github.com/Dr-TSNG/ZygiskNext /tmp/zygisknext

# Read overview
cat /tmp/zygisknext/README.md | head -100

# Check API docs
find /tmp/zygisknext -name "*.md" | xargs grep -l "API\|interface" | head -3
```

**Document:**
- When Zygisk would be needed (e.g., intent interception for animation triggers)
- Current vs. future scope (bookmark, don't implement now)

---

## METADATA & REFERENCES

### Import CSV into Spreadsheet

The file `GITHUB-REPOS-TRACKING.csv` can be imported into:
- **Google Sheets:** File → Import → Select CSV file
- **Excel:** File → Open → CSV file
- **Notion:** Create database from CSV

**Columns:** Repo Name, GitHub URL, Category, Priority, Status, Integration Type, Tech Stack, Stars, Last Updated, Key Integration Points, Action Items

---

### Quick Reference Links

| Repo | Quick Clone |
|------|------------|
| rhythmcache video-to-anim | `git clone --depth 1 https://github.com/rhythmcache/Video-to-BootAnimation-Creator-Script /tmp/video-to-anim` |
| ENEIZEM CP2077 | `git clone --depth 1 https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO /tmp/eneizem-cp2077` |
| Roboron3042 Neon | `git clone --depth 1 https://github.com/Roboron3042/Cyberpunk-Neon /tmp/cyber-neon` |
| hyprdots | `git clone --depth 1 https://github.com/prasanthrangan/hyprdots /tmp/hyprdots` |
| cybrland | `git clone --depth 1 https://github.com/scherrer-txt/cybrland /tmp/cybrland` |

---

### Completion Checklist

**Week 1:**
- [ ] Task 1.1: FFmpeg LANCZOS analysis
- [ ] Task 1.2: ENEIZEM module diff
- [ ] Task 1.3: Design token validation
- [ ] Task 1.4: K-DE-Cyberpunk-Neon status check

**Week 2:**
- [ ] Task 2.1: Waybar/eww patterns study
- [ ] Task 2.2: MMT-Extended evaluation
- [ ] Task 2.3: GitHub Actions cross-reference

**Month 2:**
- [ ] Task 3.1: Lawnchair launcher research
- [ ] Task 3.2: ZygiskNext exploration

---

## Notes

- All tasks use temporary clone locations (`/tmp/`) to avoid cluttering the workspace
- Keep `.gitignore` clean: don't commit reference repos
- Update `99-MANIFESTS/` after integrating any upstream changes
- Document all findings in `09-DOCS/` for future reference

