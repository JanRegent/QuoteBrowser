import 'package:flutter/material.dart';

import '../../AL/alib/alert/circullarsnack.dart';
import '../bl.dart';
import '../bluti.dart';

import '../orm.dart';
import '../../DL/dl.dart';

Future<List<String>> sheetRowsSaveGetKeys(List rowsArrDyn) async {
  List<String> sheetRownoKeys = [];
  for (List row in rowsArrDyn) {
    List<String> rowArr = blUti.toListString(row[1]);

    String sheetRownoKey = row[0];
    List<String> sheetNo = sheetRownoKey.toString().split('__|__');
    currentSS.sheetNames.add(sheetNo[0]);
    //rowNos.add(sheetNo[1]);

    await bl.sheetrowsCRUD.updateRow(sheetRownoKey, rowArr);
    sheetRownoKeys.add(sheetRownoKey);
  }
  return sheetRownoKeys;
}

Future filterSearchText(String searchText, BuildContext context) async {
  currentSS.filterKey = searchText;
  currentSS.swiperIndex = 0;

  debugPrint(searchText);
  try {
    currentSS.keys = (await bl.filtersCRUD.readFilter(searchText));
  } catch (_) {}
  if (currentSS.keys.isEmpty) {
    //ignore: use_build_context_synchronously
    circularSnack(context, 25, 'Querying cloud [gdrive]');

    currentSS.keys = await dl.httpService.searchSS(searchText);
    await bl.filtersCRUD
        .updateFilter(searchText, 'searchText: $searchText', currentSS.keys);
  }

  await currentRowSet();
}
