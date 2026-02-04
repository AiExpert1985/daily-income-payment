# Discovery Log

## PROJECT DISCOVERY | 2026-02-04

**Project Summary:**
Flutter Windows desktop app for identifying missing payment records. Compares two Excel files (reference vs comparison), finds records in comparison that don't exist in reference, and groups results by account number pairs using a mapping file.

- Q: What defines a record match between Input A and Input B?
- A: Exact match on account number + date + amount (all three fields)

- Q: Target platforms?
- A: Windows desktop only

- Q: How to handle accounts not found in the mapping file?
- A: Include them in results with null new account number; user will add mapping manually later

---
