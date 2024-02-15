import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';

import '../../../../2BL_domain/bl.dart';
import '../edit/battr/originalview.dart';

//-----------------------------------------------------------------highl
Map<String, HighlightedWord> words = {};
const TextStyle tagStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const TextStyle yellowStyle = TextStyle(
  backgroundColor: Colors.yellow,
  fontSize: 20.0,
);

void initTags() {
  List<String> tags = bl.orm.currentRow.tags.value.split('#');
  for (String tag in tags) {
    if (tag.isEmpty) continue;
    words[tag] = HighlightedWord(
      onTap: () {},
      textStyle: tagStyle,
      //decoration: decoration,
      //padding: padding,
    );
  }
}

void initYellowParts() {
  void initSubPart(String yellowPart) {
    List<String> yellowSubparts = yellowPart.split(',');
    for (String yellowSubPart in yellowSubparts) {
      if (yellowSubPart.isEmpty) continue;
      words[yellowSubPart.trim()] = HighlightedWord(
        onTap: () {},
        textStyle: yellowStyle,
        //decoration: decoration,
        //padding: padding,
      );
    }
  }

  List<String> yParts = bl.orm.currentRow.yellowParts.value.split('__|__');
  for (String yellowPart in yParts) {
    if (yellowPart.isEmpty) continue;
    initSubPart(yellowPart);
  }
}

void initHighlight() {
  words = {};
  if (bl.highligthOnOff == false) return;
  try {
    initYellowParts();
  } catch (e) {
    debugPrint('initHighlight.initYellowParts err\n$e');
  }
  try {
    initTags();
  } catch (e) {
    debugPrint('initHighlight.initTags err\n$e');
  }
}

//-------------------------------------------------------------userviewPage
class HighViewPage extends StatefulWidget {
  const HighViewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HighViewPageState createState() => _HighViewPageState();
}

class _HighViewPageState extends State<HighViewPage> {
  @override
  void initState() {
    super.initState();
    words = {};
    bl.highligthOnOff = true;
    initHighlight();
  }

  IconButton highlight() {
    return IconButton(
        onPressed: () {
          bl.highligthOnOff = !bl.highligthOnOff;
          initHighlight();
          setState(() {});
        },
        icon: const Icon(Icons.highlight));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                  //leading: highlight(),
                  title: Row(
                    children: [
                      Obx(() => Text(bl.orm.currentRow.author.value)),
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OriginalView()),
                        );
                      },
                      icon: const Icon(Icons.crop_original))),
              const Text('TextHighlight-frozen')
              // Card(
              //   shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //           bottomRight: Radius.circular(1),
              //           topRight: Radius.circular(1)),
              //       side: BorderSide(width: 1, color: Colors.green)),
              //   child: Obx(() => TextHighlight(
              //         text: bl.orm.currentRow.quote.value,
              //         words: words,
              //         matchCase: false,
              //         textStyle: const TextStyle(
              //           fontSize: 20.0,
              //           color: Colors.black,
              //         ),
              //         textAlign: TextAlign.left,
              //       )),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
