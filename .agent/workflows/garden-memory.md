---
description: Compress memory file when limit exceeded
---
---

## description: Compress memory file when limit exceeded

**CURRENT STATE: MEMORY GARDENING**

Compress project memory by consolidating recent activity into durable knowledge.

---

## Command

`/garden-memory [memory-file-path]`

Examples:

- `/garden-memory /obelisk/memory/core.memory.md`
- `/garden-memory /obelisk/memory/auth.memory.md`

---

## Preconditions

- Target file MUST exist
- Target file MUST contain:
    - Template sections
    - `## Recent Activity`
    - `APPEND ONLY BELOW THIS LINE`

If any fail → **STOP**.

---

## Template Dependencies

- `core.memory.md` → `/obelisk/templates/core.memory.template.md`
- `[feature].memory.md` → `/obelisk/templates/feature.memory.template.md`

If any template is missing → **STOP**.

---

## Preflight — Template & Structure (MANDATORY)

Run before any compression or refactoring.

---

### Template Integrity

1. Load canonical template:
	- `core.memory.md` → `/obelisk/templates/core.memory.template.md`
	- `[feature].memory.md` → `/obelisk/templates/feature.memory.template.md`
	If any template is missing → **STOP**.

2.  Verify all template section headers exist.
	**If any section is missing:**
	- Recreate the header **empty**
	- Do NOT move or reinterpret content or merge sections
	
	Output once:
	⚠️ Missing template sections restored. Content unchanged.
	

---
## Purpose

- Reduce memory size
- Preserve useful knowledge
- Remove noise and repetition
- Reset Recent Activity buffer

Memory is **non-authoritative** and **lossy by design**.

---

## Process

### 1. Load File

Read the entire memory file.

---

### 2. Identify Zones

- **Garden:** Everything above `## Recent Activity`
- **Buffer:** Everything below `APPEND ONLY BELOW THIS LINE`

---

### 3. Extract Knowledge from Buffer

For each buffer entry, ask: **"Is this still relevant for future decisions?"**

- If yes → Move to appropriate Garden section
- If no → Skip promotion (buffer will be cleared anyway)

Mapping:

|Content Type|Garden Section|
|---|---|
|Decisions made|`Decisions`|
|Constraints / Risks|`Constraints`|
|UX / Behavior patterns|`Design Language` or equivalent|
|Non-Goals / Rejections|`Graveyard`|
|Follow-ups / Unknowns|`Backlog` or `Open Questions`|

---

### Consolidation Rules

- Merge similar ideas and remove duplicates
- Keep wording concise
- Preserve **decision and rejection** rationale over chronology
- DO NOT invent, infer, or strengthen into rules
- DO NOT modify contracts or preserve full chronology

NEVER DELETE:
- Why an approach was rejected
- Why a decision was made  
- Why a constraint exists

MAY COMPRESS:
- Task names, dates, authors → patterns only
- Repeated failures → single rationale
- Verbose explanations → essential cause

---

### 4. Discovery Log Cross-Check (Optional)

After consolidation and before clearing the buffer:

- Read `/obelisk/archive/discovery-log.md` exists, read it
- Verify that major approved decisions are still represented in the Garden
- If a major decision is missing, reintroduce it at a high level

Do NOT:
- Add raw Q/A
- Expand memory scope
- Treat the discovery log as authoritative

---

### 5. Clear Buffer

Replace buffer content with:

```markdown
---
## Recent Activity

> APPEND ONLY BELOW THIS LINE

---
```

---

## Output

```
🌱 MEMORY GARDENED

File: [path]
Before: [X] words
After: [Y] words
Entries processed: [N]

Memory is clean and ready.
```

STOP.