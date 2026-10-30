# API contract checks

Reusable, warn-only CI for a repo that keeps an OpenAPI spec. This repo has no spec today; the workflow is a template for adopters.

The workflow is `.github/workflows/api-contract.yml`. It looks for a spec at a configurable path. The documented default is `openapi.yaml`. Change `OPENAPI_SPEC_PATH` in the workflow to point at a different file.

When that file is missing, the job prints a notice and exits 0.

When a spec is present:

1. **oasdiff** compares the current spec to the same path on the pull-request base (or the previous commit on `main`) and reports breaking changes. Warn-only.
2. **Schemathesis** runs only when `API_CONTRACT_BASE_URL` is set to a public API base URL. Leave that env empty to skip. Warn-only. Do not put credentials in the workflow; it uses no secrets.

Both checks use `continue-on-error` so findings never fail the job. A comment on each step marks where to remove that line later if the check should block.

Action and tool versions are pinned in the workflow (`actions/checkout@v4.2.2`, oasdiff `1.35.0`, Schemathesis `4.32.7`). Permissions are `contents: read` only. The workflow does not use `pull_request_target`.

## Tools

- Schemathesis: https://schemathesis.readthedocs.io/
- oasdiff: https://github.com/oasdiff/oasdiff
