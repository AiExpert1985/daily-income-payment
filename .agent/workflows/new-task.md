---
description: Creates a new Obelisk task
---

**CURRENT STATE: TASK DISCOVERY**

Define a new task through discussion.

---

## EXECUTION GUARD (CRITICAL)

Task Discovery defines intent.

You MUST NOT plan, implement, or modify code during this phase.  
If execution is triggered at any point → **STOP immediately**.

---

## Entry Point Detection

**Check if task description was provided:**

**IF user provided description:**
```
/new-task Add image picker to main screen
```
- Extract task_description = "Add image picker to main screen"
- Proceed to Preflight

**IF no description:**
```
/new-task
```
- Output: "Please describe the task you'd like to work on."
- Wait for response
- Set task_description = [response]
- Proceed to Preflight

---

## Preflight

### Clean Workspace

- Delete all files in `/obelisk/temp-state/`

### Load Inputs

#### Required Files (Mandatory)

Always load these files.  
If any are missing → **STOP** and report the missing path.

- `/obelisk/state/core.domain.md`
- `/obelisk/memory/core.memory.md`
- `/obelisk/guidelines/ai-engineering.md`
- `/obelisk/README.md`

#### Context Files (Conditional)

**Contracts:**
1. Read feature contracts when task scope appears to involve them  
   (task description, affected files, or potential invariants)
2. If uncertain, read the feature contract

**Memory (advisory only):**
1. Read feature memory when it provides relevant historical context
2. If uncertain, reading memory is optional

**Rule:** Missing a contract is worse than extra tokens. Memory is advisory.



---

## Code Reconnaissance (Optional, Bounded)

You MAY read code during Task Discovery, but ONLY to answer:
- **“Where does this change live?”**
- **“Which modules / files are likely affected?”**
- **“Do existing contracts already cover this area?”**

You MUST NOT:
- Design the solution
- Prototype implementation details
- Perform broad refactors

**Stop reconnaissance once:**
- The likely impacted modules / files are identified, AND
- Any contract impact is known (or confirmed as “none”), AND
- You can state the task boundary in plain language

If you find yourself reasoning about *how* to implement the change → STOP


**Output:**  
After completing reconnaissance, output only:
> "Related code reviewed."


---

## Discovery Questions


### Question Rules

These rules apply to all discovery questions in all sets.

**Ask ONLY questions affecting:**
- Task definition or intent
- Scope boundaries
- Feasibility or approach
- Required constraints

**Do NOT ask about:**
- Information already explicitly stated in contracts, the task description, or prior answers
- Implementation details (for planning phase)

**Keep questions high-impact. Skip obvious or low-value questions.**

---
### Providing Recommendations

For decision-based questions, provide a brief recommendation **only when code patterns or constraints clearly favor one option**.


**Format:**
``` markdown
[Question]

Recommendation: [Option] — [brief reason].
```

**Example:**
```
Where should password reset tokens be stored?

Recommendation: Database table — aligns with existing session storage.

```

**Skip the recommendation if options are equally valid, evidence is unclear, or user preference is required.**

---

### Set 1: Understanding (MANDATORY)

**Always ask at least one question**, even if task seems clear.

