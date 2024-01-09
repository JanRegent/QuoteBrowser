import 'package:isar/isar.dart';

import '../../bl.dart';

part 'simplefilter.g.dart'; //dart run build_runner build

@collection
class SimpleFilter {
  @Id()
  String wordKey = '';
  List<String> sheetRownoKeys = [];

  @override
  toString() {
    return '''
    ------------------------------SimpleFilter--$wordKey
    $sheetRownoKeys
  ''';
  }
}

class FiltersCRUD {
  //------------------------------------------------------------------read

  Future<List<String>> readWords() async {
    try {
      List<String>? keys =
          isar.simpleFilters.where().wordKeyProperty().findAll();
      List<String> words = [];
      for (String key in keys) {
        if (key.startsWith('20')) continue;
        words.add(key);
      }
      return words;
    } catch (_) {
      return [];
    }
  }

  Future<List<String>> readFilter(String filterKey) async {
    try {
      List<String>? keys = isar.simpleFilters
          .where()
          .wordKeyEqualTo(filterKey)
          .sheetRownoKeysProperty()
          .findFirst();

      return keys!;
    } catch (_) {
      return [];
    }
  }

  Future<String> readFilterAtCurrentindex(
      String filterKey, int currentIndex) async {
    try {
      String keys = isar.simpleFilters
          .where()
          .wordKeyEqualTo(filterKey)
          .sheetRownoKeysProperty()
          .findFirst()![currentIndex];
      return keys;
    } catch (_) {
      return '';
    }
  }

  //------------------------------------------------------------------update
  Future updateFilter(String filterKey, List<String> sheetRownoKeys) async {
    if (sheetRownoKeys.isEmpty) return;
    isar.write((isar) async {
      SimpleFilter sFilter = SimpleFilter();
      sFilter.wordKey = filterKey;
      sFilter.sheetRownoKeys = sheetRownoKeys;

      isar.simpleFilters.put(sFilter);
    });
  }

  //------------------------------------------------------------------delete
  Future deleteFilter(String wordKey) async {
    if (wordKey.isEmpty) return;
    isar.write((isar) async {
      isar.simpleFilters.delete(wordKey);
    });
  }
}
