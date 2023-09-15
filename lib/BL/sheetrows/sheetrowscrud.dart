import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../bl.dart';

part 'sheetrowscrud.g.dart'; //dart run build_runner build

@collection
class SheetRow {
  @Id()
  String sheetRownoKey = '';
  String sheetRowArr = '';
}

class SheetrowsCRUD {
  Future<List<String>> readAllKeys() async {
    try {
      return isar.sheetRows.where().sheetRownoKeyProperty().findAll();
    } catch (e) {
      debugPrint('sheetrowsCRUD().readAll()\n$e');
      return [];
    }
  }

  //------------------------------------------------------------------update
  Future updateRow(String sheetRownoKey, List<String> rowArr) async {
    final newsheetRow = SheetRow()
      ..sheetRownoKey = sheetRownoKey
      ..sheetRowArr = rowArr.join('__|__');

    await isar.writeAsync((isar) async {
      isar.sheetRows.put(newsheetRow);
    });
  }

  Future update() async {
    //List<String> catsRows = catsMock.split('\n');

    // await isar.write((isar) async {
    //   isar.cats.clear();
    // });

    // for (String catPath in catsRows) {
    //   final newCatpath = Cat()..catpath = catPath;

    //   isar.write((isar) async {
    //     isar.cats.put(newCatpath);
    //   });
    // }

    return [];
  }
}
