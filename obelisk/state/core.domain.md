# Core Domain Contract

---

## System Identity

**What:** A Flutter Windows desktop app that identifies missing payment records between two Excel data sources and groups results by mapped account pairs.

**What it is NOT:**
- General-purpose data comparison tool
- Persistent database or data storage
- Multi-platform (mobile/web) application

**Users:** Internal operator comparing payment datasets

---

## Core Invariants

### Record Matching

- A **record match** is defined as exact equality on: `(account_number, date, amount)`
- A **missing record** is any record in Input B that has no match in Input A

### Data Processing

- Missing records are grouped by account number
- Account numbers are joined with the account map (Input C) to produce old/new account pairs
- If an account number exists in missing records but NOT in the account map, include it with `null` new account number

### Input Validation

- Each input file (A, B) must contain columns for: account number, payment amount, date
- Account map (C) must contain columns for: old account number, new account number
- Column detection uses predefined column name lists (case-insensitive matching)

---

## Explicit Non-Goals

- Mobile or web platform support
- Data persistence between sessions
- Extensible plugin architecture
- Real-time data sync

---

## Safety Rules

None identified.

---

## Open Questions

None.
