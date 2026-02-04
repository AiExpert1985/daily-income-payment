---
description: List available commands
---

**CURRENT STATE: HELP**

Display available Obelisk commands.

---

## Output

**Obelisk Commands**

### Project
- `/start-project` — Discover and initialize a project
- `/project-status` — Show project health and active task
- `/diagnose` — Diagnose feature health (contracts, code, boundaries)

### Tasks (Required Before Execution)
- `/new-task` — Discover and freeze a new task
- `/update-task` — Modify the current frozen task
- `/suggest-task` — Suggest next tasks based on history

### Execution (After `/new-task`)
- `/execute-task` — Run full flow: plan → implement → review → archive
- `/plan-task` — Generate plan only
- `/abort-task` — Abort and archive the current task

### Advanced (Manual Execution — After `/plan-task`)
- `/implement-task` — Execute the approved plan
- `/review-task` — Review implementation against intent
- `/archive-task` — Archive task and update memory

### Maintenance
- `/hotfix` — Apply a small, safe change
- `/garden-memory` — Compress project memory

### Help
- `/help` — Show this list

STOP.
