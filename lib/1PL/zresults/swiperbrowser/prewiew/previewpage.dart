// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../2BL_domain/bl.dart';
import 'text_with_highlight.dart';

bool previewPageOn = false;

class PreviewPage extends StatefulWidget {
  VoidCallback swiperSetstate;
  PreviewPage(this.swiperSetstate, {super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  List<bool> isSelected = [true, false];

  ToggleButtons tagPartsSwitch() {
    //https://blog.logrocket.com/advanced-guide-flutter-switches-toggles/
    return ToggleButtons(
        // list of booleans
        isSelected: isSelected,
        // text color of selected toggle
        selectedColor: Colors.white,
        // text color of not selected toggle
        color: Colors.blue,
        // fill color of selected toggle
        fillColor: Colors.lightBlue.shade900,
        // when pressed, splash color is seen
        splashColor: Colors.red,
        // long press to identify highlight color
        highlightColor: Colors.orange,
        // if consistency is needed for all text style
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        // border properties for each toggle
        renderBorder: true,
        borderColor: Colors.black,
        borderWidth: 1.5,
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: Colors.pink,
// add widgets for which the users need to toggle
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Tags', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Parts', style: TextStyle(fontSize: 18)),
          ),
        ],
        // to select or deselect when pressed
        onPressed: (int newIndex) {
          setState(() {
            tagAllPartsIndex = newIndex;
            // looping through the list of booleans values
            for (int index = 0; index < isSelected.length; index++) {
              // checking for the index value
              if (index == newIndex) {
                // one button is always set to true
                isSelected[index] = true;
              } else {
                // other two will be set to false and not selected
                isSelected[index] = false;
              }
            }
          });
        });
  }

  int tagAllPartsIndex = 0;

  Row titleRow() {
    return Row(
      children: [
        Obx(() => Text(bl.orm.currentRow.author.value)),
        const Text(' / '),
        Obx(() => Text(
            '${bl.orm.currentRow.book.value}\n${bl.orm.currentRow.parPage.value}')),
        const Spacer(),
        tagPartsSwitch()
      ],
    );
  }

  IconButton previewPageReset() {
    return IconButton(
        onPressed: () {
          previewPageOn = false;
          widget.swiperSetstate();
        },
        icon: const Icon(Icons.edit));
  }

  List<String> highlightedTexts = [];

  void highStrings() {
    highlightedTexts = [];

    if (tagAllPartsIndex == 1) {
      List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__');

      for (var i = 0; i < parts.length; i++) {
        if (parts[i].isEmpty) continue;
        highlightedTexts.add(parts[i].trim());
      }
    }
    if (tagAllPartsIndex == 0) {
      List<String> tags = bl.orm.currentRow.tags.value.split('#');
      highlightedTexts.addAll(tags);
    }
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
