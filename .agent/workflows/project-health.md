---
description: Diagnose feature health
---
---

**CURRENT STATE: FEATURE DIAGNOSIS**

Reconstruct current reality from code + documents. Surface conflicts, drift, and risks.

---

## Command

`/diagnose` → List features, ask user to choose
`/diagnose [feature]` → Deep diagnosis

---

## Rules

- **Read-only** — no modifications except final report
- **Code-guided** — implementation is current reality, documents explain intent
- **No source is truth** — agreement = confidence, disagreement = flag
- **Evidence required** — every finding needs reference

---

## Inputs (read if present)

- Contracts: `[feature].domain.md`, `core.domain.md`
- Memory: `[feature].memory.md`, `core.memory.md`
- History: related tasks from `/obelisk/archive/completed/`
- Rationale: `/obelisk/archive/discovery-log.md`
- Code: feature source, services, boundaries

Missing inputs → note and continue.

---

## Stage 1: Reconstruct Current Reality

**Start from code:**
1. Identify actual services, data ownership, boundaries
2. Trace real execution paths and behaviors

**Layer in documents:**
3. Use contracts for intended invariants
4. Use tasks/memory for evolution and rationale
5. Use discovery-log for decision context

**Priority when conflicts arise:**
- Recent task + code agree → likely current reality
- Old doc contradicts code → likely stale
- Code violates contract with no task justification → likely bug

**Do NOT resolve conflicts.** Classify only.

---

## Stage 2: Health Check

### Contract Health
- Violations (code breaks invariant)
- Stale (doc claim, no code trace)
- Contradictions (docs disagree)

### Boundary Health
- Direct internal imports
- Data ownership leaks
- Missing service interfaces

### Code Risks
- Bugs (clear logic errors)
- Unhandled edges
- High-change areas (from task history)

---

## Finding Classification

| Type | Meaning |
|------|---------|
| **violation** | Code breaks documented invariant |
| **drift** | Code diverged from rationale |
| **stale** | Document has no code trace |
| **risk** | Potential bug or fragile area |
| **undocumented** | Code behavior without contract |

**Severity:** high (breaks invariant) / medium (boundary, gap) / low (stale doc)
**Confidence:** high / medium / low

---

## Output

### `/diagnose [feature]`

Write to `/obelisk/archive/diagnostics/YYYYMMDD-[feature].md`:
```markdown
# Diagnosis: [Feature Name]

**Date:** YYYY-MM-DD
**Feature:** [slug]

---

## Summary

| Confirmed | Conflicts | Undocumented | Stale | Boundary Issues |
|-----------|-----------|--------------|-------|-----------------|
| X | X | X | X | X |

---

## Findings

Ordered by severity (high → low).

### 1. [type] | [severity] | [confidence]
[One-line description]
**Location:** [file:line or doc:section]
**Evidence:** [Why this was flagged]
**Suggestion:** [One-line action]

### 2. [type] | [severity] | [confidence]
[One-line description]
**Location:** [file:line or doc:section]
**Evidence:** [Why this was flagged]
**Suggestion:** [One-line action]

---

## Suggested Tasks
- `/new-task [description]`
```

Display after saving:

```
✓ DIAGNOSIS COMPLETE

Feature: [name]
Confirmed: X | Conflicts: X | Undocumented: X | Stale: X | Boundaries: X

Report: /obelisk/archive/diagnostics/YYYYMMDD-[feature].md
```

---


### `/diagnose` (no argument)

List features from `/obelisk/state/*.domain.md`:
```
Available features:
- auth
- payments
- users

Run `/diagnose [feature]`
```

STOP.