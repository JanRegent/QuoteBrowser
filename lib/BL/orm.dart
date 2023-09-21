import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bl.dart';

import 'params/params.dart';

List<String> colsMain = ['quote', 'author', 'book', 'parPage', 'tags'];
CurrentSS currentSS = CurrentSS();
RxString loadingTitle = ''.obs;

class CurrentSS {
  String filterKey = '';
  List<String> keys = [];
  late Icon filterIcon;
  List<String> sheetNames = [];

  int swiperIndex = 0;
}

class Orm {
  CurrentRow currentRow = CurrentRow();

  Future<List<String>> map2row(Map rowMap) async {
    String sheetName = rowMap['sheetName'];
    List<String>? cols = await bl.sheetcolsCRUD.readColsBySheetName(sheetName);

    List<String> row = [];

    for (var i = 0; i < cols!.length; i++) {
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

void currentRowNew() {
  bl.orm.currentRow = CurrentRow()
    ..fileId = dataSheetId
    ..quote.value = '';
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
  String sheetRownoKey = currentSS.keys[currentSS.swiperIndex];
  List<String> rowArr = await bl.sheetrowsCRUD.getRowArr(sheetRownoKey);
  String sheetName = sheetRownoKey.split('__|__')[0];
  bl.orm.currentRow.cols =
      (await bl.sheetcolsCRUD.readColsBySheetName(sheetName))!;

  String valueGet(String columnName) {
    int fieldIndex = bl.orm.currentRow.cols.indexOf(columnName);
    if (fieldIndex == -1) return '';
    try {
      String value = rowArr[fieldIndex];
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
  //String sheetName = responseData.sheetNames[currentRowIndex];
  bl.orm.currentRow.sheetName.value = sheetName;
  bl.orm.currentRow.rowNo.value = sheetRownoKey.split('__|__')[1];
  //responseData.rowNos[currentRowIndex].toString();
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
