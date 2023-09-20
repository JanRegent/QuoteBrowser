import 'package:flutter/material.dart';

import '../../../BL/bl.dart';

import '../../../BL/orm.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';
import '../fieldpopup.dart';

Future setCellBL(String columnName, String cellContent) async {
  if (cellContent.isEmpty) return;
  try {
    await dl.httpService.setCellDL(bl.orm.currentRow.sheetName.value,
        columnName, cellContent, bl.orm.currentRow.rowNo.value);
  } catch (e) {
    debugPrint('setCellBL( \n$e');
  }
}

// ignore: must_be_immutable
class QuoteEdit extends StatelessWidget {
  final bool isAttrEdit;
  Function setstate;
  // ignore: use_key_in_widget_constructors
  QuoteEdit(this.isAttrEdit, this.setstate);

  final TextEditingController _controller = TextEditingController();

  void attribSet(String attribName) async {
    String selected = '';

    try {
      selected = _controller.text.substring(
          _controller.selection.baseOffset, _controller.selection.extentOffset);
      if (selected.isEmpty) return;
    } catch (_) {
      return;
    }

    switch (attribName) {
      case 'author':
        bl.orm.currentRow.author.value = selected;
        await setCellBL('author', bl.orm.currentRow.author.value);
        break;
      case 'book':
        bl.orm.currentRow.book.value = selected;
        await setCellBL('book', bl.orm.currentRow.book.value);
        break;
      case 'parPage':
        bl.orm.currentRow.parPage.value += ' $selected';
        await setCellBL(attribName, bl.orm.currentRow.parPage.value);
        break;
      case 'tags':
        bl.orm.currentRow.tags.value += '#$selected';
        pureTags();
        await setCellBL(attribName, bl.orm.currentRow.tags.value);
        break;

      case 'original':
        await setCellBL(attribName, bl.orm.currentRow.original);
        return;
      case '__othersFields__':
        return;

      default:
        return;
    }

    setstate();
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
        TextButton(
            child: fieldPopupMenu(bl.orm.currentRow.quote.value, 'quote'),
            onPressed: () => attribSet('__othersFields__')),
        const Spacer(),
      ],
    );
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = bl.orm.currentRow.quote.value;

    return Column(
      children: [
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
      ],
    );
  }
}
