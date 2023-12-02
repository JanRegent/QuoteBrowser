import 'package:flutter/material.dart';

import '../../BL/bl.dart';

import '../../BL/bluti.dart';
import 'valueselectpage.dart';

Future<String> dateSelect(BuildContext context) async {
  List<String> dateinserts = blUti.lastNdays(10);

  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ValueSelectPage(dateinserts, 'Select date')),
  );
}

Future<String> wordSelect(BuildContext context) async {
  List<String> words = await bl.filtersCRUD.readWords();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ValueSelectPage(words, 'Select word')),
  );
}

Future<String> authorSelect(BuildContext context) async {
  List<String> authors = await bl.authorCRUD.readAllAuthors();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ValueSelectPage(authors, 'Select author')),
  );
}

Future<String> authorTextSelect(BuildContext context) async {
  List<String> words = await bl.columnTextFilterCRUD.readColumnTextKeys();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ValueSelectPage(words, 'Select Author|text ')),
  );
}

Future<String> bookSelect(BuildContext context) async {
  List<String> books = await bl.booksCRUD.readAllBooks();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ValueSelectPage(books, 'Select book')),
  );
}
