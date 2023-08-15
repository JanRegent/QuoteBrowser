import 'package:flutter/material.dart';

import '../../../BL/sheet/sheet.dart';

// ignore: must_be_immutable
class QuoteField extends StatelessWidget {
  final Sheet sheet;
  Function setstate;
  QuoteField(this.sheet, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();

  void attribSet(String attribName) {
    String selected = _controller.text.substring(
        _controller.selection.baseOffset, _controller.selection.extentOffset);

    if (selected.isEmpty) return;

    switch (attribName) {
      case 'author':
        sheet.author = selected;
        break;
      case 'book':
        sheet.book = selected;
        break;
      case 'tags':
        sheet.tagsStr += '|$selected';
        break;
      default:
        return;
    }
    sheet.save2cloud += '$attribName, ';
    setstate();
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = sheet.quote;
    double iconSize = 30.0;
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.person, size: iconSize),
                onPressed: () => attribSet('author')),
            IconButton(
                icon: Icon(Icons.book, size: iconSize),
                onPressed: () => attribSet('book')),
            IconButton(
                icon: Icon(Icons.tag, size: iconSize),
                onPressed: () => attribSet('tags')),
          ],
        ),
        TextField(
          controller: _controller,
          maxLines: 10,
          onChanged: (value) {
            sheet.quote = value;
          },
        )
      ],
    );
  }
}
