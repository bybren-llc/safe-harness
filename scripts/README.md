# Scripts

## `check-denylist.py`

Local privacy denylist. Copy the fake example, then replace the terms:

```
cp scripts/denylist.example .denylist.local
```

`.denylist.local` is gitignored. One term per line; `#` starts a comment; optional `<TAB>category`. The check compares tracked files with `casefold()` on both the terms and the scanned lines. Hits print `file:line` and a generic category only — never the denied term.

Known categories: `denied-term`, `hardware-hostname`, `internal-volume`, `private-repo`, `internal-name`, `vault-path`. An unknown category is a config error: the script prints the line number only and exits non-zero. It never prints the term or the category value.

```
python3 scripts/check-denylist.py
```

Skip (exit 0, `no local denylist, skipped`) only when `.denylist.local` has no path entry at all. A directory, a broken symlink, or anything that is not a readable regular file is a config error (exit 2).

An existing file that cannot be read, is not valid UTF-8, or has no active terms (empty or comments only) is also a config error (exit 2). The same applies to an unreadable or undecodable tracked file and to a failed tracked-file listing.

Local tests (fake terms only):

```
python3 scripts/test_check_denylist.py
```

This check is **not** in CI. A CI version using a repo secret is planned for v1.1. Run it locally before opening a docs PR.
