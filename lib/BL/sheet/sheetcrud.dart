import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/AL/zview/sheetviewmenu.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../bl.dart';
import '../bluti.dart';

Future<int> sheetsLength() async {
  int len = isar.sheets.where().rowTypeEqualTo('dataRow').findAll().length;
  return len;
}

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

Future<List<int>> readDateinsert(String dateinsert) async {
  try {
    List<int> ids = isar.sheets
        .where()
        .dateinsertEqualTo(dateinsert)
        .idProperty()
        .findAll();

    return ids;
  } catch (_) {
    return [];
  }
}

Future<List<String>> readDateinserts() async {
  try {
    List<String> dateinserts = blUti.toListString(isar.sheets
        .where()
        .distinctByDateinsert()
        .dateinsertProperty()
        .findAll());
    dateinserts.sort((str1, str2) => str2.compareTo(str1));
    return dateinserts;
  } catch (_) {
    return [];
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

void clearSheets() async {
  isar.write((isar) {
    isar.sheets.clear();
  });
}
