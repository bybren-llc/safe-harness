# CodeRabbit Inline Thread Replies — PR #6 @ 283d26e

Applied 3 findings from CodeRabbit review on f84ee526.

## Inline 4414097718 (trace-check.yml ~L214)

**Finding:** Require sign-off link in rationale when dropping intent.md REQ.

**Reply:**

Fix commit: `283d26e33c17fdec195b40416eb04d17ff225997`

Added validation at `.github/workflows/trace-check.yml:214-221`:

```bash
# Require sign-off link in rationale
if [[ ! "$RATIONALE" =~ https?:// ]]; then
  echo "  ❌ Dropping REQ from intent.md requires sign-off link in rationale"
  ERRORS=$((ERRORS + 1))
fi
```

Per `trace/schema.md:71`, dropping a REQ from intent.md now requires both `decided_by: Scott Graham` (exactly) AND a link in rationale. Bootstrap warn-only behavior maintained.

---

## Inline 4414097743 (constitution/05 L130-138)

**Finding:** Clarify blocking activation depends on follow-up validations landing first.

**Reply:**

wording-only, see decision pack

Added blocking activation precondition at `constitution/05:130-132`:

> Trace-check becomes blocking only after the first `spec.md` with REQ IDs lands **AND** after the follow-up validations below are implemented and merged. Until both conditions are met, trace-check remains warn-only.

Matching precondition added to Decision 19 at `decision-pack.md:512-514`, pending Kai and Scott concurrence. No workflow logic change.

---

## Inline 4414097761 (decision-pack ~L640)

**Finding:** Risk summary must not claim 'mitigated' while Scott's concur is pending.

**Reply:**

Fix commit: `283d26e33c17fdec195b40416eb04d17ff225997`

Changed at `decision-pack.md:640`:
- **Before:** "Constitution changes without team alignment → **Mitigated:** Team concur record..."
- **After:** "Constitution changes without team alignment → **In progress:** Team concurred (Studio, Scout, Librarian, Ops, Delivery) above; Scott's concurrence PENDING"

Checked against team concur table at `decision-pack.md:30-52` (as of 5a62fc26): Scott's concurrence is separate and PENDING.

---

**CI status:** ✅ All checks green (Requirements Trace Validation PASS 5s, Structure & Docs Validation PASS 6s)
