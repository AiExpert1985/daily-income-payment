---
description: Diagnose feature health
---
**CURRENT STATE: MAINTENANCE**

Analyze feature health and generate fix tasks.

---

## Command

`/maintain [scope]`

Where `[scope]` is `core` or a feature name.

---

## Entry Point

**If no scope provided:**

List available features from quick survey of the code

Output:

``` markdown
Select maintenance scope:
- core
- [feature-1]
- [feature-2]

Run: /maintain [scope]
```

**STOP and wait user input**

---

## Preflight

Required:
- `/obelisk/contracts/core.domain.md`

Missing → **STOP. Show error.**


---

## Stage 1: Analysis (Read-Only)

### Gather Inputs

Read for selected scope:
- Code (ground truth)
- Contracts (authoritative intent)
- History-log (temporal context)
- Related archived tasks (evolution context)

Use history and archives to detect staleness, repetition, and deferred work.

---

### Conflict Classification

| Situation                 | Classify As            |
| ------------------------- | ---------------------- |
| Code + recent task agree  | OK                     |
| Contract contradicts code | Contract issue (stale) |
| Code violates contract    | Code issue             |

**Do not resolve. Only classify.**

---

### Detect Issues

**Code:** bugs, risks, boundary violations, contract violations, undocumented behavior  
**Contracts:** violated, stale (no recent activity), missing coverage, pending items

---

### Severity

- **CRITICAL** — invariant break, bug, security, data loss
- **MODERATE** — drift, boundary issues, missing coverage
- **LOW** — cleanup

Rank by severity.

---

### Save Diagnostic Report

Write:

`/obelisk/archive/diagnostics/YYYYMMDD-[scope].md`

Include:
- Counts by category × severity
- **Top 3–5 issues per category**
- Full findings with evidence

---

## Stage 2: Present Findings

Show **top 3-5** issues (ordered by severity):

``` markdown
✓ MAINTENANCE COMPLETE: [scope]

Summary:
- Code: [N] critical, [N] moderate, [N] low
- Contracts: [N] critical, [N] moderate, [N] low

Issues:
1. [CRITICAL | code] — [description]
2. [CRITICAL | contract] — [description]
3. [MODERATE | code] — [description]

Report:
  /obelisk/archive/diagnostics/YYYYMMDD-[scope].md

```

---

## User Selection

``` markdown
Select issues to fix (comma-separated numbers),
or choose:

- all        → fix all listed issues
- extended   → show full issue list
- skip       → exit

```

**STOP. Await input.**

---

## Stage 3: Internal Task Materialization

_(Internal only)_

## Validate Selection

If selection contains invalid indices → STOP and re-prompt

### passing tasks

- Invoke `/task` by running: `/.agent/workflows/task.md`
- Pass the user selected issues to /task  as the task description
- Transfer control to `/task` immediately
