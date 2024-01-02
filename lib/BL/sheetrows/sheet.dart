import 'package:quotebrowser/BL/bluti.dart';

// dart run build_runner build

class Sheet {
  late int id;

  String aSheetName = '';
  int aIndex = 0;

  String quote = '';
  String author = '';
  String book = '';
  String pagePar = '';
  String stars = '';
  String favorites = '';
  String folder = '';
  String category = '';
  String categoryChapterPB = '';

  String sourceUrl = '';

  String dateinsert = '';

  String tagsStr = '';

  String rowType = 'row';
  List<String> rowArr = [];

  String zfileId = '';

  String save2cloud = '';

  String toStrings() {
    return '''
    -----------------------------------------------------sheet
    id          $id
    aSheetName  $aSheetName
    rowIndex    $aIndex

    author    $author
    book      $book
    pagePar   $pagePar

    quote     ${quote.length >= 30 ? quote.substring(0, 30) : quote.length}

    dateinsert $dateinsert

    stars     $stars
    favorites $favorites

    tagsStr   $tagsStr
    
    rowType  $rowType 
    
    rowArr
    $rowArr                

    zfileId     $zfileId
  ''';
  }

  Sheet sheetFromRow(List<String> cols, List<String> row) {
    String getValue(String colName) {
      int index = cols.indexOf(colName);
      if (index == -1) return '';

      try {
        String value = row[index];
        return value;
      } catch (_) {
        return '';
      }
    }

    Sheet sheet = Sheet();

    sheet.quote = getValue('citat');
    sheet.author = getValue('autor');
    sheet.book = getValue('kniha');
    sheet.tagsStr = getValue('tags');
    sheet.dateinsert = getValue('dateinsert');

    sheet.rowArr = row;

    return sheet;
  }

  Sheet fromJson(List<String> cols, List<String> row) {
    String getValue(String colName) {
      int index = cols.indexOf(colName);
      if (index == -1) return '';

      try {
        String value = row[index];
        return value;
      } catch (_) {
        return '';
      }
    }

    Sheet sheet = Sheet();

    sheet.quote = getValue('citat');
    sheet.author = getValue('autor');
    sheet.book = getValue('kniha');
    sheet.tagsStr = getValue('tags');
    sheet.dateinsert = getValue('dateinsert');

    sheet.rowArr = row;

    return sheet;
  }

  Map<String, dynamic> toJson(
      List<String> cols, List<String> row, Sheet sheet) {
    Map<String, dynamic> rowMap = {};
    rowMap["sheetName"] = sheet.aSheetName;
    rowMap["rowNo"] = sheet.aIndex;
    if (sheet.rowType == 'colRow') {
      rowMap["colRow"] = cols;
      return rowMap;
    }

    for (var i = 0; i < cols.length; i++) {
      rowMap[cols[i]] = row[i];
    }
    rowMap["fileId"] = sheet.zfileId;
    return rowMap;
  }

  Future<List<String>> sheet2Row(Sheet sheet) async {
    List<String>? cols = []; // await readCols(sheet.aSheetName);

    if (cols.isEmpty) return [];
    List<String> row = [];

    for (var i = 0; i < cols.length; i++) {
      row.add('');
    }

    void setValue(String colName, value) {
      int index = cols.indexOf(colName);

      if (index == -1) return;

      try {
        row[index] = value;
        return;
      } catch (_) {
        return;
      }
    }

    setValue('citat', sheet.quote);
    setValue('autor', sheet.author);
    setValue('kniha', sheet.book);
    setValue('tags', sheet.tagsStr);
    setValue('dateinsert', '${blUti.todayStr()}.');

    return row;
  }
}

Future<Sheet> sheetFromMap(Map<String, dynamic> map) async {
  Sheet sheet = Sheet();

  sheet.quote = map['citat'];
  sheet.author = map['autor'];
  sheet.book = map['kniha'];
  sheet.tagsStr = map['tags'];

  return sheet;
}

enum Status {
  draft,
  pending,
  sent,
}
