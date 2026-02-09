
# Plan: Output Search & Filter

## Goal
Add a real-time search bar to the output screen to filter reconciliation results by old or new account numbers without losing expandability.

## Requirements Coverage
- User can type and see list filter instantly → Step 2
- Search finds matches in both Old Account Number and New Account Number fields → Step 1, 2
- Clicking a filtered row expands to show details → Step 3
- Clearing search restores full list → Step 2

## Scope

### Files to Modify
- `/lib/features/output/output_state.dart` — Add search query state and filtered list logic
- `/lib/features/output/output_notifier.dart` — Add setSearchQuery action
- `/lib/features/output/output_screen.dart` — Add search UI and bind to filtered list

### Files to Create
- None

## Execution Steps

1. Update Output State
   - Action: Add `searchQuery` and `filteredAccounts` logic to `OutputState`
   - Output: State can hold query and return filtered list

2. Update Output Notifier
   - Action: Add `setSearchQuery` method to update state
   - Output: UI can trigger search updates

3. Update Output UI
   - Action: Add `TextField` above list, bind to `setSearchQuery`, use `filteredAccounts`
   - Output: User sees search bar and filtered results

## Acceptance Criteria
- User can type and see list filter instantly
- Search finds matches in both Old Account Number and New Account Number fields
- Clicking a filtered row expands to show details
- Clearing search restores full list

## Must NOT Change
- Read-only processing
- Expandability of rows
- Arabic UI
