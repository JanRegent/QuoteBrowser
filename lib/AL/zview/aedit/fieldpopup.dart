import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'quoteedit.dart';

PopupMenuButton fieldPopupMenu(String fieldValue, String columnName) {
  return PopupMenuButton(
    onSelected: (value) {
      // your logic
    },
    itemBuilder: (BuildContext context) {
      return listPopupMenu(context, fieldValue, columnName);
    },
  );
}

List<PopupMenuItem> menu1 = [];
List<PopupMenuItem> listPopupMenu(
    BuildContext context, String fieldValue, String columnName) {
  menu1 = [
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
