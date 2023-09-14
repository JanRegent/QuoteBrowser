import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../../AL/zview/battribs/category/catsmock.dart';
import '../bl.dart';

part 'catscrud.g.dart'; //dart run build_runner build

@collection
class Cat {
  @Id()
  String catpath = '';
}

class CatsCRUD {
  Future<List<String>> readAll() async {
    try {
      return isar.cats.where().catpathProperty().findAll();
    } catch (e) {
      debugPrint('CatsCRUD().readAll()\n$e');
      return [];
    }
  }

  Future update() async {
    List<String> catsRows = catsMock.split('\n');

    await isar.write((isar) async {
      isar.cats.clear();
    });

    for (String catPath in catsRows) {
      final newCatpath = Cat()..catpath = catPath;

      isar.write((isar) async {
        isar.cats.put(newCatpath);
      });
    }
  }
}
