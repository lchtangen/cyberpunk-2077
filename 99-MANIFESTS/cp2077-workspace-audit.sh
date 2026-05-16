#!/bin/bash
# cp2077-workspace-audit.sh — Workspace health check and governance audit
#
# Verifies workspace integrity, manifest freshness, repository state, and release safety.
# Used in: pre-release checklist, CI gates, developer workflow, scheduled health reports
#
# Usage: bash 99-MANIFESTS/cp2077-workspace-audit.sh [--fix] [--verbose] [--json]
#
# Exit codes:
#   0: All checks passed
#   1: Non-critical warnings
#   2: Critical issues detected
#   3: Audit could not complete (permissions, missing files)

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Options
FIX_MODE=0
VERBOSE=0
JSON_MODE=0

# Results
ERRORS=()
WARNINGS=()
PASSES=()

# Color codes (disabled in JSON mode)
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_pass() {
  local msg="$1"
  PASSES+=("$msg")
  if [ $JSON_MODE -eq 0 ]; then
    [ $VERBOSE -eq 1 ] && echo -e "${GREEN}✓${NC} $msg"
  fi
}

log_warning() {
  local msg="$1"
  WARNINGS+=("$msg")
  if [ $JSON_MODE -eq 0 ]; then
    echo -e "${YELLOW}⚠${NC} $msg"
  fi
}

log_error() {
  local msg="$1"
  ERRORS+=("$msg")
  if [ $JSON_MODE -eq 0 ]; then
    echo -e "${RED}✗${NC} $msg"
  fi
}

