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
- `requirements/` — REQ-<CMP>-NNN registry
- `constitution/` — governance framework
- `trace/` — trace map and state tracking

Agents may open PRs touching these files but **must not merge them**. Use the `needs-scott-concur` label on PRs awaiting Scott's review.

---

## Workflow

1. **Issues**: Use GitHub Issues with structured templates (`.github/ISSUE_TEMPLATE/`)
2. **Branches**: `<issue#>-slug` (e.g., `42-add-trace-check`)
3. **Commits**: 
   - Prefix: `[wave-1]` (no Linear SAF tags; Linear is retired for this repo)
   - Trailer: `Refs #N` (references issue)
   - Trailer: `Req: REQ-<CMP>-NNN` (satisfies requirement)
4. **PRs**: Include `Requirements: REQ-<CMP>-NNN, REQ-<CMP>-MMM` line in body
5. **Review**: Follow constitution/03 (risk tiers, QAS independence, HITL gates)

---

## Risk tiers

See constitution/03 for Low / Med / High risk tiers and O2 high-risk defaults.

**O2 items default to High** unless Kai downgrades in writing at QAS:
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

| Artifact | Owner | Agent role |
| --- | --- | --- |
| intent.md, spec.md | Humans | May propose; **never merge** |
| constitution/ | Humans | May propose; **never merge** |
| Everything else | Agents | Own end-to-end |

Agents own: plan, GitHub Issues, code, tests, PRs, evidence.

---

## Studio handoff (spine B → A)

Studio drafts `intent.md` and `spec.md` and hands them to Delivery. Delivery commits them in a PR. Scott approves via CODEOWNERS.

---

## Questions?

See `constitution/README.md` for governance framework and `prove/README.md` for examples.
