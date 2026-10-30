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

# Create temporary config with role-term placeholder
TEMP_CONFIG="$REPO_ROOT/.github/harness.yml.temp"
cat > "$TEMP_CONFIG" << 'EOF'
# safe-harness configuration (test fixture temporary)
owner_identity: "Repository Owner"
EOF

cleanup() {
  echo ""
  echo "Restoring original files..."
  mv "$BACKUP_TRACE_MAP" "$ORIGINAL_TRACE_MAP"
  mv "$BACKUP_HARNESS_CONFIG" "$ORIGINAL_HARNESS_CONFIG"
  rm -f "$TEMP_CONFIG"
}

trap cleanup EXIT

PASS_COUNT=0
FAIL_COUNT=0

# Test pass fixtures (with placeholder config)
echo "Testing PASS fixtures (should succeed):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test with standard placeholder
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"
for fixture in "$FIXTURES_DIR"/pass/dropped-intent-req-valid.yaml; do
  if [[ ! -f "$fixture" ]]; then
    continue
  fi
  
  fixture_name=$(basename "$fixture")
  echo -n "  $fixture_name ... "
  
  cp "$fixture" "$ORIGINAL_TRACE_MAP"
  
  if bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
    echo "✓ PASS"
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    echo "❌ FAIL (expected to pass)"
    FAIL_COUNT=$((FAIL_COUNT + 1))
  fi
done

# Test with special characters (apostrophe, hyphen)
echo -n "  owner-identity-with-special-chars.yaml ... "
echo "owner_identity: \"Repository O'Brien-Smith\"" > "$ORIGINAL_HARNESS_CONFIG"
cp "$FIXTURES_DIR/pass/owner-identity-with-special-chars.yaml" "$ORIGINAL_TRACE_MAP"
if bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ PASS"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ FAIL (expected to pass)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

echo ""

# Test fail fixtures
echo "Testing FAIL fixtures (should fail):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test: config-missing
echo -n "  config-missing.yaml ... "
cp "$FIXTURES_DIR/fail/config-missing.yaml" "$ORIGINAL_TRACE_MAP"
rm "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-empty
echo -n "  owner-identity-empty.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-empty.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: " > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-whitespace
echo -n "  owner-identity-whitespace.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-whitespace.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: \"   \"" > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-null
echo -n "  owner-identity-null.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-null.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: null" > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-key-missing
echo -n "  owner-identity-key-missing.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-key-missing.yaml" "$ORIGINAL_TRACE_MAP"
echo "# Config with missing key" > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: dropped-intent-req-wrong-decider
echo -n "  dropped-intent-req-wrong-decider.yaml ... "
cp "$FIXTURES_DIR/fail/dropped-intent-req-wrong-decider.yaml" "$ORIGINAL_TRACE_MAP"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-echo-flag (leading -n)
echo -n "  owner-identity-echo-flag.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-echo-flag.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: \"-n malicious\"" > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

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
