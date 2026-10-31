#!/usr/bin/env bash
# Test the conflict marker checker with fixtures

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."
CHECK_SCRIPT="$SCRIPT_DIR/check-conflict-markers.sh"
FIXTURES_DIR="$REPO_ROOT/trace/fixtures"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Conflict Markers Check Test Suite"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

PASS_COUNT=0
FAIL_COUNT=0

# Test 1: PASS fixture (legitimate markdown equals signs)
echo "Test 1: Legitimate markdown heading underlines (should PASS)"
echo -n "  conflict-markers-pass.md ... "

# Create a temporary git repo for testing
TEMP_DIR=$(mktemp -d /tmp/conflict-test-pass-XXXXXX)
cd "$TEMP_DIR"
git init -q
cp "$FIXTURES_DIR/conflict-markers-pass.md" .
git add conflict-markers-pass.md
git config user.email "test@example.com"
git config user.name "Test User"
git commit -q -m "Add pass fixture"

if bash "$CHECK_SCRIPT" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ PASS"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ FAIL (expected to pass)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

cd - > /dev/null
rm -rf "$TEMP_DIR"

# Test 2: FAIL fixture (actual conflict markers)
echo ""
echo "Test 2: Actual merge conflict markers (should FAIL)"
echo -n "  conflict-markers-fail.md ... "

TEMP_DIR=$(mktemp -d /tmp/conflict-test-fail-XXXXXX)
cd "$TEMP_DIR"
git init -q
cp "$FIXTURES_DIR/conflict-markers-fail.md" .
git add conflict-markers-fail.md
git config user.email "test@example.com"
git config user.name "Test User"
git commit -q -m "Add fail fixture"

if ! bash "$CHECK_SCRIPT" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

cd - > /dev/null
rm -rf "$TEMP_DIR"

# Test 3: Hidden file with conflict markers (should FAIL)
echo ""
echo "Test 3: Hidden file with conflict markers (should FAIL)"
echo -n "  conflict-markers-hidden.md ... "

TEMP_DIR=$(mktemp -d /tmp/conflict-test-hidden-XXXXXX)
cd "$TEMP_DIR"
git init -q

# Generate conflict markers at runtime to avoid literal markers in this script
MARKER_START=$(printf '%s' "<<<<<<< HEAD")
MARKER_SEP=$(printf '%s' "=======")
MARKER_END=$(printf '%s' ">>>>>>> branch-name")

cat > conflict-markers-hidden.md << MARKER_EOF
# Hidden file test

This file has conflict markers and should fail.

${MARKER_START}
Content from HEAD
${MARKER_SEP}
Content from branch
${MARKER_END}

This should be detected.
MARKER_EOF

git add conflict-markers-hidden.md
git config user.email "test@example.com"
git config user.name "Test User"
git commit -q -m "Add hidden file with markers"

if ! bash "$CHECK_SCRIPT" "$TEMP_DIR" > /dev/null 2>&1; then
  echo "✓ FAIL (as expected)"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  echo "❌ PASS (expected to fail)"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

cd - > /dev/null
rm -rf "$TEMP_DIR"

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
