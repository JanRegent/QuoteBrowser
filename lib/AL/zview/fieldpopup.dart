import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../BL/bl.dart';
import 'aedit/quoteedit.dart';

Future translPopup(bool fromClipboard) async {
  final translator = GoogleTranslator();

  if (fromClipboard) {
    FlutterClipboard.paste().then((value) {
      bl.orm.currentRow.quote.value = value;
    });
  }

  try {
    var translation =
        await translator.translate(bl.orm.currentRow.quote.value, to: 'cs');
    bl.orm.currentRow.original = bl.orm.currentRow.quote.value;
    bl.orm.currentRow.quote.value = translation.text;
  } catch (e) {
    debugPrint('translPopup($fromClipboard \n$e');
  } //translator_plus/src/tokens/google_token_gen.dart:14:12)
}

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

    if (fieldValue.isEmpty && ['quote', 'original'].contains(columnName)) {
      if (columnName == 'original') {
        menu1.add(PopupMenuItem(
          value: '/transl',
          child: const Text("Translate from clipboard"),
          onTap: () async {
            await translPopup(true);
          },
        ));
      }
      menu1.add(PopupMenuItem(
        value: '/paste',
        child: const Text("Paste from clipboard"),
        onTap: () async {
          if (columnName == 'original') {
            FlutterClipboard.paste().then((value) {
              bl.orm.currentRow.original = value;
            });
          }
          if (columnName == 'quote') {
            FlutterClipboard.paste().then((value) {
              bl.orm.currentRow.quote.value = value;
            });
          }
        },
      ));

      if (columnName == 'quote') {
        menu1.add(PopupMenuItem(
          value: '/original2cloud',
          child: const Text("Original to cloud"),
          onTap: () async {
            await setCellAttr('original', bl.orm.currentRow.original,
                bl.orm.currentRow.rowNo.value);
          },
        ));
        menu1.add(PopupMenuItem(
          value: '/quote2cloud',
          child: const Text("quote to cloud"),
          onTap: () async {
            await setCellAttr('Quote', bl.orm.currentRow.quote.value,
                bl.orm.currentRow.rowNo.value);
          },
        ));
      }
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
