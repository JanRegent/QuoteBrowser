import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../2BL_domain/bl.dart';
import '../../../../widgets/alib/alib.dart';
import '../editcontent.dart';
import 'othersfields.dart';
import 'quotepopup.dart';
import '../originalview.dart';

List<PopupMenuItem> buttonRowMenu(BuildContext context) {
  return [
    PopupMenuItem(
      value: '/selectedText',
      child: al.infoButton(context, 'Selected', bl.curRow.selectedText.value),
    ),
    PopupMenuItem(
      value: '/OthersFields',
      child: IconButton(
        icon: const Icon(Icons.details),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OthersFields()),
          );
        },
      ),
    ),
    PopupMenuItem(
      value: '/edit',
      child: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditContent()),
          );
        },
      ),
    ),
    copyPopupMenuItem(bl.curRow.quote.value),
    PopupMenuItem(
      value: '/quoteIReplace',
      child: const Text("quote from clipboard Replace"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          bl.curRow.setCellBL('quote', value);
        });
      },
    ),
    PopupMenuItem(
      value: '/quoteAppend',
      child: const Text("quote from clipboard Append"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          bl.curRow.setCellBL('quote', bl.curRow.quote + '\n\n' + value);
        });
      },
    ),
    PopupMenuItem(
      value: '/OriginalView',
      child: const Text("Original View"),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OriginalView()),
        );
      },
    ),
    PopupMenuItem(
      value: '/__toRead__',
      child: const Text("__toRead__ remove"),
      onTap: () async {
        try {
          bl.curRow.setCellBL('dateinsert',
              bl.curRow.dateinsert.toString().replaceAll('__toRead__', ''));
        } catch (_) {}
      },
    )
  ];
}
