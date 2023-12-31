import 'package:flutter/material.dart';

import '../../BL/bl.dart';

import '../../BL/bluti.dart';
import '../alib/searchvalue/searchselectpage.dart';

Future<String> dateSelect(BuildContext context) async {
  List<String> dateinserts = blUti.lastNdays(10);

  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SearchSelectPage(dateinserts, 'Select date')),
  );
}

Future<String> wordSelect(BuildContext context) async {
  List<String> words = await bl.filtersCRUD.readWords();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SearchSelectPage(words, 'Select word')),
  );
}

Future<String> authorSelect(BuildContext context) async {
  List<String> authors = bl.booksCRUD.readAuthorsUniq();
  try {
    // ignore: use_build_context_synchronously
    String? selected = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchSelectPage(authors, 'Select author')),
    );
    return selected!;
  } catch (_) {
    return '';
  }
}

Future<String> authorTextSelect(BuildContext context) async {
  List<String> words = await bl.columnTextFilterCRUD.readColumnTextKeys();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SearchSelectPage(words, 'Select Author|text ')),
  );
}

Future<String> bookSelect(BuildContext context) async {
  List<String> books = await bl.booksCRUD.readAllBooks();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SearchSelectPage(books, 'Select book')),
  );
}
