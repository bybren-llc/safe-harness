# Skills CI checks (warn-only)

The Wave 0 structure workflow (`.github/workflows/wave0-checks.yml`) has a `skills-checks` job that:

1. Installs pinned PyYAML (`6.0.3`), then runs `python3 skills/check-frontmatter.py`.
2. Runs the same relative-link scan as the structure job, over `skills/`.

Both check steps use `continue-on-error`, so findings print in the log and do not fail the workflow. The job does not assert a skill count; the checker is the source of truth for what a valid `SKILL.md` looks like.

If `skills/check-frontmatter.py` is missing, the frontmatter step skips.

## Flip to blocking

1. Remove `continue-on-error` from the two check steps in `skills-checks`.
2. Add `skills` to the `find` list in the structure-check "Check markdown relative links" step.

Checkout is pinned the same way as the rest of the workflow (`actions/checkout@v4`). Workflow permissions are `contents: read`. No secrets. No `pull_request_target`.
