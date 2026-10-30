#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 ByBren, LLC
# Requirements trace validation (constitution/05).
# Used by .github/workflows/trace-check.yml and trace/fixtures/run.sh.
#
# Usage:
#   bash trace/check.sh [ROOT]
#
# Env:
#   FORCE_BLOCKING=1     treat as blocking (fixtures)
#   BLOCKING_MODE=true   override auto-detect
#   EVENT_NAME           github.event_name (pull_request | push); set via workflow env
#   PR_BODY              PR body; set via workflow env (never interpolate github.event.* in run:)
#
# Exit: 0 on pass, or on errors while warn-only. 1 on errors while blocking.
# yq: mikefarah (CI) or kislyuk (some local images). Wrapper below.

set -euo pipefail

ROOT_ARG="${1:-.}"
if ! ROOT="$(cd "$ROOT_ARG" && pwd)"; then
  echo "❌ cannot cd to ROOT: $ROOT_ARG"
  exit 1
fi
MAP="$ROOT/trace/trace-map.yaml"
COMPONENTS="$ROOT/arch/components.yaml"
SPEC="$ROOT/spec.md"
INTENT="$ROOT/intent.md"
REQ_DIR="$ROOT/requirements"
PROVE_DIR="$ROOT/prove"

ERRORS=0
WARNINGS=0

error() {
  echo "  ❌ $1"
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "  ⚠ $1"
  WARNINGS=$((WARNINGS + 1))
}

ok() {
  echo "  ✓ $1"
}

is_missing() {
  local v="${1:-}"
  [[ -z "$v" || "$v" == "null" || "$v" == "~" || "$v" == "TBD" || "$v" == "#TBD" ]]
}

req_id_ok() {
  [[ "${1:-}" =~ ^REQ-[A-Z]{3}-[0-9]{3}$ ]]
}

# --- yq wrapper (mikefarah `yq eval` vs kislyuk `yq -r`) ---
YQ_FLAVOR=""
detect_yq() {
  if ! command -v yq >/dev/null 2>&1; then
    echo "❌ yq not found"
    exit 1
  fi
  if yq --help 2>&1 | grep -q 'mikefarah'; then
    YQ_FLAVOR=mikefarah
  elif yq eval --help >/dev/null 2>&1 && yq --help 2>&1 | grep -qE 'yq eval|eval '; then
    YQ_FLAVOR=mikefarah
  else
    YQ_FLAVOR=kislyuk
  fi
}

yq_eval() {
  local expr="$1"
  local file="$2"
  if [[ "$YQ_FLAVOR" == "mikefarah" ]]; then
    yq eval "$expr" "$file"
  else
    yq -r "$expr" "$file"
  fi
}

yq_str() {
  yq_eval "$1" "$2" 2>/dev/null | sed -n '1p' | tr -d '\r' || true
}

detect_yq

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Requirements Trace Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Root: $ROOT"
echo "yq: $YQ_FLAVOR ($(yq --version 2>&1 | head -n 1))"
echo ""

# --- blocking vs warn-only ---
BLOCKING_MODE="${BLOCKING_MODE:-false}"
if [[ "${FORCE_BLOCKING:-}" == "1" || "${FORCE_BLOCKING:-}" == "true" ]]; then
  BLOCKING_MODE=true
  echo "✓ FORCE_BLOCKING — trace-check is BLOCKING (fixture or override)"
elif [[ "$BLOCKING_MODE" == "true" ]]; then
  echo "✓ BLOCKING_MODE=true — trace-check is BLOCKING"
elif [[ -f "$SPEC" ]] && grep -qE "REQ-[A-Z]{3}-[0-9]{3}" "$SPEC" && [[ -f "$ROOT/trace/.blocking" ]]; then
  echo "✓ spec.md contains REQ IDs AND trace/.blocking exists — trace-check is BLOCKING"
  BLOCKING_MODE=true
elif [[ -f "$SPEC" ]] && grep -qE "REQ-[A-Z]{3}-[0-9]{3}" "$SPEC"; then
  echo "⚠ Bootstrap mode: spec.md has REQ IDs but trace/.blocking missing — trace-check is WARN-ONLY"
