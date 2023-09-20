import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

PopupMenuButton fieldPopupMenu(String fieldValue) {
  return PopupMenuButton(
    onSelected: (value) {
      // your logic
    },
    itemBuilder: (BuildContext context) {
      return [
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
        const PopupMenuItem(
          value: '/about',
          child: Text("About"),
        ),
        const PopupMenuItem(
          value: '/contact',
          child: Text("Contact"),
        )
      ];
    },
  );
}
