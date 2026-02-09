
# Obelisk Framework

## Overview

Obelisk is a framework for **human–AI collaboration** designed to make AI-assisted development **safe, repeatable, and recoverable** over long-running software projects.

It is intended for **real applications that are built to live and grow**, not for hobby apps or throwaway prototypes.

> **AI does not fail because it is weak — it fails because long-term use is unmanaged.**

Obelisk intentionally trades early friction for long-term safety, correctness, and sustained development speed.

> **Contracts define truth. Tasks freeze intent. Plans constrain execution.  
> Memory and history explain context. Archives preserve everything.**

Higher layers constrain lower ones. Lower layers must never redefine higher ones.

> Conceptually, Obelisk defines a **collaboration protocol**, and this repository provides a reference framework implementing it.

---

## Core Properties

- Files are the source of truth — chat history is not
- Sessions are stateless — models are interchangeable
- Intent is frozen before execution
- Memory is advisory and lossy by design
- All mutations flow through tasks
- Recovery matters more than perfection
- Friction is proportional to risk

---

## Commands

| Command                      | Purpose                                |
| ---------------------------- | -------------------------------------- |
| `/start-project`             | Universal entry                        |
| `/define-task [description]` | Create new tasks                       |
| `/run-task`                  | Run task from current phase to the end |
| `/maintain [feature]`        | Analyze health, generate fix tasks     |
| `/help`                      | Show available commands                |

### How `/task` Works

- **No description?** → Suggests 2–3 tasks
- **Simple fix?** → Auto-detects and offers hotfix path
- **Complex task?** → Full discovery, then freeze intent
- **After freeze** → Say `/run`,  or  update the task
- **Interrupted?** → Say `/run` to resume from any phase

### How `/maintain` Works

- Analyzes code, contracts, and memory for drift
- Surfaces top issues with severity ranking
- Generates fix tasks (contract updates, code fixes)
- All fixes flow through the normal task lifecycle

---

## Task Lifecycle

```
task → plan → implement → review → archive
```

All phases run automatically. The system detects current state and resumes if interrupted.

**Hotfix path:** Simple mechanical fixes (typos, null checks) bypass the full lifecycle but are always recorded.

---

## File Structure

```
/obelisk/
├── contracts/                    # Authoritative business invariants
│   ├── core.domain.md
├── workspace/                    # Ephemeral execution state (single active task)
│   ├── active-task.md
│   ├── plan.md
│   ├── implementation-notes.md
│   └── review-notes.md
├── history-log.md                # Live audit trail (actively consulted)
├── archive/
│   ├── diagnostics/              # Maintenance reports
│   ├── completed/
│   ├── rejected/
│   └── aborted/
├── guidelines/
│   └── ai-engineering.md
└── internal/                     # Framework internals (not user-callable)
    ├── workflows/
    ├── operations/
    └── templates/
```

---

## Authority & Knowledge Systems

Obelisk separates **truth**, **intent**, **execution**, **context**, and **history** into explicit artifacts with strict authority boundaries.

### Contracts (`*.domain.md`) — **Authoritative Truth**

Business invariants that must always hold.

- Updated only through completed tasks
- Include a **Pending Review** section for observations awaiting `/maintain`

**Authority:** Highest. Contracts always win.

---

### Tasks (`workspace/task.md`) — **Frozen Intent**

Defines what is being attempted and why.

- Created during `/new-task`
- Immutable once frozen
- Exists only while active, then archived

**Authority:** Below contracts, above plans and code.

---

### AI Engineering Rules (`ai-engineering.md`) — **Execution Constraints**

Defines how the agent plans, implements, and reviews.

- Read-only during all workflows
- Cannot override contracts or frozen task intent

**Authority:** Below tasks, above memory.

---

### History Log (`history-log.md`) — **Audit Trail**

Complete record of all tasks and decisions.

- Append-only
- Actively consulted during discovery, maintenance, and status
- Replaces separate history and discovery files

**Authority:** Non-authoritative. Explains what happened; never defines truth.

---

### Archives (`/obelisk/archive/`) — **Full History**

- `completed/` — Approved tasks with all artifacts
- `rejected/` — Tasks needing revision
- `aborted/` — Cancelled tasks
- `diagnostics/` — Maintenance reports

Used for auditability and recovery — never execution.

---

### Authority Hierarchy (Highest → Lowest)

1. Contracts
2. Active Task
3. AI Engineering Rules
4. History Log
5. Chat History

**Rule:** Higher authority always wins.

---

## Single Mutation Path

All changes — code, contracts, memory — flow through the task lifecycle.
- No hidden updates
- No bypassing tasks for “quick” contract changes
- Complete audit trail by default
- Tasks become version history

---

## Maintenance

`/maintain` is the framework’s immune system:
- Detects contract violations and staleness
- Detects code risks and boundary violations
- Suggests feature isolation when needed

Run periodically to keep the system healthy.

---

## Scope of This File

This README provides **orientation only**.

It does **not**:
- Define project-specific rules
- Override contracts, tasks, or plans
- Participate in authority resolution

Correctness is enforced by contracts, frozen tasks, and execution rules — not this document.
