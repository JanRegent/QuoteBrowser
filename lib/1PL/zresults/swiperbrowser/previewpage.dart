// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:text_with_highlight/text_with_highlight.dart';

import '../../../2BL_domain/bl.dart';

class PreviewPage extends StatelessWidget {
  final String tagsOrParts;
  const PreviewPage(this.tagsOrParts, {super.key});

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
