import '../../../3Data/dl.dart';
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
}
