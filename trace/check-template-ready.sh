#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 ByBren, LLC
# Template-ready validation
#
# Usage:
#   bash trace/check-template-ready.sh [ROOT] [--full]
#   bash trace/check-template-ready.sh --full [ROOT]
#   bash trace/check-template-ready.sh --template-ready=full
#
# Default (CI) scope: templates/, skills/, docs/, README.md
# Full scope: entire repo except .git/
#
# Denylist config: .template-ready-denylist.local (untracked; generated in CI)
# One term per line; # starts a comment; blank lines skipped.
# Fails if config file is missing or has no active terms.
# See .template-ready-denylist.example for the format.
#
# In full mode, denied terms are allowed only in .github/harness.yml,
# .github/CODEOWNERS, examples/round-table/, LICENSE, NOTICE, and CITATION.cff.

set -euo pipefail

# Parse flags first
FULL_MODE=false
ROOT_ARG="."

for arg in "$@"; do
  case "$arg" in
    --full|--template-ready=full)
      FULL_MODE=true
      ;;
    --template-ready)
      # Default scope
      ;;
    -*)
      echo "❌ Unknown flag: $arg"
      exit 1
      ;;
    *)
      ROOT_ARG="$arg"
      ;;
  esac
done

if ! ROOT="$(cd "$ROOT_ARG" && pwd)"; then
  echo "❌ cannot cd to ROOT: $ROOT_ARG"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Template-ready validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Root: $ROOT"
echo "Mode: $([ "$FULL_MODE" = true ] && echo "full repo" || echo "CI scope (templates/, skills/, docs/, README.md)")"
echo ""

ERRORS=0

# Load denylist from config file (required)
DENYLIST_FILE="$ROOT/.template-ready-denylist.local"
EXAMPLE_VALUES=()

if [ ! -f "$DENYLIST_FILE" ]; then
  echo "❌ Denylist config missing: .template-ready-denylist.local"
  echo "   Create this file with one denied term per line."
  echo "   Example terms: example-login, @example-login"
  exit 1
fi

# Read denylist terms (skip comments and blank lines)
while IFS= read -r line || [ -n "$line" ]; do
  # Skip comments and blank lines
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ "$line" =~ ^[[:space:]]*$ ]] && continue
  
  # Trim whitespace and add to array
  term=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  [ -n "$term" ] && EXAMPLE_VALUES+=("$term")
done < "$DENYLIST_FILE"

if [ ${#EXAMPLE_VALUES[@]} -eq 0 ]; then
  echo "❌ Denylist config has no active terms: .template-ready-denylist.local"
  echo "   Add at least one term (one per line, # for comments)."
  exit 1
fi

echo "Loaded ${#EXAMPLE_VALUES[@]} denied term(s) from config"
echo ""

# Paths where the terms are allowed in full mode
ALLOWED_IN_FULL=(
  ".github/harness.yml"
  ".github/CODEOWNERS"
  "examples/round-table/"
  "LICENSE"
  "NOTICE"
  "CITATION.cff"
)

# Build list of files to scan
SCAN_PATHS=()

if [ "$FULL_MODE" = true ]; then
  # Full mode: scan everything except .git/ and specific exclusions
  while IFS= read -r -d '' file; do
    # Reject symlinks (no silent pass)
    if [ -L "$file" ]; then
      echo "  ❌ Symlink encountered (rejected): ${file#$ROOT/}"
      ERRORS=$((ERRORS + 1))
      continue
    fi
    SCAN_PATHS+=("$file")
  done < <(find -P "$ROOT" \( -type f -o -type l \) \
    ! -path "$ROOT/.git/*" \
    ! -name "check-template-ready.sh" \
    ! -name ".template-ready-denylist.local" \
    -print0)
else
  # CI scope: templates/, skills/, docs/, README.md
  # Exclude examples/round-table/ and .github/ instance config
  
  # Check that CI scan surface exists
  CI_SURFACE_DIRS=("templates" "skills" "docs")
  SURFACE_EXISTS=false
  for dir in "${CI_SURFACE_DIRS[@]}"; do
    if [ -d "$ROOT/$dir" ]; then
      SURFACE_EXISTS=true
      break
    fi
  done
  
  if [ "$SURFACE_EXISTS" = false ] && [ ! -f "$ROOT/README.md" ]; then
    echo "❌ CI scan surface missing or empty (templates/, skills/, docs/, README.md)"
    exit 1
  fi
  
  for dir in "${CI_SURFACE_DIRS[@]}"; do
    if [ -d "$ROOT/$dir" ]; then
      # Reject if the directory itself is a symlink
      if [ -L "$ROOT/$dir" ]; then
        echo "  ❌ Symlink encountered (rejected): ${dir}/"
        ERRORS=$((ERRORS + 1))
        continue
      fi
      while IFS= read -r -d '' file; do
        # Reject symlinks (no silent pass)
        if [ -L "$file" ]; then
          echo "  ❌ Symlink encountered (rejected): ${file#$ROOT/}"
          ERRORS=$((ERRORS + 1))
          continue
        fi
        # Skip examples/round-table/ in CI scope
        if [[ ! "$file" =~ /examples/round-table/ ]]; then
          SCAN_PATHS+=("$file")
        fi
      done < <(find -P "$ROOT/$dir" \( -type f -o -type l \) -print0)
    fi
  done
  
  # Add README.md if it exists
  if [ -f "$ROOT/README.md" ]; then
    if [ -L "$ROOT/README.md" ]; then
      echo "  ❌ Symlink encountered (rejected): README.md"
      ERRORS=$((ERRORS + 1))
    else
      SCAN_PATHS+=("$ROOT/README.md")
    fi
  fi
fi

if [ ${#SCAN_PATHS[@]} -eq 0 ]; then
  echo "❌ No files found in scan scope (fail closed)"
  exit 1
fi

echo "Scanning ${#SCAN_PATHS[@]} file(s)..."
echo ""

# Scan each file for denied terms (case-insensitive, fixed-string)
for file in "${SCAN_PATHS[@]}"; do
  # Skip binary files
  if file "$file" 2>/dev/null | grep -q "text"; then
    for value in "${EXAMPLE_VALUES[@]}"; do
      # Use grep -Fi for case-insensitive fixed-string matching
      if grep -qi -F "$value" "$file" 2>/dev/null; then
        # In full mode, check if file is in allowed paths
        if [ "$FULL_MODE" = true ]; then
          ALLOWED=false
          REL_PATH="${file#$ROOT/}"
          for allowed in "${ALLOWED_IN_FULL[@]}"; do
            if [[ "$REL_PATH" == "$allowed" ]] || [[ "$REL_PATH" == "$allowed"* ]]; then
              ALLOWED=true
              break
            fi
          done
          if [ "$ALLOWED" = true ]; then
            continue
          fi
        fi
        
        echo "  ❌ Found '$value' in: ${file#$ROOT/}"
        ERRORS=$((ERRORS + 1))
      fi
    done
  fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Errors: $ERRORS"
echo ""

if [ "$ERRORS" -gt 0 ]; then
  echo "❌ Template-ready check failed"
  echo ""
  echo "Template files must not contain denied terms."
  echo "See .template-ready-denylist.local for the list of denied terms."
  echo ""
  exit 1
fi

echo "✅ Template-ready check passed"
exit 0
