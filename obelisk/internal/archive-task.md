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
- `/obelisk/workspace/discovery-decisions.md`
- `/obelisk/history-log.md`

If any are missing → **STOP** and report missing path

### Optional Inputs: 

- `/obelisk/workspace/contract-changes.md`

---

## Determine Status

Read `/obelisk/workspace/review-notes.md` and extract status:
- `APPROVED` | `REJECTED`

Extract `[task-name]` from active-task.md header.

---

## Write History (Always)

Call `internal/write-history.md`

**Input:**
- entry_kind: `TASK`
- name: [from active-task.md]
- status: `APPROVED` | `REJECTED`
- summary: [from discovery-decisions.md Summary]
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

**Check if `/obelisk/workspace/contract-changes.md` exists:**

**If file does not exist:**
- Skip this step (no contract changes)

**If file exists:**
- Append approved entries verbatim to `/obelisk/contracts/core.domain.md` under the section ## Recently added
- No inference, no rewording, no restructuring

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

STOP.