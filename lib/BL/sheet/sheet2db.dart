import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'package:quotebrowser/BL/sheet/sheet.dart';
import 'package:quotebrowser/DL/spreadsheets.dart';

import '../../DL/dl.dart';
import '../bl.dart';
import 'sheetcrud.dart';

RxList sheetNamesToday = [].obs;
RxList sheetNamesLength = [].obs;
RxString loadingTitle = ''.obs;
List<String> sheetNames = [];
String fileId = spreadsheetIdInit;

Future sheetNamesInit() async {
  sheetNames = [];
  sheetNames = await dl.gsheetsHelper.getSheetNames(fileId);
  for (var i = 0; i < sheetNames.length; i++) {
    sheetNamesToday.add(0);
    sheetNamesLength.add(0);
  }
  sheets2db();
}

Future sheets2db() async {
  //String sheetName = 'fb:Lao-c';

  int sheetsLenStart = await sheetsLength();
  for (var index = 0; index < sheetNames.length; index++) {
    String sheetName = sheetNames[index];

    double progressPercD = (index / sheetNames.length) * 100;

    loadingTitle.value = '${progressPercD.toInt()}%  $sheetName';
    await sheet2db(sheetName, fileId);

    sheetNamesLength[index] = await sheetLength(sheetName);
    sheetNamesToday[index] = await sheetTodayLength(sheetName);
    if (sheetsLenStart > 1) continue;
    if (bl.devMode) {
      if (index == 10) break;
    }
  }
  loadingTitle.value = 'Refresh done';
}

Future sheet2db(String sheetName, String fileId) async {
  List<List<String>> rows =
      await dl.gsheetsHelper.readSheetAll(sheetName, fileId);

  for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
    Sheet sheet = Sheet().sheetFromRow(rows[0], rows[rowIndex]);
    sheet.id = isar.sheets.autoIncrement();
    sheet.aSheetName = sheetName;
    sheet.aIndex = rowIndex + 1;
    sheet.zfileId = fileId;
    sheet.rowType = 'dataRow';
    if (rowIndex == 0) sheet.rowType = 'colRow';
    isar.write((isar) {
      isar.sheets.put(sheet);
    });
  }
}

Future updateCell(
    Sheet sheet, List<String> cols, String columnName, String newValue) async {
  if (sheet.aIndex < 2) return;
  int colIx = cols.indexOf(columnName) + 1;
  if (colIx < 1) return;
  await dl.gsheetsHelper.updateCell(
      newValue, sheet.aSheetName, sheet.zfileId, sheet.aIndex, colIx);
}

Future printSheet(String sheetName) async {
  debugPrint('---------------------------------------printSheet($sheetName)');
  List<Sheet> sheets =
      isar.sheets.where().aSheetNameEqualTo(sheetName).findAll();
  for (var i = 0; i < sheets.length; i++) {
    debugPrint(sheets[i].toStrings());
  }
}
