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

    for (String tag in tagsWords) {
      tag = tag.replaceAll("'", "").replaceAll('"', '');
      if (tag.isEmpty) continue;
      highlightedWord[tag] = HighlightedWord(
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
      if (part.isEmpty) continue;
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
    return TextHighlight(
        text: bl.orm.currentRow.quote.value,
        words: yellowPartsShow ? highlightedParts : highlightedWord,
        matchCase: false,
        textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ));
  }

  IconButton partsSwitch() {
    return IconButton(
      icon: Icon(
        Icons.circle,
        color: yellowPartsShow ? Colors.yellowAccent : Colors.lime,
      ),
      onPressed: () {
        setState(() {
          yellowPartsShow = !yellowPartsShow;
        });
      },
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
