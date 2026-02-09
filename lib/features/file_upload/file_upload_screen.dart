import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'file_upload_notifier.dart';
import 'file_upload_state.dart';

/// Screen for uploading the three Excel files.
class FileUploadScreen extends ConsumerWidget {
  const FileUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fileUploadProvider);
    final notifier = ref.read(fileUploadProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تحميل الملفات'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            // Primary file upload row
            _FileUploadRow(
              label: 'ملف المديرية',
              fileState: state.primaryFile,
              onPressed: notifier.pickPrimaryFile,
            ),
            const SizedBox(height: 24),

            // Secondary file upload row
            _FileUploadRow(
              label: 'ملف النظم',
              fileState: state.secondaryFile,
              onPressed: notifier.pickSecondaryFile,
            ),
            const SizedBox(height: 24),

            // Mapping file upload row
            _FileUploadRow(
              label: 'ملف ارقام الحساب',
              fileState: state.mappingFile,
              onPressed: notifier.pickMappingFile,
            ),

            const Spacer(),

            // Process button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: state.allFilesReady
                    ? () => context.go('/output')
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text('معالجة', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// A row showing file label, upload button, and status indicator.
class _FileUploadRow extends StatelessWidget {
  final String label;
  final SingleFileState fileState;
  final VoidCallback onPressed;

  const _FileUploadRow({
    required this.label,
    required this.fileState,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Status icon
        SizedBox(width: 40, child: _buildStatusIcon()),
        const SizedBox(width: 16),

        // Label
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),

        // Upload button
        ElevatedButton.icon(
          onPressed: fileState.isLoading ? null : onPressed,
          icon: fileState.isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.upload_file),
          label: const Text('اختيار ملف'),
        ),
      ],
    );
  }

  Widget _buildStatusIcon() {
    return switch (fileState.status) {
      FileUploadStatus.initial => const SizedBox.shrink(),
      FileUploadStatus.loading => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      FileUploadStatus.success => const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 28,
      ),
      FileUploadStatus.error => Tooltip(
        message: fileState.errorMessage ?? 'ملف خاطئ',
        child: const Icon(Icons.cancel, color: Colors.red, size: 28),
      ),
    };
  }
}
