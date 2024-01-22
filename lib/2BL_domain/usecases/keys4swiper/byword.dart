import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';

class ByWord {
  Future<int> getSheetGroup(String sheetGroup, String searchText) async {
    currentSS.keys = await dl.httpService.getSheetGroup(sheetGroup, searchText);
    bl.lastCount[sheetGroup] = '';
    if (currentSS.keys.isEmpty) {
      return 0;
    }
    await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
    return currentSS.keys.length;
  }
}
