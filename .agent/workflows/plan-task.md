---
description: Create execution plan
---
**CURRENT STATE: TASK PLANNING**

Create a mechanical execution plan from the frozen task.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/temp-state/task.md`
- `/obelisk/guidelines/ai-engineering.md`

If any are missing → **STOP**, and report

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

## Code Analysis (Planning)

You MUST read the relevant code to produce an accurate plan.

Allowed:
- Inspect actual code structure, APIs, and dependencies
- Adjust steps to match real code layout
- Identify risks, edge cases, and required order of operations

Forbidden:
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
- Modify contracts (`*.domain.md`) or project memory (`*.memory.md`) files

---

## Blocking Conditions

Load `/.agent/workflows/abort-task.md` and STOP if:
- Task is internally contradictory or infeasible given the current codebase or constraints
- If the task intent cannot be executed as written without reinterpretation
- Task requires violating a contract
  **unless** that violation is explicitly listed and approved in
  `/obelisk/temp-state/task.md → Contract Changes`

**STOP is terminal. No further execution is allowed.**

---

## Plan Output

Write to `/obelisk/temp-state/plan.md`:

```markdown
# Plan: [Task name]

## Goal
[Copied from task.md]

## Requirements Coverage
- [Success criterion 1] → Step [X]
- [Success criterion 2] → Steps [Y, Z]
- ...

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
[Copied from task.md]

## Must NOT Change
- [Contracts and protected behavior]
````

**All sections required.** Use "None" if a section has no items.

---

**Success:**

> "✓ PLANNING COMPLETE — `plan.md` created"
> 
> `/implement-task` — run implementation  
> `/abort-task` — Cancel and archive progress