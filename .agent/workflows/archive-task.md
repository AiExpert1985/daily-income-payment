---
description: " Archive task and update memory"
---

**CURRENT STATE: TASK ARCHIVE**

Archive task materials, update project memory, and clean workspace.

---

## Preflight

### Required Inputs

The following MUST exist:
- `/obelisk/temp-state/task.md`
- `/obelisk/temp-state/plan.md`
- `/obelisk/temp-state/implementation-notes.md`
- `/obelisk/temp-state/review-notes.md`
- `/obelisk/archive/discovery-log.md`
- `/obelisk/archive/project-history.md`

If any are missing → **STOP**, report the missing file path.

---

## Determine Destination

Read `/obelisk/temp-state/review-notes.md` and extract status:
- APPROVED | CHANGES REQUIRED

| Status           | Archive Path                                       |
| ---------------- | -------------------------------------------------- |
| APPROVED         | `/obelisk/archive/completed/YYYYMMDD-[task-name]/` |
| CHANGES REQUIRED | `/obelisk/archive/rejected/YYYYMMDD-[task-name]/`  |

Extract `[task-name]` from task.md header.

---

## Archive

1. Create destination directory

2. Move ALL files from `/obelisk/temp-state/` to archive:
   - `task.md`
   - `plan.md`
   - `implementation-notes.md`
   - `review-notes.md`

---

## Update Project History

Append to `/obelisk/archive/project-history.md`:
```markdown
## YYYY-MM-DD | [task-name] | [APPROVED|CHANGES REQUIRED]
Goal: [One-line goal from task.md]
Deferred: [From review-notes.md if present, else "None"]
```

---

## Status Gate

If status is **CHANGES REQUIRED**:

- Do NOT apply contract changes or update project **memory**
- Output:

```
⚠️ TASK CLOSED — CHANGES REQUIRED  
Archived: `/obelisk/archive/rejected/[folder]/`

Rejected tasks are archived as historical records.
Addressing review feedback requires creating a new task.
```

STOP.

---

### Commit Discovery Decisions

If task status is APPROVED and discovery-qa.md exists:

1. Append discovery-qa.md to: `/obelisk/archive/discovery-log.md`
2. Delete discovery-qa.md

**Rules**:
- Do not modify content
- Do not write for aborted or rejected tasks

---
## Feature Isolation (If Specified)

**Purpose:** Move new long-lived feature contracts and memory into dedicated files.

**When:** Only if archived `task.md` contains a `## Feature Isolation` section.


### Preconditions

Read archived `task.md`.

- If no `## Feature Isolation` section → **skip this entire step**
- Otherwise, follow instructions exactly as written

**Expected structure in task.md:**
```markdown
## Feature Isolation

**Feature:** [feature-name]

**Contracts** → `/obelisk/state/[feature].domain.md`
- Move from `core.domain.md`: [exact text]
- Create new: [exact text]

**Memory** → `/obelisk/memory/[feature].memory.md`
- Move from `core.memory.md`: [exact text]
```


### Execution

1. **Ensure target files exist**
   - Create missing files as follows:
     - `[feature].domain.md` → create empty file (no template)
     - `[feature].memory.md` → from `/obelisk/templates/feature.memory.template.md`

2. **Apply exactly as written**
   - **Move** → copy to target, then delete from source
   - **Create** → write directly to target

3. **Execution order**
   - Feature isolation runs **before** any other contract changes
   - Within feature isolation: moves before creates
   - Contracts before memory


### Rules

- No inference, rewriting, or expansion
- If source item missing or operation fails → skip and note in output
- Feature isolation errors do not block archive completion

---

### Commit Contract Changes

If archived `task.md` contains **Contract & Memory Changes (Optional)**:
- **`create`:** create file from domain template if missing
- **`update`:** modify specified section only

If a change conflicts or is unsafe:
- Skip the change
- Do NOT block archive

---

### Commit Project Memory Updates (Append-Only)

Record durable understanding **only if** it emerged from execution and review.

**Target:**
- Single feature → `/obelisk/memory/[feature].memory.md`
- Otherwise → `/obelisk/memory/core.memory.md`
- Create from template if missing

**Append under:** `## Recent Activity → APPEND ONLY BELOW THIS LINE`

``` markdown

- **[Task Name]**
  • Change: [what changed]
  • Decision: [if any]
  • Constraint / Risk: [if any]
  • UX / Behavior: [if any]
  • Non-Goal / Rejection: [if any]
  • Follow-up: [if any]
```


**Rules:**
- Do not modify Garden sections
- Do not narrate discussion or infer
- Skip if nothing durable was learned

**Gardening:**  
If word count > 4000 → run /.agent/workflows/garden-memory.md

---

## Output

**If APPROVED:**
> "✅ TASK CLOSED — APPROVED
> Archived: `/obelisk/archive/completed/[folder]/`"

STOP.