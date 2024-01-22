import 'package:flutter/material.dart';

import '../../../1AL_pres/widgets/alib/alib.dart';
import 'searchss.dart';

Future searchColumnQuote(
    String columnName, String columnValue, String searchText) async {
  al.messageLoading('Searching in cloud', '$columnValue & $searchText', 25);
  searchColumnAndQuote(columnName, columnValue, searchText).then((value) async {
    if (value == 0) return;
  }, onError: (e) {
    debugPrint(e);
  });
}
