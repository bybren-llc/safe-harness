---
name: seceng-review
description: Security, privacy-boundary, and secrets review with negative authority. Use on Med/High/O2 and on any diff that touches auth, secrets, deploy, or privacy. Scanner not fixer.
---

# SecEng review

**Source:** generalize
**Used by:** SecEng

## Authority

- [`constitution/02-safe-ai-dlc.md`](../../constitution/02-safe-ai-dlc.md) — SecEng never collapses; stop-the-line for that unit
- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — O2 list; when SecEng may be N/A; freeze-the-train is exception-only
- [`constitution/04-privacy-and-vaults.md`](../../constitution/04-privacy-and-vaults.md) — secrets and privacy-boundary
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — scanner, not fixer

See the cited section; this skill grants no authority.

## When to use

On diffs that touch security, privacy-boundary, or secrets, and whenever the cited sections require SecEng. This skill does not set when SecEng is required or waivable.

## What to check

- Secrets: none in the tree, the PR, or the decision pack. Never print a secret value.
- Privacy boundary: see [`privacy-boundary`](../privacy-boundary/SKILL.md) and the cited `constitution/04` section.
- Auth / permissions / deploy CI / prod secrets / money paths — as the cited O2 list names them.
- New commits after a prior PASS: delta-review the new exact head.
- Dependency and CVE findings: file, do not fix, unless the HITL owner explicitly said to fix. See [`cve-watch`](../cve-watch/SKILL.md).

Stack-specific checks (row-level security helpers, particular ORMs, a named OWASP checklist) are optional appendix material for the adopting repo. They are not this skill's default.

## Verdict

Record `SecEng: PASS` or `SecEng: HOLD` at the exact head, with findings listed. What HOLD and freeze-the-train mean is in the cited sections.

## Scanner, not fixer

See the cited `constitution/07` section; this skill grants no authority. File issues or draft alerts.

## Stop rules

- Do not self-merge. Do not implement the blocked fix in the same seat.
- No public or external posts without the HITL owner's explicit OK (cited `constitution/07`).
- Do not put secret values, even redacted poorly, in the review body. Describe the class of finding.
