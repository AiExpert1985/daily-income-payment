import '../../../models/account_mapping.dart';
import '../../../models/payment_record.dart';

/// Status of a file upload operation.
enum FileUploadStatus {
  /// No file selected yet.
  initial,

  /// File is being parsed.
  loading,

  /// File parsed successfully.
  success,

  /// File parsing failed.
  error,
}

/// State for a single file upload.
class SingleFileState {
  final FileUploadStatus status;
  final String? errorMessage;

  const SingleFileState({
    this.status = FileUploadStatus.initial,
    this.errorMessage,
  });

  bool get isSuccess => status == FileUploadStatus.success;
  bool get isError => status == FileUploadStatus.error;
  bool get isLoading => status == FileUploadStatus.loading;
  bool get isInitial => status == FileUploadStatus.initial;

  SingleFileState copyWith({FileUploadStatus? status, String? errorMessage}) {
    return SingleFileState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

/// State for the file upload screen.
///
/// Holds the status and parsed data for all three files.
class FileUploadState {
  /// Primary dataset file (ملف المديرية).
  final SingleFileState primaryFile;

  /// Secondary dataset file (ملف النظم).
  final SingleFileState secondaryFile;

  /// Account mapping file (ملف ارقام الحساب).
  final SingleFileState mappingFile;

  /// Parsed payment records from primary file.
  final List<PaymentRecord>? primaryRecords;

  /// Parsed payment records from secondary file.
  final List<PaymentRecord>? secondaryRecords;

  /// Parsed account mappings.
  final List<AccountMapping>? accountMappings;

  const FileUploadState({
    this.primaryFile = const SingleFileState(),
    this.secondaryFile = const SingleFileState(),
    this.mappingFile = const SingleFileState(),
    this.primaryRecords,
    this.secondaryRecords,
    this.accountMappings,
  });

  /// Returns true if all three files have been successfully uploaded.
  bool get allFilesReady =>
      primaryFile.isSuccess && secondaryFile.isSuccess && mappingFile.isSuccess;

  FileUploadState copyWith({
    SingleFileState? primaryFile,
    SingleFileState? secondaryFile,
    SingleFileState? mappingFile,
    List<PaymentRecord>? primaryRecords,
    List<PaymentRecord>? secondaryRecords,
    List<AccountMapping>? accountMappings,
  }) {
    return FileUploadState(
      primaryFile: primaryFile ?? this.primaryFile,
      secondaryFile: secondaryFile ?? this.secondaryFile,
      mappingFile: mappingFile ?? this.mappingFile,
      primaryRecords: primaryRecords ?? this.primaryRecords,
      secondaryRecords: secondaryRecords ?? this.secondaryRecords,
      accountMappings: accountMappings ?? this.accountMappings,
    );
  }
}
