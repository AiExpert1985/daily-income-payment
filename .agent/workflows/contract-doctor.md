---
description: Inspect contracts for drift, ambiguity, or risk
---

**CURRENT STATE: CONTRACT AUDIT**

Read-only diagnostic for Obelisk contracts. Does NOT modify any files.

---

## Command

`/contract-doctor`  
`/contract-doctor [domain]`

---

## Entry

If no domain is provided:

- List available contracts from `/obelisk/state/*.domain.md`
- Ask the user to choose one domain or `all`

---

## Authority & Guardrails

- Contracts (`*.domain.md`) are authoritative.
- Tasks and memory provide intent and historical context only.
- Code is evidence of observed behavior, not truth.

You MUST NOT:
- Modify contracts or any files
- Infer or apply contract changes
- Open tasks automatically
- Treat code as more authoritative than contracts

---

## Inputs (read-only, if present)

Read in this order:

1. Target contract(s) in `/obelisk/state/`
2. Recent completed tasks related to the same domain
3. Project memory for historical rationale
4. Relevant code only if needed to understand observed behavior
5. Discovery Rationale `/obelisk/archive/discovery-log.md`
   Use only to explain why contracts were created or modified.
   Never treat the log as authoritative.

---

## Checks

For each contract, look for:

- **Clarity**
  - Ambiguous wording
  - TODOs / placeholders
  - Over-broad rules

- **Consistency**
  - Conflicts with other contracts
  - Tension with recent task intent
  - Apparent drift signals (never asserted as violations)

- **Staleness**
  - Long-unchanged contracts with recent related task activity

Tag findings with confidence: **High / Medium / Low**.

---

## Output

```

Contract Audit:

- [contract file]
    - [Issue] — [Confidence]  
        Evidence: [task / memory / code reference] 

Recommended follow-up:
- `/new-task [actionable task name]` 
- Or: "No issues detected. 

```

STOP. Do not modify any files.