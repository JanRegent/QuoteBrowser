import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';
import '../../alib/alert/alertok.dart';
import 'quoteedit.dart';

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
          await setCellBL(columnName, value);
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
      bl.orm.currentRow.author.value = '';
      await setCellBL('author', bl.orm.currentRow.author.value);
      break;
    case 'book':
      bl.orm.currentRow.book.value = '';
      await setCellBL('book', bl.orm.currentRow.book.value);
      break;
    case 'parPage':
      bl.orm.currentRow.parPage.value = '';
      await setCellBL('parPage', bl.orm.currentRow.parPage.value);
      break;
    case 'vydal':
      await setCellBL('vydal', '');
      break;
    case 'tags':
      bl.orm.currentRow.tags.value = '';
      await setCellBL('tags', bl.orm.currentRow.tags.value);
      break;
    case 'original':
      bl.orm.currentRow.original.value = '';
      await setCellBL('original', bl.orm.currentRow.original.value);
      return;
    case '__othersFields__':
      return;

    default:
      return;
  }
}

RxString attribNameRedo = ''.obs;
RxString attribPrevRedo = ''.obs;
RxString attribTitleRedo = ''.obs;

void redoClear() {
  attribNameRedo.value = '';
  attribPrevRedo.value = '';
  attribTitleRedo.value = '';
}

IconButton redoButton(Function attreditSetstate) {
  return IconButton(
      onPressed: () {
        redoAttrib(attreditSetstate);
      },
      icon: const Icon(Icons.redo));
}

void redoAttrib(Function attreditSetstate) async {
  if (attribNameRedo.value.toString().trim().isEmpty) return;
  bl.orm.currentRow.setCellDLOn = true;
  attreditSetstate();
  switch (attribNameRedo.value) {
    case 'author':
      bl.orm.currentRow.author.value = attribPrevRedo.value;
      await setCellBL('author', bl.orm.currentRow.author.value);
      redoClear();
      break;
    case 'book':
      bl.orm.currentRow.book.value = attribPrevRedo.value;
      await setCellBL('book', bl.orm.currentRow.book.value);
      redoClear();

      break;
    case 'parPage':
      bl.orm.currentRow.parPage.value = attribPrevRedo.value;
      await setCellBL('parPage', bl.orm.currentRow.parPage.value);
      redoClear();

      break;
    case 'tags':
      bl.orm.currentRow.tags.value = attribPrevRedo.value;
      await setCellBL('tags', bl.orm.currentRow.tags.value);
      redoClear();

      break;
    default:
      redoClear();
  }
  bl.orm.currentRow.setCellDLOn = false;
  attreditSetstate();
}
