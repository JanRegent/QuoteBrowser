import 'package:flutter/material.dart';
import 'package:input_dialog/input_dialog.dart';
import 'package:quotebrowser/1AL_pres/pages/1daily/dailylist.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';

import '../../../1AL_pres/widgets/alib/alib.dart';
import '../../../3Data/dl.dart';
import '../../bl.dart';
import 'searchss.dart';

Future<String> inputWord() async {
  try {
    final word = await InputDialog.show(
      context: al.homeContext,
      title: 'Enter word', // The default.
      okText: 'OK', // The default.
      cancelText: 'Cancel', // The default.
    );
    return word!;
  } catch (_) {
    return '';
  }
}

Future searchGroup_(
    String sheetGroup, String sheetName, String searchText) async {
  try {
    bl.lastCount[sheetGroup] =
        await searchTextSheetGroupSheetName(sheetGroup, sheetName, searchText);
  } catch (_) {
    bl.lastCount[sheetGroup] = '0';
  }
}
//----------------------------------------------------------search word

Future searchWord(String sheetGroup, String sheetName, String searchText,
    BuildContext context) async {
  bl.lastCount[sheetGroup] = 'loading';
  bl.homeTitle.value = 'load: $sheetGroup';
  searchTextSheetGroupSheetName(sheetGroup, sheetName, searchText).then(
      (value) async {
    bl.lastCount[sheetGroup] = value;
    bl.homeTitle.value = '';
  }, onError: (e) {
    debugPrint('searchText($searchText) \n $e');
    bl.homeTitle.value = '';
  });
}

Future searchSheetGroups(String searchText, sheetName) async {
  for (var sheetGroup in bl.dailyList.sheetGroups) {
    bl.lastCount[sheetGroup] = '?';
  }
  for (var sheetGroup in bl.dailyList.sheetGroups) {
    bl.lastCount[sheetGroup] = 'loading';
    await searchGroup_(sheetGroup, sheetName, searchText);
  }
}

Future searchWordInSheetGroup(
    String sheetGroup, sheetName, String searchWord) async {
  bl.lastCount[sheetGroup] = 'loading';
  await searchGroup_(sheetGroup, sheetName, searchWord);
}

Future sheet4swiperKeys() async {
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
