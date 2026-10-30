#!/usr/bin/env bash
# Trace validation script — owner-identity and decided_by checks
# Called by trace/check.sh with args: ROOT CONFIG_PATH
# Implements HARD FAIL owner-identity validation (never warn-only)

set -euo pipefail

TRACE_ROOT="${1:-.}"
CONFIG_PATH="${2:-.github/harness.yml}"

if ! cd "$TRACE_ROOT"; then
  echo "❌ cannot cd to TRACE_ROOT: $TRACE_ROOT"
  exit 1
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Load owner identity from config (HARD FAIL-CLOSED — never warn-only)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [[ ! -f "$CONFIG_PATH" ]]; then
  echo "❌ Config file $CONFIG_PATH not found"
  echo "   This file is required for trace validation."
  exit 1
fi

# Check type: must be a string (not true, false, number, list, map, or null)
OWNER_TYPE=$(yq -r '.owner_identity | type' "$CONFIG_PATH" 2>/dev/null || echo "null")
# Accept "string" or "!!str" (different yq versions output different formats)
if [[ "$OWNER_TYPE" != "string" && "$OWNER_TYPE" != "!!str" ]]; then
  echo "❌ owner_identity must be a string, not $OWNER_TYPE"
  echo "   Set owner_identity to a quoted string (e.g., owner_identity: \"Repository Owner\")."
  exit 1
fi

# Get RAW value with sentinel (preserves trailing newlines), then strip yq's formatting newline
OWNER_IDENTITY_RAW=$(yq -r '.owner_identity' "$CONFIG_PATH" 2>/dev/null; printf x)
OWNER_IDENTITY_RAW="${OWNER_IDENTITY_RAW%x}"
OWNER_IDENTITY_RAW="${OWNER_IDENTITY_RAW%$'\n'}"

# Validate RAW value FIRST: reject newlines, $, backticks, control characters
if [[ "$OWNER_IDENTITY_RAW" =~ $'\n' ]] || \
   [[ "$OWNER_IDENTITY_RAW" =~ \$ ]] || \
   [[ "$OWNER_IDENTITY_RAW" =~ \` ]] || \
   [[ "$OWNER_IDENTITY_RAW" =~ [[:cntrl:]] ]]; then
  echo "❌ owner_identity contains invalid characters (newline, \$, backtick, or control characters)"
  echo "   Must be a single line with no special shell characters."
  exit 1
fi

# Pure bash trim (no echo, no xargs, no subshell)
OWNER_IDENTITY="$OWNER_IDENTITY_RAW"
OWNER_IDENTITY="${OWNER_IDENTITY#"${OWNER_IDENTITY%%[![:space:]]*}"}"
OWNER_IDENTITY="${OWNER_IDENTITY%"${OWNER_IDENTITY##*[![:space:]]}"}"

# FAIL if raw value differs from trimmed (reject padded values)
if [[ "$OWNER_IDENTITY_RAW" != "$OWNER_IDENTITY" ]]; then
  echo "❌ owner_identity has leading or trailing whitespace"
  echo "   Remove padding: owner_identity should be exactly \"$OWNER_IDENTITY\"."
  exit 1
fi

# Check for null, empty, or whitespace-only (after trim)
if [[ "$OWNER_IDENTITY" == "null" || -z "$OWNER_IDENTITY" ]]; then
  echo "❌ owner_identity not set or empty in $CONFIG_PATH"
  echo "   Set owner_identity to the decision authority's full name."
  exit 1
fi

# Reject leading hyphen (could be interpreted as echo flag or command option)
if [[ "$OWNER_IDENTITY" =~ ^- ]]; then
  echo "❌ owner_identity cannot start with a hyphen (would be interpreted as a flag)"
  echo "   Names may contain hyphens internally (e.g., 'John Smith-Jones')."
  exit 1
fi

printf '%s\n' "✓ Loaded owner_identity: $OWNER_IDENTITY"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Check requirements (owner-check HARD FAILS; never warn-only)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MAP="trace/trace-map.yaml"

if [[ ! -f "$MAP" ]]; then
  # No trace map yet — owner check is still PASS (nothing to validate)
  exit 0
fi

# Validate YAML and fail closed on parse errors
if ! yq '.' "$MAP" > /dev/null 2>&1; then
  echo "❌ trace-map.yaml is invalid YAML"
  exit 1
fi

# Check for multi-document YAML (fail closed)
# yq outputs one result per document; count lines of a constant expression
DOC_COUNT=$(yq -r '1' "$MAP" 2>/dev/null | wc -l)
if [[ "$DOC_COUNT" -gt 1 ]]; then
  echo "❌ trace-map.yaml contains multiple YAML documents"
  echo "   Only a single YAML document is allowed."
  exit 1
fi

# Validate requirements is a sequence if it exists
if yq -e '.requirements' "$MAP" > /dev/null 2>&1; then
  REQ_TYPE=$(yq -r '.requirements | type' "$MAP" 2>/dev/null || echo "null")
  if [[ "$REQ_TYPE" != "array" && "$REQ_TYPE" != "!!seq" ]]; then
    echo "❌ requirements must be a sequence (array), not $REQ_TYPE"
    exit 1
  fi
fi

# Get requirements count and validate it's a non-negative integer
REQ_COUNT=$(yq -r '.requirements | length' "$MAP" 2>/dev/null || echo "invalid")
if ! [[ "$REQ_COUNT" =~ ^[0-9]+$ ]]; then
  echo "❌ requirements length is not a valid non-negative integer: $REQ_COUNT"
  exit 1
fi
[[ "$REQ_COUNT" -eq 0 ]] && exit 0

OWNER_CHECK_ERRORS=0

for i in $(seq 0 $((REQ_COUNT - 1))); do
  REQ_ID=$(yq -r ".requirements[$i].id" "$MAP")
  REQ_STATE=$(yq -r ".requirements[$i].state" "$MAP")
  
  if [[ "$REQ_STATE" == "Dropped" ]]; then
    SOURCE=$(yq -r ".requirements[$i].source" "$MAP")
    
    # Read decided_by with sentinel (preserves trailing newlines), then strip yq's formatting newline
    DECIDED_BY=$(yq -r ".requirements[$i].decided_by" "$MAP" 2>/dev/null; printf x)
    DECIDED_BY="${DECIDED_BY%x}"
    DECIDED_BY="${DECIDED_BY%$'\n'}"
    
    RATIONALE=$(yq -r ".requirements[$i].rationale" "$MAP")
    
    # Owner-check: HARD FAIL (never warn-only)
    if [[ "$SOURCE" =~ ^intent\.md# ]]; then
      # Exact comparison (no trim on decided_by)
      if [[ "$DECIDED_BY" != "$OWNER_IDENTITY" ]]; then
        printf '❌ %s: decided_by must be exactly: %s\n' "$REQ_ID" "$OWNER_IDENTITY"
        OWNER_CHECK_ERRORS=$((OWNER_CHECK_ERRORS + 1))
      fi
      if [[ ! "$RATIONALE" =~ https?:// ]]; then
        echo "❌ $REQ_ID: rationale must include sign-off link"
        OWNER_CHECK_ERRORS=$((OWNER_CHECK_ERRORS + 1))
      fi
    fi
  fi
done

# Hard fail on owner-check errors (never warn-only, even in bootstrap)
if [[ "$OWNER_CHECK_ERRORS" -gt 0 ]]; then
  echo ""
  printf 'Owner-check ERRORS: %d\n' "$OWNER_CHECK_ERRORS"
  exit 1
fi

exit 0
