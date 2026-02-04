---
description: Quick project status
---

# CURRENT STATE: PROJECT STATUS

Read-only snapshot for fast project re-entry.

---

## Project Health

Check required core files exist:
- `/obelisk/state/core.domain.md`
- `/obelisk/memory/core.memory.md`
- `/obelisk/archive/project-history.md`

If any core file is missing → **STOP** and output:

> ⚠️ Project not initialized. Run `/start-project`.

Optional feature files (if any):
- `/obelisk/state/[feature].domain.md`
- `/obelisk/memory/[feature].memory.md`

---

## Recent Work

Read:
- `/obelisk/archive/project-history.md`
- `## Recent Activity` from all `*.memory.md` files

Summarize in **2–3 sentences**:
- Main areas worked on
- What was completed, rejected, or deferred
- Bias toward most recent work
- Do NOT list individual tasks or counts

---

## Active Task

Check `/obelisk/temp-state/`.

Determine phase by first match:
- `review-notes.md` → **REVIEWED**
- `implementation-notes.md` → **IMPLEMENTED**
- `plan.md` → **PLANNED**
- `task.md` only → **DEFINED**
- None → **NO ACTIVE TASK**

If active:
- Read task name from `task.md`
- Show: `"[Task name]" — [Phase]`

---

## Output

```

OBELISK STATUS

Health:
- Contracts: ✓
- Memory: ✓
- History: ✓

Recent work:
- Auth: login and token flow completed; SMS auth rejected.
- Users: user creation completed.

Active task:
- "Add user roles" — Implemented
```

STOP.
