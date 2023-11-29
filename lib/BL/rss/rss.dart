import 'package:isar/isar.dart';

import '../bl.dart';

part 'rss.g.dart'; //dart run build_runner build

@collection
class Rss {
  @Id()
  String link = '';

  String title = '';
  String author = '';
  String updated = '';

  @override
  toString() {
    return '''
    -----------link--$link
    $title
    $author                        $updated
  ''';
  }
}

class RssCRUD {
  //------------------------------------------------------------------read

  Future<List<Rss>> readAll() async {
    try {
      List<Rss>? rows = isar.rss.where().findAll();
      return rows;
    } catch (_) {
      return [];
    }
  }

  // Future<List<String>> readFilter(String filterKey) async {
  //   try {
  //     List<String>? keys = isar.simpleFilters
  //         .where()
  //         .wordKeyEqualTo(filterKey)
  //         .sheetRownoKeysProperty()
  //         .findFirst();

  //     return keys!;
  //   } catch (_) {
  //     return [];
  //   }
  // }

  // Future<String> readFilterAtCurrentindex(
  //     String filterKey, int currentIndex) async {
  //   try {
  //     String keys = isar.simpleFilters
  //         .where()
  //         .wordKeyEqualTo(filterKey)
  //         .sheetRownoKeysProperty()
  //         .findFirst()![currentIndex];
  //     return keys;
  //   } catch (_) {
  //     return '';
  //   }
  // }

  // //------------------------------------------------------------------update
  // Future updateFilter(String filterKey, List<String> sheetRownoKeys) async {
  //   if (sheetRownoKeys.isEmpty) return;
  //   isar.write((isar) async {
  //     SimpleFilter sFilter = SimpleFilter();
  //     sFilter.link = filterKey;
  //     sFilter.sheetRownoKeys = sheetRownoKeys;

  //     isar.simpleFilters.put(sFilter);
  //   });
  // }

  // //------------------------------------------------------------------delete
  // Future deleteFilter(String wordKey) async {
  //   if (wordKey.isEmpty) return;
  //   isar.write((isar) async {
  //     isar.simpleFilters.delete(wordKey);
  //   });
  // }
}
