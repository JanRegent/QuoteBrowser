import 'package:flutter/material.dart';

import '../../2BL_domain/bl.dart';

import '../../2BL_domain/bluti.dart';
import '../widgets/alib/alib.dart';
import '../widgets/alib/searchvalue/searchselectpage.dart';

Future<String> dateSelect(BuildContext context) async {
  List<String> dateinserts = blUti.lastNdays(10);
  String searchDate = '';
  try {
    // ignore: use_build_context_synchronously
    searchDate = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchSelectPage(dateinserts, 'Select date')),
    );
  } catch (_) {
    searchDate = '';
  }

  return searchDate;
}

Future<String> authorSelect() async {
  List<String> authors = bl.booksCRUD.readAuthorsUniq();
  try {
    // ignore: use_build_context_synchronously
    String? selected = await Navigator.push(
      al.homeContext,
      MaterialPageRoute(
          builder: (context) => SearchSelectPage(authors, 'Select author')),
    );
    return selected!;
  } catch (_) {
    return '';
  }
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
