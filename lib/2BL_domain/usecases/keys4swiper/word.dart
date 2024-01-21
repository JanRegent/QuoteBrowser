import '../../bl.dart';
import 'searchss.dart';

class ByWord {
  Future sheetGroupSheetName(
      String sheetGroup, String sheetName, String searchText) async {
    bl.lastCount[sheetGroup] = 'loading';
    bl.homeTitle.value = 'load: $sheetGroup';
    String rowsCount =
        await searchTextSheetGroupSheetName(sheetGroup, sheetName, searchText);

    bl.lastCount[sheetGroup] = rowsCount;
    bl.homeTitle.value = '';
    return bl.lastCount[sheetGroup];
  }
}
