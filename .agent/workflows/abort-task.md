---
description: Abort & document current task
---

**CURRENT STATE: TASK ABORT**

Reset the system to a clean state.

---

## Command

`/abort-task [reason]`

- If `reason` provided → use as **Reason**
- If omitted → **Reason:** "User requested"

---

## Preflight

**Required:**
- `/obelisk/temp-state/task.md`
- `/obelisk/archive/project-history.md`

If any are missing → **STOP**, report the missing file path.

### Detect Phase (from files present)

Determine phase by the first matching file below (top to bottom):

- `review-notes.md` → **REVIEW**
- `implementation-notes.md` → **IMPLEMENTATION**
- `plan.md` → **PLANNED**
- `task.md` only → **TASK DEFINED**

### Task Name
- From `task.md` header if present  
- Else → `draft-context`

### Archive Path
`/obelisk/archive/aborted/YYYYMMDD-[task-name]/`

---

## Archive & Reset

1. Create archive directory
2. **MOVE ALL files** from `/obelisk/temp-state/` into archive
3. Create `abort-summary.md`:

```markdown
**Date:** [YYYY-MM-DD]
**Phase:** [Detected Phase]
**Aborted By:** [USER | SYSTEM]
**Reason:** [One sentence]
```

**Note:**  
Who initiated the abort (USER or SYSTEM) is inferred from context and recorded.

---

## Update Project History

append to `/obelisk/archive/project-history.md`:
```markdown
## YYYY-MM-DD | [task-name] | ABORTED
Goal: [One-line goal from task.md, or "Task undefined"]
Reason: [Abort reason from step 1]
```

Skip if no task.md existed (nothing meaningful to log).

---
## Output
```
🛑 TASK ABORTED

Archived: /obelisk/archive/aborted/YYYYMMDD-[task-name]/
Phase: [Phase]
Reason: [Reason]

System ready for next task.
```

**Note:** If this abort revealed durable learning (fundamental constraint, rejected approach, or external blocker), the user may later append it to the appropriate memory file under Constraints / Graveyard / Open Questions using the format: `[ABORT YYYYMMDD-task-name] One sentence summary`

STOP.