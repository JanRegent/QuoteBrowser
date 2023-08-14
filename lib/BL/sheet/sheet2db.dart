import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../../DL/dl.dart';
import '../bl.dart';
import 'sheetcrud.dart';

RxList sheetNamesToday = [].obs;
RxList sheetNamesLength = [].obs;
RxString loadingTitle = ''.obs;
List<String> sheetNames = [];
String fileId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

Future sheets2db() async {
  //String sheetName = 'fb:Lao-c';

  for (var index = 0; index < sheetNames.length; index++) {
    String sheetName = sheetNames[index];
    loadingTitle.value = 'loading $index/${sheetNames.length} $sheetName';
    await sheet2db(sheetName, fileId);

    sheetNamesLength[index] = await sheetLength(sheetName);
    sheetNamesToday[index] = await sheetTodayLength(sheetName);
    if (index == 0) break;
  }
  loadingTitle.value = 'Loading done of ${sheetNamesToday.length} sheets';
}

Future sheet2db(String sheetName, String fileId) async {
  List<List<String>> rows =
      await dl.gsheetsHelper.getSheetAll(sheetName, fileId);

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
    debugPrint(await sheets[i].toStrings());
  }
}
