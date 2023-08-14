import 'package:isar/isar.dart';

import '../bluti.dart';

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

  Sheet row2sheet(
      List rowArrIn,
      String sheetName,
      String fileId,
      String rowType,
      int idix,
      int dateinsertIx,
      int tagIx,
      int authorIx,
      int bookIx,
      int pageParIx,
      int quoteIx) {
    Sheet sheet = Sheet();
    List<String> rowArr = blUti.toListString(rowArrIn);
    //-----------------------ID
    try {
      sheet.sheetID = rowArr[idix].toString();
    } catch (e) {
      return sheet;
    }

    //-----------------------dateinsert
    try {
      if (dateinsertIx > -1) {
        sheet.dateinsert = rowArr[dateinsertIx].trim();
        // .replaceAll('__', '');
        // if (!sheet.dateinsert.endsWith('.')) {
        //   sheet.dateinsert = '${sheet.dateinsert}.';
        //   sheet.dateinsert = sheet.dateinsert.replaceAll('..', '.');
      }
    } catch (e) {
      sheet.dateinsert = '';
    }
    //-----------------------author

    try {
      if (authorIx > -1) {
        sheet.author = rowArr[authorIx];
      }
    } catch (e) {
      sheet.author = '';
    }
    //-----------------------book
    try {
      if (bookIx > -1) {
        sheet.book = rowArr[bookIx];
      }
    } catch (e) {
      sheet.book = '';
    }
    //-------------------------------pagePar
    try {
      if (pageParIx > -1) {
        sheet.pagePar = rowArr[pageParIx];
      }
    } catch (e) {
      sheet.pagePar = '';
    }
    //-------------------------------quote
    try {
      if (quoteIx > -1) {
        sheet.quote = rowArr[quoteIx];
      }
    } catch (e) {
      sheet.quote = '';
    }
    //-------------------------------------
    try {
      sheet
        ..aSheetName = sheetName
        ..rowType = rowType
        ..zfileId = fileId
        ..rowArr = rowArr;

      if (tagIx > -1) {
        sheet.tagsStr = rowArr[tagIx].trim();
      }
    } catch (_) {
      //todo RangeError (index): Index out of range: index should be less than 10: 10
    }
    return sheet;
  }
}

enum Status {
  draft,
  pending,
  sent,
}
