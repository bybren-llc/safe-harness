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

If `.denylist.local` is missing, the script exits 0 and prints `no local denylist, skipped`.

If the file exists but has no active terms (empty or comments only), that is a config error and the script exits non-zero.

Local tests (fake terms only):

```
python3 scripts/test_check_denylist.py
```

This check is **not** in CI. A CI version using a repo secret is planned for v1.1. Run it locally before opening a docs PR.
