// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:text_with_highlight/text_with_highlight.dart';

import '../../../2BL_domain/bl.dart';

class PreviewPage extends StatelessWidget {
  final String tagsOrParts;
  PreviewPage(this.tagsOrParts, {super.key});

  String text = bl.orm.currentRow.quote.value;

  final TextStyle normalStyle =
      TextStyle(background: Paint()..color = Colors.white, fontSize: 20);
  final TextStyle highlightStyle =
      TextStyle(background: Paint()..color = Colors.limeAccent, fontSize: 20);
  final Color highlightColor = Colors.red;

  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    List<String> words = [];
    if (tagsOrParts == 'tags') words = bl.orm.currentRow.tags.value.split('#');
    if (tagsOrParts == 'parts') {
      words = bl.orm.currentRow.yellowParts.value.split('__|__');
    }
    if (words[0].isEmpty) words.removeAt(0);

    return Scaffold(
        appBar: AppBar(title: const Text('preview')),
        body: TextWithHighlight(
            text: bl.orm.currentRow.quote.value,
            highlightedTexts: words,
            textStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black,
            ),
            highlightedTextStyle: const TextStyle(
                backgroundColor: Colors.yellow,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20)));
  }
}
