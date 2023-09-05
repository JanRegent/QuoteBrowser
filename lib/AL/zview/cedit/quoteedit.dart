import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../BL/bl.dart';
import '../../../BL/orm.dart';
import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

// ignore: must_be_immutable
class QuoteEdit extends StatelessWidget {
  final bool isAttrEdit;
  Function setstate;
  QuoteEdit(this.isAttrEdit, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();

  Future setCellAttr(
      String columnName, String cellContent, String rowNo) async {
    debugPrint('setCell $columnName $rowNo');
    List respData = await dl.httpService.setCell(
        bl.orm.currentRow.sheetName.value,
        bl.orm.currentRow.fileId,
        columnName,
        cellContent,
        rowNo);
    await currentRowUpdate();
    debugPrint('row: $respData');
  }

  void attribSet(String attribName) async {
    String selected = _controller.text.substring(
        _controller.selection.baseOffset, _controller.selection.extentOffset);

    if (selected.isEmpty) return;

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
        await setCellAttr(attribName, bl.orm.currentRow.tags.value,
            bl.orm.currentRow.rowNo.value);
        break;
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

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = bl.orm.currentRow.quote.value;

    return Column(
      children: [
        isAttrEdit
            ? Row(
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
                ],
              )
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
        )
      ],
    );
  }
}
