# Trace-check fixtures

Local pass/fail trees for `trace/check.sh`. They do not change CI: the workflow stays warn-only until `spec.md` has REQ IDs **and** a code-owner-reviewed `trace/.blocking` lands (not in this PR).

## Run

From the repository root:

```
bash trace/fixtures/run.sh
```

That runs every `pass/*` tree expecting exit 0, every `fail/*` tree expecting exit 1 (both with `FORCE_BLOCKING=1`), then confirms one failing tree still exits 0 in warn-only mode.

Single tree:

```
FORCE_BLOCKING=1 EVENT_NAME=pull_request bash trace/check.sh trace/fixtures/pass/happy-path
FORCE_BLOCKING=1 EVENT_NAME=pull_request bash trace/check.sh trace/fixtures/fail/missing-components
EVENT_NAME=pull_request bash trace/check.sh trace/fixtures/fail/missing-components
```

`EVENT_NAME` and `PR_BODY` are how CI passes pull-request context (via workflow `env:`, not `run:` interpolation). Fixtures that need a PR body use `.pr-body` in the tree.

Needs `yq` (mikefarah on GitHub-hosted runners, or kislyuk locally) and `python3`.
