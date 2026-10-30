# Scripts

## `check-denylist.py`

Local privacy denylist. Copy the fake example, then replace the terms:

```
cp scripts/denylist.example .denylist.local
```

`.denylist.local` is gitignored. One term per line; `#` starts a comment; optional `<TAB>category`. The check compares tracked files case-insensitively against those plain terms. Hits print `file:line` and a generic category only — never the denied term.

```
python3 scripts/check-denylist.py
```

If `.denylist.local` is missing, the script exits 0 and prints `no local denylist, skipped`.

This check is **not** in CI. A CI version using a repo secret is planned for v1.1. Run it locally before opening a docs PR.
