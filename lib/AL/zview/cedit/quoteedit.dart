import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

// ignore: must_be_immutable
class QuoteEdit extends StatelessWidget {
  Map rowMap;
  final bool isAttrEdit;
  Function setstate;
  QuoteEdit(this.rowMap, this.isAttrEdit, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();

  Future setCellAttr(
      String columnName, String cellContent, String rowNo) async {
    List respData = await dl.httpService.setCell(
        rowMap['sheetName'], rowMap['fileId'], columnName, cellContent, rowNo);

    debugPrint('row: $respData');
  }

  void attribSet(String attribName) async {
    String selected = _controller.text.substring(
        _controller.selection.baseOffset, _controller.selection.extentOffset);

    if (selected.isEmpty) return;

    switch (attribName) {
      case 'author':
        rowMap['author'] = selected;
        await setCellAttr(attribName, rowMap[attribName], rowMap['rowNo']);
        break;
      case 'book':
        rowMap['book'] = selected;
        await setCellAttr(attribName, rowMap[attribName], rowMap['rowNo']);
        break;
      case 'tags':
        rowMap['tags'] = rowMap['tags'] + ',$selected';
        await setCellAttr(attribName, rowMap[attribName], rowMap['rowNo']);
        break;
      default:
        return;
    }

    setstate();
  }

  Future transl() async {
    final translator = GoogleTranslator();

    var translation = await translator.translate(rowMap['quote'], to: 'cs');

    rowMap['quote'] = translation.text;

    setstate();
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = rowMap['quote'];

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
            rowMap['quote'] = value;
          },
        )
      ],
    );
  }
}
