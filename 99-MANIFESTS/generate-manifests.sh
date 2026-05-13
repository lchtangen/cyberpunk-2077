#!/usr/bin/env bash
# generate-manifests.sh — Regenerate all workspace manifests
# Run from workspace root: bash 99-MANIFESTS/generate-manifests.sh
# Updates: directory-map, workspace-size, artifact-inventory, git-repos, SHA256

set -euo pipefail
WORKSPACE="$(cd "$(dirname "$0")/.." && pwd)"
MDIR="$WORKSPACE/99-MANIFESTS"
cd "$WORKSPACE"

YLW='\033[38;2;252;238;12m'
GRN='\033[38;2;0;255;159m'
DIM='\033[2m'
RST='\033[0m'

echo -e "${YLW}  Regenerating manifests…${RST}"
echo ""

# ── 1. Directory map ──────────────────────────────────────────────
echo -e "  ${DIM}[1/5] directory-map.txt${RST}"
find . -type d \
  -not -path '*/.git/*' -not -name '.git' \
  | sort > "$MDIR/directory-map.txt"
echo -e "  ${GRN}✓${RST}  $(wc -l < "$MDIR/directory-map.txt") directories"

# ── 2. Workspace size ─────────────────────────────────────────────
echo -e "  ${DIM}[2/5] workspace-size.txt${RST}"
{
  echo "# Workspace size — $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  du -sh .
  echo ""
  echo "# File count (excluding .git)"
  find . -type f -not -path '*/.git/*' | wc -l
} > "$MDIR/workspace-size.txt"
echo -e "  ${GRN}✓${RST}  $(du -sh . 2>/dev/null | cut -f1) total"

# ── 3. Artifact inventory ─────────────────────────────────────────
echo -e "  ${DIM}[3/5] artifact-inventory.tsv${RST}"
{
  printf "INDEX\tSIZE_BYTES\tPATH\n"
  find . -type f \
    -not -path '*/.git/*' \
    -printf '%s\t%p\n' \
    | sort -t $'\t' -k2,2 \
    | awk -F '\t' '{
        printf "%d\t%s\t%s\n", NR, $1, $2
      }'
} > "$MDIR/artifact-inventory.tsv"
echo -e "  ${GRN}✓${RST}  $(awk 'NR>1' "$MDIR/artifact-inventory.tsv" | wc -l) files indexed"

# ── 4. Git repository status ──────────────────────────────────────
echo -e "  ${DIM}[4/5] git-repositories-status.txt${RST}"
{
  echo "# Git repository status — $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "# format: path  branch  last-commit  remote  dirty"
  echo ""
  find . -name '.git' -not -path '*/.git/.git' \
    | sed 's|/.git||' \
    | sort \
    | while read -r repo; do
        branch=$(git -C "$repo" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "?")
        commit=$(git -C "$repo" log -1 --format='%h %s' 2>/dev/null || echo "?")
        remote=$(git -C "$repo" remote get-url origin 2>/dev/null || echo "(no remote)")
        dirty=$(git -C "$repo" status --short 2>/dev/null | wc -l | tr -d ' ')
        printf "%-70s  branch=%-20s  dirty=%-4s  remote=%s\n  last: %s\n\n" \
          "$repo" "$branch" "$dirty" "$remote" "$commit"
      done
} > "$MDIR/git-repositories-status.txt"
echo -e "  ${GRN}✓${RST}  $(grep -c "^\./" "$MDIR/git-repositories-status.txt" || true) repos scanned"

# ── 5. Production artifact SHA-256 (parallel) ────────────────────
echo -e "  ${DIM}[5/5] production-artifact-sha256.txt${RST}"
PARALLEL="${PARALLEL_SHA256:-8}"
TMPSHA="$MDIR/.sha256-tmp"
mkdir -p "$TMPSHA"
rm -f "$TMPSHA"/*.part

# Collect ZIPs
mapfile -t ZIP_LIST < <(
  find 02-PRODUCTION 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/release \
       01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/release \
       -name '*.zip' 2>/dev/null | sort
)

if [ ${#ZIP_LIST[@]} -eq 0 ]; then
  {
    echo "# Production artifact checksums — $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
    echo "# No ZIPs found"
  } > "$MDIR/production-artifact-sha256.txt"
  echo -e "  ${GRN}✓${RST}  0 ZIPs (none found)"
else
  # Dispatch parallel sha256sum workers
  _running=0
  for f in "${ZIP_LIST[@]}"; do
    safe="${f//\//_}"
    sha256sum "$f" > "$TMPSHA/${safe}.part" &
    (( _running++ ))
    if [ "$_running" -ge "$PARALLEL" ]; then
      wait -n 2>/dev/null || wait
      (( _running-- ))
    fi
  done
  wait

  {
    echo "# Production artifact checksums — $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
    echo "# parallel workers: $PARALLEL"
    echo ""
    # Reassemble in sorted order
    for f in "${ZIP_LIST[@]}"; do
      safe="${f//\//_}"
      cat "$TMPSHA/${safe}.part" 2>/dev/null || true
    done
  } > "$MDIR/production-artifact-sha256.txt"

  rm -rf "$TMPSHA"
  count=$(grep -c '\.zip' "$MDIR/production-artifact-sha256.txt" 2>/dev/null || echo 0)
  echo -e "  ${GRN}✓${RST}  $count ZIPs checksummed (${PARALLEL} parallel workers)"
fi

echo ""
echo -e "${YLW}  Manifests updated in 99-MANIFESTS/${RST}"
