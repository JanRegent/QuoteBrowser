import 'dart:convert';

import 'package:gsheets/gsheets.dart';
import 'package:quotebrowser/BL/params/params.dart';

import './credentials.dart';
import '../BL/bluti.dart';
import '../BL/sheet/sheet.dart';

Map gsheetsCredentials = {};

Future gsheetsCredentialsLoad() async {
  try {
    gsheetsCredentials = gsheetsCredentialsDeploy;
  } catch (_) {}
  String clientSecret = await readParam('gsheetsCredentials');
  if (clientSecret.isEmpty) return;
  gsheetsCredentials = jsonDecode(clientSecret);
}

class GsheetsCRUD {
  /// https://pub.dev/packages/gsheets/example
  ///
  /// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430

  // ignore: prefer_typing_uninitialized_variables
  late final GSheets gsheets;
  Future init() async {
    // init GSheets
    gsheets = GSheets(gsheetsCredentials);
  }

  Future gsheetsCredentialsSave() async {
    Params paramCred = Params()
      ..key = 'gsheetsCredentials'
      ..scope = 'DL'
      ..value = jsonEncode(gsheetsCredentials);
    updateParam(paramCred);
  }

  Future<int> createRow(Sheet sheet, String spreadsheetId) async {
    String sheetName = sheet.aSheetName;
    if (sheetName.isEmpty) return -1;
    final ss = await gsheets.spreadsheet(spreadsheetId);

    Worksheet? worksheet = ss.worksheetByTitle(sheetName);

    final newRow = {
      'citat': sheet.quote,
      'autor': sheet.author,
      'kniha': sheet.book,
      'folder': sheet.folder,
      'tags': sheet.tagsStr,
      'sourceUrl': sheet.sourceUrl,
      'dateinsert': '${blUti.todayStr()}.',
    };
    await worksheet!.values.map.appendRow(newRow);

    return 0;
  }

  ///
  ///todo [ERROR:flutter/runtime/dart_vm_initializer.cc(41)]
  ///Unhandled Exception: GSheetsException: Quota exceeded for quota metric 'Read requests' and limit 'Read requests per minute per user' of service 'sheets.googleapis.com' for consumer 'project_number:470535595594'.
  Future<List<List<String>>> readSheetAll(
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