**📌 Questions:**
- What, why, for whom
- Success criteria (observable completion signals)
- Scope boundaries (what's in/out)
- Key constraints or dependencies (including required or preferred external libraries, if any)

**After Set 1:**
> "Understanding complete."

→ If no clarification gaps remain AND no contract require user input:
   - State: "No further questions are needed."
   - Proceed to Task Freeze

→ Otherwise: Continue to Set 2


---

### Set 2: Refinement (If Needed)

Resolve remaining issues in organized groups. Each group may be skipped if no issues were detected.

---

**📌 Group 1: Clarification** (if gaps remain)

- Resolve ambiguities from Set 1
- Important edge cases needing user input
- Approach selection when multiple valid options
- Flag if task should be split

*Skip if no clarification needed.*

---

**📋 Group 2: Contracts**

Check task against all loaded contracts with full context from Set 1.

**If conflict found:**
```
⚠️ **Contract Conflict**

Task: [specific step that conflicts]
Conflicts with: [domain].domain.md — "[exact contract text]"

**Options:**
1. **Update task** — [what changes]
2. **Update contract** — [what exception needed]

**Recommendation:** [Option] because [reason]

Choose: [1/2]
```

**If new contract needed** (ONLY for business-critical rules):
```
📋 **Contract Addition**

Task introduces: [critical functionality]

Suggested for [domain].domain.md:
— [Rule — why contract-worthy]

Add? [yes/no]
```

*Skip if no contract issues.*


---

### Feature Isolation (Optional)

Consider feature isolation only when a task introduces a new long-lived capability. Most tasks do not require this.

It is appropriate when durable decisions or constraints cluster around one capability—often across tasks—and the capability is independent, evolvable, and represents a distinct business or user-facing function.

If applicable:
* Specify in `task.md` which contracts and existing context belong to the feature
* Do NOT create files during discovery
* Moving existing contracts to feature files does NOT require approval

---

## TASK FREEZE (UPDATED, SURGICAL)

### Create task.md

**Contract Changes section MUST be added only after explicit user approval.**

Write to `/obelisk/temp-state/task.md`:

```markdown
# Task: [One-line descriptive name]

## Goal
[What must be achieved and why]

## Scope
✓ Included: [clear list from discovery]
✗ Excluded: [clear list from discovery]

## Constraints
- [Contracts to preserve]
- [Technical/business limits]

## Success Criteria
- [Observable completion signals]
  
## Contract & Memory Changes (Optional)

> New contracts or contract changes require explicit user approval.  
> Contract moves (Feature Isolation) are applied as specified.  
> Changes added here but applied to *.domain only during archive if task succeeds.

**Modify existing:**
- **File:** `/obelisk/state/[domain].domain.md`
- **Action:** `create` | `update`
- **Change:** [exact text or section]

**New feature isolation:**
- **Feature:** `[feature-name]`
- **Contract** (`/obelisk/state/[feature].domain.md`):
  - **Create:** [new invariant(s)]
  - **Move from `core.domain.md`:** [exact rule(s) or section]
- **Memory** (`/obelisk/memory/[feature].memory.md`):
  - **Move from `core.memory.md`:** [exact entry or section]
  

## Open Questions (if any)
- [Unresolved ambiguities]
```


---

### Discovery Q/A Capture

Record discovery decisions in:`/obelisk/temp-state/discovery-qa.md`

**Rules**:
- Write concise, self-contained Q/A representing the model’s understood and user-approved interpretation
- Do not copy raw or verbatim user text
- Append-only; do not revise earlier entries
- Ephemeral (temp-state only), non-authoritative
- Discarded if the task is aborted or rejected

**Format**:

```markdown
## [TASK_NAME] | YYYY-MM-DD

**Task:** <one-line description copied from task.md header>

- Q: <resolved decision or clarification> [context]
- A: <concise, user-approved answer or constraint>

- Q: <next resolved decision>
- A: <next approved answer>

```

---

### Display Task & Options

**Obelisk: Task Ready**

| **Task**    | [One-line name from header]                   |
| ----------- | --------------------------------------------- |
| **Goal**    | [One sentence]                                |
| **Scope**   | ✓ [2-3 key inclusions] ✗ [1-2 key exclusions] |
| **Success** | [Primary completion signal]                   |
| **Contracts** | *Will modify:* [domain].domain.md — [brief change] |

**Full definition:** `/obelisk/temp-state/task.md`

---

**Options:**
- `/execute-task` — Auto-run to completion (plan → implement → review → archive)
- `/plan-task` — Run plan phase only and stop
- `/update-task [changes]` — Modify task definition
- `/abort-task` — Cancel and archive progress

**STOP. Wait for user command.**