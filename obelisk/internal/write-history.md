---
description: Write a single append-only entry to history-log.md (atomic operation)
---
**OPERATION: WRITE HISTORY**

## Preconditions

- `/obelisk/history-log.md` **MUST exist**
- If missing → **STOP**

---

## Input

| Field     | Required | Description                                                        |
| --------- | -------- | ------------------------------------------------------------------ |
| name      | Yes      | Project name, task name, or hotfix slug                            |
| status    | Yes      | `INITIALIZED` \| `APPROVED` \| `REJECTED` \| `ABORTED` \| `HOTFIX` |
| summary   | Yes      | One-line description                                               |
| decisions | No       | List of decisions made                                             |
| deferred  | No       | List of deferred items                                             |

`INITIALIZED` should be written only once, during project initialization.

---

## Process

### Append Entry

Append the following block to the end of the file using the current date
(`YYYY-MM-DD`):

```markdown
## YYYY-MM-DD | [name] | [status]

**Summary:** [summary]  
```

#### Optional: Decisions

Include only if `decisions` is provided and non-empty:

```markdown
**Decisions:**
- [decision 1]
- [decision 2]

```

#### Optional: Deferred

Include only if `deferred` is provided and non-empty:

```markdown
**Deferred:**
- [item 1]
- [item 2]
```

Terminate entry with:

```
---
```

---

## Formatting Rules

- Always append to end of file
- Never modify existing entries
- Maintain exact section order
- Preserve spacing and separators
- One entry = one real-world event
- Do not infer missing fields
- Omit optional sections entirely if empty

---

## Return to Caller

```markdown
history_written:
- name: [name]
- status: [status]
- date: YYYY-MM-DD
```
