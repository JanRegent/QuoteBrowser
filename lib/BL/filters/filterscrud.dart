import 'package:isar/isar.dart';

import '../bl.dart';

part 'filterscrud.g.dart'; //dart run build_runner build

@collection
class SimpleFilter {
  @Id()
  String filterKey = '';
  List<String> sheetRownoKeys = [];

  @override
  toString() {
    return '''
    ------------------------------DateFilter--$filterKey
    $sheetRownoKeys
  ''';
  }
}

class FiltersCRUD {
  //------------------------------------------------------------------read

  Future<List<String>> readWords() async {
    try {
      List<String>? keys =
          isar.simpleFilters.where().filterKeyProperty().findAll();
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
          .filterKeyEqualTo(filterKey)
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
          .filterKeyEqualTo(filterKey)
          .sheetRownoKeysProperty()
          .findFirst()![currentIndex];
      return keys;
    } catch (_) {
      return '';
    }
  }

  //------------------------------------------------------------------update
  Future updateFilter(
      String filterKey, String filterName, List<String> sheetRownoKeys) async {
    if (filterName.isEmpty) return;
    if (sheetRownoKeys.isEmpty) return;
    isar.write((isar) async {
      SimpleFilter sFilter = SimpleFilter();
      sFilter.filterKey = filterKey;
      sFilter.sheetRownoKeys = sheetRownoKeys;

      isar.simpleFilters.put(sFilter);
    });
  }
}
