import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../bl.dart';

Future<int> sheetLength(String sheetName) async {
  int len = isar.sheets.where().aSheetNameEqualTo(sheetName).findAll().length;
  return len;
}
