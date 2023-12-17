import 'package:quotebrowser/BL/bluti.dart';
import 'package:quotebrowser/DL/backendurl.dart';
import 'package:quotebrowser/DL/dl.dart';

class BooksList {
  List<BookListRow> rows = [];
  int currentIndex = 1;

  String bookCurrent = '';

  List<String> cols = [];
  Map<String, String> sheetUrls = {};

  Future getData() async {
    List data = await dl.httpService.getAllrows('booksList', rootSheetId);
    cols = blUti.toListString(data[0]);
    int bookNameIx = cols.indexOf('bookName');
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String bookName = data[i][bookNameIx].toString().trim();
      if (bookName.isEmpty) continue;
      rows.add(BookListRow()
        ..bookName = bookName
        ..sheetName = data[i][sheetNameIx]
        ..sheetUrl = data[i][sheetUrlIx]);
      sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
      dl.httpService.sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
    }
  }
}

class BookListRow {
  String bookName = '';
  String sheetName = '';
  String sheetUrl = '';
}
