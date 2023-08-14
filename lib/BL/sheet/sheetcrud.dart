import 'package:isar/isar.dart';
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
  print('--------------------------------$sheetName');

  print(isar.sheets
      .where()
      .dateinsertEqualTo('${blUti.todayStr()}.')
      .dateinsertProperty()
      .findFirst());

  return len;
}
