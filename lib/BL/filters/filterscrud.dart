import 'package:isar/isar.dart';

import '../bl.dart';

part 'filterscrud.g.dart'; //dart run build_runner build

@collection
class SimpleFilter {
  @Id()
  String filterKey = '';
  String filterName = '';
  String filterExpr = '';
  List<String> sheetRownoKeys = [];

  @override
  toString() {
    return '''
    ------------------------------DateFilter--$filterKey
    filterName: $filterName
    filterExpr: $filterExpr
    $sheetRownoKeys
  ''';
  }
}

class FiltersCRUD {
  //------------------------------------------------------------------read

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
    isar.write((isar) async {
      SimpleFilter sFilter = SimpleFilter();
      sFilter.filterKey = filterKey;
      sFilter.sheetRownoKeys = sheetRownoKeys;
      sFilter.filterName = filterName;

      isar.simpleFilters.put(sFilter);
    });
  }
}
