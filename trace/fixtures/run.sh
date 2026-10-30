#!/usr/bin/env bash
# Run trace-check fixtures. See trace/fixtures/README.md.
set -u
set -o pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
CHECK="$ROOT/trace/check.sh"

pass_ok=0
pass_bad=0
fail_ok=0
fail_bad=0

echo "Checker: $CHECK"
echo ""

for d in "$HERE"/pass/*; do
  [[ -d "$d" ]] || continue
  name="$(basename "$d")"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "PASS $name (FORCE_BLOCKING=1)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  if FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d"; then
    echo "→ OK (exit 0)"
    pass_ok=$((pass_ok + 1))
  else
    echo "→ NOT OK (expected exit 0)"
    pass_bad=$((pass_bad + 1))
  fi
  echo ""
done

for d in "$HERE"/fail/*; do
  [[ -d "$d" ]] || continue
  name="$(basename "$d")"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "FAIL $name (FORCE_BLOCKING=1)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  if FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d"; then
    echo "→ NOT OK (expected exit 1)"
    fail_bad=$((fail_bad + 1))
  else
    echo "→ OK (exit 1)"
    fail_ok=$((fail_ok + 1))
  fi
  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "WARN-ONLY fail/missing-components (no FORCE_BLOCKING)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
WARN_OK=0
if EVENT_NAME=pull_request bash "$CHECK" "$HERE/fail/missing-components"; then
  echo "→ OK (warn-only exit 0)"
  WARN_OK=1
else
  echo "→ NOT OK (warn-only should exit 0)"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Fixture summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "pass: $pass_ok ok, $pass_bad unexpected fail"
echo "fail: $fail_ok ok, $fail_bad unexpected pass"
echo "warn-only still exits 0: $WARN_OK"
echo ""

if [[ "$pass_bad" -eq 0 && "$fail_bad" -eq 0 && "$WARN_OK" -eq 1 ]]; then
  echo "✅ All fixtures behaved as expected"
  exit 0
fi
echo "❌ Fixture suite failed"
exit 1
