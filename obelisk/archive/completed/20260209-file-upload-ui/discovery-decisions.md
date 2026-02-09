## File Upload UI | 2026-02-09

**Summary:**
- Implement Excel file upload screen with three import buttons and validation status

**Decisions:**
- File labels: "ملف المديرية", "ملف النظم", "ملف ارقام الحساب"
- Process button requires all three files successfully uploaded
- Simple error display: "ملف خاطئ" (no column-specific details)
- Use Riverpod 3 (not legacy) and GoRouter
- Excel files only (no CSV)

**Deferred:**
- Processing logic and output screen (next task)
