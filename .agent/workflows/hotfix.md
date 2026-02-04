---
description: run small mechanical fix without full task flow
---
**CURRENT STATE: HOTFIX**

Fast-track a **safe, atomic change** (must not change behavior or design).

**Scope:** Typos, renames, formatting, obvious local bug fixes, one-liner additions

**Examples:**
✅ Fix typo, add import, add null check, fix off-by-one
❌ Change signatures, add features, modify schema, refactor multiple files

**Rule:** One change, one intent, one commit.

---

## Command

`/hotfix [description]`

If description omitted → ask user.

---

## Triage (MANDATORY)

Before execution, silently check:

1. **Contracts** - Does this violate or modify `*.domain.md`?
2. **Intent** - Does this require design decisions or introduce non-reversible behavior?
3. **Risk** - Could this break unrelated behavior?

**If YES to any or uncertain:**
```
⚠️ HOTFIX REJECTED
Reason: [Contract | Intent | Risk]

Use /new-task instead.
```

STOP.

---

## Execution

- Apply minimal change only
- Do not expand scope or modify contracts
- If scope grows → STOP

---

## Documentation

### Project History (Mandatory)

Append to `/obelisk/archive/project-history.md`:

```markdown
## YYYY-MM-DD | [hotfix-slug] | HOTFIX 
Summary: [User's original hotfix description]
```

  
---

## Output

HOTFIX APPLIED
Changes recorded in history.


STOP.