import 'package:flutter/material.dart';

import 'package:highlight_text/highlight_text.dart';

import '../../BL/sheet/sheet.dart';

// ignore: must_be_immutable
class SheetViewQuote extends StatefulWidget {
  Sheet sheet;
  SheetViewQuote(this.sheet, {super.key});

  @override
  State<SheetViewQuote> createState() => _SheetViewQuoteState();
}

class _SheetViewQuoteState extends State<SheetViewQuote> {
  @override
  initState() {
    super.initState();

    //highlightedWordFill();
  }

  //------------------------------------------------------------------highlight
  Map<String, HighlightedWord> highlightedWord = {};
  void highlightedWordFill() {
    List<String> tagsWords = widget.sheet.tagsStr.split(RegExp(r'[,.\s]'));
    print(tagsWords);
    highlightedWord = {}; //split(RegExp(r'[,.\s]')
    for (var word in tagsWords) {
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

  TextHighlight quoteField(Sheet sheet) {
    //highlightedWordFill();
    return TextHighlight(
        text: sheet.quote,
        words: highlightedWord,
        matchCase: false,
        textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ));
  }

  //------------------------------------------------------------------card

  Card card(Sheet sheet) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(children: [
        ListTile(
          title: quoteField(sheet),
          leading: Text(sheet.id.toString()),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return card(widget.sheet);
  }
}
