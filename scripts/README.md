# Scripts

## `check-denylist.py`

Local privacy denylist. It hashes tokens and path-like strings from tracked files and compares them to `denylist.hashes`. Hits print `file:line` and a generic category only — never the denied term.

```
python3 scripts/check-denylist.py
```

`constitution/` is skipped (those edits are High and need Scott's concur). The hashes file is skipped so the hashes themselves are not treated as content.

This check is **not** in CI. Wiring it into `.github/workflows/` is High/O2. Run it locally before opening a docs PR.

To add a term, hash the lowercase UTF-8 of the token or path and append `digest<TAB>category`. Do not commit plaintext terms.
