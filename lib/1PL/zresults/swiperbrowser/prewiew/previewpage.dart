// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../2BL_domain/bl.dart';
import 'text_with_highlight.dart';

bool previewPageOn = false;

class PreviewPage extends StatelessWidget {
  VoidCallback swiperSetstate;
  PreviewPage(this.swiperSetstate, {super.key});

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

  List<String> highlightedTexts = [];

  void highStrings() {
    highlightedTexts = [];

    List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__');

    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      highlightedTexts.add(parts[i].trim());
    }
    List<String> tags = bl.orm.currentRow.tags.value.split('#');
    highlightedTexts.addAll(tags);
  }

  @override
  Widget build(BuildContext context) {
    highStrings();

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
            child: Obx(
          () => TextWithHighlight(
            text: bl.orm.currentRow.quote.value,
            textStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.black,
            ),
            highlightedTexts: highlightedTexts,
            highlightedTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red,
            ),
          ),

          // TextHighlight(
          //     text: bl.orm.currentRow.quote
          //         .value, // You need to pass the string you want the highlights
          //     words: words,
          //     splitOnLongWord: true,
          //     matchCase: false, //// Your dictionary words
          //     textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
          //     textAlign: TextAlign.left)
        )));
  }
}
