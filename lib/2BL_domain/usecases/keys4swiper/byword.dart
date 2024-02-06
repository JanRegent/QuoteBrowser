import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';
import '../../repos/sharedprefs.dart';

class ByWord {
  Future searchSheetsColumns2(
      String word1, String columnName1, word2, String columnName2) async {
    currentSS.keys = await dl.httpService
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
    currentSS.keys = await dl.httpService
        .fullText5wordsinService(word1, word2, word3, word4, word5);

    return currentSS.keys.length;
  }

  Future searchSheetNames(String filterPrefix, String groupName, String word1,
      String word2, String word3, String word4, String word5) async {
    currentSS.keys = SharedPrefs.getStringList(
        '$filterPrefix $groupName $word1 $word2 $word3 $word4 $word5');
    if (currentSS.keys.isNotEmpty) return currentSS.keys.length;
    currentSS.keys = await dl.httpService.searchSheetNames(
        bl.dailyList.sheetNamesStr(groupName),
        word1,
        word2,
        word3,
        word4,
        word5);
    SharedPrefs.setStringList(
        '$filterPrefix $groupName $word1 $word2 $word3 $word4 $word5',
        currentSS.keys);
    return currentSS.keys.length;
  }
}
