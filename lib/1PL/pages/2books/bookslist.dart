import 'package:quotebrowser/2BL_domain/bluti.dart';
import 'package:quotebrowser/3Data/dl.dart';

import '../../../2BL_domain/bl.dart';

class BooksList {
  List<BookListRow> rows = [];

  String bookCurrent = '';

  List<String> cols = [];

  Future getData() async {
    List data = await dl.gservice23.getPureSheet('booksList');
    cols = blUti.toListString(data[0]);
    int bookNameIx = cols.indexOf('bookName');
    int authorIx = cols.indexOf('author');
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    int swiperIndexIx = cols.indexOf('swiperIndex');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String bookName = data[i][bookNameIx].toString().trim();
      if (bookName.isEmpty) continue;
      String author = data[i][authorIx];
      bl.authorsSet.add(author);
      rows.add(BookListRow()
        ..bookName = bookName
        ..author = author
        ..sheetName = data[i][sheetNameIx]
        ..sheetUrl = data[i][sheetUrlIx]
        ..rowNo = (i + 1).toString());
      try {
        rows.last.swiperIndex = data[i][swiperIndexIx]!;
      } catch (e) {
        rows.last.swiperIndex = 0;
      }
      dl.sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
    }

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
  int swiperIndex = 0;
  String rowNo = '';
}
