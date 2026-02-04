---
description: Auto-execute task until the end
---

**CURRENT STATE: EXECUTE**

Run planning → implementation → review → archive sequentially.

---

## Execution Sequence

For each phase: **Read the prompt file, treat content as instructions, execute.**

| Phase | Prompt | Output Verification |
|-------|--------|---------------------|
| 1. Plan | `/.agent/workflows/plan-task.md` | `plan.md` exists |
| 2. Implement | `/.agent/workflows/implement-task.md` | `implementation-notes.md` exists |
| 3. Review | `/.agent/workflows/review-task.md` | `review-notes.md` exists |
| 4. Archive | `/.agent/workflows/archive-task.md` | `/obelisk/temp-state/` is empty |
“If any phase outputs a STOP condition, surface it and do not proceed to later phases.”