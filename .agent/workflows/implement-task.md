---
description: Execute the planned task
---

**CURRENT STATE: TASK IMPLEMENTATION**

Execute the approved plan sequentially and deterministically.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/temp-state/task.md`
- `/obelisk/temp-state/plan.md`
- `/obelisk/guidelines/ai-engineering.md`

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


---

## Execution Rules

**MUST:**
- Execute steps in exact order defined in plan
- Modify ONLY files listed in plan
- Preserve all contracts and protected behavior

**MUST NOT:**
- Reinterpret, reorder, skip, merge, or redesign plan steps
- Silently fix plan errors beyond what the plan explicitly allows
- Modify contracts (`*.domain.md`) or project memory (`*.memory.md`) files
- Ask questions

---

## When to STOP

Load `/.agent/workflows/abort-task.md` and STOP ONLY if:

- A plan step is **impossible** given the actual code state
  - **Impossible** = plan's *intent itself* cannot be achieved without reinterpretation or new decisions
  - **Not impossible** = plan's *intent* remains achievable through mechanical adaptation
    (renames, moves, minor signature adjustments) → proceed and log divergence
  - **When uncertain** whether a change is mechanical or requires new decisions → **STOP**

- Continuing would **violate a contract** or frozen intent
  **and** that violation is **not** explicitly authorized in
  `/obelisk/temp-state/task.md → Contract Changes`

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

Create `/obelisk/temp-state/implementation-notes.md` after implementation.

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


**Success:**
> "✓ IMPLEMENTATION COMPLETE — `implementation-notes.md` created"
>
> `/review-task` — run review
> `/abort-task` — Cancel and archive progress