log_info() {
  local msg="$1"
  if [ $JSON_MODE -eq 0 ] && [ $VERBOSE -eq 1 ]; then
    echo -e "${BLUE}ℹ${NC} $msg"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# MANIFEST FRESHNESS CHECKS
# ─────────────────────────────────────────────────────────────────────────────

check_manifest_age() {
  log_info "Checking manifest freshness..."
  
  local manifest_dir="$WORKSPACE_ROOT/99-MANIFESTS"
  local max_age_days=7
  local current_time
  local file_time
  local age_days
  
  current_time=$(date +%s)
  
  for manifest_file in directory-map.txt workspace-size.txt artifact-inventory.tsv git-repositories.txt; do
    local file_path="$manifest_dir/$manifest_file"
    if [ ! -f "$file_path" ]; then
      log_warning "Manifest missing: $manifest_file"
      continue
    fi
    
    file_time=$(stat -c %Y "$file_path" 2>/dev/null || stat -f %m "$file_path" 2>/dev/null || echo "0")
    age_days=$(((current_time - file_time) / 86400))
    
    if [ "$age_days" -gt "$max_age_days" ]; then
      log_warning "Manifest stale ($age_days days): $manifest_file"
    else
      log_pass "Manifest fresh ($age_days days): $manifest_file"
    fi
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# SYMLINK VALIDATION
# ─────────────────────────────────────────────────────────────────────────────

check_symlinks() {
  log_info "Checking symlinks..."
  
  local broken_links=0
  
  # Check bootanimation symlinks
  if [ -d "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/bootanimations" ]; then
    while IFS= read -r -d '' link; do
      if [ -L "$link" ] && ! [ -e "$link" ]; then
        log_error "Broken symlink: $link"
        broken_links=$((broken_links + 1))
        if [ $FIX_MODE -eq 1 ]; then
          rm "$link"
          log_info "Fixed: removed broken symlink"
        fi
      fi
    done < <(find "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/bootanimations" -type l -print0 2>/dev/null)
  fi
  
  if [ $broken_links -eq 0 ]; then
    log_pass "No broken symlinks found"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# QUARANTINE ISOLATION CHECK
# ─────────────────────────────────────────────────────────────────────────────

check_quarantine_isolation() {
  log_info "Checking quarantine isolation..."
  
  local quarantine_dir="$WORKSPACE_ROOT/10-QUARANTINE-invalid-downloads"
  local leaks=0
  
  if [ ! -d "$quarantine_dir" ]; then
    log_warning "Quarantine directory not found"
    return
  fi
  
  # Scan for references to quarantined files in build/release processes
  if grep -r "10-QUARANTINE" "$WORKSPACE_ROOT/01-DEVELOPMENT" "$WORKSPACE_ROOT/releases" 2>/dev/null | grep -v "\.git"; then
    log_error "Quarantine leak detected: references in build/release"
    leaks=$((leaks + 1))
  fi
  
  if [ $leaks -eq 0 ]; then
    log_pass "Quarantine is properly isolated"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# GIT INTERNALS CHECK
# ─────────────────────────────────────────────────────────────────────────────

check_git_internals() {
  log_info "Checking for nested .git/ internals in tracked files..."
  
  local git_internals=0
  
  # Check if any .git/ directories are tracked by parent git
  cd "$WORKSPACE_ROOT"
  if git ls-files | grep -q "\.git/"; then
    log_error ".git/ directories found in git index (should be gitignored)"
    git_internals=$((git_internals + 1))
  fi
  
  if [ $git_internals -eq 0 ]; then
    log_pass "No nested .git/ internals tracked"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# NESTED REPO DIRTY STATE CHECK
# ─────────────────────────────────────────────────────────────────────────────

check_nested_repos_dirty() {
  log_info "Checking nested repository state..."
  
  local repos_to_check=(
    "01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro"
    "01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate"
    "01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal"
  )
  
  for repo_path in "${repos_to_check[@]}"; do
    local full_path="$WORKSPACE_ROOT/$repo_path"
    if [ ! -d "$full_path/.git" ]; then
      continue
    fi
    
    cd "$full_path"
    local dirty_count
    dirty_count=$(git status --porcelain 2>/dev/null | wc -l)
    
    if [ "$dirty_count" -gt 0 ]; then
      log_warning "Repo has uncommitted changes ($dirty_count files): $repo_path"
    else
      log_pass "Repo is clean: $repo_path"
    fi
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# RELEASE ARTIFACT VERIFICATION
# ─────────────────────────────────────────────────────────────────────────────

check_release_artifacts() {
  log_info "Checking release artifacts..."
  
  local releases_dir="$WORKSPACE_ROOT/02-PRODUCTION/magisk-modules"
  local missing_artifacts=0
  
  local expected_symlinks=(
    "CP2077-OP7Pro-release"
    "CP2077-OP7Pro-Ultimate-release"
    "CP2077-Universal-release"
  )
  
  for link in "${expected_symlinks[@]}"; do
    local link_path="$releases_dir/$link"
    if [ ! -L "$link_path" ]; then
      log_error "Missing release symlink: $link"
      missing_artifacts=$((missing_artifacts + 1))
    elif ! [ -e "$link_path" ]; then
      log_error "Broken release symlink: $link"
      missing_artifacts=$((missing_artifacts + 1))
    else
      log_pass "Release symlink OK: $link"
    fi
  done
  
  # Check for oversized files that shouldn't be tracked
  if find "$releases_dir" -size +100M -type f 2>/dev/null | grep -v "\.gitignore"; then
    log_error "Found >100MB file in release directory (should be .gitignored)"
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# MODULE.PROP VALIDATION
# ─────────────────────────────────────────────────────────────────────────────

check_module_props() {
  log_info "Validating module.prop files..."
  
  local modules=(
    "01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro"
    "01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate"
    "01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal"
  )
  
  for module_path in "${modules[@]}"; do
    local full_path="$WORKSPACE_ROOT/$module_path"
    local prop_file="$full_path/module.prop"
    
    if [ ! -f "$prop_file" ]; then
      log_error "Missing module.prop: $module_path"
      continue
    fi
    
    # Check required fields
    for field in id name version versionCode; do
      if ! grep -q "^${field}=" "$prop_file"; then
        log_error "Missing field in module.prop ($module_path): $field"
      fi
    done
    
    log_pass "module.prop valid: $(basename "$module_path")"
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# SUMMARY AND EXIT
# ─────────────────────────────────────────────────────────────────────────────

print_summary() {
  if [ $JSON_MODE -eq 0 ]; then
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║              WORKSPACE AUDIT SUMMARY                       ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo -e "${GREEN}Passed:${NC}   ${#PASSES[@]}"
    echo -e "${YELLOW}Warnings:${NC} ${#WARNINGS[@]}"
    echo -e "${RED}Errors:${NC}   ${#ERRORS[@]}"
    echo ""
    
    if [ ${#WARNINGS[@]} -gt 0 ]; then
      echo "Warnings:"
      for w in "${WARNINGS[@]}"; do
        echo "  - $w"
      done
      echo ""
    fi
    
    if [ ${#ERRORS[@]} -gt 0 ]; then
      echo "Errors:"
      for e in "${ERRORS[@]}"; do
        echo "  - $e"
      done
      echo ""
    fi
  fi
}

print_json_summary() {
  cat <<EOF
{
  "audit_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "workspace": "$WORKSPACE_ROOT",
  "passed": ${#PASSES[@]},
  "warnings": ${#WARNINGS[@]},
  "errors": ${#ERRORS[@]},
  "status": "$([ ${#ERRORS[@]} -eq 0 ] && echo "OK" || echo "FAIL")",
  "warnings_list": [$(printf '"%s",' "${WARNINGS[@]}" | sed 's/,$//')],
  "errors_list": [$(printf '"%s",' "${ERRORS[@]}" | sed 's/,$//')]
}
EOF
}

# ─────────────────────────────────────────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────────────────────────────────────────

main() {
  # Parse arguments
  while [ $# -gt 0 ]; do
    case "$1" in
      --fix)      FIX_MODE=1 ;;
      --verbose)  VERBOSE=1 ;;
      --json)     JSON_MODE=1 ;;
      *)          echo "Unknown option: $1"; exit 3 ;;
    esac
    shift
  done

  log_info "Starting workspace audit..."
  log_info "Workspace: $WORKSPACE_ROOT"
  
  # Run all checks
  check_manifest_age
  check_symlinks
  check_quarantine_isolation
  check_git_internals
  check_nested_repos_dirty
  check_release_artifacts
  check_module_props
  
  # Print results
  if [ $JSON_MODE -eq 1 ]; then
    print_json_summary
  else
    print_summary
  fi
  
  # Exit with appropriate code
  if [ ${#ERRORS[@]} -gt 0 ]; then
    exit 2
  elif [ ${#WARNINGS[@]} -gt 0 ]; then
    exit 1
  else
    exit 0
  fi
}

main "$@"
