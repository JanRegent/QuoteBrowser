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
  Future update() async {
    List<String> catsRows = catsMock.split('\n');
    //isar.cats.clear();

    for (String catPath in catsRows) {
      final newCatpath = Cat()..catpath = catPath;

      isar.write((isar) async {
        isar.cats.put(newCatpath);
      });
      print(catPath);
    }
  }
}
