---
description: Update existing task
---


**CURRENT STATE: TASK UPDATE**

Refine an existing frozen task by re-running discovery via `/new-task`.

> **Scope:** `/update-task` modifies task intent only.  
> Validation, questioning, contracts, and freezing are handled by `/new-task`.

---

## Input

- `/update-task [description]` → `update_req`
- `/update-task` (no description) → Ask: "What changes are required (scope, constraints, or success criteria)?" → Wait

**If `update_req` is vague** (e.g., "improve it"):
> "Please specify concrete changes (scope, constraints, or success criteria)."

Wait for response.

---

## Load Existing Task

Read `/obelisk/temp-state/task.md`.

**If missing:**
> ❌ No task to update. Use `/new-task`.

STOP.

---

## Execute Updated Task

Run `/new-task` with this task description:
```markdown
TASK UPDATE REQUEST

**Original Task:**
[Full content of task.md]

**Requested Changes:**
[update_req]

**Merge Rules:**
- Requested Changes override Original Task on conflict
- Result must be complete and self-contained
- Contract changes require explicit approval during discovery
```

STOP (control passes to `/new-task`, which will replace the current task if successful).
