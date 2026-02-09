import 'payment_record.dart';

/// A missing payment record with its old account number.
class MissingPayment {
  final String oldAccountNumber;
  final DateTime date;
  final double amount;

  const MissingPayment({
    required this.oldAccountNumber,
    required this.date,
    required this.amount,
  });

  /// Creates from a PaymentRecord.
  factory MissingPayment.fromRecord(PaymentRecord record) {
    return MissingPayment(
      oldAccountNumber: record.accountNumber,
      date: record.date,
      amount: record.amount,
    );
  }
}

/// Aggregated payments for a single old account number.
class AggregatedAccount {
  /// The old account number.
  final String oldAccountNumber;

  /// The mapped new account number, or an Arabic note if missing/duplicate.
  final String newAccountNumberOrNote;

  /// Total sum of all missing payment amounts.
  final double totalAmount;

  /// Individual missing payments for this account.
  final List<MissingPayment> payments;

  const AggregatedAccount({
    required this.oldAccountNumber,
    required this.newAccountNumberOrNote,
    required this.totalAmount,
    required this.payments,
  });

  /// Number of individual payments.
  int get paymentCount => payments.length;
}

/// Complete reconciliation result.
class ReconciliationResult {
  /// List of aggregated accounts with their missing payments.
  final List<AggregatedAccount> aggregatedAccounts;

  /// Total number of missing records.
  final int totalMissingRecords;

  /// Total sum of all missing amounts.
  final double totalMissingAmount;

  const ReconciliationResult({
    required this.aggregatedAccounts,
    required this.totalMissingRecords,
    required this.totalMissingAmount,
  });

  /// Creates an empty result.
  const ReconciliationResult.empty()
    : aggregatedAccounts = const [],
      totalMissingRecords = 0,
      totalMissingAmount = 0;
}
