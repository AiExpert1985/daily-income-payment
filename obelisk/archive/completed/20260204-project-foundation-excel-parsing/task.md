# Task: Project Foundation & Excel Parsing

## Goal
Set up the project foundation with the `excel` package and implement Excel file parsing service that can read payment data files and account mapping files, detecting required columns from predefined name lists.

## Scope
✓ Included:
- Add `excel` package dependency
- Create data models for payment records and account mappings
- Create Excel parsing service with column detection
- Create hardcoded column name mapping constants
- Flat project structure with `services/` and `models/` folders

✗ Excluded:
- File picker UI (next task)
- Comparison logic (separate task)
- Input screen UI
- Results screen UI

## Constraints
- Preserve existing `main.dart` app shell
- Use `excel` package (researched as best option)
- Column detection must be case-insensitive
- Keep structure flat and simple (short-term tool)

## Success Criteria
- `flutter pub get` succeeds with new dependency
- Excel parsing service can read an Excel file and extract records
- Column detection works with any column name from the predefined lists
- `flutter analyze` passes with no errors
- `flutter run -d windows` builds successfully

## Contract & Memory Changes (Optional)

None required.

## Open Questions (if any)

None.
