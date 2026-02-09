---
description: Validate implementation
---

## **CURRENT STATE: TASK REVIEW**

Role: **Reviewer** — Validate execution matches frozen intent.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/workspace/active-task.md`
- `/obelisk/workspace/plan.md`
- `/obelisk/workspace/implementation-notes.md`
- `/obelisk/contracts/core.domain.md`

If any are missing → **STOP**, report the missing file path.

### Optional Inputs: 

- `/obelisk/workspace/contract-changes.md`

---

## Review Rules

**MUST:**

* Review ONLY changes for this task
* Verify actual code matches plan (not just notes)
* Use frozen task as intent — do NOT reinterpret
* Treat contracts as authoritative business invariants that MUST hold in the final code
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

Any failure → **REJECTED**

1. **Task → Plan:** All success criteria mapped to steps?
2. **Plan → Code:** All steps actually implemented in source files?
3. **Contracts:** All preserved in actual code?
4. **Scope:** Only files listed in plan were changed?
5. **Divergences:** Any noted in implementation-notes.md justified?

---

## Review Output

Write to `/obelisk/workspace/review-notes.md`:

```markdown
# Review Outcome

**Status:** APPROVED | REJECTED

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

> "✓ REVIEW COMPLETE — Status: [APPROVED|REJECTED]"