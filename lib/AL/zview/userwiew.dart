import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';

import '../../BL/bl.dart';
import 'userheadfields.dart';

class UserViewPage extends StatefulWidget {
  const UserViewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserViewPageState createState() => _UserViewPageState();
}

class _UserViewPageState extends State<UserViewPage> {
  //final String text = bl.orm.currentRow.quote.value;

  final EdgeInsetsGeometry padding = const EdgeInsets.all(8.0);

  final BoxDecoration decoration = BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(50),
  );

  final TextStyle tagStyle = const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  final TextStyle yellowStyle = const TextStyle(
    backgroundColor: Colors.yellow,
    fontSize: 20.0,
  );

  late Map<String, HighlightedWord> words;

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
        words[yellowSubPart] = HighlightedWord(
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

  @override
  void initState() {
    super.initState();
    words = {};
  }

  IconButton highlight() {
    return IconButton(
        onPressed: () {
          words = {};
          initTags();
          initYellowParts();
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
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1),
                        topRight: Radius.circular(1)),
                    side: BorderSide(width: 1, color: Colors.green)),
                child: Obx(() => TextHighlight(
                      text: bl.orm.currentRow.quote.value,
                      words: words,
                      matchCase: false,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    )),
              ),
              ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserHeadFields()),
                      );
                    },
                  ),
                  title: Obx(() => Text(bl.orm.currentRow.author.value)),
                  trailing: highlight())
              //const HeadFields()
            ],
          ),
        ),
      ),
    );
  }
}