elif [[ -f "$SPEC" ]]; then
  echo "⚠ Bootstrap mode: spec.md exists but has no REQ IDs — trace-check is WARN-ONLY"
else
  echo "⚠ spec.md not found — trace-check is WARN-ONLY"
fi
echo ""

# --- trace map present + YAML ---
echo "Checking trace map: $MAP"
echo ""

if [[ ! -f "$MAP" ]]; then
  error "trace/trace-map.yaml not found"
  if [[ "$BLOCKING_MODE" == "true" ]]; then
    echo "❌ BLOCKING MODE: Trace check failed"
    exit 1
  fi
  echo "⚠ WARN-ONLY: continuing (bootstrap mode)"
  exit 0
fi

if ! yq_eval '.' "$MAP" >/dev/null 2>&1; then
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "❌ Invalid YAML FAILED (hard fail, even in warn-only mode)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "trace/trace-map.yaml has invalid YAML syntax"
  exit 1
fi

# Multi-document guard: hard-fail even in warn-only mode
DOC_COUNT=$(yq -r '1' "$MAP" 2>/dev/null | wc -l)
if [[ "$DOC_COUNT" -gt 1 ]]; then
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "❌ Multi-document trace-map FAILED (hard fail, even in warn-only mode)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "trace-map.yaml contains multiple YAML documents."
  echo "Only a single YAML document is allowed."
  exit 1
fi

ok "trace/trace-map.yaml is valid YAML"
echo ""

# --- Owner identity check (hard fail, even in warn-only mode) ---
# Calls validate-trace.sh which handles:
# - Loading owner_identity from .github/harness.yml
# - Validating it (safe characters, not empty)
# - Checking decided_by on Dropped intent-sourced requirements
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Running owner-identity validation..."
if ! bash "$SCRIPT_DIR/validate-trace.sh" "$ROOT" "$ROOT/.github/harness.yml"; then
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "❌ Owner-identity check FAILED (hard fail, even in warn-only mode)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 1
fi
echo ""

REQ_COUNT=$(yq_str '.requirements | length' "$MAP")
if ! [[ "$REQ_COUNT" =~ ^[0-9]+$ ]]; then
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "❌ Invalid requirements count FAILED (hard fail)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "requirements length is not a valid non-negative integer: $REQ_COUNT"
  exit 1
fi
echo "Found $REQ_COUNT requirements"
echo ""

# Empty trace map in blocking mode
if [[ "$REQ_COUNT" -eq 0 ]]; then
  if [[ "$BLOCKING_MODE" == "true" ]]; then
    error "Empty trace map in blocking mode"
  else
    echo "⚠ No requirements defined yet — empty-map rule skipped (warn-only)"
  fi
fi

# --- arch/components.yaml: missing is ERROR ---
if [[ ! -f "$COMPONENTS" ]]; then
  error "arch/components.yaml not found"
  HAS_COMPONENTS=false
else
  if ! yq_eval '.' "$COMPONENTS" >/dev/null 2>&1; then
    error "arch/components.yaml has invalid YAML syntax"
    HAS_COMPONENTS=false
  else
    HAS_COMPONENTS=true
    ok "arch/components.yaml is present"
  fi
fi
echo ""

