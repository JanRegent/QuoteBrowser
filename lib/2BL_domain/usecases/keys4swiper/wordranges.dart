import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';

class ByWord {
  Future<String> getSheetGroup(String sheetGroup, String searchText) async {
    currentSS.filterKey = '$searchText __|__ $sheetGroup';
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
    if (currentSS.keys.isEmpty) {
      return '0';
    }
    await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
    return currentSS.keys.length.toString();
  }
}
