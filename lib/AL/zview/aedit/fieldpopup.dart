import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';
import '../../alib/alert/alertok.dart';
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

  if (columnName.isNotEmpty) {
    menu1.add(PopupMenuItem(
      value: '/clearField',
      child: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () async {
          String result = await noYes(
              'Clear this field?\nIt will be cleared even in the cloud!',
              context);

          if (result == 'no') return;
          clearField(columnName);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        },
      ),
    ));
  }
  if ('fileUrl' == columnName) {
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
  if ('quote' == columnName) {
    menu1.add(PopupMenuItem(
      value: '/quoteIReplace',
      child: const Text("quote from clipboard Replace"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          await setCellBL('quote', value);
        });
      },
    ));
    menu1.add(PopupMenuItem(
      value: '/quoteAppend',
      child: const Text("quote from clipboard Append"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          await setCellBL('quote', bl.orm.currentRow.quote + '\n\n' + value);
        });
      },
    ));
  }
  if ('original' == columnName) {
    menu1.add(PopupMenuItem(
      value: '/Original',
      child: const Text("Original from clipboard"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          await setCellBL('original', value);
        });
      },
    ));
    menu1.add(PopupMenuItem(
      value: '/OriginalFromTitle',
      child: const Text("Original from title"),
      onTap: () async {
        try {
          await setCellBL(
              'original', bl.orm.currentRow.optionalFields['title']);
        } catch (_) {}
      },
    ));
  }

  if (bl.orm.currentRow.dateinsert.toString().contains('__toRead__')) {
    menu1.add(PopupMenuItem(
      value: '/__toRead__',
      child: const Text("__toRead__ remove"),
      onTap: () async {
        try {
          await setCellBL(
              'dateinsert',
              bl.orm.currentRow.dateinsert
                  .toString()
                  .replaceAll('__toRead__', ''));
        } catch (_) {}
      },
    ));
  }
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
      bl.orm.currentRow.original = '';
      await setCellBL('original', bl.orm.currentRow.original);
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
