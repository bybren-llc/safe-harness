#!/usr/bin/env bash
# Trace validation script
# Extracted from .github/workflows/trace-check.yml for local testing

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Load owner identity from config (fail-closed)
if [[ ! -f ".github/harness.yml" ]]; then
  echo "❌ Config file .github/harness.yml not found"
  exit 1
fi

OWNER_IDENTITY=$(yq -r '.owner_identity' .github/harness.yml)

if [[ "$OWNER_IDENTITY" == "null" || -z "$OWNER_IDENTITY" ]]; then
  echo "❌ owner_identity not set in .github/harness.yml"
  exit 1
fi

# Bootstrap mode check
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

for i in $(seq 0 $((REQ_COUNT - 1))); do
  REQ_ID=$(yq -r ".requirements[$i].id" trace/trace-map.yaml)
  REQ_STATE=$(yq -r ".requirements[$i].state" trace/trace-map.yaml)
  
  if [[ "$REQ_STATE" == "Dropped" ]]; then
    SOURCE=$(yq -r ".requirements[$i].source" trace/trace-map.yaml)
    DECIDED_BY=$(yq -r ".requirements[$i].decided_by" trace/trace-map.yaml)
    RATIONALE=$(yq -r ".requirements[$i].rationale" trace/trace-map.yaml)
    
    if [[ "$SOURCE" =~ ^intent\.md# ]]; then
      if [[ "$DECIDED_BY" != "$OWNER_IDENTITY" ]]; then
        echo "❌ $REQ_ID: decided_by must be '$OWNER_IDENTITY'"
        ERRORS=$((ERRORS + 1))
      fi
      if [[ ! "$RATIONALE" =~ https?:// ]]; then
        echo "❌ $REQ_ID: rationale must include link"
        ERRORS=$((ERRORS + 1))
      fi
    fi
  fi
done

[[ "$ERRORS" -gt 0 ]] && exit 1 || exit 0
