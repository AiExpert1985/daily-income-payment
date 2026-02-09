# Plan: Reconciliation Service and Output Screen

## Goal
Implement the reconciliation logic that compares primary and secondary payment datasets, identifies missing records, aggregates them by old account number with mapped new account numbers, and displays results in an expandable table UI.

## Requirements Coverage
- Pressing "معالجة" navigates to output with results → Steps 4, 5
- Output shows aggregated table: old account | new account/note | total → Steps 2, 3
- Tapping row expands to show individual payment details → Step 3
- Mapping notes display correctly for missing/duplicate cases → Step 1
- App compiles and runs on Windows → Step 6

## Scope

### Files to Modify
- `lib/features/output/output_screen.dart` — Replace placeholder with full implementation

### Files to Create
- `lib/services/reconciliation_service.dart` — Core comparison and aggregation logic
- `lib/features/output/output_state.dart` — State model for reconciliation results
- `lib/features/output/output_notifier.dart` — Riverpod notifier to run reconciliation
- `lib/models/reconciliation_result.dart` — Result models (aggregated account + details)

## Execution Steps

### 1. Create result models
- Action: Create `lib/models/reconciliation_result.dart` with:
  - `MissingPayment`: single payment record with old account
  - `AggregatedAccount`: old account, new account/note, total amount, list of payments
  - `ReconciliationResult`: list of aggregated accounts
- Output: Type-safe models for reconciliation output

### 2. Create reconciliation service
- Action: Create `lib/services/reconciliation_service.dart` with:
  - `findMissingRecords(primary, secondary)`: return records in secondary not in primary (using existing `PaymentRecord` equality)
  - `buildAccountMapping(mappings)`: create lookup map, track duplicates
  - `aggregateByAccount(missingRecords, mappingLookup)`: group by old account, apply mapping rules
  - `reconcile(primary, secondary, mappings)`: orchestrate full flow, return `ReconciliationResult`
- Output: Stateless service with single-responsibility methods

### 3. Create output feature state and notifier
- Action: Create `lib/features/output/output_state.dart`:
  - `OutputState`: holds `ReconciliationResult`, loading status, expanded row indices
- Action: Create `lib/features/output/output_notifier.dart`:
  - Riverpod Notifier that reads from `fileUploadProvider` and calls `ReconciliationService`
  - Methods: `runReconciliation()`, `toggleRowExpanded(index)`
- Output: State management for output screen

### 4. Update output screen UI
- Action: Replace `lib/features/output/output_screen.dart` with:
  - ConsumerWidget using output notifier
  - ListView/DataTable showing aggregated rows (old account | new account | total)
  - ExpansionTile or similar for expandable details
  - Details table: account, date, amount for each payment
  - Arabic RTL layout
- Output: Functional output screen with expandable rows

### 5. Wire navigation to trigger reconciliation
- Action: In output notifier `build()`, automatically run reconciliation on init
- Output: Navigating to `/output` triggers processing and shows results

### 6. Verify Windows build
- Action: Run `flutter analyze` and `flutter build windows`
- Output: App compiles with no errors

## Acceptance Criteria
- Pressing "معالجة" on upload screen navigates to output with results
- Output shows aggregated table: old account | new account/note | total
- Tapping a row expands to show individual payment details
- Mapping notes display correctly for missing/duplicate cases
- App compiles and runs on Windows

## Must NOT Change
- `lib/services/excel_parser_service.dart` — Existing parsing logic
- `lib/models/payment_record.dart` — Existing model with equality
- `lib/models/account_mapping.dart` — Existing model
- `lib/features/file_upload/*` — Existing upload feature
- `obelisk/contracts/core.domain.md` — Domain contracts
