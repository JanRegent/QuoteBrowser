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
    int authorIx = cols.indexOf('author');
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    int currentIndexIx = cols.indexOf('currentIndex');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String bookName = data[i][bookNameIx].toString().trim();
      if (bookName.isEmpty) continue;
      rows.add(BookListRow()
        ..bookName = bookName
        ..author = data[i][authorIx]
        ..sheetName = data[i][sheetNameIx]
        ..sheetUrl = data[i][sheetUrlIx]);
      try {
        rows.last.currentIndex = data[i][currentIndexIx]!;
      } catch (e) {
        rows.last.currentIndex = 0;
      }
      sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
      dl.httpService.sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
    }
    dl.httpService.sheetUrls['booksList'] = rootSheetId;
    authorsUniqBuild();
  }

  List<String> authorsUniq = [];
  void authorsUniqBuild() {
    Set auth = {};
    for (int bix = 0; bix < rows.length; bix++) {
      auth.add(rows[bix].author);
    }

    authorsUniq = blUti.toListString(auth.toList());
  }
}

class BookListRow {
  String bookName = '';
  String author = '';
  String sheetName = '';
  String sheetUrl = '';
  int currentIndex = 0;
}
