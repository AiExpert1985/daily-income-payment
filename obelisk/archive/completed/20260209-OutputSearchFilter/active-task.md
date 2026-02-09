
# Task: Implement Output Search & Filter

## Goal
Add a real-time search bar to the output screen to filter reconciliation results by old or new account numbers without losing expandability.

## Scope
✓ Included: 
- Search bar UI at top of OutputScreen
- Filtering logic in OutputNotifier
- Matching logic for old and new account numbers
- Real-time updates as user types

✗ Excluded:
- Advanced filtering (e.g., by amount or date)
- Search text highlighting
- Exporting filtered results

## Constraints
- Read-only processing (no data modification)
- Must maintain expandability of rows
- Arabic UI 

## Success Criteria
- User can type and see list filter instantly
- Search finds matches in both Old Account Number and New Account Number fields
- Clicking a filtered row expands to show details
- Clearing search restores full list

## Open Questions
- (none)
