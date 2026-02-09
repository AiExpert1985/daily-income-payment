# Plan: File Upload UI

## Goal
Implement an Excel file upload screen with three import buttons for loading the primary dataset, secondary dataset, and account mapping file. Users see success/failure status for each upload, and can proceed to processing only when all three files are valid.

## Requirements Coverage
- Three file upload buttons visible with correct Arabic labels → Step 3
- Each button opens file picker filtered to Excel files → Step 3
- Upload shows green checkmark on valid parse, red X on failure → Step 3
- Process button disabled until all three files show green → Step 3
- App compiles and runs on Windows → Step 6

## Scope

### Files to Modify
- `pubspec.yaml` — Add dependencies: flutter_riverpod, go_router, file_picker
- `lib/main.dart` — Replace placeholder with ProviderScope + GoRouter setup + RTL Directionality

### Files to Create
- `lib/features/file_upload/file_upload_state.dart` — State model for upload status
- `lib/features/file_upload/file_upload_notifier.dart` — Riverpod 3 Notifier for managing upload state
- `lib/features/file_upload/file_upload_screen.dart` — UI with 3 upload buttons + process button
- `lib/core/router.dart` — GoRouter configuration with upload and placeholder output routes

## Execution Steps

### 1. Add dependencies to pubspec.yaml
- Action: Add `flutter_riverpod`, `go_router`, `file_picker` to dependencies section
- Output: Updated pubspec.yaml with new packages

### 2. Create router configuration
- Action: Create `lib/core/router.dart` with GoRouter defining:
  - `/` → FileUploadScreen
  - `/output` → Placeholder OutputScreen (Text: "نتائج المعالجة")
- Output: Working router with two routes

### 3. Create file upload feature
- Action: Create feature folder with:
  - **State model** (`file_upload_state.dart`): Enum for status (initial/loading/success/error), state class holding status + parsed data + error for each of 3 files
  - **Notifier** (`file_upload_notifier.dart`): Riverpod 3 Notifier with methods `pickPrimaryFile()`, `pickSecondaryFile()`, `pickMappingFile()` using file_picker + ExcelParserService
  - **Screen** (`file_upload_screen.dart`): RTL Arabic UI with 3 upload rows (label + button + status icon), process button at bottom
- Output: Complete feature with state management and UI

### 4. Update main.dart
- Action: Replace existing content with:
  - ProviderScope wrapper
  - Directionality(textDirection: TextDirection.rtl)
  - MaterialApp.router with GoRouter
- Output: App entry point configured for Riverpod + GoRouter + RTL

### 5. Run pub get
- Action: Execute `flutter pub get`
- Output: Dependencies resolved

### 6. Verify Windows build
- Action: Execute `flutter run -d windows`
- Output: App runs showing upload screen with 3 buttons

## Acceptance Criteria
- Three file upload buttons visible with correct Arabic labels
- Each button opens file picker filtered to Excel files
- Upload shows green checkmark on valid parse, red X on failure
- Process button disabled until all three files show green
- App compiles and runs on Windows

## Must NOT Change
- `lib/services/excel_parser_service.dart` — Existing parsing logic
- `lib/models/*.dart` — Existing data models
- `obelisk/contracts/core.domain.md` — Domain contracts
