# Contributing to safe-harness

**Repo:** bybren-llc/safe-harness  
**Owner:** Kai · GM & lead ARCHitect  
**Org:** bybren-llc

---

## Personal boundary rule

**NEVER include personal-vault content, story IP, or NAS-private facts in this repository.**

Prohibited content:
- Personal vault paths, file names, or excerpts
- Story IP (character names, plot details, worldbuilding specifics)
- NAS-private facts: LAN IPs, tokens, `/home` paths, device identifiers
- Personal context that violates privacy boundaries (constitution/04)

**How to reference:**
- ✅ **Cite by concept name only**: "See personal vault entry for authentication flow"
- ✅ **Generic examples**: "Example: a media server at 192.0.2.1 (RFC 5737 documentation range)"
- ❌ **Never paste**: actual IPs, tokens, paths, or personal details

Agents and humans: when referencing NAS, personal vault, or private context, **describe the pattern** without exposing the instance.

---

## Constitution-gated files (CODEOWNERS)

The following files require @cheddarfox review and approval before merge:
- `intent.md` and `intent/` — human-owned design intent
- `spec.md` — human-owned specification
- `requirements/` — agent-authored REQ-<CMP>-NNN registry (human review gate)
- `constitution/` — agent-authored governance changes (human review gate)
- `trace/` — agent-authored trace map (human review gate)

**Ownership distinction:** Humans own and accept only design (intent.md + spec.md). Agents own and author everything else (plan, issues, code, tests, PRs, evidence, requirements, trace, constitution changes). CODEOWNERS enforces human review gates before merge.

Agents may open PRs touching these files but **must not merge them**. Use the `needs-scott-concur` label on PRs awaiting Scott's review.

---

## How a change flows

1. **Issue:** Create GitHub Issue with work type, risk tier, and O2 labels
2. **Branch:** Create branch `<issue#>-slug` off main (e.g., `42-add-trace-check`)
3. **Implement:** Write code, tests, gather evidence
4. **Commit:** Use `Refs #N` and `Req: REQ-<CMP>-NNN` trailers (no Linear SAF tags)
5. **PR:** Open PR with `Requirements: REQ-<CMP>-NNN` line in body
6. **CI:** Structure & Docs Validation + Requirements Trace Validation run automatically
7. **CodeRabbit:** Automated code review (required gate input)
8. **QAS:** Independent review at exact commit SHA (Kai), posted as COMMENT review (PRs are authored by the `cheddarfox` account, which is also the account Kai reviews through; GitHub does not let a PR's author APPROVE or REQUEST_CHANGES on their own PR, so the independent QAS verdict is recorded as a COMMENT review with an explicit `QAS: APPROVE` / `QAS: CHANGES NEEDED` line)
9. **Decision pack:** If Medium or High tier, create decision pack with rationale, evidence, and risks
10. **Merge:** Merge rights belong only to Scott (HITL), Kai (GM, delegated authority, recorded as `hitl_delegate` at Low or written Scott concur at Med/High), and Release · RTE (see [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md)). No other agent merges, including Delivery and cloud agents

**Key constraint:** QAS independence means QAS is never the implementer. Nobody merges their own authored change. High/O2 still needs Scott's recorded concur. See [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) for full merge authority rules.

---

## Risk tiers

See constitution/03 for Low / Med / High risk tiers and O2 high-risk defaults.

**O2 items default to High** unless downgraded in writing at QAS. Delivery may propose a downgrade rationale in the decision pack; Kai decides at QAS:
- Pricing, refunds, auth
- Deploy CI / workflows
- Prod secrets
- Privacy-boundary crosses

---

## Evidence

Portable evidence (constitution/05) must include:
- `evidence_id` (runtime-native unique ID)
- `runtime` (cursor / claude-code / grok-bot / etc.)
- `exact_head` (commit SHA or PR head)
- `issue` (GitHub Issue `#N`)
- `actor` (agent or human handle)
- `gate` (which gate this evidence satisfies)
- `req_ids` (list of REQ-<CMP>-NNN IDs addressed)

---

## Human vs. agent ownership (constitution/05)

**Humans own and accept only design:**
- `intent.md`, `spec.md` — Scott owns and accepts; agents may propose but **never merge**

**Agents own everything else end-to-end:**
- Plan, GitHub Issues, code, tests, PRs, evidence
- Requirements registry (`requirements/`) — agents author; human-reviewed PR required (CODEOWNERS)
- Trace map (`trace/`) — agents author; human-reviewed PR required (CODEOWNERS)
- Constitution changes — agents author; human-reviewed PR required (CODEOWNERS)

**CODEOWNERS = review gate, not ownership.** Agents author requirements, trace, and constitution changes; humans review and approve before merge.

---

## Studio handoff (spine B → A)

Studio drafts `intent.md` and `spec.md` and hands them to Delivery. Delivery commits them in a PR. Scott approves via CODEOWNERS.

---

## Questions?

See `constitution/README.md` for governance framework and `prove/README.md` for examples.
