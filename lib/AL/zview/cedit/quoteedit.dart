import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';
import '../aacommon.dart';

// ignore: must_be_immutable
class QuoteEdit extends StatelessWidget {
  final bool isAttrEdit;
  Function setstate;
  QuoteEdit(this.isAttrEdit, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();

  Future setCellAttr(
      String columnName, String cellContent, String rowNo) async {
    debugPrint('setCell $columnName $rowNo');
    List respData = await dl.httpService.setCell(currentRow.sheetName.value,
        currentRow.fileId, columnName, cellContent, rowNo);
    await currentRowUpdate();
    debugPrint('row: $respData');
  }

  void attribSet(String attribName) async {
    String selected = _controller.text.substring(
        _controller.selection.baseOffset, _controller.selection.extentOffset);

    if (selected.isEmpty) return;

    switch (attribName) {
      case 'author':
        currentRow.author.value = selected;
        await setCellAttr(
            attribName, currentRow.author.value, currentRow.rowNo.value);
        break;
      case 'book':
        currentRow.book.value = selected;
        await setCellAttr(
            attribName, currentRow.book.value, currentRow.rowNo.value);
        break;
      case 'parPage':
        currentRow.parPage.value += ' $selected';
        await setCellAttr(
            attribName, currentRow.tags.value, currentRow.rowNo.value);
        break;
      case 'tags':
        currentRow.tags.value += ',$selected';
        await setCellAttr(
            attribName, currentRow.tags.value, currentRow.rowNo.value);
        break;
      default:
        return;
    }

    setstate();
  }

  Future transl() async {
    final translator = GoogleTranslator();

    var translation =
        await translator.translate(currentRow.quote.value, to: 'cs');
    currentRow.original = currentRow.quote.value;
    currentRow.quote.value = translation.text;

    setstate();
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = currentRow.quote.value;

    double iconSize = 30.0;
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
                      icon: ALicons.attrIcons.tagIcon,
                      onPressed: () => attribSet('tags')),
                ],
              )
            : Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.translate, size: iconSize),
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
            currentRow.quote.value = value;
          },
        )
      ],
    );
  }
}
