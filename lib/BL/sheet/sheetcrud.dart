import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/AL/zview/sheetviewmenu.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../bl.dart';
import '../bluti.dart';

Future<int> sheetLength(String sheetName) async {
  int len = isar.sheets.where().aSheetNameEqualTo(sheetName).findAll().length;
  return len;
}

Future<int> sheetTodayLength(String sheetName) async {
  int len = isar.sheets
      .where()
      .dateinsertEqualTo('${blUti.todayStr()}.')
      .and()
      .rowTypeEqualTo('dataRow')
      .findAll()
      .length;
  //todo error count, wait for inspector
  // print('--------------------------------$sheetName');

  // print(isar.sheets
  //     .where()
  //     .dateinsertEqualTo('${blUti.todayStr()}.')
  //     .dateinsertProperty()
  //     .findFirst());

  return len;
}

Future<Sheet?> readByRowIndex(int index) async {
  try {
    Sheet? sheet = isar.sheets.where().aIndexEqualTo(index).findFirst();

    return sheet;
  } catch (_) {
    return Sheet()..aIndex = index;
  }
}

Future<Sheet> readByRowIndex2(int index) async {
  try {
    Sheet sheet = isar.sheets.where().aIndexEqualTo(index).findFirst()!;
    currentSheet = sheet;
    return sheet;
  } catch (e) {
    debugPrint(e.toString());
    return Sheet()..aIndex = index;
  }
}
