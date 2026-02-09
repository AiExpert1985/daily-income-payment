---
description: " Archive task and update memory"
---
**CURRENT STATE: TASK ARCHIVE**

Finalize task, write history, apply approved changes, and clean workspace.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/workspace/active-task.md`
- `/obelisk/workspace/plan.md`
- `/obelisk/workspace/implementation-notes.md`
- `/obelisk/workspace/review-notes.md`
- `/obelisk/workspace/contract-changes.md`
- `/obelisk/workspace/discovery-decisions.md`
- `/obelisk/history-log.md`

If any are missing → **STOP** and report missing path

---

## Determine Status

Read `/obelisk/workspace/review-notes.md` and extract status:
- `APPROVED` | `REJECTED`

Extract `[task-name]` from active-task.md header.

---

## Write History (Always)

Call `internal/operations/write-history.md`

**Input:**
- entry_kind: `TASK`
- name: [from active-task.md]
- status: `APPROVED` | `REJECTED`
- summary: [from discovery-decisions.md Summary]
- outcome: [from review-notes.md]
- decisions: [from discovery-decisions.md Decisions]
- deferred: [from discovery-decisions.md or review-notes.md]


---

## Status Gate — Rejected Tasks

If status is `REJECTED`:

**Archive workspace:**

Destination: `/obelisk/archive/rejected/YYYYMMDD-[task-name]/`

1. Create destination directory
2. Move ALL files from `/obelisk/workspace/` to destination
3. Verify `/obelisk/workspace/` is empty

**Output:**
```
⚠️ TASK CLOSED — REJECTED
Archived: /obelisk/archive/rejected/YYYYMMDD-[task-name]/

Addressing feedback requires creating a new task.
```

**STOP.**

---

## Append Contract Changes (Approved Only)

Read `/obelisk/workspace/contract-changes.md`

**If "No contract changes required":**
- Skip this step

**If changes specified:**
- Append approved entries verbatim to target file
- Target:
  - Feature contract if specified → `/obelisk/contracts/[feature].domain.md`
  - Otherwise → `/obelisk/contracts/core.domain.md`
- No inference, no rewording, no restructuring

**If destination missing:**
- Core contract → **STOP** (project not initialized)
- Feature contract → **STOP** (feature not created via task)

**On append failure → STOP**

---

## Archive Workspace (Approved Only)

Destination: `/obelisk/archive/completed/YYYYMMDD-[task-name]/`

**Steps:**
1. Create destination directory
2. Move ALL files from `/obelisk/workspace/` to destination
3. Verify `/obelisk/workspace/` is empty

---

## Output
```
✅ TASK CLOSED — APPROVED
Archived: /obelisk/archive/completed/YYYYMMDD-[task-name]/
```

**If memory word count > 4000:**
```
Note: Memory gardening recommended (run /maintain)
```

STOP.