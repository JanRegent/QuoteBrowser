import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
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
    authorsInit();
    debugPrint('authors: ${authors.length}');
  }

  List<String> authors = [];
  void authorsInit() {
    Set authorsSet = Set.from(authBooksMap.keys.toList().sorted());
    authors = blUti.toListString(authorsSet.toList().sorted());
    authors.insert(0, '');
  }

  List<String> authorBooksGet(String author) {
    Set booksSet = Set.from(authBooksMap[author].toString().split('__|__'));

    return blUti.toListString(booksSet.toList().sorted());
  }
}
