import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';

import '../../../BL/orm.dart';

import '../../../DL/dl.dart';

import '../../alib/alicons.dart';

import 'addquote/addquoterow.dart';
import 'fieldpopup.dart';

Future setCellBL(String columnName, String cellContent) async {
  if (columnName.isEmpty) return;
  if (bl.orm.currentRow.sheetName.value.isEmpty) return;
  try {
    String sheetRownokey = await dl.httpService.setCellDL(
        bl.orm.currentRow.sheetName.value,
        columnName,
        cellContent,
        bl.orm.currentRow.rowNo.value);
    if (sheetRownokey.isNotEmpty) {
      await currentRowSet(sheetRownokey);
    }
  } catch (e) {
    debugPrint('setCellBL( \n$e');
  }
}

// ignore: must_be_immutable
class QuoteEdit extends StatefulWidget {
  final bool isAttrEdit;
  Function swiperSetstate;
  BuildContext context;
  // ignore: use_key_in_widget_constructors
  QuoteEdit(this.isAttrEdit, this.swiperSetstate, this.context);

  @override
  State<QuoteEdit> createState() => _QuoteEditState();
}

class _QuoteEditState extends State<QuoteEdit> {
  final TextEditingController _controller = TextEditingController();

  RxString selected = ''.obs;
  List<PopupMenuItem> menu1 = [
    copyPopupMenuItem(bl.orm.currentRow.quote.value),
    PopupMenuItem(
      value: '/quoteIReplace',
      child: const Text("quote from clipboard Replace"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          await setCellBL('quote', value);
        });
      },
    ),
    PopupMenuItem(
      value: '/quoteAppend',
      child: const Text("quote from clipboard Append"),
      onTap: () async {
        FlutterClipboard.paste().then((value) async {
          await setCellBL('quote', bl.orm.currentRow.quote + '\n\n' + value);
        });
      },
    ),
    PopupMenuItem(
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
    )
  ];

  void attribSet(String attribName) async {
    try {
      selected.value = _controller.text.substring(
          _controller.selection.baseOffset, _controller.selection.extentOffset);
      if (selected.value.isEmpty) return;
    } catch (_) {
      return;
    }
    attribNameRedo.value = '';
    setState(() {
      bl.orm.currentRow.setCellDLOn = true;
    });

    switch (attribName) {
      case 'author':
        selected.value;
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.author.value;
        bl.orm.currentRow.author.value = selected.value;
        await setCellBL('author', bl.orm.currentRow.author.value);
        attribNameRedo.value = attribName;
        break;
      case 'book':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.book.value;
        bl.orm.currentRow.book.value = selected.value;
        await setCellBL('book', bl.orm.currentRow.book.value);
        attribNameRedo.value = attribName;
        break;
      case 'parPage':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.parPage.value;
        bl.orm.currentRow.parPage.value += ' ${selected.value}';
        await setCellBL(attribName, bl.orm.currentRow.parPage.value);
        attribNameRedo.value = attribName;
        break;
      case 'vydal':
        attribTitleRedo.value = selected.value;
        await setCellBL(attribName, selected.value);
        break;
      case 'tags':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.tags.value;
        bl.orm.currentRow.tags.value += '#${selected.value}';
        pureTags();
        await setCellBL(attribName, bl.orm.currentRow.tags.value);
        attribNameRedo.value = attribName;
        break;

      case 'original':
        await setCellBL(attribName, bl.orm.currentRow.original.value);
        return;
      case '__othersFields__':
        return;

      default:
        return;
    }
    setState(() {
      bl.orm.currentRow.setCellDLOn = false;
    });

    widget.swiperSetstate();
  }

  Container buttRow() {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.yellow[100],
            border: Border.all(
              color: bl.orm.currentRow.setCellDLOn ? Colors.red : Colors.white,
              width: 5,
            )),
        child: Row(
          children: [
            IconButton(
                icon: ALicons.attrIcons.authorIcon,
                onPressed: () => attribSet('author')),
            IconButton(
                icon: ALicons.attrIcons.bookIcon,
                onPressed: () => attribSet('book')),
            IconButton(
                icon: ALicons.attrIcons.parPageIcon,
                onPressed: () => attribSet('parPage')),
            IconButton(
                icon: ALicons.attrIcons.tagIcon,
                onPressed: () => attribSet('tags')),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.publish_rounded),
                onPressed: () => attribSet('vydal')),

            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                if (bl.orm.currentRow.dateinsert
                    .toString()
                    .contains('__toRead__')) {
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
              },
            )

            // TextButton(
            //     child: fieldPopupMenu(bl.orm.currentRow.quote.value, 'quote'),
            //     onPressed: () => attribSet('quote')),
            // const Spacer(),
          ],
        ));
  }

  String onEdit = '';

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = bl.orm.currentRow.quote.value;

    List<Widget> colItems = [
      buttRow(),
      TextField(
        controller: _controller,
        readOnly: true,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
        maxLines: 20,
        onChanged: (value) async {
          bl.orm.currentRow.quote.value = value;
        },
      ),
      widget.isAttrEdit ? buttRow() : const Text(' ')
    ];
    if (currentSS.addQuoteMode) {
      colItems.insert(0, addQuoteRow(context, widget.swiperSetstate));
    }

    return Column(children: colItems);
  }
}
