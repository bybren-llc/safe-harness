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

**Local denylist:** copy `scripts/denylist.example` to `.denylist.local` at the repo root (gitignored), replace the fake terms, then run `python3 scripts/check-denylist.py` before opening a PR. It compares tracked files case-insensitively against the local plain terms and prints `file:line` plus a generic category only. If `.denylist.local` is missing, the script exits 0 (`no local denylist, skipped`). This is not yet wired into CI. A CI version using a repo secret is planned for v1.1. See `scripts/README.md`.

Secrets live in vaults. Scott owns both the GitHub secrets and the vault side. Never include a secret value in this repository.

---

## Constitution-gated files (CODEOWNERS)

The following files require @cheddarfox review and approval before merge:
- `intent.md` and `intent/` — human-owned design intent
- `spec.md` — human-owned specification
- `requirements/` — agent-authored REQ-<CMP>-NNN registry (human review gate)
- `constitution/` — agent-authored governance changes (human review gate)
- `trace/` — agent-authored trace map (human review gate)
- `arch/` — component registry (human review gate)
- `AGENTS.md` and `adapters/**/AGENTS.md` — agent entry points (human review gate)
- `skills/` — skills library (human review gate)
- `.github/CODEOWNERS` and `.github/workflows/` — review-gate and CI controls

**Ownership distinction:** Humans own and accept only design (intent.md + spec.md). Agents own and author everything else (plan, issues, code, tests, PRs, evidence, requirements, trace, constitution changes). CODEOWNERS enforces human review gates before merge.

Agents may open PRs touching these files but **must not merge them**, except Kai or Release · RTE may merge `constitution/` changes only under the conditions in [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md), including Scott's recorded own-words concurrence at exact head. Use the `needs-scott-concur` label on PRs awaiting Scott's review.

---

## How a change flows

1. **Issue:** Create GitHub Issue with work type, risk tier, and O2 labels
2. **Branch:** Create branch `<issue#>-slug` off main (e.g., `42-add-trace-check`)
3. **Implement:** Write code, tests, gather evidence
4. **Commit:** Use `Refs #N` and `Req: REQ-<CMP>-NNN` trailers (no Linear SAF tags)
5. **PR:** Open PR from [`.github/pull_request_template.md`](.github/pull_request_template.md) with a `Requirements:` line (`REQ-<CMP>-NNN` or N/A)
6. **CI:** Structure & Docs Validation + Requirements Trace Validation run automatically
7. **CodeRabbit:** Automated code review (required gate input)
8. **QAS:** Independent review at exact commit SHA (Kai), posted as COMMENT review (PRs are authored by the `cheddarfox` account, which is also the account Kai reviews through; GitHub does not let a PR's author APPROVE or REQUEST_CHANGES on their own PR, so the independent QAS verdict is recorded as a COMMENT review with an explicit `QAS: APPROVE` / `QAS: CHANGES NEEDED` line)
9. **Decision pack:** If Medium or High tier, create decision pack with rationale, evidence, and risks
10. **Merge:** Human approval is distinct from merge execution. On trunk, Kai may execute the merge once checks are green and an independent QAS APPROVE is on the exact head; at Med/High/O2 also RTE PASS on the exact head, or a HOLD override from Kai or Scott recorded on the PR with its reason. Release · RTE also needs Kai's independent QAS APPROVE and its own PASS. Scott's recorded own-words concur is required for constitution/, High, and O2. CODEOWNERS-gated paths other than constitution/ (intent.md, spec.md, requirements/, trace/) stay agents-must-not-merge (Scott/CODEOWNERS only). Delivery and cloud agents never merge. See [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md).

**Key constraint:** QAS independence means QAS is never the implementer. Nobody merges their own authored change. An agent merge never counts as human approval. High/O2 still needs Scott's recorded concur as a required human approval. Two distinct humans on High-tier work is recommended guidance, not a gate. See [`constitution/03-cd-and-hitl.md`](constitution/03-cd-and-hitl.md) for the template default.

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
