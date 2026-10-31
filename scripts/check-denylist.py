#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 ByBren, LLC
"""Fail if local denylist terms appear in tracked files.

Reads plain terms from repo-root `.denylist.local` (gitignored). One term per
line; `#` starts a comment; optional `<TAB>category`. Comparison uses
`casefold()` on terms and scanned lines. Hits print file:line and a generic
category only — never the denied term.

Skip (exit 0, `no local denylist, skipped`) only when the path has no entry.
A directory, broken symlink, or anything that is not a readable regular file
is a config error (exit 2). Zero active terms, unknown category, unreadable
or undecodable input, and a failed tracked-file listing are also exit 2.

Not wired into CI. A CI version using a repo secret is planned for v1.1.

    python3 scripts/check-denylist.py
"""

from __future__ import annotations

import stat
import subprocess
import sys
from collections.abc import Callable
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


class ConfigError(Exception):
    def __init__(self, message: str) -> None:
        self.message = message


class UnknownCategoryError(Exception):
    def __init__(self, line_numbers: list[int]) -> None:
        self.line_numbers = line_numbers


def classify_local_path(path: Path) -> str:
    """Return 'missing' or 'regular'; any other existing entry is 'not-regular'."""
    try:
        info = path.lstat()
    except FileNotFoundError:
        return "missing"
    except OSError as exc:
        raise ConfigError(f"ERROR: {path.name} cannot be read") from exc

    if stat.S_ISLNK(info.st_mode):
        try:
            followed = path.stat()
        except FileNotFoundError:
            return "not-regular"
        except OSError as exc:
            raise ConfigError(f"ERROR: {path.name} cannot be read") from exc
        return "regular" if stat.S_ISREG(followed.st_mode) else "not-regular"

    return "regular" if stat.S_ISREG(info.st_mode) else "not-regular"


def read_utf8(path: Path, label: str) -> str:
    try:
        return path.read_text(encoding="utf-8-sig")
    except UnicodeDecodeError as exc:
        raise ConfigError(f"ERROR: {label} is not valid UTF-8") from exc
    except OSError as exc:
        raise ConfigError(f"ERROR: {label} cannot be read") from exc


def load_terms(path: Path) -> list[tuple[str, str]]:
    terms: list[tuple[str, str]] = []
    unknown_lines: list[int] = []
    for line_no, raw in enumerate(read_utf8(path, path.name).splitlines(), start=1):
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
    try:
        result = subprocess.run(
            ["git", "ls-files", "-z"],
            cwd=REPO_ROOT,
            check=True,
            stdout=subprocess.PIPE,
        )
    except (OSError, subprocess.CalledProcessError) as exc:
        raise ConfigError("ERROR: cannot list tracked files") from exc
    return [item for item in result.stdout.decode("utf-8").split("\0") if item]


def scan_file(rel_path: str, terms: list[tuple[str, str]], root: Path = REPO_ROOT) -> list[tuple[int, str]]:
    text = read_utf8(root / rel_path, rel_path)
    hits: list[tuple[int, str]] = []
    seen_on_line: set[tuple[int, str]] = set()
    for line_no, line in enumerate(text.splitlines(), start=1):
        folded = line.casefold()
        for term, category in terms:
            if term in folded and (line_no, category) not in seen_on_line:
                seen_on_line.add((line_no, category))
                hits.append((line_no, category))
    return hits


def run(
    local_path: Path = LOCAL_PATH,
    *,
    repo_root: Path = REPO_ROOT,
    list_files: Callable[[], list[str]] | None = None,
) -> int:
    try:
        kind = classify_local_path(local_path)
    except ConfigError as exc:
        print(exc.message, file=sys.stderr)
        return 2

    if kind == "missing":
        print("no local denylist, skipped")
        return 0
    if kind != "regular":
        print(f"ERROR: {local_path.name} is not a readable regular file", file=sys.stderr)
        return 2

    try:
        terms = load_terms(local_path)
    except ConfigError as exc:
        print(exc.message, file=sys.stderr)
        return 2
    except UnknownCategoryError as exc:
        for line_no in exc.line_numbers:
            print(f"ERROR: {local_path.name}:{line_no}: unknown category", file=sys.stderr)
        return 2

    if not terms:
        print(f"ERROR: {local_path.name} has no active terms", file=sys.stderr)
        return 2

    try:
        paths = list_files() if list_files is not None else tracked_files()
    except ConfigError as exc:
        print(exc.message, file=sys.stderr)
        return 2

    hits: list[tuple[str, int, str]] = []
    scanned = 0
    try:
        for rel_path in paths:
            if rel_path in SKIP_FILES:
                continue
            scanned += 1
            for line_no, category in scan_file(rel_path, terms, root=repo_root):
                hits.append((rel_path, line_no, category))
    except ConfigError as exc:
        print(exc.message, file=sys.stderr)
        return 2

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
