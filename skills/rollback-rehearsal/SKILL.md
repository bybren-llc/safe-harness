---
name: rollback-rehearsal
description: Treat rollback as first-class — rehearse before high-risk deploys, keep a one-step revert, record evidence. Use before a High or prod-risk promotion and when a deploy goes bad.
license: MIT (see repository LICENSE)
---

# Rollback rehearsal

**Source:** generalize
**Used by:** RTE, Delivery

## Authority

- [`constitution/03-cd-and-hitl.md`](../../constitution/03-cd-and-hitl.md) — rollback is first-class; prod-risk
- [`constitution/07-roles-and-lanes.md`](../../constitution/07-roles-and-lanes.md) — scanner, not fixer

See the cited section; this skill grants no authority.

**Working practice, not yet constitutional:** A consequential action needs the human's own words verified. An agent relaying approval is never approval.

## When to use

Rehearse the path before a high-risk deploy. Use it for real when a promotion is bad.

## Rehearse (before)

1. Name the one-step revert (revert commit, re-tag previous, or the adopter's documented promote-previous). One step, not a scavenger hunt.
2. Run that step in a non-prod environment.
3. Smoke the adopter's documented health checks.
4. Record portable evidence (command + output + exact head restored).

## Execute (when live is bad)

1. Identify the failure with evidence.
2. Run the rehearsed one-step revert.
3. Re-smoke.
4. File the incident note. Do not hotfix forward on prod-risk except as the cited section allows.

## Stop rules

- No Docker hostnames, registries, or SSH runbooks in this skill. Those belong in the adopter's private ops docs.
- Do not skip rehearsal on High / O2 "because we are late."
- Scanner, not fixer, if the failure is a security incident — stop-the-line and page SecEng.
