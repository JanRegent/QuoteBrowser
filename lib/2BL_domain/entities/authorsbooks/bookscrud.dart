import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/2BL_domain/bluti.dart';

import '../../../3Data/dl.dart';
import '../../bl.dart';

part 'bookscrud.g.dart'; //dart run build_runner build

@collection
class Books {
  @Id()
  String quoteContains = '';
  String book = '';
  String author = '';
  String cleanString = '';
}

class BooksCRUD {
  Future clear() async {
    isar.write((isar) async {
      isar.books.clear();
    });
  }

  Future<List<String>> readAllBooks() async {
    try {
      return isar.books.where().bookProperty().findAll();
    } catch (e) {
      debugPrint('BooksCRUD().readAll()\n$e');
      return [];
    }
  }

  List<String> quoteContainsList() {
    List<String> qc = isar.books.where().quoteContainsProperty().findAll();
    return qc;
  }

  (String book, String author) readBookAuthor(String key) {
    Books? row = isar.books.where().quoteContainsEqualTo(key).findFirst();
    return (row!.book, row.author);
  }

  List<String> readAuthorsUniq() {
    List<String> authorsAll =
        isar.books.where().authorProperty().findAll().sorted();
    Set authors = {};
    for (var author in authorsAll) {
      authors.add(author);
    }
    return blUti.toListString(authors.toList());
  }

  //-----------------------------------------------------------------update
  Future updateBooks() async {
    await clear();

    List booksDyn = await dl.httpService.getBooks();
    List<String> cols = blUti.toListString(booksDyn[0]);
    int quoteContainsIx = cols.indexOf('quoteContains');
    int bookIx = cols.indexOf('book');
    int authorIx = cols.indexOf('author');

    for (var i = 1; i < booksDyn.length; i++) {
      // print('------------');
      // print(booksDyn[i]);
      List<String> book = blUti.toListString(booksDyn[i]);
      updateRow(book[quoteContainsIx], book[bookIx], book[authorIx], '');
    }
    debugPrint('BooksCRUD.updateBooks() ${booksDyn.length}');
  }

  Future updateRow(String quoteContains, String book, String author,
      String cleanString) async {
    if (book.isEmpty) return;

    Books newBook = Books();
    newBook.book = book;
    newBook.author = author;
    newBook.quoteContains = quoteContains;
    newBook.cleanString = cleanString;

    isar.write((isar) async {
      isar.books.put(newBook);
    });
  }
}
