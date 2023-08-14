import 'package:isar/isar.dart';

part 'sheet.g.dart';

// dart run build_runner build

@Collection()
class Sheet {
  late int id;
  String aSheetName = '';
  int aIndex = 0;
  String sheetID = '';

  String quote = '';
  String author = '';
  String book = '';
  String pagePar = '';
  String stars = '';
  String favorites = '';
  String folder = '';
  String category = '';
  String categoryChapterPB = '';

  String dateinsert = '';
  String tagsStr = '';
  // @Index(type: IndexType.value, caseSensitive: false)
  // List<String> get tags => Isar.splitWords(tagsStr);

  String rowType = 'row';
  List<String> rowArr = [];

  String zfileId = '';
  @ignore
  String save2cloud = '';

  Future<String> toStrings() async {
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
    //sheet.id = int.tryParse(getValue('ID'))!;
    sheet.quote = getValue('citat');
    sheet.author = getValue('autor');
    sheet.book = getValue('kniha');
    sheet.tagsStr = getValue('tags');
    sheet.dateinsert = getValue('dateinsert');

    sheet.rowArr = row;

    return sheet;
  }
}

enum Status {
  draft,
  pending,
  sent,
}
