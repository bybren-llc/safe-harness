#!/usr/bin/env python3
"""Fail if hashed privacy-denylist tokens appear outside constitution/.

Scans the working-tree copies of git-tracked files. Skips constitution/
(High / needs Scott concur) and this hashes file. Prints file:line and a
generic category only — never the denied term.

Not wired into CI: adding it to .github/workflows/ is High/O2. Run locally:

    python3 scripts/check-denylist.py
"""

from __future__ import annotations

import hashlib
import re
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
HASHES_PATH = Path(__file__).resolve().parent / "denylist.hashes"
SKIP_PREFIXES = ("constitution/",)
SKIP_FILES = frozenset(
    {
        "scripts/denylist.hashes",
    }
)

TOKEN_RE = re.compile(r"[a-z0-9]+(?:[-_][a-z0-9]+)*")
PATH_RE = re.compile(r"[a-z0-9_.-]+(?:/[a-z0-9_.-]+)+")


def sha256_text(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def load_denylist(path: Path) -> dict[str, str]:
    mapping: dict[str, str] = {}
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if "\t" not in line:
            print(f"ERROR: malformed denylist line (need hash<TAB>category): {path}", file=sys.stderr)
            sys.exit(2)
        digest, category = line.split("\t", 1)
        digest = digest.strip().lower()
        category = category.strip()
        if not re.fullmatch(r"[0-9a-f]{64}", digest):
            print(f"ERROR: denylist entry is not a SHA-256 hex digest: {path}", file=sys.stderr)
            sys.exit(2)
        if not category:
            print(f"ERROR: denylist category missing: {path}", file=sys.stderr)
            sys.exit(2)
        mapping[digest] = category
    if not mapping:
        print(f"ERROR: denylist is empty: {path}", file=sys.stderr)
        sys.exit(2)
    return mapping


def tracked_files() -> list[str]:
    result = subprocess.run(
        ["git", "ls-files", "-z"],
        cwd=REPO_ROOT,
        check=True,
        stdout=subprocess.PIPE,
    )
    return [item for item in result.stdout.decode("utf-8").split("\0") if item]


def should_skip(rel_path: str) -> bool:
    if rel_path in SKIP_FILES:
        return True
    return any(rel_path == prefix.rstrip("/") or rel_path.startswith(prefix) for prefix in SKIP_PREFIXES)


def candidates_from_line(lowered: str) -> set[str]:
    found: set[str] = set()
    for token in TOKEN_RE.findall(lowered):
        found.add(token)
        for part in re.split(r"[-_]", token):
            if part:
                found.add(part)
    for path in PATH_RE.findall(lowered):
        found.add(path)
        for segment in path.split("/"):
            if segment:
                found.add(segment)
                for part in re.split(r"[-_]", segment):
                    if part:
                        found.add(part)
    return found


def scan_file(rel_path: str, denylist: dict[str, str]) -> list[tuple[int, str]]:
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
        for candidate in candidates_from_line(line.lower()):
            category = denylist.get(sha256_text(candidate))
            if category and (line_no, category) not in seen_on_line:
                seen_on_line.add((line_no, category))
                hits.append((line_no, category))
    return hits


def main() -> int:
    if not HASHES_PATH.is_file():
        print(f"ERROR: missing denylist file: {HASHES_PATH}", file=sys.stderr)
        return 2

    denylist = load_denylist(HASHES_PATH)
    hits: list[tuple[str, int, str]] = []
    scanned = 0
    for rel_path in tracked_files():
        if should_skip(rel_path):
            continue
        scanned += 1
        for line_no, category in scan_file(rel_path, denylist):
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
