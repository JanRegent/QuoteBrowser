import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';

class ByWord {
  Future<int> getSheetGroup(String sheetGroup, String searchText) async {
    currentSS.keys = await dl.httpService.getSheetGroup(sheetGroup, searchText);
    if (currentSS.keys.isEmpty) {
      return 0;
    }
    await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
    return currentSS.keys.length;
  }

  Future searchSheetsColumns2(
      String word1, String columnName1, word2, String columnName2) async {
    currentSS.keys = await dl.httpService
        .searchSheetsColumns2(word1, columnName1, word2, columnName2);

    return currentSS.keys.length;
  }

  Future fulltextWord5(
    String word1,
    String word2,
    String word3,
    String word4,
    String word5,
  ) async {
    currentSS.keys = await dl.httpService
        .fulltextWord5('', word1, word2, word3, word4, word5);

    return currentSS.keys.length;
  }

  Future searchSheetNames(
    String groupName,
    String word1,
    String word2,
    String word3,
    String word4,
    String word5,
  ) async {
    currentSS.keys = await dl.httpService.searchSheetNames(
        bl.dailyList.sheetNamesStr(groupName),
        word1,
        word2,
        word3,
        word4,
        word5);

    return currentSS.keys.length;
  }
}
