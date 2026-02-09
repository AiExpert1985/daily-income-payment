---
description: Execute the planned task
---

**CURRENT STATE: TASK IMPLEMENTATION**

Execute the approved plan sequentially and deterministically.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/workspace/active-task.md`
- `/obelisk/workspace/plan.md`
- `/obelisk/workspace/contract-changes.md`
- `/obelisk/guidelines/ai-engineering.md`
- `/obelisk/contracts/core.domain.md`

If any are missing → **STOP** and report missing path


---

## Execution Rules

**MUST:**
- Execute steps in exact order defined in plan
- Modify ONLY files listed in plan
- Preserve all contracts and protected behavior

**MUST NOT:**
- Reinterpret, reorder, skip, merge, or redesign plan steps
- Silently fix plan errors beyond what the plan explicitly allows
- Modify contracts (`core.domain.md`)
- Ask questions

---

## When to STOP

Load `/obelisk/internal/workflows/abort-task.md` and STOP ONLY if:

- A plan step is **impossible** given the actual code state
  - **Impossible** = plan's *intent itself* cannot be achieved without reinterpretation or new decisions
  - **Not impossible** = plan's *intent* remains achievable through mechanical adaptation
    (renames, moves, minor signature adjustments) → proceed and log divergence
  - **When uncertain** whether a change is mechanical or requires new decisions → **STOP**

- Task requires violating a contract **unless** explicitly approved in `/obelisk/workspace/contract-changes.md`

- Completing the step requires **critical decisions not covered by the plan**

- Continuing would risk **irreversible or unsafe changes** (e.g., data loss)

**STOP is terminal. No further execution is allowed.**

---

### Allowed to Proceed (No STOP)

Proceed **only if** observable behavior and intent remain unchanged.  
If uncertain whether a change is mechanical → **STOP**.

**Safe divergences include:**
- Mechanical adjustments to match actual code structure
- Formatting or whitespace changes
- Variable renames with identical meaning
- Import reordering
- Syntax/API adjustments required by actual code state
- Defensive null checks matching existing patterns
- Mechanical micro-details fully determined by the plan

Log any divergence in `implementation-notes.md`.

---

## Implementation Notes

Create `/obelisk/workspace/implementation-notes.md` after implementation.

**If divergences:**
```markdown
## Divergences
- Plan specified: [X]
- Actual: [Y]
- Reason: [mechanically necessary because...]
```

**If no divergences:**
```markdown
Plan implemented as specified. No divergences.
```

---


**OUTPUT:**

> "✓ IMPLEMENTATION COMPLETE — `implementation-notes.md` created"
