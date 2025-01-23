import 'package:intl/intl.dart';

class ExpenseRecord {
  final String uploadDate;
  final DateTime invoiceDate;
  final String item;
  final String category;
  final String currency;
  final String amount;
  final String fileName;
  final String finalAmount;

  ExpenseRecord({
    required this.uploadDate,
    required this.invoiceDate,
    required this.item,
    required this.category,
    required this.currency,
    required this.amount,
    required this.fileName,
    required this.finalAmount,
  });

  List<Object> toSheetRow() {
    final dateFormat = DateFormat('d MMM y');
    return [uploadDate,
      dateFormat.format(invoiceDate),
      item,
      category,
      currency,
      amount,
      fileName,
      finalAmount,
    ];
  }

  factory ExpenseRecord.fromSheetRow(List<Object?> row) {
    final dateFormat = DateFormat('d MMM y');
    return ExpenseRecord(
      uploadDate: row[0] as String,
      invoiceDate: dateFormat.parse(row[1] as String),
      item: row[2] as String,
      category: row[3] as String,
      currency: row[4] as String,
      amount: row[5] as String,
      fileName: row[6] as String,
      finalAmount: row[7] as String,
    );
  }

  static List<String> get headers => [
    'Upload Date',
    'Invoice Date',
    'Item',
    'Category',
    'Currency',
    'Amount',
    'File',
    'Final Amount'
  ];
} 