import 'dart:typed_data';

import 'package:excel/excel.dart';

import '../models/account_mapping.dart';
import '../models/payment_record.dart';
import 'column_constants.dart';

/// Result of parsing an Excel file.
///
/// Contains either parsed data or an error message.
class ParseResult<T> {
  final List<T>? data;
  final String? error;

  const ParseResult.success(this.data) : error = null;
  const ParseResult.failure(this.error) : data = null;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}

/// Service for parsing Excel files containing payment and account mapping data.
class ExcelParserService {
  /// Parses a payment file (Input A or B) and extracts payment records.
  ///
  /// Returns a [ParseResult] containing either a list of [PaymentRecord]
  /// or an error message if parsing fails.
  ParseResult<PaymentRecord> parsePaymentFile(Uint8List bytes) {
    try {
      final excel = Excel.decodeBytes(bytes);
      final sheet = _getFirstSheet(excel);
      if (sheet == null) {
        return const ParseResult.failure('No sheets found in Excel file');
      }

      final rows = sheet.rows;
      if (rows.isEmpty) {
        return const ParseResult.failure('Excel file is empty');
      }

      // First row is header
      final headerRow = _extractHeaderRow(rows.first);
      if (headerRow.isEmpty) {
        return const ParseResult.failure('Header row is empty');
      }

      // Find required columns
      final accountColIndex = _findColumnIndex(
        headerRow,
        ColumnConstants.accountNumberColumns,
      );
      final amountColIndex = _findColumnIndex(
        headerRow,
        ColumnConstants.paymentColumns,
      );
      final dateColIndex = _findColumnIndex(
        headerRow,
        ColumnConstants.dateColumns,
      );

      if (accountColIndex == -1) {
        return ParseResult.failure(
          'Account number column not found. Expected one of: ${ColumnConstants.accountNumberColumns}',
        );
      }
      if (amountColIndex == -1) {
        return ParseResult.failure(
          'Payment amount column not found. Expected one of: ${ColumnConstants.paymentColumns}',
        );
      }
      if (dateColIndex == -1) {
        return ParseResult.failure(
          'Date column not found. Expected one of: ${ColumnConstants.dateColumns}',
        );
      }

      // Parse data rows (skip header)
      final records = <PaymentRecord>[];
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        final record = _parsePaymentRow(
          row,
          accountColIndex,
          amountColIndex,
          dateColIndex,
          i + 1, // 1-based row number for error messages
        );
        if (record != null) {
          records.add(record);
        }
      }

      return ParseResult.success(records);
    } catch (e) {
      return ParseResult.failure('Failed to parse Excel file: $e');
    }
  }

  /// Parses an account mapping file (Input C) and extracts mappings.
  ///
  /// Returns a [ParseResult] containing either a list of [AccountMapping]
  /// or an error message if parsing fails.
  ParseResult<AccountMapping> parseAccountMappingFile(Uint8List bytes) {
    try {
      final excel = Excel.decodeBytes(bytes);
      final sheet = _getFirstSheet(excel);
      if (sheet == null) {
        return const ParseResult.failure('No sheets found in Excel file');
      }

      final rows = sheet.rows;
      if (rows.isEmpty) {
        return const ParseResult.failure('Excel file is empty');
      }

      // First row is header
      final headerRow = _extractHeaderRow(rows.first);
      if (headerRow.isEmpty) {
        return const ParseResult.failure('Header row is empty');
      }

      // Find required columns
      final oldAccountColIndex = _findColumnIndex(
        headerRow,
        ColumnConstants.oldAccountColumns,
      );
      final newAccountColIndex = _findColumnIndex(
        headerRow,
        ColumnConstants.newAccountColumns,
      );

      if (oldAccountColIndex == -1) {
        return ParseResult.failure(
          'Old account column not found. Expected one of: ${ColumnConstants.oldAccountColumns}',
        );
      }
      if (newAccountColIndex == -1) {
        return ParseResult.failure(
          'New account column not found. Expected one of: ${ColumnConstants.newAccountColumns}',
        );
      }

      // Parse data rows (skip header)
      final mappings = <AccountMapping>[];
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        final mapping = _parseAccountMappingRow(
          row,
          oldAccountColIndex,
          newAccountColIndex,
        );
        if (mapping != null) {
          mappings.add(mapping);
        }
      }

      return ParseResult.success(mappings);
    } catch (e) {
      return ParseResult.failure('Failed to parse Excel file: $e');
    }
  }

  /// Gets the first sheet from the Excel file.
  Sheet? _getFirstSheet(Excel excel) {
    if (excel.tables.isEmpty) return null;
    return excel.tables.values.first;
  }

  /// Extracts header row as lowercase strings for case-insensitive matching.
  List<String> _extractHeaderRow(List<Data?> row) {
    return row
        .map((cell) => _getCellString(cell).toLowerCase().trim())
        .toList();
  }

  /// Finds the column index matching any of the possible column names.
  /// Returns -1 if no match found.
  int _findColumnIndex(List<String> headerRow, List<String> possibleNames) {
    final lowerNames = possibleNames.map((n) => n.toLowerCase()).toSet();
    for (var i = 0; i < headerRow.length; i++) {
      if (lowerNames.contains(headerRow[i])) {
        return i;
      }
    }
    return -1;
  }

  /// Parses a payment row into a PaymentRecord.
  /// Returns null if the row is empty or has missing data.
  PaymentRecord? _parsePaymentRow(
    List<Data?> row,
    int accountColIndex,
    int amountColIndex,
    int dateColIndex,
    int rowNumber,
  ) {
    if (row.isEmpty) return null;

    final accountNumber = _getCellString(_getCell(row, accountColIndex));
    if (accountNumber.isEmpty) return null;

    final amount = _getCellDouble(_getCell(row, amountColIndex));
    if (amount == null) return null;

    final date = _getCellDate(_getCell(row, dateColIndex));
    if (date == null) return null;

    return PaymentRecord(
      accountNumber: accountNumber,
      date: date,
      amount: amount,
    );
  }

  /// Parses an account mapping row.
  /// Returns null if the row is empty or has missing old account.
  AccountMapping? _parseAccountMappingRow(
    List<Data?> row,
    int oldAccountColIndex,
    int newAccountColIndex,
  ) {
    if (row.isEmpty) return null;

    final oldAccount = _getCellString(_getCell(row, oldAccountColIndex));
    if (oldAccount.isEmpty) return null;

    final newAccount = _getCellString(_getCell(row, newAccountColIndex));

    return AccountMapping(
      oldAccountNumber: oldAccount,
      newAccountNumber: newAccount.isEmpty ? null : newAccount,
    );
  }

  /// Safely gets a cell from a row, handling index bounds.
  Data? _getCell(List<Data?> row, int index) {
    if (index < 0 || index >= row.length) return null;
    return row[index];
  }

  /// Extracts a string value from a cell.
  String _getCellString(Data? cell) {
    if (cell == null) return '';
    final value = cell.value;
    return switch (value) {
      null => '',
      TextCellValue() => value.value.toString(),
      IntCellValue() => value.value.toString(),
      DoubleCellValue() => value.value.toString(),
      _ => value.toString(),
    };
  }

  /// Extracts a double value from a cell.
  double? _getCellDouble(Data? cell) {
    if (cell == null) return null;
    final value = cell.value;
    return switch (value) {
      null => null,
      IntCellValue() => value.value.toDouble(),
      DoubleCellValue() => value.value,
      TextCellValue() => double.tryParse(value.value.toString()),
      _ => double.tryParse(value.toString()),
    };
  }

  /// Extracts a DateTime value from a cell.
  DateTime? _getCellDate(Data? cell) {
    if (cell == null) return null;
    final value = cell.value;
    return switch (value) {
      null => null,
      DateCellValue() => value.asDateTimeLocal(),
      DateTimeCellValue() => value.asDateTimeLocal(),
      TextCellValue() => DateTime.tryParse(value.value.toString()),
      IntCellValue() => _excelSerialToDate(value.value),
      DoubleCellValue() => _excelSerialToDate(value.value.toInt()),
      _ => DateTime.tryParse(value.toString()),
    };
  }

  /// Converts an Excel serial date number to DateTime.
  /// Excel serial dates start from 1900-01-01 (serial = 1).
  DateTime? _excelSerialToDate(int serial) {
    if (serial < 1) return null;
    // Excel incorrectly considers 1900 a leap year, so we adjust for dates after Feb 28, 1900
    final adjustedSerial = serial > 59 ? serial - 1 : serial;
    return DateTime(1899, 12, 30).add(Duration(days: adjustedSerial));
  }
}
