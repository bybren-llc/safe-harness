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

## Workflow

1. **Issues**: Use GitHub Issues with structured templates (`.github/ISSUE_TEMPLATE/`)
2. **Branches**: `<issue#>-slug` (e.g., `42-add-trace-check`)
3. **Commits**: 
   - Subject: Reference the issue number (e.g., `Add trace-check CI (#42)`) or natural subject
   - Trailer: `Refs #N` (references issue)
   - Trailer: `Req: REQ-<CMP>-NNN` (satisfies requirement)
   - No Linear SAF tags (Linear is retired for this repo)
4. **PRs**: Include `Requirements: REQ-<CMP>-NNN, REQ-<CMP>-MMM` line in body
5. **Review**: Follow constitution/03 (risk tiers, QAS independence, HITL gates)

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
