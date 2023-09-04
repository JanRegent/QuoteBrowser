import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'bl.dart';
import 'bluti.dart';
import 'params/params.dart';

class Orm {
  CurrentRow currentRow = CurrentRow();

  Map<String, dynamic> row2map(List<String> cols, List<String> row,
      String sheetName, String rowNo, String fileId) {
    Map<String, dynamic> rowMap = {};
    rowMap["sheetName"] = sheetName;
    rowMap["rowNo"] = rowNo;
    if (rowNo == '1') {
      rowMap["colRow"] = cols;
      return rowMap;
    }

    for (var i = 0; i < cols.length; i++) {
      rowMap[cols[i]] = row[i];
    }
    rowMap["fileId"] = fileId;
    return rowMap;
  }

  Future<List<String>> map2row(Map rowMap) async {
    String sheetName = rowMap['sheetName'];
    List<String> cols = await bl.crud.readColRowsOfSheetName(sheetName);
    debugPrint(cols.toString());
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

  Map newRowMap() {
    Map rowMap = {
      'sheetName': '',
      'rowNo': '',
      'fileId': dataSheetId,
      'dateinsert': '${blUti.todayStr()}.'
    };

    try {
      for (var fieldName in bl.orm.mandatoryFields) {
        rowMap[fieldName] = '';
      }
    } catch (_) {}

    //return checkMap(rowMap);
    return rowMap;
  }
}

List<Map> swiperSheetRownoKeys = [];

int currentRowIndex = 0;

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
  Map optionalFields = {};
}

Future currentRowSet() async {
  Map rowMapRowView =
      await bl.crud.readBySheetRowNo(swiperSheetRownoKeys[currentRowIndex]);

  bl.orm.currentRow.quote.value = rowMapRowView['quote'] ?? '';
  bl.orm.currentRow.author.value = rowMapRowView['author'] ?? '';
  bl.orm.currentRow.book.value = rowMapRowView['book'] ?? '';
  bl.orm.currentRow.parPage.value = rowMapRowView['parPage'] ?? '';
  bl.orm.currentRow.tags.value = rowMapRowView['tags'] ?? '';

  bl.orm.currentRow.original = '';

  //--------------------------ids
  bl.orm.currentRow.sheetName.value = rowMapRowView['sheetName'] ?? '';
  bl.orm.currentRow.rowNo.value = rowMapRowView['rowNo'] ?? '';
  bl.orm.currentRow.fileId = rowMapRowView['fileId'] ?? '';
  bl.orm.currentRow.dateinsert = rowMapRowView['dateinsert'] ?? '';
  //--------------------------optional user fields
  bl.orm.currentRow.optionalFields = {};

  debugPrint('-----------------------$currentRowIndex');
  debugPrint(swiperSheetRownoKeys[currentRowIndex].toString());
}

Future currentRowUpdate() async {
  Map tempRow = {};

  tempRow['book'] = bl.orm.currentRow.book.value;
  tempRow['author'] = bl.orm.currentRow.author.value;
  tempRow['tags'] = bl.orm.currentRow.tags.value;
  tempRow['parPage'] = bl.orm.currentRow.parPage.value;

  await bl.crud.updateOrInsert(tempRow);
}
