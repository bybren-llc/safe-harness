#!/usr/bin/env python3
"""Fail if local denylist terms appear in tracked files.

Reads plain terms from repo-root `.denylist.local` (gitignored). One term per
line; `#` starts a comment; optional `<TAB>category`. Comparison uses
`casefold()` on terms and scanned lines. Hits print file:line and a generic
category only — never the denied term.

If `.denylist.local` is missing, exits 0 with `no local denylist, skipped`.
If the file exists but has no active terms, that is a config error (non-zero).
An unknown category is a config error: line number only, never the value.

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
        "scripts/test_check_denylist.py",
    }
)
KNOWN_CATEGORIES = frozenset(
    {
        "denied-term",
        "hardware-hostname",
        "internal-volume",
        "private-repo",
        "internal-name",
        "vault-path",
    }
)
_CANONICAL_CATEGORY = {item.casefold(): item for item in KNOWN_CATEGORIES}


class UnknownCategoryError(Exception):
    def __init__(self, line_numbers: list[int]) -> None:
        self.line_numbers = line_numbers


def load_terms(path: Path) -> list[tuple[str, str]]:
    terms: list[tuple[str, str]] = []
    unknown_lines: list[int] = []
    for line_no, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if "\t" in line:
            term, category = line.split("\t", 1)
        else:
            term, category = line, "denied-term"
        term = term.strip()
        category = category.strip()
        if not term:
            continue
        if category:
            canonical = _CANONICAL_CATEGORY.get(category.casefold())
            if canonical is None:
                unknown_lines.append(line_no)
                continue
            category = canonical
        else:
            category = "denied-term"
        terms.append((term.casefold(), category))
    if unknown_lines:
        raise UnknownCategoryError(unknown_lines)
    return terms


def tracked_files() -> list[str]:
    result = subprocess.run(
        ["git", "ls-files", "-z"],
        cwd=REPO_ROOT,
        check=True,
        stdout=subprocess.PIPE,
    )
    return [item for item in result.stdout.decode("utf-8").split("\0") if item]


def scan_file(rel_path: str, terms: list[tuple[str, str]], root: Path = REPO_ROOT) -> list[tuple[int, str]]:
    path = root / rel_path
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
        folded = line.casefold()
        for term, category in terms:
            if term in folded and (line_no, category) not in seen_on_line:
                seen_on_line.add((line_no, category))
                hits.append((line_no, category))
    return hits


def run(local_path: Path = LOCAL_PATH) -> int:
    if not local_path.is_file():
        print("no local denylist, skipped")
        return 0

    try:
        terms = load_terms(local_path)
    except UnknownCategoryError as exc:
        for line_no in exc.line_numbers:
            print(f"ERROR: {local_path.name}:{line_no}: unknown category", file=sys.stderr)
        return 2

    if not terms:
        print(f"ERROR: {local_path.name} has no active terms", file=sys.stderr)
        return 2

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


def main() -> int:
    return run()


if __name__ == "__main__":
    sys.exit(main())
