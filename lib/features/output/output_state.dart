import '../../models/reconciliation_result.dart';

/// Status of the reconciliation process.
enum ReconciliationStatus {
  /// Initial state, not yet started.
  initial,

  /// Reconciliation is running.
  loading,

  /// Reconciliation completed successfully.
  success,

  /// Reconciliation failed.
  error,
}

/// State for the output screen.
class OutputState {
  /// Status of the reconciliation process.
  final ReconciliationStatus status;

  /// Reconciliation result, available when status is success.
  final ReconciliationResult? result;

  /// Error message, available when status is error.
  final String? errorMessage;

  /// Set of expanded row indices (for showing payment details).
  final Set<int> expandedRows;

  /// Current search query for filtering accounts.
  final String searchQuery;

  const OutputState({
    this.status = ReconciliationStatus.initial,
    this.result,
    this.errorMessage,
    this.expandedRows = const {},
    this.searchQuery = '',
  });

  /// Returns the list of accounts filtered by the search query.
  List<AggregatedAccount> get filteredAccounts {
    final accounts = result?.aggregatedAccounts ?? [];
    if (searchQuery.isEmpty) {
      return accounts;
    }

    final query = searchQuery.toLowerCase();
    return accounts.where((account) {
      return account.oldAccountNumber.toLowerCase().contains(query) ||
          account.newAccountNumberOrNote.toLowerCase().contains(query);
    }).toList();
  }

  bool get isLoading => status == ReconciliationStatus.loading;
  bool get isSuccess => status == ReconciliationStatus.success;
  bool get isError => status == ReconciliationStatus.error;

  OutputState copyWith({
    ReconciliationStatus? status,
    ReconciliationResult? result,
    String? errorMessage,
    Set<int>? expandedRows,
    String? searchQuery,
  }) {
    return OutputState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage,
      expandedRows: expandedRows ?? this.expandedRows,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
