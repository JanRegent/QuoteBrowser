import '../../../1AL_pres/widgets/alib/alib.dart';

import '../../bl.dart';
import '../../bluti.dart';

import '../../orm.dart';
import '../../../3Data/dl.dart';

Future<int> searchColumnAndQuote(
    String columnName, String columnValue, String searchText) async {
  currentSS.swiperIndex.value = 0;

  //ignore: use_build_context_synchronously
  al.messageLoading('Search', '$columnValue __|__$searchText', 25);

  currentSS.keys = await dl.httpService
      .searchColumnAndQuote(searchText, columnName, columnValue);

  if (currentSS.keys.isEmpty) {
    return 0;
  }
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length;
}

Future<List<String>> sheetRowsSaveGetKeys(List rowsArrDyn) async {
  List<String> sheetRownoKeys = [];
  for (List row in rowsArrDyn) {
    List<String> rowArr = blUti.toListString(row);

    String sheetRownoKey = rowArr[0];
    List<String> sheetNo = sheetRownoKey.toString().split('__|__');

    currentSS.sheetNames.add(sheetNo[0]);
    //rowNos.add(sheetNo[1]);

    await bl.sheetrowsCRUD.updateRow(sheetRownoKey, rowArr);
    sheetRownoKeys.add(sheetRownoKey);
  }
  return sheetRownoKeys;
}
