# Decision Pack — Reconcile release/flow.md and delivery-bolt-brief (#26)

**PR:** this PR  
**Branch:** `cursor/reconcile-flow-and-bolt-brief-f781`  
**Issue:** [#26](https://github.com/bybren-llc/safe-harness/issues/26)  
**Status:** PROPOSED — needs Scott concur  
**Owner:** Delivery · Lead  
**QAS:** Kai (independent; not the implementer)  
**Tier:** **High** (touches merge and release authority text). No downgrade.

---

## Executive summary

Docs-only operating-draft update. Rewrites `release/flow.md` §§3, 5, 7, 8 and 9 to match `constitution/03-cd-and-hitl.md`, `constitution/05-evidence-and-traceability.md`, and `roles/release-rte.md`. Removes the superseded note. Aligns `templates/delivery-bolt-brief.md` stale fields with the same sources.

This file stays **PROPOSED / needs Scott concur / non-binding**. It does not amend `constitution/`.

**Not changed: #28 (a) and (b).** G4 ordering and the Med-tier Scott decision-pack-concur row are left as written, with an inline note on each.

Delivery does not merge. Kai QAS APPROVE and Scott's own-words concur are required at the exact head.

---

## Constitution / 03 minimum

| Field | Value |
| --- | --- |
| GitHub Issue | [#26](https://github.com/bybren-llc/safe-harness/issues/26) |
| Exact-head SHA / PR | [#29](https://github.com/bybren-llc/safe-harness/pull/29). The exact head under concur is recorded in Kai's QAS review and in the merge commit body. |
| Evidence IDs | this pack; #26; #22 squash `d88c884`; #27 squash `132f890` |
| Requirements | Closes #26 (no REQ-IDs in spec.md yet) |
| QAS | Pending Kai independent QAS at exact head |
| SecEng | Pending independent SecEng (High/O2 never N/A). Implementer is not SecEng. |
| Risk tier + O2 | **High**. Merge and release authority text. No downgrade. |
| Ask | approve / change-request / escalate — **concur in your own words at the exact head. Do not answer #28 (a) or (b) here.** |

---

## Tier ruling

**High.** The rewrite restates who may merge, which MERGED exit state a Kai/RTE merge uses, and that tag/Release publication is a separate O2 step. That is merge and release authority text. Scott's own-words concur is required at the exact head. No workflow files changed. No secret values.

O2 checklist:

- [ ] Pricing — N/A
- [ ] Refunds — N/A
- [x] **Auth — YES** (who may merge; which MERGED state records the executor)
- [ ] Deploy CI / workflows — publication is named as a future O2 step; no workflow files changed
- [ ] Prod secrets — N/A
- [ ] Privacy-boundary — N/A

---

## Parked (do not decide here)

See [#28](https://github.com/bybren-llc/safe-harness/issues/28).

- (a) G4 ordering: whether Scott's concur gates RTE PASS or only the merge
- (b) Med-tier row requiring Scott's decision-pack concur

Both lines keep their existing text plus: `Open decision, see #28; unchanged here.`
