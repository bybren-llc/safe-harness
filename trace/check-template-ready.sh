#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 ByBren, LLC
# Template-ready validation
#
# Usage:
#   bash trace/check-template-ready.sh [ROOT] [--full]
#   bash trace/check-template-ready.sh --template-ready=full
#
# Default (CI) scope: templates/, skills/, docs/, README.md
# Full scope: entire repo except .git/
#
# Fails if example values (cheddarfox, bybren-llc GitHub org references) appear
# in the scanned files.

set -euo pipefail

ROOT_ARG="${1:-.}"
FULL_MODE=false

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --full|--template-ready=full)
      FULL_MODE=true
      ;;
    --template-ready)
      # Default scope
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

# Example values that should not appear in template surface
# Note: "bybren-llc" org name in attribution/LICENSE is legitimate; 
# we're checking for placeholder/example values like the cheddarfox GitHub login
EXAMPLE_VALUES=(
  "cheddarfox"
  "@cheddarfox"
)

# Directories to scan based on mode
if [ "$FULL_MODE" = true ]; then
  # Full mode: scan everything except .git/, LICENSE, NOTICE, CITATION.cff
  SCAN_PATHS=()
  while IFS= read -r -d '' file; do
    SCAN_PATHS+=("$file")
  done < <(find "$ROOT" -type f \
    ! -path "$ROOT/.git/*" \
    ! -name "LICENSE" \
    ! -name "NOTICE" \
    ! -name "CITATION.cff" \
    ! -name "check-template-ready.sh" \
    -print0)
else
  # CI scope: templates/, skills/, docs/, README.md
  # Exclude examples/round-table/ and .github/ instance config
  SCAN_PATHS=()
  for dir in templates skills docs; do
    if [ -d "$ROOT/$dir" ]; then
      while IFS= read -r -d '' file; do
        # Skip examples/round-table/ in default scope
        if [[ ! "$file" =~ /examples/round-table/ ]]; then
          SCAN_PATHS+=("$file")
        fi
      done < <(find "$ROOT/$dir" -type f -print0)
    fi
  done
  
  # Add README.md if it exists
  if [ -f "$ROOT/README.md" ]; then
    SCAN_PATHS+=("$ROOT/README.md")
  fi
fi

if [ ${#SCAN_PATHS[@]} -eq 0 ]; then
  echo "⚠ No files found in scan scope"
  echo ""
  echo "✅ Template-ready check passed (no files to scan)"
  exit 0
fi

echo "Scanning ${#SCAN_PATHS[@]} file(s)..."
echo ""

# Scan each file for example values
for file in "${SCAN_PATHS[@]}"; do
  # Skip binary files
  if file "$file" 2>/dev/null | grep -q "text"; then
    for value in "${EXAMPLE_VALUES[@]}"; do
      if grep -l "$value" "$file" >/dev/null 2>&1; then
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
  echo "Template files must not contain example values like 'cheddarfox'."
  echo "Replace example values with placeholders (e.g., '<your-github-login>')."
  echo ""
  exit 1
fi

echo "✅ Template-ready check passed"
exit 0
