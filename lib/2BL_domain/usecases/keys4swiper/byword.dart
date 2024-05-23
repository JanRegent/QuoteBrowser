import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../repos/sharedprefs.dart';

class ByWord {
  Future searchSheetsColumns2(
      String word1, String columnName1, word2, String columnName2) async {
    bl.currentSS.keys = await dl.gservice23
        .searchSheetsColumns2(word1, columnName1, word2, columnName2);

    return bl.currentSS.keys.length;
  }

  Future fullText5wordsinService(
    String word1,
    String word2,
    String word3,
    String word4,
    String word5,
  ) async {
    bl.currentSS.keys = await dl.gservice23
        .fullText5wordsinService(word1, word2, word3, word4, word5);

    return bl.currentSS.keys.length;
  }

  String searchMode = 'sql';

  Future columnWord5(String filterColumnName, String word1, String word2,
      String word3, String word4, String word5) async {
    bl.currentSS.keys =
        SharedPrefs.getStringList('$word1 $word2 $word3 $word4 $word5');
    if (bl.currentSS.keys.isNotEmpty) return bl.currentSS.keys.length;

    if (filterColumnName == 'dateinsert') {
      bl.currentSS.keys = await bl.supRepo.dateinsertKeys(word1);
      bl.wfiltersRepo.insert({'filtertype': 'dateinsert', 'w1': word1});
    }
    if (filterColumnName == 'quote') {
      bl.currentSS.keys = await bl.supRepo.quote1Select(word1);
    }
    SharedPrefs.setStringList(
        '$word1 $word2 $word3 $word4 $word5', bl.currentSS.keys);
    return bl.currentSS.keys.length;
  }
}
