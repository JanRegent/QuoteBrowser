// ignore_for_file: sort_child_properties_last

import 'package:clipboard/clipboard.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../../BL/bl.dart';
import '../../BL/orm.dart';
import '../alib/alib.dart';

//----------------------------------------------------------------goto
// ↓ get the tap position Offset
void showGotoPopupMenu(
    BuildContext context, VoidCallback swiperSetstate) async {
  final size = MediaQuery.of(context).size;
  final center = Offset(size.width - 100, size.height - size.height);
  final position = RelativeRect.fromSize(
      Rect.fromCenter(center: center, width: 0, height: 0), size);

  gotoItemsBuild(swiperSetstate);
  await showMenu(
    context: context,
    position: position,
    items: gotoItems,
    elevation: 8.0,
  );
}

void setstateGoto(VoidCallback swiperSetstate) async {
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  swiperSetstate();
}

List<PopupMenuItem<String>> gotoItems = [];
void gotoItemsBuild(VoidCallback swiperSetstate) {
  int localIdsLength = currentSS.keys.length - 1;
  gotoItems = [];
  //todo widget.configRow['localIds.length'];
  gotoItems.add(PopupMenuItem(
    child: Text('$localIdsLength >|'),
    onTap: () async {
      currentSS.swiperIndex.value = localIdsLength - 1;
      setstateGoto(swiperSetstate);
    },
  ));
  for (int i = 0; i < localIdsLength; i = i + 10) {
    gotoItems.add(PopupMenuItem(
      child: i > 0 ? Text((i + 1).toString()) : const Text('1  |<'),
      onTap: () async {
        currentSS.swiperIndex.value = i;
        setstateGoto(swiperSetstate);
      },
    ));
  }
  gotoItems.add(PopupMenuItem(
    child: Text('$localIdsLength >|'),
    onTap: () async {
      currentSS.swiperIndex.value = localIdsLength - 1;
      setstateGoto(swiperSetstate);
    },
  ));
}

//----------------------------------------------------------------no goto menus
PopupMenuButton rowViewMenu(Map configRow, VoidCallback swiperSetstate) {
  return PopupMenuButton(
    child: const Icon(Icons.menu),
    itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupMenuButton>>[
      PopupMenuItem(
        child: PopupMenuItem<String>(
            child: Text(
                '${bl.orm.currentRow.sheetName.value}__|__${bl.orm.currentRow.rowNo}\n${bl.orm.currentRow.dateinsert}')),
      ),
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
                    bl.orm.currentRow.fileId, context, 'Open source sheet');
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
                List<String> row = [bl.orm.currentRow.sheetName.value];
                // for (var element in rowmap.entries) {
                //   if (element.key == 'ID') continue;
                //   row.add('${element.value}');
                // }
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
                FlutterClipboard.copy(bl.orm.currentRow.quote.value)
                    .then((value) => {});
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
