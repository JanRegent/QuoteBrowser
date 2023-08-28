import 'package:flutter/material.dart';
import 'package:translator_plus/translator_plus.dart';

import '../../../BL/bl.dart';

// ignore: must_be_immutable
class QuoteField extends StatelessWidget {
  final Map rowMap;
  Function setstate;
  QuoteField(this.rowMap, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();

  void attribSet(String attribName) {
    String selected = _controller.text.substring(
        _controller.selection.baseOffset, _controller.selection.extentOffset);

    if (selected.isEmpty) return;

    switch (attribName) {
      case 'author':
        rowMap[bl.fields['author']] = selected;
        break;
      case 'book':
        rowMap[bl.fields['book']] = selected;
        break;
      case 'tags':
        rowMap['tags'] += ',$selected';
        break;
      default:
        return;
    }
    rowMap['save2cloud'] += '$attribName, ';
    setstate();
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    _controller.text = rowMap['quote'];
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
          onChanged: (value) async {
            final translator = GoogleTranslator();
            var translation = await translator.translate(value, to: 'cs');
            rowMap['quote'] = translation.toString();
          },
        )
      ],
    );
  }
}
