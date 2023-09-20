import 'package:flutter/material.dart';

import '../../../BL/bl.dart';

import '../../../BL/orm.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';
import '../fieldpopup.dart';

Future setCellAttr(String columnName, String cellContent, String rowNo) async {
  try {
    await dl.httpService.setCellDL(
        bl.orm.currentRow.sheetName.value, columnName, cellContent, rowNo);
  } catch (e) {
    debugPrint('setCellBL( \n$e');
  }
  //await currentRowUpdate();
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
        await setCellAttr(attribName, bl.orm.currentRow.author.value,
            bl.orm.currentRow.rowNo.value);
        break;
      case 'book':
        bl.orm.currentRow.book.value = selected;
        await setCellAttr(attribName, bl.orm.currentRow.book.value,
            bl.orm.currentRow.rowNo.value);
        break;
      case 'parPage':
        bl.orm.currentRow.parPage.value += ' $selected';
        await setCellAttr(attribName, bl.orm.currentRow.parPage.value,
            bl.orm.currentRow.rowNo.value);
        break;
      case 'tags':
        bl.orm.currentRow.tags.value += '#$selected';
        pureTags();
        await setCellAttr(attribName, bl.orm.currentRow.tags.value,
            bl.orm.currentRow.rowNo.value);
        break;

      case 'quote':
        await setCellAttr(attribName, bl.orm.currentRow.quote.value,
            bl.orm.currentRow.rowNo.value);
        return;
      case 'original':
        await setCellAttr(attribName, bl.orm.currentRow.original,
            bl.orm.currentRow.rowNo.value);
        return;
      case '__othersFields__':
        return;

      default:
        return;
    }

    setstate();
  }

  Future transl() async {
    translPopup(false);
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
        isAttrEdit
            ? buttRow()
            : Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.translate),
                      onPressed: () => transl()),
                ],
              ),
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
