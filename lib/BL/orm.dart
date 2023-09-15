import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import 'bl.dart';

import 'params/params.dart';

List<String> colsMain = ['quote', 'author', 'book', 'parPage', 'tags'];
ResponseData responseData = ResponseData();
RxString loadingTitle = ''.obs;
List<String> sheetNames = [];

class ResponseData {
  List<List<String>> keyrows = [];
  List<String> sheetNames = [];
  List<String> rowNos = [];
  Map colsSet = {};

  void keyrowsSet(List keyrowsDyn) async {
    List<String> sheetRownoKeys = [];
    for (List row in keyrowsDyn) {
      List<String> rowArr = blUti.toListString(row[1]);
      keyrows.add(rowArr);

      String sheetRownoKey = row[0];
      List<String> sheetNo = sheetRownoKey.toString().split('__|__');
      sheetNames.add(sheetNo[0]);
      rowNos.add(sheetNo[1]);

      await bl.sheetrowsCRUD.updateRow(sheetRownoKey, rowArr);
      sheetRownoKeys.add(sheetRownoKey);
    }
    String filterKey = '${blUti.todayStr()}.';
    bl.filtersCRUD
        .updateFilter(filterKey, 'dainsert $filterKey', sheetRownoKeys);
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
  RxString stars = ''.obs;
  RxString fav = ''.obs;
  RxString categories = ''.obs;
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
  List<String> tagsList = bl.orm.currentRow.tags.value.split('#');
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
  bl.orm.currentRow.tags.value = tags.join('#');
}

Future currentRowSet() async {
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
  bl.orm.currentRow.stars.value = valueGet('stars');
  bl.orm.currentRow.fav.value = valueGet('favorite');
  bl.orm.currentRow.fav.value = valueGet('categories');
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

  for (var columnName in bl.orm.currentRow.cols) {
    if (columnName == 'ID') continue;
    if (columnName == 'RowNo') continue;
    if (columnName == 'quote') continue;
    if (columnName == 'author') continue;
    if (columnName == 'book') continue;
    if (columnName == 'parPage') continue;
    if (columnName == 'tags') continue;
    if (columnName == 'stars') continue;
    if (columnName == 'favorite') continue;
    if (columnName == 'categories') continue;
    bl.orm.currentRow.optionalFields[columnName] = valueGet(columnName);
  }
}
