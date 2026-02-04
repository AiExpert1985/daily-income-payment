# Core Project Memory

---
## Identity

**What:** A Flutter Windows desktop app that compares two payment Excel files, finds records missing from the reference file, and groups them by mapped account pairs (old/new).

**Who:** Internal user comparing payment datasets

**Why:** Quickly identify missing payments and associate them with correct account mappings for manual follow-up

---
## Stack & Architecture

**Language/Framework:** Flutter (Dart), Windows desktop

**Database:** None (no persistence)

**Key Dependencies:** `excel` or `spreadsheet_decoder` for Excel parsing

**Build:** `flutter build windows`

**Run:** `flutter run -d windows`

**Test:** `flutter test`


**Architectural Decisions:**

- Single-use tool: prioritize simplicity over extensibility
- No state management library needed (simple data flow)

  
---
## Design Language

**UI Patterns:** Two-screen flow (Input → Results)

**UX Philosophy:** Minimal clicks, clear validation feedback

**Tone:** Functional, utilitarian

  
---
## Global Decisions

- Column name detection via hardcoded lists (flexible matching)
- Unmapped accounts included with null new account (user edits manually)

  
---
## Graveyard (Rejected Approaches)

- [None yet]

  
---
## Backlog

> Items here are suggestions. Only frozen task.md has authority.

  

**Milestones:**

- [ ] Core comparison engine
- [ ] Input screen with file upload and validation
- [ ] Results screen with drill-down

  

**Tasks:**

- [ ] Set up project structure
- [ ] Implement Excel parsing
- [ ] Implement comparison logic
- [ ] Build input screen UI
- [ ] Build results screen UI

  
---
## Open Questions

- [None]

  

---

## Recent Activity

> APPEND ONLY BELOW THIS LINE

- **Project Foundation & Excel Parsing**
  • Change: Added `excel: ^4.0.6` dependency, created `PaymentRecord` and `AccountMapping` models, `ColumnConstants`, and `ExcelParserService`
  • Decision: Use `excel` package (best maintained option)
  • Constraint: Column detection is case-insensitive

---

**Words:** ~280/4000 | **Updated:** 2026-02-04
