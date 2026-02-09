# Core Domain Contract

## System Identity

**What it is:** A one-time financial reconciliation tool that compares two datasets, extracts records missing from the primary dataset, aggregates payments by account, and maps old account numbers to new ones.

**What it is NOT:**
- A persistent database application
- A sync or ongoing maintenance tool
- A multi-language application

**Users:** Arabic-speaking users processing financial records

---

## Global Business Rules

### Comparison Logic
- Match is defined as **exact equality** on: account number + payment amount + date
- Duplicate records in secondary dataset are counted **once only**

### Column Mapping
- Column names are not fixed
- App uses predefined lists of acceptable column names per logical field
- First matching column from configured list is selected; others ignored

### Account Mapping Rules
| Scenario | Behavior |
|----------|----------|
| Old account has no mapping | Include with `newAccountNumber`: "لا يوجد رقم حساب جديد مقابل" |
| Old account maps to multiple new accounts | Exclude with note: "يوجد أكثر من رقم حساب جديد" |

---

## Safety-Critical Rules

- Read-only processing (no data modification)
- Fail-fast validation with clear Arabic error messages

---

## Explicit Non-Goals

- Multi-language support (Arabic only)
- Data persistence
- User customization beyond file upload
- Visual polish beyond clarity and correctness

---

## Open Questions

(none)
