import 'package:flutter/material.dart';

import '../../AL/alib/alib.dart';
import '../bl.dart';
import '../bluti.dart';

import '../orm.dart';
import '../../DL/dl.dart';
import 'emptyresults.dart';

Future<int> filterSearchText(String searchText, BuildContext context) async {
  currentSS.filterKey = searchText;
  currentSS.swiperIndex.value = 0;

  debugPrint(searchText);
  try {
    currentSS.keys = (await bl.filtersCRUD.readFilter(searchText));
  } catch (_) {}

  // ignore: prefer_is_empty
  if (currentSS.keys.length == 0) {
    //ignore: use_build_context_synchronously
    al.messageLoading(context, 'Searching in cloud', searchText, 25);

    currentSS.keys = await dl.httpService.searchSS(searchText);

    await bl.filtersCRUD.updateFilter(searchText, currentSS.keys);
  }
  if (currentSS.keys.isEmpty) {
    return 0;
  }
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length;
}

Future<String> searchTextSheetGroupSheetName(
    String sheetGroup, String sheetName, String searchText) async {
  currentSS.filterKey = '$searchText __|__ $sheetGroup';
  currentSS.swiperIndex.value = 0;
  try {
    currentSS.keys = (await bl.filtersCRUD.readFilter(currentSS.filterKey));
  } catch (_) {}

  // ignore: prefer_is_empty
  if (currentSS.keys.length == 0) {
    currentSS.keys = await dl.httpService.getSheetGroup(sheetGroup, searchText);

    await bl.filtersCRUD
        .updateFilter('$searchText __|__ $sheetGroup', currentSS.keys);
  }
  if (currentSS.keys.isEmpty) {
    return '0';
  }
  currentSS.keys = sheetNameKeysFilter(sheetGroup, sheetName);
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length.toString();
}

List<String> sheetNameKeysFilter(String sheetGroup, String sheetName) {
  emptyResult = (searchText: '', sheetGroup: sheetGroup, sheetName: sheetName);
  if (sheetName.isEmpty) return currentSS.keys;
  List<String> sheetNameKeys = [];
  for (String key in currentSS.keys) {
    try {
      List<String> sheetNameNo = key.split('__|__');
      if (sheetNameNo[0] != sheetName) continue;
      sheetNameKeys.add(key);
    } catch (_) {}
  }
  return sheetNameKeys;
}

Future<int> columnTextShow(String columnTextKey, BuildContext context) async {
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

Future<int> searchColumnAndQuote(String columnName, String columnValue,
    String searchText, BuildContext context) async {
  currentSS.filterKey = searchText;
  currentSS.swiperIndex.value = 0;

  debugPrint(searchText);
  try {
    currentSS.keys = (await bl.columnTextFilterCRUD
        .readFilter('$columnValue __|__$searchText'));
  } catch (_) {}

  if (currentSS.keys.isEmpty) {
    //ignore: use_build_context_synchronously
    al.messageLoading(context, 'Search', '$columnValue __|__$searchText', 25);

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

Future<int> getLastRows(String sheetName, BuildContext context) async {
  currentSS.filterKey = '';
  currentSS.swiperIndex.value = 0;

  debugPrint(sheetName);

  //ignore: use_build_context_synchronously
  al.messageLoading(context, 'Search', 'Get last rows of $sheetName', 25);

  currentSS.keys = await dl.httpService.getLastRows(sheetName);

  if (currentSS.keys.isEmpty) {
    return 0;
  }
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length;
}
