import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../bl.dart';

part 'sheetrowscrud.g.dart'; //dart run build_runner build

@collection
class SheetRow {
  @Id()
  String sheetRownoKey = '';
  int rowNo = 0;
  List<String> sheetRowArr = [];
}

class SheetrowsCRUD {
  //----------------------------------------------------------------create,count

  Future<int> count() async {
    try {
      return isar.sheetRows.where().findAll().length;
    } catch (e) {
      debugPrint('sheetrowsCRUD().count()\n$e');
      return 0;
    }
  }
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

  Future<List<String>> readKeysRowNoSorted(String sheetName) async {
    List<String> keys = [];
    try {
      List<int> rowInts = isar.sheetRows
          .where()
          .sheetRownoKeyStartsWith(sheetName)
          .rowNoProperty()
          .findAll()
          .sorted();
      for (var i = 0; i < rowInts.length; i++) {
        keys.add('${sheetName}__|__${rowInts[i]}');
      }

      return keys;
    } catch (e) {
      debugPrint('sheetrowsCRUD().readAll()\n$e');
      return [];
    }
  }

  //------------------------------------------------------------------update
  Future updateRow(String sheetRownoKey, List<String> rowArr) async {
    final sheetrow = SheetRow();
    sheetrow.sheetRownoKey = sheetRownoKey;
    try {
      sheetrow.rowNo = int.tryParse(sheetRownoKey.split('__|__')[1])!;
    } catch (_) {
      sheetrow.rowNo = 0;
    }
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
