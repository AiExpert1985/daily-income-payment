---
description: Auto-execute task until the end
---

 **CURRENT STATE: RUN**

Execute the active task from its current phase.

---

## Preconditions

- `/obelisk/workspace/active-task.md` **MUST exist**

If missing → **STOP**

```
No active task.
Use /task to create one.
```

---

## Phase Detection

Determine state from workspace files:

| Files Present             | State       | Next                                |
| ------------------------- | ----------- | ----------------------------------- |
| `active-task.md`          | DEFINED     | Plan → Implement → Review → Archive |
| `plan.md`                 | PLANNED     | Implement → Review → Archive        |
| `implementation-notes.md` | IMPLEMENTED | Review → Archive                    |
| `review-notes.md`         | REVIEWED    | Archive                             |

---

## Execution

Run all remaining phases in order until completion or STOP.

## Phase Workflows

| Phase     | Workflow                               |
| --------- | -------------------------------------- |
| Plan      | `/obelisk/workspace/plan-task.md`      |
| Implement | `/obelisk/workspace/implement-task.md` |
| Review    | `/obelisk/workspace/review-task.md`    |
| Archive   | `/obelisk/workspace/archive-task.md`   |

**Rules**

- Read workflow and execute as instructions
- Missing required files → **STOP**, report paths
- Workflow STOP → halt immediately
- Review + Archive are always paired

---

## Output

No user-facing output unless:
- STOP condition
- Error
- Final archive confirmation
