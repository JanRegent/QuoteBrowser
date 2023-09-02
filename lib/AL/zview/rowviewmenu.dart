import 'package:clipboard/clipboard.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../alib/alib.dart';

int currentRowIndex = 0;
Map currentSheet = {'quote': '[init]'};

PopupMenuButton rowViewMenu(
    Map rowmap, Map configRow, VoidCallback swiperSetstate) {
  return PopupMenuButton(
    child: const Icon(Icons.menu),
    itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupMenuButton>>[
      PopupMenuItem(
        child: PopupMenuButton(
          child: const Text('File'),
          onSelected: (String result) {
            Navigator.pop(context);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
                child: InkWell(
              child: const Text('Open source sheet'),
              onTap: () async {
                // ignore: use_build_context_synchronously //Icons.open_in_browser
                await al.openDoc(
                    currentSheet['fileId'], context, 'Open source sheet');
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            )),
            PopupMenuItem<String>(
                child: InkWell(
              child: const Text('Import/export'),
              onTap: () async {
                showExportDialog(context);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            )),
          ],
        ),
      ),
      PopupMenuItem(
        child: PopupMenuButton(
          child: const Text('Edit'),
          onSelected: (String result) {
            //setState(() { _selection = result; });
            Navigator.pop(context);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
                child: InkWell(
              child: const Text('Copy row as CSV'),
              onTap: () async {
                String res = const ListToCsvConverter().convert([
                  [',b', 3.1, 42],
                  ['n\n']
                ]);
                List<String> row = ['ID?', rowmap['sheetName'], rowmap['ID']];
                for (var element in rowmap.entries) {
                  if (element.key == 'ID') continue;
                  row.add('${element.value}');
                }
                const conv = ListToCsvConverter(fieldDelimiter: '|');
                res = conv.convert([row]);
                FlutterClipboard.copy(res).then((value) => {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            )),
            PopupMenuItem<String>(
                child: InkWell(
              child: const Text('Copy current quote'),
              onTap: () async {
                FlutterClipboard.copy(rowmap['quote']).then((value) => {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            )),
          ],
        ),
      ),
    ],
  );
}

Future<void> showExportDialog(BuildContext context) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          // <-- SEE HERE
          title: const Text('Select Booking Type'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('General'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Silver'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Gold'),
            ),
          ],
        );
      });
}
