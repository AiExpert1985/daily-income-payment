import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/reconciliation_result.dart';
import 'output_notifier.dart';
import 'output_state.dart';

/// Screen displaying reconciliation results.
class OutputScreen extends ConsumerWidget {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(outputProvider);
    final notifier = ref.read(outputProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج المعالجة'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(context, state, notifier),
    );
  }

  Widget _buildBody(
    BuildContext context,
    OutputState state,
    OutputNotifier notifier,
  ) {
    if (state.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('جاري المعالجة...', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    if (state.isError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.errorMessage ?? 'حدث خطأ',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final result = state.result;
    if (result == null || result.aggregatedAccounts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text('لا توجد سجلات مفقودة', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return _buildResultsView(context, result, state, notifier);
  }

  Widget _buildResultsView(
    BuildContext context,
    ReconciliationResult result,
    OutputState state,
    OutputNotifier notifier,
  ) {
    return Column(
      children: [
        // Summary header
        _buildSummaryHeader(context, result),
        const Divider(height: 1),

        // Results list
        Expanded(
          child: ListView.builder(
            itemCount: result.aggregatedAccounts.length,
            itemBuilder: (context, index) {
              final account = result.aggregatedAccounts[index];
              final isExpanded = state.expandedRows.contains(index);

              return _AccountRow(
                account: account,
                isExpanded: isExpanded,
                onTap: () => notifier.toggleRowExpanded(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryHeader(
    BuildContext context,
    ReconciliationResult result,
  ) {
    final numberFormat = intl.NumberFormat('#,##0.00', 'ar');

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(
            label: 'عدد الحسابات',
            value: result.aggregatedAccounts.length.toString(),
          ),
          _SummaryItem(
            label: 'عدد السجلات',
            value: result.totalMissingRecords.toString(),
          ),
          _SummaryItem(
            label: 'إجمالي المبالغ',
            value: numberFormat.format(result.totalMissingAmount),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _AccountRow extends StatelessWidget {
  final AggregatedAccount account;
  final bool isExpanded;
  final VoidCallback onTap;

  const _AccountRow({
    required this.account,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = intl.NumberFormat('#,##0.00', 'ar');

    return Column(
      children: [
        // Main row
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Expand icon
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),

                // Old account
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'رقم الحساب القديم',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        account.oldAccountNumber,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                // New account or note
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'رقم الحساب الجديد',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        account.newAccountNumberOrNote,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: _isNote(account.newAccountNumberOrNote)
                              ? Colors.orange
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),

                // Total amount
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'المجموع',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        numberFormat.format(account.totalAmount),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expanded details
        if (isExpanded) _buildDetailsTable(context, numberFormat),

        const Divider(height: 1),
      ],
    );
  }

  bool _isNote(String text) {
    return text.contains('لا يوجد') || text.contains('أكثر من');
  }

  Widget _buildDetailsTable(
    BuildContext context,
    intl.NumberFormat numberFormat,
  ) {
    final dateFormat = intl.DateFormat('yyyy-MM-dd', 'ar');

    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل الدفعات (${account.paymentCount})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
            },
            border: TableBorder.all(color: Colors.grey.shade300),
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade200),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'رقم الحساب',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'التاريخ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'المبلغ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // Data rows
              ...account.payments.map(
                (payment) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(payment.oldAccountNumber),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(dateFormat.format(payment.date)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(numberFormat.format(payment.amount)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
