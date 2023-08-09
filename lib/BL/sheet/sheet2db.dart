import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../../DL/dl.dart';
import '../bl.dart';

Future sheet2db() async {
  String sheetName = 'fb:Lao-c';
  String fileId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';

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
  printSheet(sheetName);
}

Future printSheet(String sheetName) async {
  debugPrint('---------------------------------------printSheet($sheetName)');
  List<Sheet> sheets =
      isar.sheets.where().aSheetNameEqualTo(sheetName).findAll();
  for (var i = 0; i < sheets.length; i++) {
    debugPrint(await sheets[i].toStrings());
  }
}
