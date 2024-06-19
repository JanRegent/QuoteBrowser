// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:quotebrowser/1PL/widgets/alib/alicons.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/bluti.dart';
import '../../../widgets/alib/alib.dart';
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
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('#', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ALicons.attrIcons.yellowPartIcon,
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
        al.infoButton(context, bl.curRow.author.value,
            '${bl.curRow.book.value}\n${bl.curRow.parpage.value}\n\n${bl.curRow.stars.value}\n${bl.curRow.fav.value}'),
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
  Map<String, HighlightedWord> tagWords = {};

  List<String> sortedPartsGet() {
    List<String> ypList = bl.curRow.yellowparts.value.split('__|__');
    Set set = ypList.toSet();
    List<String> parts = blUti.toListString(set.toList());
    //------------------------------------------------------indexOf

    String quote = bl.curRow.quote.value.toLowerCase();
    Map<int, String> partsMap = {};
    for (var part in parts) {
      if (part.trim().isEmpty) continue;
      int index = quote.indexOf(part.trim().toLowerCase());
      if (index == -1) continue;

      partsMap[index] = part.trim();
    }
    //------------------------------------------------------sort by index
    List<String> sortedParts = [];
    var sortedMap = Map.fromEntries(
        partsMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    for (var part in sortedMap.values) {
      sortedParts.add(part);
    }
    return sortedParts;
  }

  int tagsLen = 0;
  List<String> tagsGet() {
    List<String> tags = bl.curRow.tags.value.split('#');
    tagsLen = tags.length;
    List<String> parts = bl.curRow.yellowparts.value.split('__|__');
    for (String part in parts) {
      List<String> tags1 = part.split(' ');
      String tag1 = tags1[0].trim();
      if (tag1.isEmpty) continue;
      tags.add(tag1);
    }
    return tags;
  }

  void highStrings() {
    highlightedTexts = [];
    tagWords = {};
    TextStyle tagStyle = const TextStyle(
        // You can set the general style, like a Text()
        fontSize: 20.0,
        color: Colors.red,
        fontWeight: FontWeight.bold);
    TextStyle tagStyleFirstWord = const TextStyle(
        // You can set the general style, like a Text()
        fontSize: 20.0,
        color: Colors.yellow,
        fontWeight: FontWeight.bold);
    if (tagAllPartsIndex == 1) {
      List<String> parts = sortedPartsGet();

      for (var i = 0; i < parts.length; i++) {
        if (parts[i].isEmpty) continue;
        highlightedTexts.add(parts[i].trim());
      }
    }
    if (tagAllPartsIndex == 0) {
      List<String> tags = tagsGet();
      highlightedTexts.addAll(tags);
      for (var i = 0; i < tags.length; i++) {
        if (tags[i].isEmpty) continue;
        tagWords.addAll({
          tags[i]: HighlightedWord(
            onTap: () {
              debugPrint(tags[i]);
            },
            textStyle: i < tagsLen ? tagStyle : tagStyleFirstWord,
          )
        });
      }
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
            child: tagAllPartsIndex != 0
                ? Obx(
                    () => TextWithHighlight(
                      text: bl.curRow.quote.value,
                      highlightedTexts: highlightedTexts,
                    ),
                  )
                : TextHighlight(
                    text: bl.curRow.quote.value,
                    words: tagWords,
                    splitOnLongWord: true,
                    matchCase: false,
                    textStyle:
                        const TextStyle(fontSize: 20.0, color: Colors.black),
                    textAlign: TextAlign.left)));
  }
}
