# Plan: Project Foundation & Excel Parsing

## Goal
Set up the project foundation with the `excel` package and implement Excel file parsing service that can read payment data files and account mapping files, detecting required columns from predefined name lists.

## Requirements Coverage
- `flutter pub get` succeeds → Step 1
- Excel parsing service can read an Excel file → Steps 3, 4
- Column detection works with any column name from predefined lists → Steps 3, 4
- `flutter analyze` passes → Step 5
- `flutter run -d windows` builds successfully → Step 5

## Scope

### Files to Modify
- `pubspec.yaml` — add `excel: ^4.0.6` dependency

### Files to Create
- `lib/models/payment_record.dart` — data model for payment records
- `lib/models/account_mapping.dart` — data model for account mappings
- `lib/services/column_constants.dart` — hardcoded column name lists
- `lib/services/excel_parser_service.dart` — Excel file parsing service

## Execution Steps

1. **Add excel dependency**
   - Action: Add `excel: ^4.0.6` to `pubspec.yaml` dependencies
   - Output: Run `flutter pub get` succeeds

2. **Create data models**
   - Action: Create `PaymentRecord` model with fields: `accountNumber`, `date`, `amount`
   - Action: Create `AccountMapping` model with fields: `oldAccountNumber`, `newAccountNumber`
   - Output: Two model files in `lib/models/`

3. **Create column constants**
   - Action: Create `ColumnConstants` class with static lists:
     - `accountNumberColumns`: ['account_no', 'acc_num', 'account_id', 'account_number', 'acc_no']
     - `paymentColumns`: ['payment', 'amount', 'pay_amt', 'payment_amount', 'amt']
     - `dateColumns`: ['date', 'payment_date', 'trans_date', 'transaction_date']
     - `newAccountColumns`: ['new_account', 'new_acc_no', 'new_account_number']
     - `oldAccountColumns`: ['old_account', 'old_acc_no', 'old_account_number']
   - Output: `lib/services/column_constants.dart`

4. **Create Excel parser service**
   - Action: Create `ExcelParserService` class with methods:
     - `parsePaymentFile(Uint8List bytes)` → returns `List<PaymentRecord>` or error
     - `parseAccountMappingFile(Uint8List bytes)` → returns `List<AccountMapping>` or error
     - Private helper: `_findColumn(List<String> headerRow, List<String> possibleNames)` for case-insensitive column detection
   - Output: `lib/services/excel_parser_service.dart`

5. **Verify build**
   - Action: Run `flutter analyze` and `flutter run -d windows`
   - Output: No errors, app builds successfully

## Acceptance Criteria
- `flutter pub get` succeeds with new dependency
- Excel parsing service can read an Excel file and extract records
- Column detection works with any column name from the predefined lists
- `flutter analyze` passes with no errors
- `flutter run -d windows` builds successfully

## Verification Plan

### Automated Tests
- None required (task does not specify tests)

### Manual Verification
1. Run `flutter pub get` — should succeed without errors
2. Run `flutter analyze` — should report no errors
3. Run `flutter run -d windows` — app should build and launch successfully

## Must NOT Change
- Existing `main.dart` app shell (preserve current structure)
- Core domain contracts
