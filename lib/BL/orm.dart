import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import 'bl.dart';

import 'params/params.dart';

List<String> colsMain = ['quote', 'author', 'book', 'parPage', 'tags'];

List sheetkeyData = [];
Map colsSet = {};

class Orm {
  CurrentRow currentRow = CurrentRow();

  Future<List<String>> map2row(Map rowMap) async {
    String sheetName = rowMap['sheetName'];
    List<String> cols = colsSet[sheetName];

    List<String> row = [];

    for (var i = 0; i < cols.length; i++) {
      try {
        row.add(rowMap[cols[i]]);
      } catch (e) {
        debugPrint(e.toString());
        row.add('');
      }
    }

    return row;
  }

  List<String> mandatoryFields = ['quote', 'author', 'book', 'tags'];
  List<String> optionalFields = [
    'category',
    'sourceUrl',
    'fileUrl',
    'categoryChapterPB',
    'folder',
    'original'
  ];
}

int currentRowIndex = 0;
void currentRowNew() {
  bl.orm.currentRow = CurrentRow()..fileId = dataSheetId;
}

class CurrentRow {
  RxString quote = ''.obs;
  String original = '';
  //-----------------------attribs
  RxString author = ''.obs;
  RxString book = ''.obs;
  RxString parPage = ''.obs;
  RxString tags = ''.obs;
  //--------------------------ids
  RxString sheetName = ''.obs;
  RxString rowNo = ''.obs;
  String fileId = '';
  String dateinsert = '';
  //--------------------------optional user fields
  List<String> cols = [];
  Map optionalFields = {};
}

void pureTags() {
  List<String> tagsList = bl.orm.currentRow.tags.value.split(',');
  Set tagsSet = tagsList.toSet();
  List<String> tags = [];
  for (var tag in tagsSet) {
    try {
      if (tag.toString().isEmpty) continue;
    } catch (_) {
      continue;
    }
    tags.add(tag);
  }
  bl.orm.currentRow.tags.value = tags.join(',');
}

Future currentRowSet() async {
  debugPrint('----currentRowSet-----$currentRowIndex');
  Map rowMapRowView = await row2map();

  bl.orm.currentRow.quote.value = rowMapRowView['quote'] ?? '';
  bl.orm.currentRow.author.value = rowMapRowView['author'] ?? '';
  bl.orm.currentRow.book.value = rowMapRowView['book'] ?? '';
  bl.orm.currentRow.parPage.value = rowMapRowView['parPage'].toString();
  bl.orm.currentRow.tags.value = rowMapRowView['tags'] ?? '';
  pureTags();

  bl.orm.currentRow.original = '';

  //--------------------------ids
  String sheetName = rowMapRowView['sheetName'] ?? '';
  bl.orm.currentRow.sheetName.value = sheetName;
  bl.orm.currentRow.rowNo.value = rowMapRowView['rowNo'] ?? '';
  bl.orm.currentRow.fileId = rowMapRowView['fileId'] ?? '';
  bl.orm.currentRow.dateinsert = rowMapRowView['dateinsert'] ?? '';
  //--------------------------optional user fields
  bl.orm.currentRow.cols = blUti.toListString(colsSet[sheetName]);
  bl.orm.currentRow.optionalFields = {};

  // for (var columnName in rowMapRowView.keys) {
  //   if (columnName == 'ID') continue;
  //   if (columnName == 'RowNo') continue;

  //   bl.orm.currentRow.optionalFields[columnName] = rowMapRowView[columnName];
  // }

  bl.orm.currentRow.tags =
      sheetkeyData[currentRowIndex][1][bl.orm.currentRow.cols.indexOf('tags')];
  debugPrint('----currentRowSet-------------------$currentRowIndex');
  debugPrint(sheetkeyData[currentRowIndex].toString());
}

Future<Map> row2map() async {
  debugPrint('----row2map-------------------$currentRowIndex');
  Map rowMap = {};

  List<String> keys =
      sheetkeyData[currentRowIndex][0].toString().split('__|__');
  rowMap['sheetName'] = keys[0];
  rowMap['rowNo'] = keys[1];

  Map rowkey = {};
  rowkey['sheetName'] = rowMap['sheetName'];
  rowkey['RowNo'] = rowMap['rowNo'];
  rowkey['fileId'] = dataSheetId;

  List cols = colsSet[rowMap['sheetName']];
  for (var i = 0; i < cols.length; i++) {
    rowMap[cols[i]] = sheetkeyData[currentRowIndex][1][i];
  }
  print(rowMap);
  return rowMap;
}

Future currentRowUpdate() async {
  Map tempRow = {};

  tempRow['book'] = bl.orm.currentRow.book.value;
  tempRow['author'] = bl.orm.currentRow.author.value;
  tempRow['tags'] = bl.orm.currentRow.tags.value;
  tempRow['parPage'] = bl.orm.currentRow.parPage.value;

  await bl.crud.updateOrInsert(tempRow);
}
