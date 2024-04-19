// ignore_for_file: sort_child_properties_last

import 'package:clipboard/clipboard.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';

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
            child: TextButton(
          child: Text(
              '${bl.orm.currentRow.rowkey.value}\n${bl.orm.currentRow.dateinsert} \n${bl.orm.currentRow.rownoKey}'),
          onPressed: () async {
            String? fileUrl = dl.sheetUrls[bl.orm.currentRow.sheetName.value];
            String rownoInrowkey = bl.orm.currentRow.rowkey.value
                .replaceAll(RegExp("[a-zA-Z:s]"), "");
            await al.jump2sheetRow(
                fileUrl!, rownoInrowkey, context, 'Jump to row');
          },
        )),
      ),
      PopupMenuItem(
          child: InkWell(
        child: const Icon(Icons.preview),
        onTap: () async {
          bl.userViewMode = !bl.userViewMode;
          Navigator.of(context).pop();
          swiperSetstate();
        },
      )),
      PopupMenuItem(
        child: PopupMenuButton(
          child: const Text('File'),
          onSelected: (String result) {
            Navigator.pop(context);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
                child: InkWell(
              child: const Text('Jump to row'),
              onTap: () async {
                String? fileUrl =
                    dl.sheetUrls[bl.orm.currentRow.sheetName.value];

                // ignore: use_build_context_synchronously //Icons.open_in_browser
                await al.jump2sheetRow(fileUrl!, bl.orm.currentRow.rowNo.value,
                    context, 'Jump to row');
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
