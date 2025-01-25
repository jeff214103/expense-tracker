import 'package:expense_tracker_web/models/expense_record.dart';
import 'package:expense_tracker_web/util/currency_service.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
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

  // Cache to store sheet data
  static final Map<String, List<ExpenseRecord>> _cachedSheetData = {};

  static Future<List<ExpenseRecord>?> getSheetData(
    String sheetTitle, {
    bool force = false,
  }) async {
    // If not forced and data exists in cache, return cached data
    if (!force && _cachedSheetData.containsKey(sheetTitle)) {
      if (kDebugMode) {
        print('Cached sheet data found for $sheetTitle');
      }
      return _cachedSheetData[sheetTitle];
    }
    if (kDebugMode) {
      print('Fetching sheet data for $sheetTitle');
    }

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

    final sheetData = (response.values ?? [])
        .map((row) => ExpenseRecord.fromSheetRow(row))
        .toList();

    // Cache the fetched data
    _cachedSheetData[sheetTitle] = sheetData;

    return sheetData;
  }

  static Future<bool> updateFinalAmount({
    required String sheetTitle,
    required int rowIndex, // 1-based index, excluding header
    required String finalAmount,
    required String currency,
  }) async {
    try {
      final googleAuth =
          (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
      final sheetsApi = sheets.SheetsApi(googleAuth);

      final spreadsheetId = await getSpreadsheetId();

      // Construct the range to update the final amount column (8th column)
      // Add 2 to rowIndex to account for 1-based indexing and header row
      String range = '$sheetTitle!H${rowIndex + 2}:H${rowIndex + 2}';

      final valueRange = sheets.ValueRange()
        ..values = [
          [finalAmount]
        ];

      await sheetsApi.spreadsheets.values.update(
        valueRange,
        spreadsheetId,
        range,
        valueInputOption: 'USER_ENTERED',
      );

      return true;
    } catch (e) {
      print('Error updating final amount: $e');
      return false;
    }
  }

  static Future<void> initializeExchangeRatesSheet(sheets.SheetsApi sheetsApi,
      String spreadsheetId, String sheetTitle) async {
    try {
      // Define major currencies to track
      final currencies = CurrencyServiceCustom.getAllCurrencies();

      // Prepare batch update request
      final requests = <sheets.Request>[];

      // Add sheet if it doesn't exist
      requests.add(sheets.Request(
        addSheet: sheets.AddSheetRequest(
          properties: sheets.SheetProperties(
            title: sheetTitle,
            gridProperties: sheets.GridProperties(
              rowCount: currencies.length + 1,
              columnCount: 2,
            ),
          ),
        ),
      ));

      // Batch update to create sheet
      await sheetsApi.spreadsheets.batchUpdate(
        sheets.BatchUpdateSpreadsheetRequest(requests: requests),
        spreadsheetId,
      );

      // Prepare values to write
      final values = <List<String>>[
        ['Currency', 'Exchange Rate'], // Header
        ...currencies
            .map((currency) =>
                [currency, '=GOOGLEFINANCE("CURRENCY:USD$currency")'])
            .toList(),
      ];

      // Write headers and formulas
      await sheetsApi.spreadsheets.values.update(
        sheets.ValueRange(values: values),
        spreadsheetId,
        '$sheetTitle!A1:B${values.length}',
        valueInputOption: 'USER_ENTERED',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing $sheetTitle sheet: $e');
      }
    }
  }

  static Future<Map<String, double>> getExchangeRates() async {
    Map<String, double> exchangeRates = {};
    final spreadsheetId = await GoogleSheetHelper.getSpreadsheetId();
    final googleAuth =
        await GoogleSignInHelper.googleSignIn.authenticatedClient();
    final sheetsApi = sheets.SheetsApi(googleAuth!);

    final spreadsheet = await sheetsApi.spreadsheets.get(spreadsheetId);

    const String sheetTitle = 'Exchange Rates';
    bool sheetExists = spreadsheet.sheets
            ?.any((sheet) => sheet.properties?.title == sheetTitle) ??
        false;

    if (!sheetExists) {
      // Ensure spreadsheet exists
      initializeExchangeRatesSheet(sheetsApi, spreadsheetId, sheetTitle);
    }

    // Read exchange rates from the sheet
    final response = await sheetsApi.spreadsheets.values.get(
      spreadsheetId,
      '$sheetTitle!A2:B', // Assuming A column is currency code, B column is rate
    );

    if (response.values != null) {
      for (var row in response.values!) {
        if (row.length >= 2) {
          final currencyCode = row[0].toString();
          final rate = double.tryParse(row[1].toString()) ?? 1.0;
          exchangeRates[currencyCode] = rate;
        }
      }
    }
    return exchangeRates;
  }
}
