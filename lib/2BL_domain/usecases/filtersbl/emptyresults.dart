import 'package:flutter/material.dart';

import '../../../1AL_pres/widgets/alib/alib.dart';

({String searchText, String sheetGroup, String sheetName}) emptyResult =
    (searchText: '', sheetGroup: '', sheetName: '');

ListView emptyResultListview(String title, BuildContext context) {
  return ListView(
    children: [
      Row(children: [al.iconBack(context)]),
      Text(title),
      ListTile(
        leading: const Text('searchText'),
        title: Text(emptyResult.searchText),
      ),
      ListTile(
        leading: const Text('sheetsGroup'),
        title: Text(emptyResult.sheetGroup),
      ),
      ListTile(
        leading: const Text('sheetName'),
        title: Text(emptyResult.sheetName),
      )
    ],
  );
}
