import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../../bl.dart';
import '../../bluti.dart';

part 'sheetcolscrud.g.dart'; //dart run build_runner build

@collection
class SheetCol {
  @Id()
  String sheetName = '';

  List<String> cols = [];

  @override
  toString() {
    return '''
    ------------------------------SheetCol--$sheetName
    $cols
  ''';
  }
}

class SheetcolsCRUD {
  //----------------------------------------------------------------read
  Future<List<String>> readSheetnames() async {
    try {
      return isar.sheetCols.where().sheetNameProperty().findAll();
    } catch (e) {
      debugPrint('sheetrowsCRUD().readAll()\n$e');
      return [];
    }
  }

  Future<List<String>?> readColsBySheetName(String sheetName) async {
    try {
      return isar.sheetCols
          .where()
          .sheetNameEqualTo(sheetName)
          .colsProperty()
          .findFirst();
    } catch (e) {
      debugPrint('sheetrowsCRUD().readColsBySheetName($sheetName)\n$e');
      return [];
    }
  }

  //------------------------------------------------------------------update
  Future updateCols(String sheetName, List<String> rowArr) async {
    isar.write((isar) async {
      SheetCol sheetCol = SheetCol();
      sheetCol.sheetName = sheetName;
      sheetCol.cols = rowArr;

      isar.sheetCols.put(sheetCol);
    });
  }

  Future updateColSet(Map colsSet) async {
    for (var sheetName in colsSet.keys) {
      await updateCols(sheetName, blUti.toListString(colsSet[sheetName]));
    }
  }
}
