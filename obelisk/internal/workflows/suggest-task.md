---
description: Suggest next tasks
---
**CURRENT STATE: TASK SUGGESTION**

Help the user choose the next task to work on.

> **Scope:** Advisory only. Does NOT create tasks or modify files.

---

## Gather Context (Read-only)

Read, if present:

1. **Project History**
   - `/obelisk/history-log.md`
   - Recent work, sequence, and unfinished threads
   - Detect deferred work, follow-ups, and recurring patterns
   - Avoid re-suggesting resolved questions
   - **Must NOT:** Treat discussions as commitments or override current authority

2. **Code Signals (Light scan)**
   - High-signal TODO / FIXME comments
   - Obvious missing pieces implied by existing code


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

Select the **top 2 candidates.

---

## Output

```
Here are some suggested tasks based on project state:

1. [Task Name]
   Why: [Brief reason]

2. [Task Name]
   Why: [Brief reason]

```


Suggested tasks are **examples only**.  
**They MUST NOT** be treated as selected unless the user explicitly describes them.