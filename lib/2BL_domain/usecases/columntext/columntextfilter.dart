import 'package:isar/isar.dart';

import '../../bl.dart';

part 'columntextfilter.g.dart'; //dart run build_runner build

@collection
class ColumnTextFilter {
  @Id()
  String columnTextKey = '';
  String columnName = '';
  String columnValue = '';
  String searchText = '';
  List<String> sheetRownoKeys = [];

  @override
  toString() {
    return '''
    ------------------------------DateFilter--$columnTextKey
    $sheetRownoKeys
  ''';
  }
}

class ColumnTextFilterCRUD {
  //------------------------------------------------------------------read

  Future<List<String>> readColumnTextKeys() async {
    try {
      List<String>? keys =
          isar.columnTextFilters.where().columnTextKeyProperty().findAll();

      List<String> words = [];
      for (String key in keys) {
        words.add(key);
      }
      return words;
    } catch (_) {
      return [];
    }
  }

  Future<List<String>> readFilter(String filterKey) async {
    try {
      List<String>? keys = isar.columnTextFilters
          .where()
          .columnTextKeyEqualTo(filterKey)
          .sheetRownoKeysProperty()
          .findFirst();

      return keys!;
    } catch (_) {
      return [];
    }
  }

  Future<String> readFilterAtswiperIndex(
      String filterKey, int swiperIndex) async {
    try {
      String keys = isar.columnTextFilters
          .where()
          .columnTextKeyEqualTo(filterKey)
          .sheetRownoKeysProperty()
          .findFirst()![swiperIndex];
      return keys;
    } catch (_) {
      return '';
    }
  }

  //------------------------------------------------------------------update
  Future updateFilter(String columnName, String columnValue, String word,
      List<String> sheetRownoKeys) async {
    if (columnValue.isEmpty) return;
    if (word.isEmpty) return;
    if (sheetRownoKeys.isEmpty) return;
    isar.write((isar) async {
      ColumnTextFilter sFilter = ColumnTextFilter();
      sFilter.columnTextKey = '$columnValue __|__$word';
      sFilter.columnName = columnName;
      sFilter.sheetRownoKeys = sheetRownoKeys;

      isar.columnTextFilters.put(sFilter);
    });
  }
}
