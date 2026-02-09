# Task: Reconciliation Service and Output Screen

## Goal
Implement the reconciliation logic that compares primary and secondary payment datasets, identifies missing records, aggregates them by old account number with mapped new account numbers, and displays results in an expandable table UI.

## Scope
✓ Included:
- Reconciliation service: compare datasets, find missing records from secondary
- Aggregation logic: group by old account number, sum amounts
- Account mapping: apply mapping rules per contract
- Output screen: table showing (old account, new account/note, total amount)
- Expandable row details: individual payments (account, date, amount)
- Pass parsed data from file upload to output screen

✗ Excluded:
- Export functionality
- Data modification/persistence
- Additional file upload UI changes
- Editing results

## Constraints
- Contracts to preserve:
  - Match = exact equality on account + payment + date
  - Duplicates in secondary counted once only
  - No mapping → "لا يوجد رقم حساب جديد مقابل"
  - Multiple mappings → "يوجد أكثر من رقم حساب جديد"
- Technical: Riverpod 3, GoRouter, Arabic RTL UI
- Read-only processing

## Success Criteria
- Pressing "معالجة" on upload screen navigates to output with results
- Output shows aggregated table: old account | new account/note | total
- Tapping a row expands to show individual payment details
- Mapping notes display correctly for missing/duplicate cases
- App compiles and runs on Windows

## Open Questions
(none)
