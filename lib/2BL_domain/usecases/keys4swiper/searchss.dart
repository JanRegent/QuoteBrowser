import 'package:flutter/material.dart';

import '../../../1AL_pres/widgets/alib/alib.dart';

import '../../bl.dart';
import '../../bluti.dart';

import '../../orm.dart';
import '../../../3Data/dl.dart';

Future<int> columnTextShow(String columnTextKey) async {
  currentSS.filterKey = columnTextKey;
  currentSS.swiperIndex.value = 0;

  currentSS.keys = await bl.columnTextFilterCRUD.readFilter(columnTextKey);

  if (currentSS.keys.isEmpty) {
    return 0;
  }
  currentSS.swiperIndex.value = 0;
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length;
}

Future<int> searchColumnAndQuote(
    String columnName, String columnValue, String searchText) async {
  currentSS.filterKey = searchText;
  currentSS.swiperIndex.value = 0;

  debugPrint(searchText);
  try {
    currentSS.keys = (await bl.columnTextFilterCRUD
        .readFilter('$columnValue __|__$searchText'));
  } catch (_) {}

  if (currentSS.keys.isEmpty) {
    //ignore: use_build_context_synchronously
    al.messageLoading('Search', '$columnValue __|__$searchText', 25);

    currentSS.keys = await dl.httpService
        .searchColumnAndQuote(searchText, columnName, columnValue);

    await bl.columnTextFilterCRUD
        .updateFilter(columnName, columnValue, searchText, currentSS.keys);
  }
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
