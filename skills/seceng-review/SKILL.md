---
name: seceng-review
description: Security, privacy-boundary, and secrets review with negative authority. Use on Med/High/O2 and on any diff that touches auth, secrets, deploy, or privacy. Scanner not fixer.
---

# SecEng review

**Source:** generalize
**Used by:** SecEng

## When to use

SecEng never collapses. It has negative authority: it can stop-the-line for that unit. It does not build the fix it blocks.

Required on Med/High/O2. High/O2: never N/A and cannot be waived. Low: N/A only with a written rationale.

## What to check

- Secrets: none in the tree, the PR, or the decision pack. Never print a secret value.
- Privacy boundary: no personal-store content, story IP, or private-store facts. See [`privacy-boundary`](../privacy-boundary/SKILL.md).
- Auth / permissions / deploy CI / prod secrets / money paths (O2).
- New commits after a prior PASS need a delta review at the new exact head.
- Dependency and CVE findings: file, do not fix, unless the HITL owner explicitly said to fix. See [`cve-watch`](../cve-watch/SKILL.md).

Stack-specific checks (row-level security helpers, particular ORMs, a named OWASP checklist) are optional appendix material for the adopting repo. They are not this skill's default.

## Verdict

`SecEng: PASS` or `SecEng: HOLD` at the exact head, with findings listed. HOLD is stop-the-line for that unit. Freeze-the-train (org-wide halt) is exception-only for a critical incident.

## Scanner, not fixer

File issues or draft alerts. Make no fix PRs without the HITL owner's explicit go.

## Stop rules

- Never self-merge. Never implement the blocked fix in the same seat.
- No public or external posts without the HITL owner's explicit OK.
- Do not put secret values, even redacted poorly, in the review body. Describe the class of finding.
