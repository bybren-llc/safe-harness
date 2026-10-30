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

# Lock directory to prevent concurrent runs
LOCK_DIR="/tmp/trace-test-fixtures-lock"
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "❌ Another test-fixtures.sh is running (lock exists: $LOCK_DIR)"
  exit 1
fi

# Verify yq is available
if ! command -v yq &> /dev/null; then
  echo "❌ yq not found"
  rmdir "$LOCK_DIR"
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

# Track temp directories created by mktemp
TEMP_DIRS=()

cleanup() {
  echo ""
  echo "Restoring original files..."
  mv "$BACKUP_TRACE_MAP" "$ORIGINAL_TRACE_MAP"
  mv "$BACKUP_HARNESS_CONFIG" "$ORIGINAL_HARNESS_CONFIG"
  rm -f "$TEMP_CONFIG"
  # Clean up tracked temp dirs from check.sh regression tests
  for temp_dir in "${TEMP_DIRS[@]}"; do
    if [[ -d "$temp_dir" ]]; then
      rm -rf "$temp_dir"
    fi
  done
  # Release lock
  rmdir "$LOCK_DIR" 2>/dev/null || true
}

trap cleanup EXIT

PASS_COUNT=0
FAIL_COUNT=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Part 1: validate-trace.sh unit tests"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test pass fixtures (with placeholder config)
echo "Testing PASS fixtures (should succeed):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test with standard placeholder
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

fixture="$FIXTURES_DIR/pass/dropped-intent-req-valid.yaml"
if [[ -f "$fixture" ]]; then
  fixture_name=$(basename "$fixture")
  echo -n "  $fixture_name ... "
  
  cp "$fixture" "$ORIGINAL_TRACE_MAP"
  
  if bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
    echo "✓ PASS"
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    echo "❌ FAIL (expected to pass)"
    FAIL_COUNT=$((FAIL_COUNT + 1))
  fi
fi

# Test with special characters (apostrophe, hyphen)
echo -n "  owner-identity-with-special-chars.yaml ... "
echo "owner_identity: \"Repository O'Brien-Smith\"" > "$ORIGINAL_HARNESS_CONFIG"
cp "$FIXTURES_DIR/pass/owner-identity-with-special-chars.yaml" "$ORIGINAL_TRACE_MAP"
if bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
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
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-non-string (boolean true)
echo -n "  owner-identity-non-string.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-non-string.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: true" > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-trailing-newline
echo -n "  owner-identity-trailing-newline.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-trailing-newline.yaml" "$ORIGINAL_TRACE_MAP"
printf '%s\n' 'owner_identity: "Repository Owner\n"' > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: owner-identity-padded (leading/trailing spaces)
echo -n "  owner-identity-padded.yaml ... "
cp "$FIXTURES_DIR/fail/owner-identity-padded.yaml" "$ORIGINAL_TRACE_MAP"
echo "owner_identity: \"  Repository Owner  \"" > "$ORIGINAL_HARNESS_CONFIG"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: trace-map-multi-doc
echo -n "  trace-map-multi-doc.yaml ... "
cp "$FIXTURES_DIR/fail/trace-map-multi-doc.yaml" "$ORIGINAL_TRACE_MAP"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

# Test: requirements-not-a-list
echo -n "  requirements-not-a-list.yaml ... "
cp "$FIXTURES_DIR/fail/requirements-not-a-list.yaml" "$ORIGINAL_TRACE_MAP"
if ! bash "$REPO_ROOT/trace/validate-trace.sh" "$REPO_ROOT" "$ORIGINAL_HARNESS_CONFIG" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi
cp "$TEMP_CONFIG" "$ORIGINAL_HARNESS_CONFIG"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Part 2: check.sh regression tests (hard-fail in warn-only)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Testing that owner-check hard-fails even WITHOUT FORCE_BLOCKING..."
echo ""

