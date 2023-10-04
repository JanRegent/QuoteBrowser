import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../../../BL/bl.dart';

import '../../../../BL/orm.dart';
import '../../../../DL/dl.dart';

import '../../../alib/alib.dart';
import '../../../alib/selectiondialogs/selectone.dart';

Future appendrowCurrentRowSet(BuildContext context) async {
  currentRowNew();
  // ignore: use_build_context_synchronously
  bl.orm.currentRow.sheetName.value =
      await selectOne(currentSS.sheetNames, context);
  if (bl.orm.currentRow.sheetName.value.isEmpty) return;
  // ignore: use_build_context_synchronously
  al.messageLoading(
      context, 'Creating row in cloud', bl.orm.currentRow.sheetName.value, 7);
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

Widget addQuoteRow(BuildContext context, Function swiperSetstate) {
  IconButton fromClip() {
    return IconButton(
        onPressed: () {
          FlutterClipboard.paste().then((value) async {
            if (value.isEmpty) return;

            String sheetRownoKey = await dl.httpService.setCellDL(
                bl.orm.currentRow.sheetName.value,
                'original',
                value,
                bl.orm.currentRow.rowNo.value);
            debugPrint('sheetRownoKey $sheetRownoKey');
            await currentRowSet(sheetRownoKey);
          });
          swiperSetstate();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Switch tabs to refresh')));
        },
        icon: const Icon(Icons.paste));
  }

  return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.yellow[100],
          border: Border.all(
            color: Colors.red,
            width: 5,
          )),
      child: Row(
        children: [
          Text(bl.orm.currentRow.sheetName.value),
          Text('__|__${bl.orm.currentRow.rowNo.value}'),
          const Spacer(),
          fromClip(),
          currentSS.addQuoteMode
              ? IconButton(
                  onPressed: () async {
                    await appendrowCurrentRowSet(context);
                    swiperSetstate();
                  },
                  icon: const Icon(Icons.add))
              : const Text(' '),
        ],
      ));
}
