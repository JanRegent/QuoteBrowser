import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:highlight_text/highlight_text.dart';

import '../../BL/bl.dart';

// ignore: must_be_immutable
class ColoredView extends StatefulWidget {
  const ColoredView({super.key});

  @override
  State<ColoredView> createState() => _ColoredViewState();
}

class _ColoredViewState extends State<ColoredView> {
  @override
  initState() {
    super.initState();

    highlightedWordFill();
  }

  //------------------------------------------------------------------highlight
  Map<String, HighlightedWord> highlightedWord = {};
  void highlightedWordFill() {
    List<String> tagsWords = bl.orm.currentRow.tags.value.trim().split('#');
    //bl.orm.currentRow.tags.value.trim().split(RegExp(r'[|,.\s]'));
    highlightedWord.clear();
    if (tagsWords.length < 2) return;
    for (String word in tagsWords) {
      if (word.length < 2) continue;
      word = word.replaceAll("'", "").replaceAll('"', '');
      highlightedWord[word] = HighlightedWord(
        onTap: () {},
        textStyle: textStyle,
      );
    }
  }

  TextStyle textStyle = const TextStyle(
    // You can set the general style, like a Text()
    fontSize: 20.0,
    color: Colors.red,
  );

  TextHighlight quoteField() {
    highlightedWordFill();
    return TextHighlight(
        text: bl.orm.currentRow.quote.value,
        words: highlightedWord,
        matchCase: false,
        textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ));
  }

  //------------------------------------------------------------------card

  Card card() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(children: [
        ListTile(
          tileColor: const Color.fromARGB(255, 232, 216, 142),
          leading: Text(bl.orm.currentRow.dateinsert),
          title: Text(bl.orm.currentRow.sheetName.value),
        ),
        ListTile(
          title: quoteField(),
          leading: Obx(() => Text(bl.orm.currentRow.rowNo.value)),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return card();
  }
}
