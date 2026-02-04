---
description: Validate implementation
---

## **CURRENT STATE: TASK REVIEW**

Role: **Reviewer** — Validate execution matches frozen intent.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/temp-state/task.md`
- `/obelisk/temp-state/plan.md`
- `/obelisk/temp-state/implementation-notes.md`

If any are missing → **STOP**, report the missing file path.

### Load Context

**Contracts:**
1. Always read: `/obelisk/state/core.domain.md`
2. Read feature contracts when task scope appears to involve them  
   (Check: task description, affected files, or potential invariants)
3. If uncertain, read the feature contract

**Memory:**
1. Always read: `/obelisk/memory/core.memory.md`
2. Read feature memory when task scope appears to involve it
3. If uncertain, read the feature memory

**Rule:** When in doubt, read the file. Missing context is worse than extra tokens.

During review, be conservative: re-check any feature contracts or memory that could plausibly be affected, even indirectly.

---

## Review Rules

**MUST:**

* Review ONLY changes for this task
* Verify actual code matches plan (not just notes)
* Use frozen task as intent — do NOT reinterpret
* Treat contracts as authoritative business invariants that MUST hold in the final code
* Use project memory (`*.memory.md`) as **context only**, not as approval criteria
* Base conclusions on **inspection of real code**, not confidence or summaries

**MUST NOT:**

* Propose fixes or alternatives
* Modify any files
* Re-run planning or implementation
* Approve based on notes alone

---

## Anti-Hallucination Rule (MANDATORY)

For every ✓ in checklist items that involve code verification,
the reviewer MUST be able to point to the actual code that justifies it.

At least one of the following MUST be included when marking an item as ✓:
* File path + function/class name
* A short code snippet (few lines)
* A precise description of the logic observed in the code

If you cannot point to the code, mark the item as **✗**.

---

## Review Checklist

Any failure → **CHANGES REQUIRED**

1. **Task → Plan:** All success criteria mapped to steps?
2. **Plan → Code:** All steps actually implemented in source files?
3. **Contracts:** All preserved in actual code?
4. **Scope:** Only files listed in plan were changed?
5. **Divergences:** Any noted in implementation-notes.md justified?

---

## Review Output

Write to `/obelisk/temp-state/review-notes.md`:

```markdown
# Review Outcome

**Status:** APPROVED | CHANGES REQUIRED

## Summary
[2–3 sentence factual summary]

## Checklist Results
1. Task → Plan: ✓ | ✗ [brief justification]
2. Plan → Code: ✓ | ✗
3. Contracts: ✓ | ✗
4. Scope: ✓ | ✗
5. Divergences: ✓ | ✗

## Files Verified
- [list of source files actually reviewed]

## Deferred Items (if any)
- [Item → requires new task]

## Notes (Optional)
- Factual, non-blocking observations
```

---

**Success:**

> "✓ REVIEW COMPLETE — Status: [APPROVED|CHANGES REQUIRED]"