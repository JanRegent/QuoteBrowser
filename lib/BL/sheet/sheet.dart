import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/bluti.dart';
import 'package:quotebrowser/BL/params/params.dart';

import '../bl.dart';
import 'sheetcrud.dart';

part 'sheet.g.dart';

// dart run build_runner build

Sheet newSheet() {
  Sheet sheet = Sheet()
    ..id = isar.sheets.autoIncrement()
    ..zfileId = dataSheetId;

  return sheet;
}

@Collection()
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

  @Ignore()
  String sourceUrl = '';

  String dateinsert = '';

  @Index(unique: true)
  String tagsStr = '';

  String rowType = 'row';
  List<String> rowArr = [];

  String zfileId = '';
  @ignore
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

    Sheet sheet = newSheet();

    sheet.quote = getValue('citat');
    sheet.author = getValue('autor');
    sheet.book = getValue('kniha');
    sheet.tagsStr = getValue('tags');
    sheet.dateinsert = getValue('dateinsert');

    sheet.rowArr = row;

    return sheet;
  }

  Future<List<String>> sheet2Row(Sheet sheet) async {
    List<String>? cols = await readCols(sheet.aSheetName);

    if (cols!.isEmpty) return [];
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

enum Status {
  draft,
  pending,
  sent,
}
