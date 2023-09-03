import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';
import '../acommonrowmap.dart';

// ignore: must_be_immutable
class QuoteEdit extends StatelessWidget {
  final bool isAttrEdit;
  Function setstate;
  QuoteEdit(this.isAttrEdit, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();

  Future setCellAttr(
      String columnName, String cellContent, String rowNo) async {
    List respData = await dl.httpService.setCell(rowMapRowView['sheetName'],
        rowMapRowView['fileId'], columnName, cellContent, rowNo);

    debugPrint('row: $respData');
  }

  void attribSet(String attribName) async {
    String selected = _controller.text.substring(
        _controller.selection.baseOffset, _controller.selection.extentOffset);

    if (selected.isEmpty) return;

    switch (attribName) {
      case 'author':
        rowMapRowView['author'] = selected;
        await setCellAttr(
            attribName, rowMapRowView[attribName], rowMapRowView['rowNo']);
        break;
      case 'book':
        rowMapRowView['book'] = selected;
        await setCellAttr(
            attribName, rowMapRowView[attribName], rowMapRowView['rowNo']);
        break;
      case 'tags':
        rowMapRowView['tags'] = rowMapRowView['tags'] + ',$selected';
        await setCellAttr(
            attribName, rowMapRowView[attribName], rowMapRowView['rowNo']);
        break;
      default:
        return;
    }

    setstate();
  }

  Future transl() async {
    final translator = GoogleTranslator();

    var translation =
        await translator.translate(rowMapRowView['quote'], to: 'cs');

    rowMapRowView['quote'] = translation.text;

    setstate();
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = rowMapRowView['quote'];

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
            rowMapRowView['quote'] = value;
          },
        )
      ],
    );
  }
}
