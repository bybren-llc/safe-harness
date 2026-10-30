#!/usr/bin/env python3
"""Fail if local denylist terms appear in tracked files.

Reads plain terms from repo-root `.denylist.local` (gitignored). One term per
line; `#` starts a comment; optional `<TAB>category`. Comparison is
case-insensitive. Hits print file:line and a generic category only — never
the denied term.

If `.denylist.local` is missing, exits 0 with `no local denylist, skipped`.

Not wired into CI. A CI version using a repo secret is planned for v1.1.

    python3 scripts/check-denylist.py
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
LOCAL_PATH = REPO_ROOT / ".denylist.local"
SKIP_FILES = frozenset(
    {
        "scripts/denylist.example",
    }
)


def load_terms(path: Path) -> list[tuple[str, str]]:
    terms: list[tuple[str, str]] = []
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if "\t" in line:
            term, category = line.split("\t", 1)
        else:
            term, category = line, "denied-term"
        term = term.strip()
        category = category.strip() or "denied-term"
        if term:
            terms.append((term.lower(), category))
    return terms


def tracked_files() -> list[str]:
    result = subprocess.run(
        ["git", "ls-files", "-z"],
        cwd=REPO_ROOT,
        check=True,
        stdout=subprocess.PIPE,
    )
    return [item for item in result.stdout.decode("utf-8").split("\0") if item]


def scan_file(rel_path: str, terms: list[tuple[str, str]]) -> list[tuple[int, str]]:
    path = REPO_ROOT / rel_path
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return []
    except OSError as exc:
        print(f"ERROR: cannot read {rel_path}: {exc}", file=sys.stderr)
        sys.exit(2)

    hits: list[tuple[int, str]] = []
    seen_on_line: set[tuple[int, str]] = set()
    for line_no, line in enumerate(text.splitlines(), start=1):
        lowered = line.lower()
        for term, category in terms:
            if term in lowered and (line_no, category) not in seen_on_line:
                seen_on_line.add((line_no, category))
                hits.append((line_no, category))
    return hits


def main() -> int:
    if not LOCAL_PATH.is_file():
        print("no local denylist, skipped")
        return 0

    terms = load_terms(LOCAL_PATH)
    hits: list[tuple[str, int, str]] = []
    scanned = 0
    for rel_path in tracked_files():
        if rel_path in SKIP_FILES:
            continue
        scanned += 1
        for line_no, category in scan_file(rel_path, terms):
            hits.append((rel_path, line_no, category))

    if hits:
        print(f"Denylist check failed: {len(hits)} hit(s) in {scanned} scanned file(s).")
        for rel_path, line_no, category in hits:
            print(f"  {rel_path}:{line_no}: denylist hit ({category})")
        return 1

    print(f"Denylist check passed: {scanned} file(s), no hits.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
