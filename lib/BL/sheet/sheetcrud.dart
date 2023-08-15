import 'dart:math';

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

Future<Sheet> readByAuthor(String author) async {
  try {
    Sheet sheet = isar.sheets.where().authorContains('IconButton').findAll()[0];
    currentSheet = sheet;
    return sheet;
  } catch (e) {
    debugPrint(e.toString());
    return newSheet();
  }
}

Future<int> readMaxRowIndex(String sheetName) async {
  try {
    List<int> rowIndexes = isar.sheets
        .where()
        .aSheetNameEqualTo(sheetName)
        .aIndexProperty()
        .findAll();
    int newIndex = rowIndexes.reduce(max) + 1;

    return newIndex;
  } catch (e) {
    debugPrint(e.toString());
    return -1;
  }
}

void update(Sheet sheet) async {
  if (sheet.aIndex == 0) sheet.aIndex = await readMaxRowIndex(sheet.aSheetName);
  isar.write((isar) {
    isar.sheets.put(sheet);
  });
}
