import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';

class ByWord {
  Future<int> getSheetGroup(String sheetGroup, String searchText) async {
    currentSS.filterKey = '$searchText __|__ $sheetGroup';
    bl.lastCount[sheetGroup] = 'loading';
    currentSS.swiperIndex.value = 0;
    try {
      currentSS.keys = (await bl.filtersCRUD.readFilter(currentSS.filterKey));
    } catch (_) {}

    if (currentSS.keys.isEmpty) {
      currentSS.keys =
          await dl.httpService.getSheetGroup(sheetGroup, searchText);
      await bl.filtersCRUD
          .updateFilter('$searchText __|__ $sheetGroup', currentSS.keys);
    }
    bl.lastCount[sheetGroup] = '';
    if (currentSS.keys.isEmpty) {
      return 0;
    }
    await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
    return currentSS.keys.length;
  }
}
