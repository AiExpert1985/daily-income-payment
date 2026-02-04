
# Obelisk Framework

## Overview

Obelisk is a framework for **human–AI collaboration** designed to make AI-assisted development **safe, repeatable, and recoverable** over long-running software projects.

It is intended for **real applications that are built to live and grow**, not for hobby apps or throwaway prototypes.

> **AI does not fail because it is weak — it fails because long-term use is unmanaged.**

Obelisk intentionally trades early friction for long-term safety, correctness, and sustained development speed.

> **Contracts define truth. Tasks freeze intent. Plans constrain execution.  
> Memory and logs explain context. Archives preserve history.**

Higher layers constrain lower ones. Lower layers must never redefine higher ones.

---

## Core Properties

- Files are the source of truth — chat history is not
- Sessions are stateless — models are interchangeable
- Intent is frozen before execution
- Memory is advisory and lossy by design
- History lives in Git and task archives
- Recovery matters more than perfection
- Friction is proportional to risk

---

## How Obelisk Is Used

All projects — new codebases or existing codebases — **must begin with** `/start-project`.

- Initializes contracts, memory, and history
- Discovery is optional and can be skipped when prompted


For complex or existing projects, skip discovery to start with minimal setup and introduce contracts incrementally through tasks.

---

## Quick Start

**Initialize Obelisk (new or existing project):**

```bash
/start-project  # Discovery optional—can skip for existing codebases
```

**Standard workflow:**

```bash
/new-task [description]
/execute-task
```

**Other common flows:**

```bash
/hotfix [description]
/suggest-task
/project-status
```

---

## Commands

### Core Workflows

|Command|Purpose|
|---|---|
|`/start-project`|Initialize contracts + memory|
|`/new-task`|Define and freeze task intent|
|`/execute-task`|Run full flow: plan → implement → review → archive|
|`/update-task`|Modify frozen task before execution|
|`/abort-task`|Cancel and archive current task|

### Utilities

| Command           | Purpose                                       |
| ----------------- | --------------------------------------------- |
| `/diagnose`       | Diagnose feature health and surface conflicts |
| `/hotfix`         | Guarded fast path for small mechanical fixes  |
| `/suggest-task`   | Recommend next tasks                          |
| `/project-status` | Snapshot of project health and active task    |
| `/garden-memory`  | Compress project memory                       |
| `/help`           | Show available commands                       |
### Manual Phases

For step-by-step execution or debugging:  
`/plan-task`, `/implement-task`, `/review-task`, `/archive-task`

---

## Task Lifecycle

During task discovery (`/new-task`), the agent inspects only relevant parts of the codebase to **understand the user’s intent in context** — not to infer solutions, redesign the system, or execute changes.

```
/new-task → task.md
↓
/plan-task → plan.md
↓
/implement-task → implementation-notes.md
↓
/review-task → review-notes.md
↓
/archive-task
```

`/execute-task` runs all phases automatically.

### Hotfix Path

`/hotfix` is a **guarded fast path** for small, low-risk, mechanical changes only.

Hotfixes:

- Must not modify contracts
- Must remain small and atomic
- Are rejected automatically if risk or size is detected
- Are always recorded in project history

---

## File Structure

```
/obelisk/
├── state/
│   ├── core.domain.md
│   └── [feature].domain.md
├── memory/
│   ├── core.memory.md
│   └── [feature].memory.md
├── temp-state/
│   ├── task.md
│   ├── plan.md
│   ├── implementation-notes.md
│   └── review-notes.md
├── templates/
│   ├── core.memory.template.md
│   └── feature.memory.template.md
├── archive/
│   ├── diagnostics/
│   ├── project-history.md
│   ├── discovery-log.md
│   ├── completed/
│   ├── rejected/
│   └── aborted/
└── .agent/workflows/
```

---

## Authority & Knowledge Systems

Obelisk separates **truth**, **intent**, **context**, and **history** into explicit artifacts with strict authority boundaries.

### Contracts (`*.domain.md`) — **Authoritative Truth**

Business invariants that must always hold.
- Proposed explicitly during `/new-task`
- Applied only during `/archive-task` of an approved task
- Frozen during planning, implementation, review, and hotfixes
- Aborted or rejected tasks must not modify contracts

**Authority:** Highest. If anything conflicts with contracts, contracts win.

---

### Tasks (`task.md`) — **Frozen Intent**

Defines what is being attempted and why.
- Created and approved during `/new-task`
- Immutable once frozen
- Exists only while active, then archived

**Authority:** Below contracts, above plans and code.

---

### AI Engineering Rules (`ai-engineering.md`) — **Execution Constraints**

Defines how the agent is allowed to plan, implement, and review work.
- Read-only during all workflows
- Enforced during planning, implementation, review, and hotfixes
- Cannot override contracts or frozen task intent

**Authority:** Below tasks, above memory and code  
It constrains execution behavior, not system truth.


---

### Project Memory (`*.memory.md`) — **Advisory Context**

Durable context cache for patterns and rationale.
- Non-authoritative and lossy by design
- Updated only at lifecycle checkpoints
- May be compressed via `/garden-memory`
- Not documentation; full history lives in archives and Git

**Authority:** Advisory only  
If memory conflicts with contracts or tasks, it is wrong.

---

### Discovery Log (`/obelisk/archive/discovery-log.md`) — **Decision Rationale**

Explains _why_ approved decisions were made.

- Records concise, user-approved discovery Q/A
- Written during `/new-task`, committed only on successful `/archive-task`
- Append-only; excludes aborted or rejected tasks

Used by:
- `/suggest-task`
- `/contract-doctor`
- `/garden-memory`

**Authority:** Non-authoritative  
It explains decisions; it never defines them.

---

### Task Archives (`/obelisk/archive/`) — **Audit Trail**

Preserve full task history.

- `completed/` — approved and implemented tasks
- `rejected/` — tasks needing revision
- `aborted/` — cancelled tasks

Used for auditability, learning, and recovery — never execution.

---

### Project History (`project-history.md`) — **Chronological Index**

Minimal timeline of all task outcomes.

- Append-only
- One line per task (date, name, status)
- Used for quick project re-entry and sequencing

---

### Diagnostics (`/obelisk/archive/diagnostics/`) — **Health Records**

Feature health reports generated by `/diagnose`.

- Conflicts between documents and code
- Boundary violations and implementation risks
- Append-only, date-prefixed files
- For tracking health over time, not execution

**Authority:** Non-authoritative  
Reports findings; does not define intent or truth.


---

### Authority Hierarchy (Highest → Lowest)

1. Contracts
2. Active Task
3. AI Engineering Rules
4. Project Memory
5. Discovery Log
6. Chat History

**Rule:** Higher authority always wins.

---

## Scope of This File

This README provides **orientation only**.

It does **not**:
- Define project-specific rules
- Override contracts, tasks, or plans
- Participate in authority resolution

Correctness is enforced by contracts, frozen tasks, guarded hotfixes, and execution rules — not this document.