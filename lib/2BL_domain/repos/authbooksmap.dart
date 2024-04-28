import 'package:quotebrowser/2BL_domain/bluti.dart';
import 'package:quotebrowser/3Data/dl.dart';

Map authBooksMap = {};

class AuthorBooksMap {
  int swiperIndex = 1;

  List<String> cols = [];

  Future getData() async {
    dl.sheetUrls['__books__'] = dl.sheetUrls['rootSheetId'];
    List data = await dl.gservice23.getPureSheet('__books__');
    cols = blUti.toListString(data[0]);
    int authorIx = cols.indexOf('author');
    int bookIx = cols.indexOf('book');
    // int cleanStringIx = cols.indexOf('cleanString');
    // int pageParseIx = cols.indexOf('pageParse');
    //rows.clear();
    for (var i = 1; i < data.length; i++) {
      String author = data[i][authorIx].toString().trim();
      if (author.isEmpty) continue;
      String book = data[i][bookIx].toString().trim();
      if (book.isEmpty) continue;

      if (authBooksMap[author] != null) {
        authBooksMap[author] = authBooksMap[author] + '__|__' + book;
      } else {
        authBooksMap[author] = book;
      }
    }
  }
}
