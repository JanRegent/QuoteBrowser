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
    await currentRowSet(sheetRownokey);
  } catch (e) {
    debugPrint('setCellBL( \n$e');
  }
}

// ignore: must_be_immutable
class QuoteEdit extends StatelessWidget {
  final bool isAttrEdit;
  Function swiperSetstate;
  BuildContext context;
  // ignore: use_key_in_widget_constructors
  QuoteEdit(this.isAttrEdit, this.swiperSetstate, this.context);

  final TextEditingController _controller = TextEditingController();

  RxString selected = ''.obs;
  void attribSet(String attribName) async {
    try {
      selected.value = _controller.text.substring(
          _controller.selection.baseOffset, _controller.selection.extentOffset);
      if (selected.value.isEmpty) return;
    } catch (_) {
      return;
    }

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
        await setCellBL(attribName, bl.orm.currentRow.original);
        return;
      case '__othersFields__':
        return;

      default:
        return;
    }

    swiperSetstate();
  }

  Row buttRow() {
    return Row(
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
        TextButton(
            child: fieldPopupMenu(bl.orm.currentRow.quote.value, 'quote'),
            onPressed: () => attribSet('__othersFields__')),
        const Spacer(),
      ],
    );
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
      isAttrEdit ? buttRow() : const Text(' ')
    ];
    if (currentSS.addQuoteMode) {
      colItems.insert(0, addQuoteRow(context, swiperSetstate));
    }

    return Column(children: colItems);
  }
}
