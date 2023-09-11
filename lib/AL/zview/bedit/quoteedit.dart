import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../BL/bl.dart';
import '../../../BL/bluti.dart';
import '../../../BL/orm.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

Future setCellAttr(String columnName, String cellContent, String rowNo) async {
  // ignore: unused_local_variable
  List responseRow = await dl.httpService.setCellDL(
      bl.orm.currentRow.sheetName.value, columnName, cellContent, rowNo);
  try {
    responseData.keyrows[currentRowIndex] = blUti.toListString(responseRow);
  } catch (e) {
    debugPrint('setCellBL( \n$e');
  }
  await currentRowUpdate();
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
    selected =
        selected.replaceAll('.', '').replaceAll(',', ' ').replaceAll('\n', ' ');

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
        bl.orm.currentRow.tags.value += ',$selected';
        pureTags();
        await setCellAttr(attribName, bl.orm.currentRow.tags.value,
            bl.orm.currentRow.rowNo.value);
        break;
      case '__othersFields__':
        return;

      default:
        return;
    }

    setstate();
  }

  Future transl() async {
    final translator = GoogleTranslator();

    var translation =
        await translator.translate(bl.orm.currentRow.quote.value, to: 'cs');
    bl.orm.currentRow.original = bl.orm.currentRow.quote.value;
    bl.orm.currentRow.quote.value = translation.text;

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
        const Text('    '),
        TextButton(
            child: const Text(' >>'),
            onPressed: () => attribSet('__othersFields__')),
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
