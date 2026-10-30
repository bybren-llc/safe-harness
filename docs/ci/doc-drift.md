# Doc-drift checks (v1 proposed)

**Status:** v1 proposed. Warn-only. Kai to confirm the rule set before any flip to blocking.

The workflow is `.github/workflows/doc-drift.yml`. It runs on `pull_request` only. Permissions are `contents: read`. No secrets. No `pull_request_target`. Checkout is pinned the same way as the other repo workflows (`actions/checkout@v4`). The job never fails the build: findings print as `WARN` and the step exits 0.

v1 is warn-only (Kai). A later PR may flip it to blocking after the rule set is confirmed.

## Rule set (v1 proposed)

### 1. Companion-doc rule

A pull request that changes a **watched tree** should also change at least one **companion** for that tree. Changing a companion alone is enough; no second companion is required.

| Watched tree | Companions (any one changed is enough) |
| --- | --- |
| `constitution/` | `constitution/README.md`, `README.md`, `AGENTS.md`, any `skills/*/SKILL.md` |
| `roles/` | `roles/README.md`, `README.md`, `AGENTS.md`, any `skills/*/SKILL.md` |
| `.github/workflows/` | any path under `docs/ci/`, `README.md`, `AGENTS.md`, any `skills/*/SKILL.md` |

The check uses `git diff --name-only origin/<base>...HEAD`. It does not read pull-request title or body.

### 2. Stale-rename rule

For each git rename (`R` status) in that same diff, the check searches tracked `*.md`, `*.yml`, and `*.yaml` at HEAD for the old path and, when the basename is specific enough, the old basename. Hits are reported as leftover cross-references.

Generic basenames are skipped for the basename search: `README.md`, `AGENTS.md`, `SKILL.md`, `index.md`, `LICENSE`, and any basename shorter than 8 characters. The old full path is still searched.

Hits under `prove/` are skipped. That tree is historical evidence (decision packs and Wave 0 records). An old filename cited there, including the Decision 18 history row in `prove/wave-1/decision-pack.md`, is a citation, not drift.

## Flip to blocking (not in v1)

1. Confirm this rule set in writing (Kai).
2. In `.github/workflows/doc-drift.yml`, drop `continue-on-error` and make the check step exit non-zero when `WARNINGS` is greater than 0.
3. Keep `permissions: contents: read`. Do not add secrets or `pull_request_target`.
