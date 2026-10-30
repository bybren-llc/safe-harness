#!/usr/bin/env bash
# Trace fixture test runner
# Exercises pass/ and fail/ fixtures to validate trace-check behavior

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."
FIXTURES_DIR="$SCRIPT_DIR/fixtures"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Trace Fixture Test Runner"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verify yq is available
if ! command -v yq &> /dev/null; then
  echo "❌ yq not found"
  exit 1
fi

# Save original files
ORIGINAL_TRACE_MAP="$REPO_ROOT/trace/trace-map.yaml"
ORIGINAL_HARNESS_CONFIG="$REPO_ROOT/.github/harness.yml"
BACKUP_TRACE_MAP="$REPO_ROOT/trace/trace-map.yaml.backup"
BACKUP_HARNESS_CONFIG="$REPO_ROOT/.github/harness.yml.backup"

cp "$ORIGINAL_TRACE_MAP" "$BACKUP_TRACE_MAP"
cp "$ORIGINAL_HARNESS_CONFIG" "$BACKUP_HARNESS_CONFIG"

cleanup() {
  echo ""
  echo "Restoring original files..."
  mv "$BACKUP_TRACE_MAP" "$ORIGINAL_TRACE_MAP"
  mv "$BACKUP_HARNESS_CONFIG" "$ORIGINAL_HARNESS_CONFIG"
}

trap cleanup EXIT

PASS_COUNT=0
FAIL_COUNT=0

# Test pass fixtures
echo "Testing PASS fixtures (should succeed):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
for fixture in "$FIXTURES_DIR"/pass/*.yaml; do
  if [[ ! -f "$fixture" ]]; then
    continue
  fi
  
  fixture_name=$(basename "$fixture")
  echo -n "  $fixture_name ... "
  
  # Copy fixture to trace-map.yaml
  cp "$fixture" "$ORIGINAL_TRACE_MAP"
  
  # Run validation script (extracted from workflow)
  if "$SCRIPT_DIR/validate-trace.sh" > /dev/null 2>&1; then
    echo "✓ PASS"
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    echo "❌ FAIL (expected to pass)"
    FAIL_COUNT=$((FAIL_COUNT + 1))
  fi
done

echo ""

# Test fail fixtures
echo "Testing FAIL fixtures (should fail):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test: config-missing
echo -n "  config-missing.yaml ... "
cp "$FIXTURES_DIR/fail/config-missing.yaml" "$ORIGINAL_TRACE_MAP"
rm "$ORIGINAL_HARNESS_CONFIG"
if ! "$SCRIPT_DIR/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$BACKUP_HARNESS_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-empty
echo -n "  owner-identity-empty.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-empty.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: " > "$ORIGINAL_HARNESS_CONFIG"
if ! "$SCRIPT_DIR/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$BACKUP_HARNESS_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: dropped-intent-req-wrong-decider
echo -n "  dropped-intent-req-wrong-decider.yaml ... "
cp "$FIXTURES_DIR/fail/dropped-intent-req-wrong-decider.yaml" "$ORIGINAL_TRACE_MAP"
if ! "$SCRIPT_DIR/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Passed: $PASS_COUNT"
echo "Failed: $FAIL_COUNT"
echo ""

if [[ $FAIL_COUNT -gt 0 ]]; then
  echo "❌ Some tests failed"
  exit 1
else
  echo "✅ All tests passed"
  exit 0
fi
