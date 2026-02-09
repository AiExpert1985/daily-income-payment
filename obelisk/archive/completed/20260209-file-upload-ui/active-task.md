# Task: File Upload UI

## Goal
Implement an Excel file upload screen with three import buttons for loading the primary dataset, secondary dataset, and account mapping file. Users see success/failure status for each upload, and can proceed to processing only when all three files are valid.

## Scope
✓ Included:
- Three upload buttons with Arabic labels
- File picker integration (Excel only)
- Parse validation using existing `ExcelParserService`
- Success (green checkmark) / failure (red X) status display
- Process button (disabled until all files valid)
- Navigation stub to output screen (placeholder)
- Riverpod 3 state management
- GoRouter navigation setup

✗ Excluded:
- Processing/reconciliation logic
- Output screen implementation
- CSV support (Excel only)

## Constraints
- Contracts to preserve: Arabic-only UI, fail-fast validation
- Technical: Riverpod 3 (no legacy), GoRouter, Windows desktop target
- File labels: "ملف المديرية", "ملف النظم", "ملف ارقام الحساب"
- Error display: Simple "ملف خاطئ" (not detailed)

## Success Criteria
- Three file upload buttons visible with correct Arabic labels
- Each button opens file picker filtered to Excel files
- Upload shows green checkmark on valid parse, red X on failure
- Process button disabled until all three files show green
- App compiles and runs on Windows

## Open Questions
(none)
