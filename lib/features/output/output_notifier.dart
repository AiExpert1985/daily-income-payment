import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/reconciliation_service.dart';
import '../file_upload/file_upload_notifier.dart';
import 'output_state.dart';

/// Notifier for managing output screen state.
///
/// Runs reconciliation on init and manages row expansion.
class OutputNotifier extends Notifier<OutputState> {
  late final ReconciliationService _reconciliationService;

  @override
  OutputState build() {
    _reconciliationService = ReconciliationService();

    // Run reconciliation automatically on init
    Future.microtask(_runReconciliation);

    return const OutputState(status: ReconciliationStatus.loading);
  }

  /// Runs the reconciliation process using uploaded file data.
  Future<void> _runReconciliation() async {
    try {
      final uploadState = ref.read(fileUploadProvider);

      // Validate that all files are loaded
      final primaryRecords = uploadState.primaryRecords;
      final secondaryRecords = uploadState.secondaryRecords;
      final accountMappings = uploadState.accountMappings;

      if (primaryRecords == null ||
          secondaryRecords == null ||
          accountMappings == null) {
        state = state.copyWith(
          status: ReconciliationStatus.error,
          errorMessage: 'بيانات الملفات غير متوفرة',
        );
        return;
      }

      // Run reconciliation
      final result = _reconciliationService.reconcile(
        primaryRecords,
        secondaryRecords,
        accountMappings,
      );

      state = state.copyWith(
        status: ReconciliationStatus.success,
        result: result,
      );
    } catch (e) {
      state = state.copyWith(
        status: ReconciliationStatus.error,
        errorMessage: 'حدث خطأ أثناء المعالجة: $e',
      );
    }
  }

  /// Toggles the expanded state of a row.
  void toggleRowExpanded(int index) {
    final newExpanded = Set<int>.from(state.expandedRows);

    if (newExpanded.contains(index)) {
      newExpanded.remove(index);
    } else {
      newExpanded.add(index);
    }

    state = state.copyWith(expandedRows: newExpanded);
  }
}

/// Provider for output screen state management.
final outputProvider = NotifierProvider<OutputNotifier, OutputState>(
  OutputNotifier.new,
);
