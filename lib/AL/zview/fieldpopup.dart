import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../BL/bl.dart';
import 'aedit/quoteedit.dart';

PopupMenuButton fieldPopupMenu(String fieldValue, String columnName,
    {String? original2trans}) {
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

    if (fieldValue.isEmpty && ['quote'].contains(columnName)) {
      menu1.add(PopupMenuItem(
        value: '/original2cloud',
        child: const Text("Original from clipboard to cloud"),
        onTap: () async {
          FlutterClipboard.paste().then((value) async {
            await setCellBL('original', value);
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
