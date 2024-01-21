import 'package:input_dialog/input_dialog.dart';

import '../../../1AL_pres/widgets/alib/alib.dart';
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
