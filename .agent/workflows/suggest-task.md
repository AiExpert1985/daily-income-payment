---
description: Suggest next tasks
---
**CURRENT STATE: TASK SUGGESTION**

Help the user choose the next task to work on.

> **Scope:** Advisory only. Does NOT create tasks or modify files.

---

## Input

- `/suggest-task`
- `/suggest-task [focus area]` (e.g., "auth", "ui", "refactor")

---

## Gather Context (Read-only)

Read, if present:

1. **Project History**
   - `/obelisk/archive/project-history.md`
   - Recent work, sequence, and unfinished threads

2. **Memory (Signal only)**
   - `/obelisk/memory/core.memory.md`
     - Backlog
     - Open Questions
     - Recent Activity
   - Feature memory files related to focus area (if any)

3. **Code Signals (Light scan)**
   - High-signal TODO / FIXME comments
   - Obvious missing pieces implied by existing code

4. **Discovery Log (Optional)**
   - `/obelisk/archive/discovery-log.md`
   - Detect deferred work, follow-ups, and recurring patterns
   - Avoid re-suggesting resolved questions
   - **Must NOT:** Treat discussions as commitments or override current authority

---

## Generate Suggestions

Identify candidate tasks from context.

**Priority (highest first):**
1. Deferred or explicit follow-ups
2. Natural continuation of recent work
3. Unblockers for known goals
4. Backlog items
5. Critical code health issues

**Filter:**
- Skip already-completed work
- If focus area specified, only suggest related tasks

Select the **top 3** candidates.

---

## Output
```
Suggested Next Tasks:

1. [Task Name]
   Why: [Brief reason]
   → `/new-task [Task Name]`

2. [Task Name]
   Why: [Brief reason]
   → `/new-task [Task Name]`

3. [Task Name]
   Why: [Brief reason]
   → `/new-task [Task Name]`
```

---

## Exit

> "Copy a command above, or `/suggest-task [focus]` to refine."

STOP.