import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/excel_parser_service.dart';
import 'file_upload_state.dart';

/// Notifier for managing file upload state.
///
/// Uses Riverpod 3 Notifier pattern for state management.
class FileUploadNotifier extends Notifier<FileUploadState> {
  late final ExcelParserService _parserService;

  @override
  FileUploadState build() {
    _parserService = ExcelParserService();
    return const FileUploadState();
  }

  /// Opens file picker and parses the primary dataset file (ملف المديرية).
  Future<void> pickPrimaryFile() async {
    state = state.copyWith(
      primaryFile: const SingleFileState(status: FileUploadStatus.loading),
    );

    final result = await _pickExcelFile();
    if (result == null) {
      state = state.copyWith(
        primaryFile: const SingleFileState(status: FileUploadStatus.initial),
      );
      return;
    }

    final parseResult = _parserService.parsePaymentFile(result);
    if (parseResult.isSuccess) {
      state = state.copyWith(
        primaryFile: const SingleFileState(status: FileUploadStatus.success),
        primaryRecords: parseResult.data,
      );
    } else {
      state = state.copyWith(
        primaryFile: const SingleFileState(
          status: FileUploadStatus.error,
          errorMessage: 'ملف خاطئ',
        ),
      );
    }
  }

  /// Opens file picker and parses the secondary dataset file (ملف النظم).
  Future<void> pickSecondaryFile() async {
    state = state.copyWith(
      secondaryFile: const SingleFileState(status: FileUploadStatus.loading),
    );

    final result = await _pickExcelFile();
    if (result == null) {
      state = state.copyWith(
        secondaryFile: const SingleFileState(status: FileUploadStatus.initial),
      );
      return;
    }

    final parseResult = _parserService.parsePaymentFile(result);
    if (parseResult.isSuccess) {
      state = state.copyWith(
        secondaryFile: const SingleFileState(status: FileUploadStatus.success),
        secondaryRecords: parseResult.data,
      );
    } else {
      state = state.copyWith(
        secondaryFile: const SingleFileState(
          status: FileUploadStatus.error,
          errorMessage: 'ملف خاطئ',
        ),
      );
    }
  }

  /// Opens file picker and parses the account mapping file (ملف ارقام الحساب).
  Future<void> pickMappingFile() async {
    state = state.copyWith(
      mappingFile: const SingleFileState(status: FileUploadStatus.loading),
    );

    final result = await _pickExcelFile();
    if (result == null) {
      state = state.copyWith(
        mappingFile: const SingleFileState(status: FileUploadStatus.initial),
      );
      return;
    }

    final parseResult = _parserService.parseAccountMappingFile(result);
    if (parseResult.isSuccess) {
      state = state.copyWith(
        mappingFile: const SingleFileState(status: FileUploadStatus.success),
        accountMappings: parseResult.data,
      );
    } else {
      state = state.copyWith(
        mappingFile: const SingleFileState(
          status: FileUploadStatus.error,
          errorMessage: 'ملف خاطئ',
        ),
      );
    }
  }

  /// Opens the file picker dialog for Excel files.
  /// Returns the file bytes or null if cancelled.
  Future<Uint8List?> _pickExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    return result.files.first.bytes;
  }
}

/// Provider for file upload state management.
final fileUploadProvider =
    NotifierProvider<FileUploadNotifier, FileUploadState>(
      FileUploadNotifier.new,
    );
