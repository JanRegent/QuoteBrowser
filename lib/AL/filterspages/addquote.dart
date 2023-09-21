import 'package:flutter/material.dart';

import '../../BL/bl.dart';

import '../../BL/orm.dart';
import '../../DL/dl.dart';

import '../alib/selectiondialogs/selectone.dart';

Future appendrowCurrentRowSet(BuildContext context) async {
  // ignore: use_build_context_synchronously
  bl.orm.currentRow.sheetName.value =
      await selectOne(currentSS.sheetNames, context);
  if (bl.orm.currentRow.sheetName.value.isEmpty) return;

  String sheetRownoKey = await setCellAppendRow();
  currentSS.keys.clear();
  currentSS.keys.add(sheetRownoKey);
  bl.orm.currentRow.quote.value = '';
}

Future<String> setCellAppendRow() async {
  String sheetRownoKey = await dl.httpService
      .setCellDL(bl.orm.currentRow.sheetName.value, 'quote', '?', '');
  bl.orm.currentRow.rowNo.value = sheetRownoKey.split('__|__')[1];
  return sheetRownoKey;
}

void emptyDialog(String fieldName, BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Field empty"),
        content: Text("$fieldName is empty"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
