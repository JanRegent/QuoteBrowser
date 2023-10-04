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
    highlightedYellowPartsFill();
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

  Map<String, HighlightedWord> highlightedParts = {};
  void highlightedYellowPartsFill() {
    List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__\n');
    //bl.orm.currentRow.tags.value.trim().split(RegExp(r'[|,.\s]'));
    highlightedParts.clear();
    for (String part in parts) {
      if (part.length < 2) continue;
      highlightedParts[part] = HighlightedWord(
        onTap: () {},
        textStyle: textStyleParts,
      );
    }
  }

  TextStyle textStyleParts = const TextStyle(
      // You can set the general style, like a Text()
      fontSize: 20.0,
      backgroundColor: Colors.yellow);

  bool yellowPartsShow = false;
  TextHighlight quoteField() {
    highlightedWordFill();
    highlightedYellowPartsFill();
    return TextHighlight(
        text: bl.orm.currentRow.quote.value,
        words: yellowPartsShow ? highlightedParts : highlightedWord,
        matchCase: false,
        textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ));
  }

  Switch partsSwitch() {
    return Switch(
      // thumb color (round icon)
      activeColor: const Color.fromARGB(255, 240, 185, 22),
      activeTrackColor: Colors.cyan,
      inactiveThumbColor: Colors.blueGrey.shade600,
      inactiveTrackColor: Colors.grey.shade400,
      splashRadius: 50.0,
      // boolean variable value
      value: yellowPartsShow,
      // changes the state of the switch
      onChanged: (value) => setState(() => yellowPartsShow = value),
    );
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
          title: Obx(() => Text(
              '${bl.orm.currentRow.sheetName.value}_|_${bl.orm.currentRow.rowNo.value}')),
          trailing: partsSwitch(),
        ),
        ListTile(title: quoteField()),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return card();
  }
}
