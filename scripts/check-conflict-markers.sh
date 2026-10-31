#!/usr/bin/env bash
# Check for leftover merge conflict markers in tracked files
# Must FAIL when conflict markers are present
# Must PASS when only legitimate markdown heading underlines exist

set -euo pipefail

REPO_ROOT="${1:-.}"

echo "Checking for merge conflict markers in tracked files..."
echo ""

# Track whether we found markers in context (between <<<<<<< and >>>>>>>)
found_conflict_markers=0

# Get all tracked files (NUL-delimited; a git failure exits non-zero under set -e)
list_file=$(mktemp)
trap 'rm -f "$list_file"' EXIT
git -C "$REPO_ROOT" ls-files -z > "$list_file"

while IFS= read -r -d '' file; do
  filepath="$REPO_ROOT/$file"
  
  # Skip only the exact test fixture file
  if [[ "$file" == "trace/fixtures/conflict-markers-fail.md" ]]; then
    continue
  fi
  
  # Skip if file doesn't exist (shouldn't happen with git ls-files, but safe)
  if [[ ! -f "$filepath" ]]; then
    continue
  fi
  
  # Look for <<<<<<< markers (conflict start)
  if grep -n "^<<<<<<< " "$filepath" 2>/dev/null; then
    echo "❌ Found conflict start marker in: $file"
    found_conflict_markers=1
  fi
  
  # Look for >>>>>>> markers (conflict end)
  if grep -n "^>>>>>>> " "$filepath" 2>/dev/null; then
    echo "❌ Found conflict end marker in: $file"
    found_conflict_markers=1
  fi
  
  # Check for ======= lines that appear between conflict markers
  # This is more complex: we need to verify it's actually part of a conflict block
  # For now, we check if ======= appears on its own line AND we have both < and > markers
  if grep -q "^<<<<<<< " "$filepath" 2>/dev/null && \
     grep -q "^>>>>>>> " "$filepath" 2>/dev/null && \
     grep -n "^=======$" "$filepath" 2>/dev/null; then
    echo "❌ Found conflict separator marker in: $file"
    found_conflict_markers=1
  fi
done < "$list_file"

if [[ $found_conflict_markers -gt 0 ]]; then
  echo ""
  echo "ERROR: Found merge conflict markers in tracked files"
  echo "Please resolve all conflicts before committing"
  exit 1
fi

echo "✅ No merge conflict markers found"
exit 0
