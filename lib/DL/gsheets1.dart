import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class GsheetsHelper {
  /// https://pub.dev/packages/gsheets/example
  ///
  /// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
  Map _credentials = {};
  Future<void> loadCredentials() async {
    if (_credentials.isNotEmpty) return;
    final String jsonString =
        await rootBundle.loadString('assets/gitIgnore/client_secret.json');
    _credentials = jsonDecode(jsonString);
  }

  // ignore: prefer_typing_uninitialized_variables
  late final GSheets gsheets;
  Future init() async {
    await loadCredentials();
    // init GSheets
    gsheets = GSheets(_credentials);
  }

  Future<List<List<String>>> getSheetAll(
      String sheetName, String spreadsheetId) async {
    final ss = await gsheets.spreadsheet(spreadsheetId);

    Worksheet? worksheet = ss.worksheetByTitle(sheetName);
    List<List<String>> rows = await worksheet!.values.allRows();

    return rows;
  }

  Future<List<String>> getSheetNames(String spreadsheetId) async {
    final Spreadsheet ss = await gsheets.spreadsheet(spreadsheetId);

    List<Worksheet> worksheets = ss.sheets;
    List<String> sheetNames = [];
    for (Worksheet worksheet in worksheets) {
      if (worksheet.title.contains('log')) continue;
      if (worksheet.title.contains('DailyManForm')) continue;
      if (worksheet.title.toLowerCase().contains('config')) continue;
      if (worksheet.title.startsWith('__')) continue;

      sheetNames.add(worksheet.title);
    }

    return sheetNames;
  }

  Future updateCell(String newValue, String sheetName, String spreadsheetId,
      int rowIndex, int colIndex) async {
    final ss = await gsheets.spreadsheet(spreadsheetId);

    var sheet = ss.worksheetByTitle(sheetName);

    await sheet!.values.insertValue(newValue, column: colIndex, row: rowIndex);
  }
}
