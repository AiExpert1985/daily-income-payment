---
description: Create execution plan
---
**CURRENT STATE: TASK PLANNING**

Create a mechanical execution plan from the frozen task.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/workspace/active-task.md`
- `/obelisk/workspace/contract-changes.md`
- `/obelisk/guidelines/ai-engineering.md`
- `/obelisk/contracts/core.domain.md`

If any are missing → **STOP** and report missing path

---

## Code Analysis (Planning)

You MUST read the relevant code to produce an accurate plan.

**Allowed:**
- Inspect actual code structure, APIs, and dependencies
- Adjust steps to match real code layout
- Identify risks, edge cases, and required order of operations

**Forbidden:**
- Reinterpreting or expanding task intent
- Introducing new requirements or design decisions
- Modifying contracts or frozen task scope

---

## Planning Rules

**MUST:**
- Preserve all contracts
- Follow the frozen task exactly
- Make the plan executable without interpretation

**MUST NOT:**
- Change, reinterpret, or extend the task
- Invent requirements or features
- Make unstated assumptions
- Write code or ask questions
- Modify contracts (`core.domain.md`) 

---

## Blocking Conditions

Load `internal/workflows/abort-task.md` and STOP if:

- Task is internally contradictory or infeasible given current codebase or constraints
- Task intent cannot be executed as written without reinterpretation
- Task requires violating a contract **unless** explicitly approved in `/obelisk/workspace/contract-changes.md`

**STOP is terminal. No further execution is allowed.**

---

## Plan Output

Write to `/obelisk/workspace/plan.md`:
```markdown
# Plan: [Task name]

## Goal
[Copied from active-task.md]

## Requirements Coverage
- [Success criterion 1] → Step [X]
- [Success criterion 2] → Steps [Y, Z]

## Scope

### Files to Modify
- `/path/file.ext` — [what changes]

### Files to Create
- `/path/new-file.ext` — [purpose]

## Execution Steps

1. [Step description]
   - Action: [exact change]
   - Output: [expected result]

2. ...

## Acceptance Criteria
[Copied from active-task.md]

## Must NOT Change
- [Contracts and protected behavior]
```

**All sections required.** Use "None" if a section has no items.

---

**OUTPUT:**

> "✓ PLANNING COMPLETE — `plan.md` created"