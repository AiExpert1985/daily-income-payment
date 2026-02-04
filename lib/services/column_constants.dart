/// Hardcoded column name lists for flexible Excel column detection.
///
/// Column detection is case-insensitive. Any matching name in a list
/// will be used to identify the corresponding data column.
class ColumnConstants {
  ColumnConstants._();

  /// Possible column names for account number in payment files (A, B)
  static const accountNumberColumns = [
    'account_no',
    'acc_num',
    'account_id',
    'account_number',
    'acc_no',
    'account',
  ];

  /// Possible column names for payment amount in payment files (A, B)
  static const paymentColumns = [
    'payment',
    'amount',
    'pay_amt',
    'payment_amount',
    'amt',
    'sum',
    'total',
  ];

  /// Possible column names for date in payment files (A, B)
  static const dateColumns = [
    'date',
    'payment_date',
    'trans_date',
    'transaction_date',
    'pay_date',
  ];

  /// Possible column names for new account in account map file (C)
  static const newAccountColumns = [
    'new_account',
    'new_acc_no',
    'new_account_number',
    'new_acc',
  ];

  /// Possible column names for old account in account map file (C)
  static const oldAccountColumns = [
    'old_account',
    'old_acc_no',
    'old_account_number',
    'old_acc',
  ];
}
