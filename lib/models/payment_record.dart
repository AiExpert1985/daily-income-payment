/// Data model representing a payment record from an Excel file.
///
/// Used for both Input A (reference) and Input B (comparison) files.
class PaymentRecord {
  final String accountNumber;
  final DateTime date;
  final double amount;

  const PaymentRecord({
    required this.accountNumber,
    required this.date,
    required this.amount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentRecord &&
        other.accountNumber == accountNumber &&
        other.date.year == date.year &&
        other.date.month == date.month &&
        other.date.day == date.day &&
        other.amount == amount;
  }

  @override
  int get hashCode => Object.hash(
    accountNumber,
    DateTime(date.year, date.month, date.day),
    amount,
  );

  @override
  String toString() =>
      'PaymentRecord(account: $accountNumber, date: ${date.toIso8601String().split('T')[0]}, amount: $amount)';
}
