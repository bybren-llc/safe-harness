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
  if [[ "$name" == "empty-req-ids-cell" ]]; then
    out="$(FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d" 2>&1)" && rc=0 || rc=$?
    printf '%s\n' "$out"
    if [[ "$rc" -eq 0 ]] \
      && grep -Fq 'evidence row' <<<"$out" \
      && ! grep -Fq 'missing exact_head' <<<"$out" \
      && ! grep -Fq 'missing actor' <<<"$out"; then
      echo "→ OK (exit 0; empty req_ids stayed positional)"
      pass_ok=$((pass_ok + 1))
    else
      echo "→ NOT OK (expected exit 0 and no field-shift diagnostics)"
      pass_bad=$((pass_bad + 1))
    fi
  elif FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d"; then
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
  if [[ "$name" == "empty-evidence-cell" ]]; then
    out="$(FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d" 2>&1)" && rc=0 || rc=$?
    printf '%s\n' "$out"
    if [[ "$rc" -ne 0 ]] && grep -Fq 'missing exact_head' <<<"$out"; then
      echo "→ OK (exit 1; missing exact_head)"
      fail_ok=$((fail_ok + 1))
    else
      echo "→ NOT OK (expected exit 1 and 'missing exact_head')"
      fail_bad=$((fail_bad + 1))
    fi
  elif [[ "$name" == "non-utf8-prove" ]]; then
    out="$(FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d" 2>&1)" && rc=0 || rc=$?
    printf '%s\n' "$out"
    if [[ "$rc" -ne 0 ]] \
      && grep -Fq 'prove/latin1.md: evidence-table extractor failed' <<<"$out" \
      && ! grep -Fq 'Trace check passed' <<<"$out"; then
      echo "→ OK (exit 1; extractor named latin1.md; no pass line)"
      fail_ok=$((fail_ok + 1))
    else
      echo "→ NOT OK (expected exit 1, named latin1.md, and no pass line)"
      fail_bad=$((fail_bad + 1))
    fi
  elif [[ "$name" == "empty-actor-req-ids-cell" ]]; then
    out="$(FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d" 2>&1)" && rc=0 || rc=$?
    printf '%s\n' "$out"
    if [[ "$rc" -ne 0 ]] \
      && grep -Fq 'missing actor' <<<"$out" \
      && ! grep -Fq 'missing exact_head' <<<"$out" \
      && ! grep -Fq 'Trace check passed' <<<"$out"; then
      echo "→ OK (exit 1; missing actor only; no pass line)"
      fail_ok=$((fail_ok + 1))
    else
      echo "→ NOT OK (expected exit 1, missing actor only, and no pass line)"
      fail_bad=$((fail_bad + 1))
    fi
  elif FORCE_BLOCKING=1 EVENT_NAME=pull_request bash "$CHECK" "$d"; then
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
echo "WARN-ONLY fail/empty-evidence-cell (no FORCE_BLOCKING)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
WARN_EMPTY_OK=0
out="$(EVENT_NAME=pull_request bash "$CHECK" "$HERE/fail/empty-evidence-cell" 2>&1)" && rc=0 || rc=$?
printf '%s\n' "$out"
if [[ "$rc" -eq 0 ]] && grep -Fq 'missing exact_head' <<<"$out"; then
  echo "→ OK (warn-only exit 0; missing exact_head)"
  WARN_EMPTY_OK=1
else
  echo "→ NOT OK (warn-only should exit 0 and report missing exact_head)"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "WARN-ONLY fail/non-utf8-prove (no FORCE_BLOCKING)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
WARN_UTF8_OK=0
out="$(EVENT_NAME=pull_request bash "$CHECK" "$HERE/fail/non-utf8-prove" 2>&1)" && rc=0 || rc=$?
printf '%s\n' "$out"
if [[ "$rc" -eq 0 ]] \
  && grep -Fq 'prove/latin1.md: evidence-table extractor failed' <<<"$out" \
  && ! grep -Fq 'Trace check passed' <<<"$out"; then
  echo "→ OK (warn-only exit 0; named latin1.md; no pass line)"
  WARN_UTF8_OK=1
else
  echo "→ NOT OK (warn-only should exit 0, name latin1.md, and not print pass)"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Fixture summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "pass: $pass_ok ok, $pass_bad unexpected fail"
echo "fail: $fail_ok ok, $fail_bad unexpected pass"
echo "warn-only still exits 0: $WARN_OK"
echo "warn-only empty-evidence-cell: $WARN_EMPTY_OK"
echo "warn-only non-utf8-prove: $WARN_UTF8_OK"
echo ""

if [[ "$pass_bad" -eq 0 && "$fail_bad" -eq 0 && "$WARN_OK" -eq 1 && "$WARN_EMPTY_OK" -eq 1 && "$WARN_UTF8_OK" -eq 1 ]]; then
  echo "✅ All fixtures behaved as expected"
  exit 0
fi
echo "❌ Fixture suite failed"
exit 1
