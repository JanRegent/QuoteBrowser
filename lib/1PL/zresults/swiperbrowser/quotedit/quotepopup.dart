import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/bluti.dart';
import '../../../widgets/alib/alertinfo/alertok.dart';

PopupMenuItem copyPopupMenuItem(String fieldValue) {
  return PopupMenuItem(
    value: '/copy',
    child: IconButton(
      icon: const Icon(Icons.copy, color: Colors.black),
      onPressed: () {
        FlutterClipboard.copy(fieldValue).then((value) => {});
      },
    ),
  );
}

PopupMenuButton copyPopupMenuButton(String fieldValue) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [copyPopupMenuItem(fieldValue)];
    },
  );
}

PopupMenuItem pastePopupMenuItem(String columnName) {
  return PopupMenuItem(
    value: '/paste',
    child: IconButton(
      icon: const Icon(Icons.paste, color: Colors.black),
      onPressed: () {
        FlutterClipboard.paste().then((value) async {
          if (['fileUrl', 'sourceUrl', 'folder'].contains(columnName)) {
            value = blUti.pureHttpGDriveLink(value);
          }
          bl.curRow.setCellBL(columnName, value);
        });
      },
    ),
  );
}

PopupMenuItem clearPopupMenuItem(String columnName) {
  return PopupMenuItem(
    value: '/clearField',
    child: IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () async {
        String result = noYes(
          'Clear this field?\nIt will be cleared even in the cloud!',
        );

        if (result == 'no') return;
        clearField(columnName);
      },
    ),
  );
}

PopupMenuButton copyPasteClearPopupMenuButton(
    String fieldValue, String columnName) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return copyPasteClearPopumMenuItem(fieldValue, columnName);
    },
  );
}

List<PopupMenuItem> copyPasteClearPopumMenuItem(
    String fieldValue, String columnName) {
  List<PopupMenuItem> menu1 = [
    copyPopupMenuItem(fieldValue),
    //clearPopupMenuItem(fieldValue)
    pastePopupMenuItem(columnName)
  ];
  return menu1;
}

void clearField(String attribName) async {
  switch (attribName) {
    case 'author':
      bl.curRow.author.value = '';
      bl.curRow.setCellBL('author', bl.curRow.author.value);
      break;
    case 'book':
      bl.curRow.book.value = '';
      bl.curRow.setCellBL('book', bl.curRow.book.value);
      break;
    case 'parPage':
      bl.curRow.parPage.value = '';
      bl.curRow.setCellBL('parPage', bl.curRow.parPage.value);
      break;
    case 'vydal':
      bl.curRow.setCellBL('vydal', '');
      break;
    case 'tags':
      bl.curRow.tags.value = '';
      bl.curRow.setCellBL('tags', bl.curRow.tags.value);
      break;
    case 'original':
      bl.curRow.original.value = '';
      bl.curRow.setCellBL('original', bl.curRow.original.value);
      return;
    case '__othersFields__':
      return;

    default:
      return;
  }
}
