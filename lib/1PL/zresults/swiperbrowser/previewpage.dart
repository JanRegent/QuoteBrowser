// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:highlight_text/highlight_text.dart';

import '../../../2BL_domain/bl.dart';

bool previewPageOn = false;

class PreviewPage extends StatelessWidget {
  VoidCallback swiperSetstate;
  PreviewPage(this.swiperSetstate, {super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, HighlightedWord> words = {};
    words = highParts();

    Row titleRow() {
      return Row(
        children: [
          Obx(() => Text(bl.orm.currentRow.author.value)),
          const Text(' / '),
          Obx(() => Text(
              '${bl.orm.currentRow.book.value}\n${bl.orm.currentRow.parPage.value}'))
        ],
      );
    }

    IconButton previewPageReset() {
      return IconButton(
          onPressed: () {
            previewPageOn = false;
            swiperSetstate();
          },
          icon: const Icon(Icons.edit));
    }

    return Scaffold(
        appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.orange, width: 4)),
          elevation: 4,
          leading: const Text(' '),
          title: titleRow(),
          actions: [previewPageReset()],
        ),
        body: SingleChildScrollView(
            child: Obx(() => TextHighlight(
                text: bl.orm.currentRow.quote
                    .value, // You need to pass the string you want the highlights
                words: words,
                matchCase: false, //// Your dictionary words
                textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
                textAlign: TextAlign.left))));
  }
}

//----------------------------------------------------------------------
Map<String, HighlightedWord> highTags() {
  Map<String, HighlightedWord> words = {};

  TextStyle tagStyle = const TextStyle(
      fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold);

  List<String> tags = bl.orm.currentRow.tags.value.split('#');
  for (var i = 0; i < tags.length; i++) {
    if (tags[i].isEmpty) continue;

    words.addAll({
      tags[i]: HighlightedWord(
        onTap: () {
          debugPrint(tags[i]);
        },
        textStyle: tagStyle,
      )
    });
  }

  return words;
}

Map<String, HighlightedWord> highParts() {
  Map<String, HighlightedWord> words = {};

  TextStyle partStyle =
      const TextStyle(fontSize: 20.0, backgroundColor: Colors.yellow);

  List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__');

  for (var i = 0; i < parts.length; i++) {
    if (parts[i].isEmpty) continue;
    List<String> partwords = parts[i].replaceAll(',', '').trim().split(' ');
    for (var wix = 0; wix < partwords.length; wix++) {
      if (partwords[wix].length <= 2) continue;
      words.addAll({
        partwords[wix]: HighlightedWord(
          onTap: () {
            debugPrint(partwords[wix]);
          },
          textStyle: partStyle,
        )
      });
    }
  }
  words.addAll(highTags());
  return words;
}
