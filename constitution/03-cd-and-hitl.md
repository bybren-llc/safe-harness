# 03 — Continuous Deployment & HITL

SDLC target = **continuous deployment**. Mainline stays releasable. Gates prove safety without long freeze windows.

## Risk tiers

| Tier | Behavior | Human requirement |
| --- | --- | --- |
| **Low** | Auto when green (tests + evidence types met) | Agent may flow; human assignee still named |
| **Med** | One human decision pack | Approve / change-request on that unit only |
| **High** | Two humans | Two distinct humans; agent ≠ human |

## O2 high-risk default (always High unless Scott/Kai downgrade in writing)

- Pricing
- Refunds
- Auth
- Deploy CI / workflows
- Prod secrets
- Privacy-boundary crosses (vault routing, PII, personal→remote attempts)

## Gate types

| Gate | Behavior | Blocks whole train? |
| --- | --- | --- |
| **Decision pack** (POPM/HITL) | Async review of evidence + AC | Only that change unit |
| **Independence** (QAS / SecEng) | Separate actor; bounce / stop-the-line | That unit until cleared |
| **Business-context HITL** | Before construction on policy/secrets/risk | That Bolt’s construction start |
| **Freeze-the-train** | Org-wide halt | **Exception only** (critical SecEng / prod incident) |

Default = decision packs + independence. Freeze is rare and named.

## CD mechanics (spine A)

| Practice | Rule |
| --- | --- |
| **Exact-head** | Evidence and CI must refer to the exact commit/PR head under review |
| **Merge queue** | Prefer queue over freeze; policy input from SAW Dark Factory merge-queue docs (tmux not required) |
| **Flags** | Prefer feature flags for incomplete work over long-lived freeze branches |
| **Rollback** | First-class; rehearse path before high-risk deploys |
| **HITL merge** | Humans merge; agents never self-merge |

## Decision pack minimum

- Link to Linear issue (SoR)
- Exact-head SHA / PR
- Evidence IDs (portable — see `05-evidence-and-linear.md`)
- QAS + SecEng status (or explicit N/A with rationale for low tier only)
- Risk tier + O2 checklist
- Ask: approve / change-request / escalate
