import 'package:flutter/foundation.dart';

import 'bl.dart';

class Orm {
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

  List<String> fields = [
    'quote',
    'author',
    'book',
    'tags',
    'category',
    'categoryChapterPB',
    'folder'
  ];

  Map<String, dynamic> newRowMap() {
    Map<String, dynamic> rowMap = {};
    rowMap["sheetName"] = '';
    rowMap["rowNo"] = '';

    for (var fieldName in bl.orm.fields) {
      rowMap[fieldName] = '';
    }
    rowMap['save2cloud'] = false;

    return rowMap;
  }
}
