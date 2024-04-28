import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';
import '../../repos/sharedprefs.dart';

class ByWord {
  Future searchSheetsColumns2(
      String word1, String columnName1, word2, String columnName2) async {
    currentSS.keys = await dl.gservice23
        .searchSheetsColumns2(word1, columnName1, word2, columnName2);

    return currentSS.keys.length;
  }

  Future fullText5wordsinService(
    String word1,
    String word2,
    String word3,
    String word4,
    String word5,
  ) async {
    currentSS.keys = await dl.gservice23
        .fullText5wordsinService(word1, word2, word3, word4, word5);

    return currentSS.keys.length;
  }

  String searchMode = 'sql';

  Future columnWord5(String filterColumnName, String word1, String word2,
      String word3, String word4, String word5) async {
    currentSS.keys =
        SharedPrefs.getStringList('$word1 $word2 $word3 $word4 $word5');
    if (currentSS.keys.isNotEmpty) return currentSS.keys.length;

    if (filterColumnName == 'dateinsert') {
      currentSS.keys = await bl.supRepo.dateinsertSelect(word1);
    }
    if (filterColumnName == 'quote') {
      currentSS.keys = await bl.supRepo.quote1Select(word1);
    }
    SharedPrefs.setStringList(
        '$word1 $word2 $word3 $word4 $word5', currentSS.keys);
    return currentSS.keys.length;
  }
}
