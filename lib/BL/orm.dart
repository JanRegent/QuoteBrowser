import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import 'bl.dart';

import 'params/params.dart';

List<String> colsMain = ['quote', 'author', 'book', 'parPage', 'tags'];
ResponseData responseData = ResponseData();

class ResponseData {
  List<List<String>> keyrows = [];
  List<String> sheetNames = [];
  List<String> rowNos = [];
  Map colsSet = {};

  void keyrowsSet(List keyrowsDyn) {
    for (List row in keyrowsDyn) {
      keyrows.add(blUti.toListString(row[1]));

      List<String> sheetNo = row[0].toString().split('__|__');
      sheetNames.add(sheetNo[0]);
      rowNos.add(sheetNo[1]);
    }
  }

  List<String> colsGet() {
    return blUti.toListString(colsSet[sheetNames[currentRowIndex]]);
  }
}

class Orm {
  CurrentRow currentRow = CurrentRow();

  Future<List<String>> map2row(Map rowMap) async {
    String sheetName = rowMap['sheetName'];
    List<String> cols = responseData.colsSet[sheetName];

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
  //Map rowMapRowView = await row2map();
  bl.orm.currentRow.cols = responseData.colsGet();
  String valueGet(String columnName) {
    int fieldIndex = bl.orm.currentRow.cols.indexOf(columnName);
    if (fieldIndex == -1) return '';
    try {
      String value = responseData.keyrows[currentRowIndex][fieldIndex];
      return value;
    } catch (_) {
      return '';
    }
  }

  bl.orm.currentRow.quote.value = valueGet('quote');
  bl.orm.currentRow.author.value = valueGet('author');
  bl.orm.currentRow.book.value = valueGet('book');
  bl.orm.currentRow.parPage.value = valueGet('parPage');
  bl.orm.currentRow.tags.value = valueGet('tags');
  pureTags();

  bl.orm.currentRow.original = '';

  //--------------------------ids
  String sheetName = responseData.sheetNames[currentRowIndex];
  bl.orm.currentRow.sheetName.value = sheetName;
  bl.orm.currentRow.rowNo.value =
      responseData.rowNos[currentRowIndex].toString();
  bl.orm.currentRow.fileId = valueGet('fileId');
  bl.orm.currentRow.dateinsert = valueGet('dateinsert');
  //--------------------------optional user fields

  bl.orm.currentRow.optionalFields = {};

  // for (var columnName in rowMapRowView.keys) {
  //   if (columnName == 'ID') continue;
  //   if (columnName == 'RowNo') continue;

  //   bl.orm.currentRow.optionalFields[columnName] = rowMapRowView[columnName];
  // }

  debugPrint('----currentRowSet-------------------$currentRowIndex');
}

//   List cols = responseData.colsSet[rowMap['sheetName']];
//   for (var i = 0; i < cols.length; i++) {
//     rowMap[cols[i]] = responseData.keyrows[currentRowIndex][1][i];
//   }

Future currentRowUpdate() async {
  Map tempRow = {};

  tempRow['book'] = bl.orm.currentRow.book.value;
  tempRow['author'] = bl.orm.currentRow.author.value;
  tempRow['tags'] = bl.orm.currentRow.tags.value;
  tempRow['parPage'] = bl.orm.currentRow.parPage.value;

  await bl.crud.updateOrInsert(tempRow);
}
