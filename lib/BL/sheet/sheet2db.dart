import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/params/params.dart';

import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../../DL/dl.dart';
import '../bl.dart';
import '../bluti.dart';
import '../locdb/sembast/sembastdao.dart';
import 'sheetcrud.dart';

RxList sheetNamesToday = [].obs;
RxList sheetNamesLength = [].obs;
RxString loadingTitle = ''.obs;
List<String> sheetNames = [];
String fileId = dataSheetId;

Future sheetNamesInit() async {
  sheetNames = [];
  sheetNames = await dl.httpService.getDataSheets(dataSheetId);
  for (var i = 0; i < sheetNames.length; i++) {
    sheetNamesToday.add(0);
    sheetNamesLength.add(0);
  }
  sheets2db();
}

Future sheets2db() async {
  debugPrint('-------------------------------refresh start');
  // isar.write((isar) {
  //   isar.clear();
  // });

  int sheetsLenStart = await readLenght();

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
  debugPrint('-------------------------------refresh done');

  loadingTitle.value = 'Refresh done devmode:${bl.devMode}';
}

Future sheet2db(String sheetName, String fileId) async {
  List rows = await dl.httpService.getAllrows(sheetName, dataSheetId);

  List<String> cols = blUti.toListString(rows[0]);

  for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
    List<String> datarow = blUti.toListString(rows[rowIndex]);

    await createRowMap(
        cols, datarow, sheetName, (rowIndex + 1).toString(), fileId);
  }
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
