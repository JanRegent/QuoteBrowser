import 'package:flutter/foundation.dart';

import 'bl.dart';
import 'bluti.dart';
import 'params/params.dart';

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
    Map rowMap = {};
    rowMap["sheetName"] = '';
    rowMap["rowNo"] = '';
    rowMap['fileId'] = dataSheetId;
    rowMap['dateinsert'] = '${blUti.todayStr()}.';

    for (var fieldName in bl.orm.mandatoryFields) {
      rowMap[fieldName] = '';
    }

    return checkMap(rowMap);
  }

  Map checkMap(Map rowMap) {
    void checkField(String columnName) {
      if (rowMap[columnName] == null) {
        rowMap[columnName] = '';
        return;
      }
      if (rowMap[columnName].toString().isEmpty) {
        rowMap[columnName] = '';
      }
    }

    checkField('author');
    checkField('book');
    checkField('tags');
    //checkField('parPage');
    return rowMap;
  }
}
