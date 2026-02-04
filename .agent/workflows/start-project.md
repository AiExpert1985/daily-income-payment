---
description: Initialize new Obelisk project
---
**CURRENT STATE: PROJECT START**

Two-phase process: Discovery (discussion) → Initialization (file creation).

---

## Forbidden Pre-Existing State

The following MUST NOT exist:

**State files:**
- `/obelisk/state/*.domain.md`
- `/obelisk/memory/*.memory.md`
- `/obelisk/archive/project-history.md`

If any exist → **STOP**.

**Output to user:**
> ⛔ PROJECT INIT ABORTED  
> This project appears to be already initialized.  
> Re-initialization is blocked to prevent accidental data loss.  
> If you intended to start fresh, ensure no existing project state remains.

---

## Required Files

The following templates MUST exist:
- `/obelisk/templates/core.memory.template.md`
- `/obelisk/templates/feature.memory.template.md`
- `/obelisk/README.md`

If any file is missing → **STOP**.

**Output to user:**
> ⛔ PROJECT INIT FAILED  
> Required file not found: [file path]  
>  
> Ensure all files exist before running `/start-project`.

---

# PHASE 1: DISCOVERY

Understand the project through discussion. **No files created yet.**

---

## Discovery Rules

**Purpose**
- Understand the system
- Identify contract and project-memory candidates

**Questioning Rules**
- Ask only what materially affects contracts or long-lived understanding
- Do NOT propose solutions, designs, or code
- Do NOT assume missing information — surface it explicitly
- Prefer fewer, high-impact questions
- Skip obvious or deferrable details
- Group related clarifications into a single question

**Allowed Topics**
- System identity and boundaries
- Core invariants
- Global or technical constraints
- Safety or irreversible risks
- Long-lived design or UX intent

**Forbidden Topics**
- Implementation details
- Edge cases or speculative future features
- Preferences likely to change
- Anything deferrable to task-level work or clearly inferable

---

## Discovery Flow

### 1. Open

Output exactly:
```
PHASE 1: DISCOVERY

Describe your system to help initialize contracts and memory.
Type `skip` to use minimal defaults (not recommended).
```

**STOP. Wait for user response.**

- If `skip` → proceed to PHASE 2
- Otherwise → treat response as project description, proceed to Clarification

---

### 2. Clarification

#### Step 1 — Core Questions

Based on the project description provided by the user, ask questions that materially affect:
- System identity and boundaries
- Contracts and invariants
- Global constraints or risks
- Long-lived architectural or UX intent

Ask only what would change contracts or durable understanding.

---

#### Step 2 — Follow-up Questions

Ask follow-up questions **only if needed** to resolve ambiguity
introduced by earlier answers.


---

### 3. Summary

Present confirmed understanding for review.

If ambiguity remains:
- Record unresolved items under **Open Questions**
- Treat them as task-level concerns, not blockers
- Proceed with initialization

**Summary Format**
```markdown
**System Identity:**
- What it is:
- What it is NOT:
- Users:

**Contract Candidates:**
- Core:
- [Feature]:

**Project Memory Candidates:**
- Architectural decisions
- UX / design philosophy
- Explicit non-goals
- Known risks or tradeoffs

**Safety Concerns:**  
**Explicit Non-Goals:**  
**Open Questions:**
````

---

## Discovery Exit

Output exactly:
```
Review the summary above.
- Type `initialize` to create project files
- Or reply with corrections to update the summary

Awaiting input.
```

**STOP. Do not proceed until user responds.**

- If `initialize` → proceed to PHASE 2
- Otherwise → treat as corrections, update summary, confirm again

---

# PHASE 2: INITIALIZATION

Extract and persist confirmed project truth. **Non-interactive, non-creative.**

---

## Rules

- Use ONLY information explicitly established
- Do NOT invent, infer, or strengthen intent
- Be minimal — over-specification is failure
- List unresolved items explicitly

---

## Initialization (Skipped Discovery)

If discovery was skipped:

- Populate only what is explicitly stated
- Leave all other sections empty
- Do NOT infer or normalize missing information
- Do NOT create feature contract or memory files

---

## Required Outputs

### Contracts (`/obelisk/state/`)

**`core.domain.md`** — Project-wide invariants only:
- System identity and boundaries
- Global business rules
- Explicit non-goals
- Safety-critical rules
- Open questions

**`[feature].domain.md`** — Feature-specific invariants:
- Create only for features with distinct rules
- Do NOT duplicate or restate core contracts

### Project Memory (`/obelisk/memory/`)

Persist durable, non-authoritative project context.
**Template structure is authoritative. Content is advisory.**

**`core.memory.md`**
- Created once during initialization
- Must follow the canonical template exactly
- Template source:  `/obelisk/templates/core.memory.template.md`
- Create the file by copying the template verbatim
- Populate only explicitly confirmed sections
- Leave all other sections empty

**`[feature].memory.md`**
- Created only when explicitly approved (never inferred)
- Must follow the canonical feature template
- Template source:  `/obelisk/templates/feature.memory.template.md`
- Do NOT create empty feature memories
- Populate only confirmed sections
- Leave remaining sections empty


**Memory is non-authoritative and MUST NOT contradict contracts.**  
**Template structure is authoritative.**

---

### Discovery Log (`/obelisk/archive/`)

Create `discovery-log.md`.

#### If discovery was run:

Append **project-level discovery record**:

```markdown
# Discovery Log

## PROJECT DISCOVERY | YYYY-MM-DD

**Project Summary:**
Concise, bounded summary of the project as described and approved by the user.
Capture system purpose, users, boundaries, and high-level intent.
Do not include raw questions, speculation, or implementation detail.

**Decisions:**
- [Topic]: [decision or constraint] ([rationale if brief])
- [Topic]: [decision]
- [Topic]: [decision]

---
```

#### If discovery was skipped:

Create the file with header only:

```markdown
# Discovery Log

Append-only record of approved discovery decisions.
```

#### Rules:

- Record **curated, self-contained, user-approved understanding**
- Do **not** copy raw or verbatim user text
- Do **not** infer beyond confirmed discovery
- Append-only; **non-authoritative**
- Task-level discovery is appended later during `/archive-task`


---

### Project History (`/obelisk/archive/`)

Create `project-history.md`:

```markdown
# Project History

Append-only audit log. Not intended for linear reading.
```

---

## Output

> ✅ PROJECT INITIALIZED
> 
> **Created:**
> - `core.domain.md` + [N] feature contracts
> - `core.memory.md` + [N] feature memories
> - `project-history.md`
> - `discovery-log.md`
> 
> **Next:**
> - `/new-task` — Define the first task
> - `/suggest-task` — Get task recommendations


