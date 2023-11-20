import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../bl.dart';

part 'sheetrowscrud.g.dart'; //dart run build_runner build

@collection
class SheetRow {
  @Id()
  String sheetRownoKey = '';
  List<String> sheetRowArr = [];
}

class SheetrowsCRUD {
  //------------------------------------------------------------------read

  Future<List<String>> getRowArr(String key) async {
    try {
      return isar.sheetRows.get(key)!.sheetRowArr;
    } catch (e) {
      debugPrint('sheetrowsCRUD().getRowArr($key)\n$e');
      return [];
    }
  }

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
    final sheetrow = SheetRow();
    sheetrow.sheetRownoKey = sheetRownoKey;
    sheetrow.sheetRowArr = rowArr;
    // rowArr.join('__|__');

    isar.write((isar) async {
      isar.sheetRows.put(sheetrow);
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

  //------------------------------------------------------------------update
  Future deleteAllDb() async {
    isar.write((isar) async {
      isar.sheetRows.clear();
    });
  }
}
