/// Data model representing an account mapping from old to new account number.
///
/// Used for Input C (account map) file.
class AccountMapping {
  final String oldAccountNumber;
  final String? newAccountNumber;

  const AccountMapping({required this.oldAccountNumber, this.newAccountNumber});

  @override
  String toString() =>
      'AccountMapping(old: $oldAccountNumber, new: $newAccountNumber)';
}
