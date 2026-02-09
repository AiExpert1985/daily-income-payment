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

  const OutputState({
    this.status = ReconciliationStatus.initial,
    this.result,
    this.errorMessage,
    this.expandedRows = const {},
  });

  bool get isLoading => status == ReconciliationStatus.loading;
  bool get isSuccess => status == ReconciliationStatus.success;
  bool get isError => status == ReconciliationStatus.error;

  OutputState copyWith({
    ReconciliationStatus? status,
    ReconciliationResult? result,
    String? errorMessage,
    Set<int>? expandedRows,
  }) {
    return OutputState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage,
      expandedRows: expandedRows ?? this.expandedRows,
    );
  }
}
