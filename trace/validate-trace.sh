#!/usr/bin/env bash
# Trace validation script
# Called by .github/workflows/trace-check.yml
# Implements all owner-identity and decided_by validation logic

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Load owner identity from config (HARD FAIL-CLOSED — never warn-only)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [[ ! -f ".github/harness.yml" ]]; then
  echo "❌ Config file .github/harness.yml not found"
  echo "   This file is required for trace validation."
  exit 1
fi

OWNER_IDENTITY=$(yq -r '.owner_identity' .github/harness.yml 2>/dev/null || echo "")

# Trim leading/trailing whitespace
OWNER_IDENTITY=$(echo "$OWNER_IDENTITY" | xargs)

# Check for null, empty, or whitespace-only
if [[ "$OWNER_IDENTITY" == "null" || -z "$OWNER_IDENTITY" ]]; then
  echo "❌ owner_identity not set or empty in .github/harness.yml"
  echo "   Set owner_identity to the decision authority's full name."
  exit 1
fi

# Validate: single line, no $, backticks, or control characters
if [[ "$OWNER_IDENTITY" =~ $'\n' ]] || \
   [[ "$OWNER_IDENTITY" =~ \$ ]] || \
   [[ "$OWNER_IDENTITY" =~ \` ]] || \
   [[ "$OWNER_IDENTITY" =~ [[:cntrl:]] ]]; then
  echo "❌ owner_identity contains invalid characters (newline, \$, backtick, or control characters)"
  echo "   Must be a single line with no special shell characters."
  exit 1
fi

# Safe output
printf '✓ Loaded owner_identity: %s\n' "$OWNER_IDENTITY"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Bootstrap mode check (rest of trace-check behavior, not owner-check)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

BLOCKING_MODE=false
if [[ -f "spec.md" ]] && grep -qE "REQ-[A-Z]{3}-[0-9]{3}" spec.md && [[ -f "trace/.blocking" ]]; then
  BLOCKING_MODE=true
fi

if [[ ! -f "trace/trace-map.yaml" ]]; then
  echo "❌ trace/trace-map.yaml not found"
  [[ "$BLOCKING_MODE" == "true" ]] && exit 1 || exit 0
fi

# Validate YAML
if ! yq '.' trace/trace-map.yaml > /dev/null 2>&1; then
  echo "❌ Invalid YAML"
  [[ "$BLOCKING_MODE" == "true" ]] && exit 1 || exit 0
fi

REQ_COUNT=$(yq -r '.requirements | length' trace/trace-map.yaml)
[[ "$REQ_COUNT" -eq 0 ]] && exit 0

ERRORS=0
OWNER_CHECK_ERRORS=0

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Check requirements (owner-check HARD FAILS; other checks respect bootstrap)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

for i in $(seq 0 $((REQ_COUNT - 1))); do
  REQ_ID=$(yq -r ".requirements[$i].id" trace/trace-map.yaml)
  REQ_STATE=$(yq -r ".requirements[$i].state" trace/trace-map.yaml)
  
  if [[ "$REQ_STATE" == "Dropped" ]]; then
    SOURCE=$(yq -r ".requirements[$i].source" trace/trace-map.yaml)
    DECIDED_BY=$(yq -r ".requirements[$i].decided_by" trace/trace-map.yaml)
    RATIONALE=$(yq -r ".requirements[$i].rationale" trace/trace-map.yaml)
    
    # Owner-check: HARD FAIL (never warn-only)
    if [[ "$SOURCE" =~ ^intent\.md# ]]; then
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
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  printf 'Owner-check ERRORS: %d\n' "$OWNER_CHECK_ERRORS"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 1
fi

exit 0
