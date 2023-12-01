import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../DL/dl.dart';
import '../bl.dart';

part 'bookscrud.g.dart'; //dart run build_runner build

@collection
class Books {
  @Id()
  String book = '';
  String quoteContains = '';
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

  //-----------------------------------------------------------------update
  Future updateBooks() async {
    await clear();

    List booksDyn = await dl.httpService.getBooks();
    for (var i = 1; i < booksDyn.length; i++) {
      // print('------------');
      // print(booksDyn[i]);
      List<String> book = blUti.toListString(booksDyn[i]);
      updateRow(book[0], book[1], book[2], book[3]);
    }
    debugPrint('BooksCRUD.updateBooks() ${booksDyn.length}');
  }

  Future updateRow(String book, String author, String quoteContains,
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
