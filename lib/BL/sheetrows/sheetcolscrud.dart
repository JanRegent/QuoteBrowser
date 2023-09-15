import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../bl.dart';

part 'sheetcolscrud.g.dart'; //dart run build_runner build

@collection
class SheetCol {
  @Id()
  String sheetRownoKey = '';
  String cols = '';
}

class SheetcolsCRUD {
  Future<List<String>> readAllKeys() async {
    try {
      return isar.sheetCols.where().sheetRownoKeyProperty().findAll();
    } catch (e) {
      debugPrint('sheetrowsCRUD().readAll()\n$e');
      return [];
    }
  }

  //------------------------------------------------------------------update
  Future updateCols(String sheetRownoKey, List<String> rowArr) async {
    final newsheetCol = SheetCol()
      ..sheetRownoKey = sheetRownoKey
      ..cols = rowArr.join('__|__');
    print(newsheetCol.cols);
    print('--------------');
    await isar.writeAsync((isar) async {
      isar.sheetCols.put(newsheetCol);
    });
  }

  Future updateColSet(Map colsSet) async {
    for (var sheetRownoKey in colsSet.keys) {
      await updateCols(
          sheetRownoKey, blUti.toListString(colsSet[sheetRownoKey]));
    }
  }
}
