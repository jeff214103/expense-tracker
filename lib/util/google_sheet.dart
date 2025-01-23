import 'package:expense_tracker_web/models/expense_record.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;

class GoogleSheetHelper {
  static Future<String> getSpreadsheetId() async {
    final googleAuth =
        (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
    final driveApi = drive.DriveApi(googleAuth);
    final sheetsApi = sheets.SheetsApi(googleAuth);

    // List files with spreadsheet mime type
    final files = await driveApi.files.list(
      q: "mimeType = 'application/vnd.google-apps.spreadsheet'",
    );

    // Find or create spreadsheet
    String? spreadsheetId;
    for (var file in (files.files) ?? []) {
      if (file.name == 'Expense Record (Automated)') {
        spreadsheetId = file.id!;
        break;
      }
    }

    if (spreadsheetId == null) {
      // Create spreadsheet using Sheets API
      final spreadsheet = await sheetsApi.spreadsheets.create(
          sheets.Spreadsheet()
            ..properties = sheets.SpreadsheetProperties(
                title: 'Expense Record (Automated)'));

      spreadsheetId = spreadsheet.spreadsheetId!;
      return spreadsheetId;
    } else {
      return spreadsheetId;
    }
  }

  static Future<bool> createSheet(
      sheets.SheetsApi sheetsApi, String spreadsheetId, String title) async {
    // First, get the spreadsheet to check existing sheets
    final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);

    // Check if sheet with given title already exists
    bool sheetExists =
        spreadsheet.sheets?.any((sheet) => sheet.properties?.title == title) ??
            false;

    if (!sheetExists) {
      final batchUpdate = sheets.BatchUpdateSpreadsheetRequest();

      // Add sheet request
      batchUpdate.requests = [
        sheets.Request()
          ..addSheet = sheets.AddSheetRequest(
              properties: sheets.SheetProperties(title: title))
      ];

      // Execute batch update to create the sheet
      await sheetsApi.spreadsheets.batchUpdate(batchUpdate, spreadsheetId);

      String range = "$title!A1:H1";
      final values = [ExpenseRecord.headers];

      await sheetsApi.spreadsheets.values.append(
        sheets.ValueRange()..values = values,
        spreadsheetId,
        range,
        valueInputOption: 'USER_ENTERED',
      );
    }

    return true;
  }

  static Future<sheets.AppendValuesResponse> insert({
    required String itemName,
    required String category,
    required String currency,
    required String amount,
    required String submitDate,
    required String filename,
    required DateTime receiptDate,
  }) async {
    final googleAuth =
        (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
    final sheetsApi = sheets.SheetsApi(googleAuth);

    String title = "Expense (${DateFormat('y MMM').format(receiptDate)})";
    final spreadsheetId = await getSpreadsheetId();

    await createSheet(sheetsApi, spreadsheetId, title);

    String range = '$title!A1:E1';

    final expenseRecord = ExpenseRecord(
      uploadDate: submitDate,
      invoiceDate: receiptDate,
      item: itemName,
      category: category,
      currency: currency,
      amount: amount,
      fileName: filename,
      finalAmount: amount, // Assuming final amount is same as amount for now
    );

    return sheetsApi.spreadsheets.values.append(
      sheets.ValueRange()..values = [expenseRecord.toSheetRow()],
      spreadsheetId,
      range,
      valueInputOption: 'USER_ENTERED',
    );
  }

  static Future<List<String>> getSpreadsheets() async {
    final googleAuth =
        (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
    final sheetsApi = sheets.SheetsApi(googleAuth);

    final spreadsheetId = await getSpreadsheetId();

    final spreadsheets = await sheetsApi.spreadsheets.get(spreadsheetId);
    return spreadsheets.sheets!
        .map((sheet) => sheet.properties!.title!)
        .where((title) => title.startsWith('Expense ('))
        .toList()
      ..sort((a, b) {
        // Extract date strings (e.g., "2024 Mar" from "Expense (2024 Mar)")
        final dateA =
            a.substring(9, a.length - 1); // Remove "Expense (" and ")"
        final dateB = b.substring(9, b.length - 1);

        // Parse dates using DateFormat
        final parsedDateA = DateFormat('y MMM').parse(dateA);
        final parsedDateB = DateFormat('y MMM').parse(dateB);

        return parsedDateB.compareTo(parsedDateA);
      });
  }

  static Future<List<ExpenseRecord>?> getSheetData(String sheetTitle) async {
    final googleAuth =
        (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
    final sheetsApi = sheets.SheetsApi(googleAuth);

    final spreadsheetId = await getSpreadsheetId();

    final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);

    bool sheetExists = spreadsheet.sheets
            ?.any((sheet) => sheet.properties?.title == sheetTitle) ??
        false;

    if (!sheetExists) {
      return null;
    }

    final response = await sheetsApi.spreadsheets.values.get(
      spreadsheetId,
      '$sheetTitle!A2:H',
    );

    return (response.values ?? [])
        .map((row) => ExpenseRecord.fromSheetRow(row))
        .toList();
  }
}