# Regression test 1: missing .github/harness.yml
echo -n "  Regression: missing harness.yml (no FORCE_BLOCKING) ... "
TEMP_DIR=$(mktemp -d /tmp/trace-check-test-XXXXXX)
TEMP_DIRS+=("$TEMP_DIR")
mkdir -p "$TEMP_DIR/trace" "$TEMP_DIR/arch"
cat > "$TEMP_DIR/trace/trace-map.yaml" << 'REOF'
requirements: []
evidence: []
REOF
cat > "$TEMP_DIR/arch/components.yaml" << 'REOF'
components:
  - id: ARC-CON
    name: Constitution
REOF
if ! bash "$REPO_ROOT/trace/check.sh" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected, hard-fail even in warn-only)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected hard-fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

# Regression test 2: invalid owner_identity (non-string)
echo -n "  Regression: invalid owner_identity (no FORCE_BLOCKING) ... "
TEMP_DIR=$(mktemp -d /tmp/trace-check-test-XXXXXX)
TEMP_DIRS+=("$TEMP_DIR")
mkdir -p "$TEMP_DIR/trace" "$TEMP_DIR/arch" "$TEMP_DIR/.github"
cat > "$TEMP_DIR/.github/harness.yml" << 'REOF'
owner_identity: 42
REOF
cat > "$TEMP_DIR/trace/trace-map.yaml" << 'REOF'
requirements: []
evidence: []
REOF
cat > "$TEMP_DIR/arch/components.yaml" << 'REOF'
components:
  - id: ARC-CON
    name: Constitution
REOF
if ! bash "$REPO_ROOT/trace/check.sh" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected, hard-fail even in warn-only)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected hard-fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

# Regression test 3: decided_by mismatch
echo -n "  Regression: decided_by mismatch (no FORCE_BLOCKING) ... "
TEMP_DIR=$(mktemp -d /tmp/trace-check-test-XXXXXX)
TEMP_DIRS+=("$TEMP_DIR")
mkdir -p "$TEMP_DIR/trace" "$TEMP_DIR/arch" "$TEMP_DIR/.github"
cat > "$TEMP_DIR/.github/harness.yml" << 'REOF'
owner_identity: "Repository Owner"
REOF
cat > "$TEMP_DIR/intent.md" << 'REOF'
# design-goal
Something
REOF
cat > "$TEMP_DIR/trace/trace-map.yaml" << 'REOF'
requirements:
  - id: REQ-CON-001
    component: ARC-CON
    state: Dropped
    title: Test
    source: intent.md#design-goal
    rationale: Not needed https://example.com/review
    decided_by: Wrong Person
    decided_at: 2026-10-30
evidence: []
REOF
cat > "$TEMP_DIR/arch/components.yaml" << 'REOF'
components:
  - id: ARC-CON
    name: Constitution
REOF
if ! bash "$REPO_ROOT/trace/check.sh" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected, hard-fail even in warn-only)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected hard-fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

# Regression test 4: multi-document trace-map
echo -n "  Regression: multi-doc trace-map (no FORCE_BLOCKING) ... "
TEMP_DIR=$(mktemp -d /tmp/trace-check-test-XXXXXX)
TEMP_DIRS+=("$TEMP_DIR")
mkdir -p "$TEMP_DIR/trace" "$TEMP_DIR/arch" "$TEMP_DIR/.github"
cat > "$TEMP_DIR/.github/harness.yml" << 'REOF'
owner_identity: "Repository Owner"
REOF
cat > "$TEMP_DIR/trace/trace-map.yaml" << 'REOF'
requirements: []
evidence: []
---
extra: document
REOF
cat > "$TEMP_DIR/arch/components.yaml" << 'REOF'
components:
  - id: ARC-CON
    name: Constitution
REOF
if ! bash "$REPO_ROOT/trace/check.sh" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected, hard-fail even in warn-only)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected hard-fail)"
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
