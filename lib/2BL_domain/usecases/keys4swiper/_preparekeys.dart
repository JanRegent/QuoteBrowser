import '../../../1PL/pages/1bydate/dailylist.dart';
import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';
import 'byword.dart';

class PrepareKeys {
  ByWord byWord = ByWord();

  Future sheetAllKeys() async {
    DailyListRow dailyListRow = currentSS.dailyListRow;
    String sheetGroup = dailyListRow.sheetGroup;
    bl.lastCount[sheetGroup] = 'loading';
    String sheetName = dailyListRow.sheetName;
    await dl.httpService.getSheetSave(sheetName);
    List<String> keys = await bl.sheetrowsCRUD.readKeysRowNoSorted(sheetName);
    if (keys.isEmpty) return;
    currentSS.keys = [];
    currentSS.keys.addAll(keys);
    bl.lastCount[sheetGroup] = '';
    currentSS.swiperIndex.value = int.tryParse(dailyListRow.swiperIndex)!;
  }
}