# --- per-requirement checks (existing + component ERROR) ---
if [[ "$REQ_COUNT" -gt 0 ]]; then
  for i in $(seq 0 $((REQ_COUNT - 1))); do
    REQ_ID=$(yq_str ".requirements[$i].id" "$MAP")
    REQ_STATE=$(yq_str ".requirements[$i].state" "$MAP")
    REQ_COMPONENT=$(yq_str ".requirements[$i].component" "$MAP")

    echo "Checking $REQ_ID (state: $REQ_STATE, component: $REQ_COMPONENT)"

    if ! req_id_ok "$REQ_ID"; then
      error "Malformed requirement id: $REQ_ID (expected REQ-[A-Z]{3}-[0-9]{3})"
    fi

    if [[ "$REQ_STATE" != "Placed" && "$REQ_STATE" != "Deferred" && "$REQ_STATE" != "Dropped" && "$REQ_STATE" != "Missing" ]]; then
      error "Invalid state: $REQ_STATE (must be Placed/Deferred/Dropped/Missing)"
    fi

    if [[ "$REQ_STATE" == "Missing" ]]; then
      error "Requirement in Missing state (must be defined)"
    fi

    if [[ "$REQ_STATE" == "Placed" ]]; then
      SOURCE=$(yq_str ".requirements[$i].source" "$MAP")
      EXIT_CRIT=$(yq_str ".requirements[$i].exit_criterion" "$MAP")
      METRIC=$(yq_str ".requirements[$i].metric" "$MAP")

      if is_missing "$SOURCE"; then
        error "Missing required field: source"
      fi
      if is_missing "$EXIT_CRIT"; then
        error "Missing required field: exit_criterion"
      fi
      if is_missing "$METRIC"; then
        error "Missing required field: metric"
      fi

      EVIDENCE_COUNT=$(yq_str '.evidence | length' "$MAP")
      if ! [[ "$EVIDENCE_COUNT" =~ ^[0-9]+$ ]]; then
        EVIDENCE_COUNT=0
      fi
      HAS_EVIDENCE=false
      HAS_ISSUE=false

      if [[ "$EVIDENCE_COUNT" -gt 0 ]]; then
        for j in $(seq 0 $((EVIDENCE_COUNT - 1))); do
          EV_ID=$(yq_str ".evidence[$j].evidence_id" "$MAP")
          EV_HEAD=$(yq_str ".evidence[$j].exact_head" "$MAP")
          EV_ACTOR=$(yq_str ".evidence[$j].actor" "$MAP")
          EV_GATE=$(yq_str ".evidence[$j].gate" "$MAP")
          EV_ISSUE=$(yq_str ".evidence[$j].issue" "$MAP")

          if is_missing "$EV_ID" || is_missing "$EV_HEAD" || is_missing "$EV_ACTOR" || is_missing "$EV_GATE"; then
            warn "Evidence row $j missing required fields (evidence_id, exact_head, actor, gate); skipping"
            continue
          fi

          REQ_IDS=$(yq_eval ".evidence[$j].req_ids[]" "$MAP" 2>/dev/null || true)
          if ! req_id_ok "$REQ_ID"; then
            :
          elif printf '%s\n' "$REQ_IDS" | grep -Fxq -- "$REQ_ID"; then
            HAS_EVIDENCE=true
            if ! is_missing "$EV_ISSUE" && [[ "$EV_ISSUE" =~ ^#[0-9]+$ ]]; then
              HAS_ISSUE=true
            fi
          fi
        done
      fi

      if [[ "$HAS_EVIDENCE" == "false" ]]; then
        error "No evidence row references $REQ_ID via req_ids"
      else
        ok "Evidence linked"
        if [[ "$HAS_ISSUE" == "false" ]]; then
          error "REQ $REQ_ID has no GitHub Issue reference on a linked evidence row (issue: #N)"
        fi
      fi
    fi

    if [[ "$REQ_STATE" == "Deferred" ]]; then
      RATIONALE=$(yq_str ".requirements[$i].rationale" "$MAP")
      DECIDED_BY=$(yq_str ".requirements[$i].decided_by" "$MAP")
      DECIDED_AT=$(yq_str ".requirements[$i].decided_at" "$MAP")
      DEFER_TO=$(yq_str ".requirements[$i].defer_to" "$MAP")

      if is_missing "$RATIONALE"; then
        error "Missing required field: rationale"
      fi
      if is_missing "$DECIDED_BY"; then
        error "Missing required field: decided_by"
      fi
      if is_missing "$DECIDED_AT"; then
        error "Missing required field: decided_at"
      fi
      if is_missing "$DEFER_TO"; then
        error "Missing required field: defer_to"
      fi
    fi

    if [[ "$REQ_STATE" == "Dropped" ]]; then
      RATIONALE=$(yq_str ".requirements[$i].rationale" "$MAP")
      DECIDED_BY=$(yq_str ".requirements[$i].decided_by" "$MAP")
      DECIDED_AT=$(yq_str ".requirements[$i].decided_at" "$MAP")

      if is_missing "$RATIONALE"; then
        error "Missing required field: rationale"
      fi
      if is_missing "$DECIDED_BY"; then
        error "Missing required field: decided_by"
      fi
      if is_missing "$DECIDED_AT"; then
        error "Missing required field: decided_at"
      fi

      # Owner-check for intent-sourced drops is handled by validate-trace.sh
      # (called earlier in this script via SCRIPT_DIR/validate-trace.sh)
    fi

    if [[ "$HAS_COMPONENTS" == "true" ]]; then
      if ! is_missing "$REQ_COMPONENT"; then
        if ! yq_eval '.components[].id' "$COMPONENTS" 2>/dev/null | grep -Fxq -- "$REQ_COMPONENT"; then
          error "Component $REQ_COMPONENT not found in arch/components.yaml"
        fi
      fi
    fi

    echo ""
  done
fi

# --- Spec REQ ↔ trace-map reconciliation ---
echo "Spec REQ ↔ trace-map reconciliation"
echo ""

SPEC_REQS=""
if [[ -f "$SPEC" ]]; then
  SPEC_REQS=$(grep -oE 'REQ-[A-Z]{3}-[0-9]{3}' "$SPEC" 2>/dev/null | sort -u || true)
fi

MAP_REQS=""
if [[ "$REQ_COUNT" -gt 0 ]]; then
  MAP_REQS=$(yq_eval '.requirements[].id' "$MAP" 2>/dev/null | sort -u || true)
fi

if [[ -n "$SPEC_REQS" ]]; then
  while IFS= read -r sid; do
    if [[ -z "$sid" ]]; then
      continue
    fi
    if ! req_id_ok "$sid"; then
      error "Malformed spec REQ id: $sid (expected REQ-[A-Z]{3}-[0-9]{3})"
    elif ! printf '%s\n' "$MAP_REQS" | grep -Fxq -- "$sid"; then
      error "Spec REQ $sid is not in the trace map"
    fi
  done <<< "$SPEC_REQS"
else
  echo "  (no REQ IDs in spec.md)"
fi

if [[ "$REQ_COUNT" -gt 0 ]]; then
  for i in $(seq 0 $((REQ_COUNT - 1))); do
    REQ_ID=$(yq_str ".requirements[$i].id" "$MAP")
    SOURCE=$(yq_str ".requirements[$i].source" "$MAP")
    if [[ "$SOURCE" =~ ^spec\.md ]]; then
      if [[ -z "$SPEC_REQS" ]] || ! printf '%s\n' "$SPEC_REQS" | grep -Fxq -- "$REQ_ID"; then
        error "Trace-map $REQ_ID has source $SOURCE but that ID is not in spec.md"
      fi
    fi
  done
fi
echo ""

# --- source-anchor validation ---
echo "Source-anchor validation"
echo ""

anchor_exists() {
  local file="$1"
  local anchor="$2"
  python3 - "$file" "$anchor" <<'PY'
import re, sys
path, anchor = sys.argv[1], sys.argv[2]
try:
    text = open(path, encoding="utf-8").read()
except OSError:
    sys.exit(2)
if re.search(r"\{#" + re.escape(anchor) + r"\}", text):
    sys.exit(0)
for m in re.finditer(r"^(#{1,6})\s+(.+?)\s*$", text, re.M):
    title = re.sub(r"\s*\{#.*\}\s*$", "", m.group(2))
    slug = title.strip().lower()
    slug = re.sub(r"[^\w\s-]", "", slug, flags=re.U)
    slug = re.sub(r"[-\s]+", "-", slug).strip("-")
    if slug == anchor:
        sys.exit(0)
sys.exit(1)
PY
}

if [[ "$REQ_COUNT" -gt 0 ]]; then
  for i in $(seq 0 $((REQ_COUNT - 1))); do
    REQ_ID=$(yq_str ".requirements[$i].id" "$MAP")
    SOURCE=$(yq_str ".requirements[$i].source" "$MAP")
    if is_missing "$SOURCE"; then
      continue
    fi
    if [[ "$SOURCE" =~ ^(spec|intent)\.md$ ]]; then
      error "$REQ_ID source $SOURCE is missing an anchor (#...)"
      continue
    fi
    if [[ "$SOURCE" =~ ^(spec|intent)\.md#(.+)$ ]]; then
      src_file="${BASH_REMATCH[1]}.md"
      src_anchor="${BASH_REMATCH[2]}"
      src_path="$ROOT/$src_file"
      if [[ ! -f "$src_path" ]]; then
        error "$REQ_ID source file $src_file not found"
        continue
      fi
      if ! anchor_exists "$src_path" "$src_anchor"; then
        error "$REQ_ID source anchor $src_file#$src_anchor does not exist"
      else
        ok "$REQ_ID source $src_file#$src_anchor"
      fi
    fi
  done
else
  echo "  (no requirements to check)"
fi
echo ""

# --- requirements/*.yaml registry ---
echo "requirements/*.yaml registry validation"
echo ""

REG_COUNT=0
if [[ -d "$REQ_DIR" ]]; then
  shopt -s nullglob
  for rf in "$REQ_DIR"/REQ-[A-Z][A-Z][A-Z]-[0-9][0-9][0-9].yaml; do
    REG_COUNT=$((REG_COUNT + 1))
    base="$(basename "$rf" .yaml)"
    echo "  Registry file $base.yaml"
    if ! yq_eval '.' "$rf" >/dev/null 2>&1; then
      error "Invalid YAML: $base.yaml"
      continue
    fi
    RID=$(yq_str '.id' "$rf")
    RSTATE=$(yq_str '.state' "$rf")
    RCOMP=$(yq_str '.component' "$rf")
    RTITLE=$(yq_str '.title' "$rf")
    RSOURCE=$(yq_str '.source' "$rf")
    if [[ "$RID" != "$base" ]]; then
      error "$base.yaml id '$RID' does not match filename"
    fi
    if is_missing "$RCOMP"; then
      error "$base.yaml missing component"
    fi
    if is_missing "$RTITLE"; then
      error "$base.yaml missing title"
    fi
    if is_missing "$RSOURCE"; then
      error "$base.yaml missing source"
    fi
    if [[ "$RSTATE" != "Placed" && "$RSTATE" != "Deferred" && "$RSTATE" != "Dropped" && "$RSTATE" != "Missing" ]]; then
      error "$base.yaml invalid state: $RSTATE"
    fi
    if [[ "$RSTATE" == "Placed" ]]; then
      if is_missing "$(yq_str '.exit_criterion' "$rf")"; then
        error "$base.yaml Placed missing exit_criterion"
      fi
      if is_missing "$(yq_str '.metric' "$rf")"; then
        error "$base.yaml Placed missing metric"
      fi
    fi
    if [[ "$RSTATE" == "Deferred" ]]; then
      for fld in rationale decided_by decided_at defer_to; do
        if is_missing "$(yq_str ".$fld" "$rf")"; then
          error "$base.yaml Deferred missing $fld"
        fi
      done
    fi
    if [[ "$RSTATE" == "Dropped" ]]; then
      for fld in rationale decided_by decided_at; do
        if is_missing "$(yq_str ".$fld" "$rf")"; then
          error "$base.yaml Dropped missing $fld"
        fi
      done
    fi
    if ! req_id_ok "$RID"; then
      error "$base.yaml id $RID is malformed (expected REQ-[A-Z]{3}-[0-9]{3})"
    elif [[ -z "$MAP_REQS" ]] || ! printf '%s\n' "$MAP_REQS" | grep -Fxq -- "$RID"; then
      error "$base.yaml id $RID is not in the trace map"
    else
      # state must match map
      map_state=""
      for i in $(seq 0 $((REQ_COUNT - 1))); do
        if [[ "$(yq_str ".requirements[$i].id" "$MAP")" == "$RID" ]]; then
          map_state=$(yq_str ".requirements[$i].state" "$MAP")
          break
        fi
      done
      if [[ -n "$map_state" && "$map_state" != "$RSTATE" ]]; then
        error "$base.yaml state $RSTATE does not match trace map ($map_state)"
      fi
    fi
  done
  shopt -u nullglob
fi

if [[ "$REG_COUNT" -eq 0 ]]; then
  echo "  (no REQ-*.yaml registry files; template-only is OK)"
fi
echo ""

# --- Issue + PR Requirements: linkage ---
echo "Issue + PR Requirements: linkage"
echo ""

PR_TEXT="${PR_BODY:-}"
if [[ -z "$PR_TEXT" && -f "$ROOT/.pr-body" ]]; then
  PR_TEXT="$(cat "$ROOT/.pr-body")"
fi

HAS_PLACED=false
if [[ "$REQ_COUNT" -gt 0 ]]; then
  for i in $(seq 0 $((REQ_COUNT - 1))); do
    if [[ "$(yq_str ".requirements[$i].state" "$MAP")" == "Placed" ]]; then
      HAS_PLACED=true
      break
    fi
  done
fi

SPEC_HAS_REQS=false
if [[ -n "$SPEC_REQS" ]]; then
  SPEC_HAS_REQS=true
fi

REQ_LINE_REQUIRED=false
if [[ "$HAS_PLACED" == "true" || "$SPEC_HAS_REQS" == "true" ]]; then
  REQ_LINE_REQUIRED=true
fi

EVENT_NAME="${EVENT_NAME:-}"
if [[ "$REQ_LINE_REQUIRED" == "true" ]]; then
  if [[ "$EVENT_NAME" == "push" && -z "$PR_TEXT" ]]; then
    warn "PR body not available on push; skipping Requirements: linkage"
  elif [[ -z "$PR_TEXT" && "$EVENT_NAME" != "pull_request" && ! -f "$ROOT/.pr-body" ]]; then
    warn "PR body not available; skipping Requirements: linkage"
  else
    REQ_LINE="$(printf '%s\n' "$PR_TEXT" | grep -iE '^[[:space:]]*Requirements:[[:space:]]*' | head -n 1 || true)"
    if [[ -z "$REQ_LINE" ]]; then
      error "PR is missing a Requirements: line"
    else
      REST="$(printf '%s\n' "$REQ_LINE" | sed -E 's/^[[:space:]]*[Rr]equirements:[[:space:]]*//')"
      REST="$(printf '%s' "$REST" | tr -d '\r' | sed 's/[[:space:]]*$//')"
      if [[ "$REST" == "N/A" || "$REST" == "n/a" ]]; then
        ok "Requirements: N/A"
      else
        FOUND_IDS=$(printf '%s\n' "$REST" | grep -oE 'REQ-[A-Z]{3}-[0-9]{3}' || true)
        if [[ -z "$FOUND_IDS" ]]; then
          error "Requirements: line has neither N/A nor REQ IDs"
        else
          while IFS= read -r pid; do
            if [[ -z "$pid" ]]; then
              continue
            fi
            if [[ -z "$MAP_REQS" ]] || ! printf '%s\n' "$MAP_REQS" | grep -Fxq -- "$pid"; then
              error "Requirements: lists $pid which is not in the trace map"
            fi
          done <<< "$FOUND_IDS"
          ok "Requirements: line present"
        fi
      fi
    fi
  fi
else
  echo "  (Requirements: line not required — no Placed REQs and no spec REQ IDs)"
fi
echo ""

# --- Evidence rows from bolt briefs / decision packs ---
echo "Evidence rows from bolt briefs / decision packs"
echo ""

if [[ -d "$PROVE_DIR" ]]; then
  tmp="$(mktemp)"
  trap 'rm -f "$tmp"' EXIT
  extractor_rc=0
  python3 - "$PROVE_DIR" <<'PY' > "$tmp" || extractor_rc=$?
import os, re, sys
prove = sys.argv[1]
sep_re = re.compile(r"^:?-+:?$")
SENT = "."

def emit(*fields):
    print("\x1f".join(fields + (SENT,)))

def cells(line):
    line = line.strip()
    if line.startswith("|"):
        line = line[1:]
    if line.endswith("|"):
        line = line[:-1]
    return [c.strip() for c in line.split("|")]

def flush(path, header, rows):
    idx = {h.lower(): i for i, h in enumerate(header)}
    if "evidence_id" not in idx:
        return
    if "req_ids" not in idx:
        return  # Wave 0 tables (linear_issue, no req_ids)
    for n, row in rows:
        def col(name):
            i = idx.get(name)
            if i is None or i >= len(row):
                return ""
            return row[i]
        ev = col("evidence_id")
        head = col("exact_head")
        actor = col("actor")
        gate = col("gate")
        issue = col("issue")
        reqs = col("req_ids")
        emit("ROW", path, str(n), ev, head, actor, gate, issue, reqs)

for dirpath, _, files in os.walk(prove):
    for fn in files:
        if not fn.endswith(".md"):
            continue
        path = os.path.join(dirpath, fn)
        rel = os.path.relpath(path, prove)
        try:
            lines = open(path, encoding="utf-8").read().splitlines()
            header = None
            rows = []
            start = 0
            for i, line in enumerate(lines, 1):
                if "|" not in line:
                    if header is not None:
                        flush(rel, header, rows)
                    header = None
                    rows = []
                    continue
                cols = cells(line)
                if header is None:
                    header = cols
                    start = i
                    rows = []
                    continue
                if all(sep_re.match(c.replace(" ", "")) for c in cols if c):
                    continue
                rows.append((i, cols))
            if header is not None:
                flush(rel, header, rows)
        except Exception as e:
            msg = f"{type(e).__name__}: {e}".replace("\x1f", " ").replace("\n", " ")
            emit("ERR", rel, msg)
PY

  if [[ "$extractor_rc" -ne 0 ]]; then
    if ! command -v python3 >/dev/null 2>&1; then
      error "evidence-table extractor failed: python3 not found"
    else
      error "evidence-table extractor failed (exit $extractor_rc); prove/ rows not fully validated"
    fi
  fi

  if [[ -s "$tmp" ]]; then
    while IFS=$'\x1f' read -r kind rel lineno ev head actor gate issue reqs sent || [[ -n "${kind:-}" ]]; do
      if [[ "${kind:-}" == "ERR" ]]; then
        error "prove/${rel:-}: evidence-table extractor failed: ${lineno:-}"
        continue
      fi
      if [[ "${kind:-}" != "ROW" ]]; then
        error "evidence-table extractor returned a malformed record"
        continue
      fi
      echo "  prove/${rel:-}:$lineno"
      row_err=0
      if is_missing "${ev:-}"; then
        error "prove/${rel:-}:${lineno:-} missing evidence_id"
        row_err=1
      fi
      if is_missing "${head:-}"; then
        error "prove/${rel:-}:${lineno:-} missing exact_head"
        row_err=1
      fi
      if is_missing "${actor:-}"; then
        error "prove/${rel:-}:${lineno:-} missing actor"
        row_err=1
      fi
      if is_missing "${gate:-}"; then
        error "prove/${rel:-}:${lineno:-} missing gate"
        row_err=1
      fi
      if [[ -n "${reqs:-}" ]]; then
        while IFS= read -r pid; do
          if [[ -z "$pid" ]]; then
            continue
          fi
          if [[ -z "$MAP_REQS" ]] || ! printf '%s\n' "$MAP_REQS" | grep -Fxq -- "$pid"; then
            error "prove/${rel:-}:${lineno:-} req_ids lists $pid which is not in the trace map"
            row_err=1
          fi
        done < <(printf '%s\n' "$reqs" | grep -oE 'REQ-[A-Z]{3}-[0-9]{3}' || true)
      fi
      if [[ "$row_err" -eq 0 ]]; then
        ok "prove/${rel:-}:${lineno:-} evidence row"
      fi
    done < "$tmp"
  elif [[ "$extractor_rc" -eq 0 ]]; then
    echo "  (no Wave 1 evidence tables with req_ids under prove/)"
  fi
else
  echo "  (no prove/ directory)"
fi
echo ""

# --- Summary ---
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Requirements checked: $REQ_COUNT"
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [[ "$ERRORS" -gt 0 ]]; then
  if [[ "$BLOCKING_MODE" == "true" ]]; then
    echo "❌ BLOCKING MODE: Trace check failed"
    exit 1
  fi
  echo "⚠ WARN-ONLY MODE: Errors detected but not blocking"
  echo "Trace check becomes blocking after spec.md has REQ IDs AND trace/.blocking exists"
  exit 0
fi

echo "✅ Trace check passed"
exit 0
