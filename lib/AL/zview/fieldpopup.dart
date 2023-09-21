import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'aedit/quoteedit.dart';

PopupMenuButton fieldPopupMenu(String fieldValue, String columnName) {
  List<PopupMenuItem> menu(BuildContext context) {
    List<PopupMenuItem> menu1 = [
      PopupMenuItem(
        value: '/copy',
        child: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            FlutterClipboard.copy(fieldValue).then((value) => {});
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
        ),
      ),
    ];

    if (fieldValue.isEmpty && 'fileUrl' == columnName) {
      menu1.add(PopupMenuItem(
        value: '/fileUrl',
        child: const Text("fileUrl from clipboard"),
        onTap: () async {
          FlutterClipboard.paste().then((value) async {
            await setCellBL('fileUrl', value);
          });
        },
      ));
    }
    return menu1;
  }

  return PopupMenuButton(
    onSelected: (value) {
      // your logic
    },
    itemBuilder: (BuildContext context) {
      return menu(context);
    },
  );
}
