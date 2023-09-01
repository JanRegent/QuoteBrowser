import 'package:flutter/material.dart';

import 'package:highlight_text/highlight_text.dart';

import '../../BL/bl.dart';

// ignore: must_be_immutable
class QuoteView extends StatefulWidget {
  Map rowMap;
  QuoteView(this.rowMap, {super.key});

  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  @override
  initState() {
    super.initState();

    highlightedWordFill();
  }

  //------------------------------------------------------------------highlight
  Map<String, HighlightedWord> highlightedWord = {};
  void highlightedWordFill() {
    List<String> tagsWords =
        widget.rowMap['tags'].trim().split(RegExp(r'[|,.\s]'));
    highlightedWord.clear();
    if (tagsWords.length < 2) return;
    for (String word in tagsWords) {
      if (word.length < 2) continue;
      word = word.replaceAll("'", "").replaceAll('"', '');
      highlightedWord[word] = HighlightedWord(
        onTap: () {
          debugPrint(word);
        },
        textStyle: textStyle,
      );
    }
  }

  TextStyle textStyle = const TextStyle(
    // You can set the general style, like a Text()
    fontSize: 20.0,
    color: Colors.red,
  );

  TextHighlight quoteField(Map rowMap) {
    highlightedWordFill();
    return TextHighlight(
        text: rowMap[bl.orm.fields['quote']],
        words: highlightedWord,
        matchCase: false,
        textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ));
  }

  //------------------------------------------------------------------card

  Card card(Map rowMap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(children: [
        ListTile(
          title: quoteField(rowMap),
          leading: Text(rowMap['rowNo']),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return card(widget.rowMap);
  }
}
