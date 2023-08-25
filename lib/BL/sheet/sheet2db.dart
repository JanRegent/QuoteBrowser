import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/params/params.dart';

import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../../DL/diocrud.dart';

import '../bl.dart';
import '../bluti.dart';
import 'sheetcrud.dart';

RxList sheetNamesToday = [].obs;
RxList sheetNamesLength = [].obs;
RxString loadingTitle = ''.obs;
List<String> sheetNames = [];
String fileId = dataSheetId;

Future sheetNamesInit() async {
  sheetNames = [];
  sheetNames = await getDataSheets(dataSheetId);
  for (var i = 0; i < sheetNames.length; i++) {
    sheetNamesToday.add(0);
    sheetNamesLength.add(0);
  }
  sheets2db();
}

Future sheets2db() async {
  debugPrint('refresh start');
  await isar.write((isar) async {
    isar.clear();
  });

  int sheetsLenStart = await sheetsLength();

  if (sheetsLenStart > 1) {
    loadingTitle.value = 'Data UpToDate devmode:${bl.devMode}';
    return;
  }

  for (var index = 0; index < sheetNames.length; index++) {
    String sheetName = sheetNames[index];

    double progressPercD = (index / sheetNames.length) * 100;

    loadingTitle.value = '${progressPercD.toInt()}%  $sheetName';
    await sheet2db(sheetName, fileId);

    sheetNamesLength[index] = await sheetLength(sheetName);

    sheetNamesToday[index] = await sheetTodayLength(sheetName);

    if (bl.devMode) {
      if (index == 1) break;
    }
  }
  debugPrint('refresh done');
  loadingTitle.value = 'Refresh done devmode:${bl.devMode}';
}

Future sheet2db(String sheetName, String fileId) async {
  // List<List<String>> rows =
  //     await dl.gsheetsHelper.readSheetAll(sheetName, fileId);

  List rows = await getAllrows(sheetName, dataSheetId);
  List<Sheet> sheets = [];
  List<String> cols = blUti.toListString(rows[0]);

  for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
    List<String> datarow = blUti.toListString(rows[rowIndex]);
    Sheet sheet = Sheet().sheetFromRow(cols, datarow);

    sheet.aSheetName = sheetName;
    sheet.aIndex = rowIndex + 1;
    sheet.zfileId = fileId;
    sheet.rowType = 'dataRow';

    if (rowIndex == 0) sheet.rowType = 'colRow';
    sheets.add(sheet);
  }

  await isar.write((isar) async {
    for (Sheet sheet in sheets) {
      isar.sheets.put(sheet);
    }
  });
}

Future updateCell(
    Sheet sheet, List<String> cols, String columnName, String newValue) async {
  if (sheet.aIndex < 2) return;
  int colIx = cols.indexOf(columnName) + 1;
  if (colIx < 1) return;
  // await dl.gsheetsHelper.updateCell(
  //     newValue, sheet.aSheetName, sheet.zfileId, sheet.aIndex, colIx);
}

Future printSheet(String sheetName) async {
  debugPrint('---------------------------------------printSheet($sheetName)');
  List<Sheet> sheets =
      isar.sheets.where().aSheetNameEqualTo(sheetName).findAll();
  for (var i = 0; i < sheets.length; i++) {
    debugPrint(sheets[i].toStrings());
  }
}
