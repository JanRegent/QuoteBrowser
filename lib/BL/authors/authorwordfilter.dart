import 'package:isar/isar.dart';

import '../bl.dart';

part '../filters/authorwordfilter.g.dart'; //dart run build_runner build

@collection
class AuthorWordFilter {
  @Id()
  String authorWordKey = '';
  String author = '';
  String word = '';
  List<String> sheetRownoKeys = [];

  @override
  toString() {
    return '''
    ------------------------------DateFilter--$authorWordKey
    $sheetRownoKeys
  ''';
  }
}

class AuthorWordFilterCRUD {
  //------------------------------------------------------------------read

  Future<List<String>> readWords() async {
    try {
      List<String>? keys =
          isar.authorWordFilters.where().authorWordKeyProperty().findAll();
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
      List<String>? keys = isar.authorWordFilters
          .where()
          .authorWordKeyEqualTo(filterKey)
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
      String keys = isar.authorWordFilters
          .where()
          .authorWordKeyEqualTo(filterKey)
          .sheetRownoKeysProperty()
          .findFirst()![currentIndex];
      return keys;
    } catch (_) {
      return '';
    }
  }

  //------------------------------------------------------------------update
  Future updateFilter(
      String author, String word, List<String> sheetRownoKeys) async {
    if (author.isEmpty) return;
    if (word.isEmpty) return;
    if (sheetRownoKeys.isEmpty) return;
    isar.write((isar) async {
      AuthorWordFilter sFilter = AuthorWordFilter();
      sFilter.authorWordKey = '$author __|__$word';
      sFilter.sheetRownoKeys = sheetRownoKeys;

      isar.authorWordFilters.put(sFilter);
    });
  }
}
