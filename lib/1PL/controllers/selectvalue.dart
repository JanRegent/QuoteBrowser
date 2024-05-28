import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:quotebrowser/2BL_domain/repos/authbooksmap.dart';

import '../../2BL_domain/bluti.dart';
import '../../3Data/dl.dart';
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

Future<String> sheetNameSelect(BuildContext context) async {
  List<String> sheetNames = [];
  for (var sheetName in dl.sheetUrls.keys) {
    sheetNames.add(sheetName);
  }
  String searchDate = '';
  try {
    // ignore: use_build_context_synchronously
    searchDate = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SearchSelectPage(sheetNames, 'Select sheetName')),
    );
  } catch (_) {
    searchDate = '';
  }

  return searchDate;
}

Future<String> authorSelect() async {
  List<String> authors =
      blUti.toListString(authBooksMap.keys.toList().sorted());

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

Future<String> bookSelect(BuildContext context, String author) async {
  List<String> books = authBooksMap[author].toString().split('__|__');
  try {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchSelectPage(books, 'Select book')),
    );
  } catch (_) {
    return '';
  }
}
