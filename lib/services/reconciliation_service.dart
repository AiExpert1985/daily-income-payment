import '../models/account_mapping.dart';
import '../models/payment_record.dart';
import '../models/reconciliation_result.dart';

/// Arabic notes for account mapping edge cases.
class MappingNotes {
  static const noMapping = 'لا يوجد رقم حساب جديد مقابل';
  static const multipleMapping = 'يوجد أكثر من رقم حساب جديد';
}

/// Service for reconciling payment datasets.
///
/// Compares primary and secondary datasets, finds missing records,
/// and aggregates them by account with mapping information.
class ReconciliationService {
  /// Finds records in secondary that are not in primary.
  ///
  /// Uses PaymentRecord equality (account + date + amount).
  /// Duplicates in secondary are counted once only.
  List<PaymentRecord> findMissingRecords(
    List<PaymentRecord> primary,
    List<PaymentRecord> secondary,
  ) {
    final primarySet = primary.toSet();
    final secondarySet = secondary.toSet(); // Removes duplicates

    return secondarySet
        .where((record) => !primarySet.contains(record))
        .toList();
  }

  /// Builds account mapping lookup and tracks duplicates.
  ///
  /// Returns a map where:
  /// - Key: old account number
  /// - Value: new account number, or null if no mapping or multiple mappings
  ///
  /// Also returns a set of old accounts with multiple mappings.
  ({Map<String, String?> lookup, Set<String> duplicates})
  buildAccountMappingLookup(List<AccountMapping> mappings) {
    final lookup = <String, String?>{};
    final duplicates = <String>{};
    final seen = <String>{};

    for (final mapping in mappings) {
      final oldAccount = mapping.oldAccountNumber;

      if (seen.contains(oldAccount)) {
        // Already seen - mark as duplicate
        duplicates.add(oldAccount);
        lookup[oldAccount] = null; // Clear any previous mapping
      } else {
        seen.add(oldAccount);
        lookup[oldAccount] = mapping.newAccountNumber;
      }
    }

    return (lookup: lookup, duplicates: duplicates);
  }

  /// Aggregates missing records by old account number.
  ///
  /// Applies mapping rules:
  /// - No mapping → Arabic note
  /// - Multiple mappings → Arabic note
  /// - Valid mapping → new account number
  List<AggregatedAccount> aggregateByAccount(
    List<PaymentRecord> missingRecords,
    Map<String, String?> mappingLookup,
    Set<String> duplicateMappings,
  ) {
    // Group by old account number
    final groupedPayments = <String, List<MissingPayment>>{};

    for (final record in missingRecords) {
      final oldAccount = record.accountNumber;
      groupedPayments.putIfAbsent(oldAccount, () => []);
      groupedPayments[oldAccount]!.add(MissingPayment.fromRecord(record));
    }

    // Build aggregated accounts
    final aggregated = <AggregatedAccount>[];

    for (final entry in groupedPayments.entries) {
      final oldAccount = entry.key;
      final payments = entry.value;

      // Calculate total amount
      final totalAmount = payments.fold<double>(
        0,
        (sum, payment) => sum + payment.amount,
      );

      // Determine new account or note
      String newAccountOrNote;

      if (duplicateMappings.contains(oldAccount)) {
        newAccountOrNote = MappingNotes.multipleMapping;
      } else if (!mappingLookup.containsKey(oldAccount)) {
        newAccountOrNote = MappingNotes.noMapping;
      } else {
        final newAccount = mappingLookup[oldAccount];
        newAccountOrNote = newAccount ?? MappingNotes.noMapping;
      }

      aggregated.add(
        AggregatedAccount(
          oldAccountNumber: oldAccount,
          newAccountNumberOrNote: newAccountOrNote,
          totalAmount: totalAmount,
          payments: payments,
        ),
      );
    }

    return aggregated;
  }

  /// Runs the full reconciliation process.
  ///
  /// 1. Finds missing records (in secondary but not in primary)
  /// 2. Builds account mapping lookup
  /// 3. Aggregates by old account with mapped new accounts
  ReconciliationResult reconcile(
    List<PaymentRecord> primary,
    List<PaymentRecord> secondary,
    List<AccountMapping> mappings,
  ) {
    // Step 1: Find missing records
    final missingRecords = findMissingRecords(primary, secondary);

    if (missingRecords.isEmpty) {
      return const ReconciliationResult.empty();
    }

    // Step 2: Build mapping lookup
    final (:lookup, :duplicates) = buildAccountMappingLookup(mappings);

    // Step 3: Aggregate by account
    final aggregatedAccounts = aggregateByAccount(
      missingRecords,
      lookup,
      duplicates,
    );

    // Calculate totals
    final totalMissingRecords = missingRecords.length;
    final totalMissingAmount = missingRecords.fold<double>(
      0,
      (sum, record) => sum + record.amount,
    );

    return ReconciliationResult(
      aggregatedAccounts: aggregatedAccounts,
      totalMissingRecords: totalMissingRecords,
      totalMissingAmount: totalMissingAmount,
    );
  }
}
