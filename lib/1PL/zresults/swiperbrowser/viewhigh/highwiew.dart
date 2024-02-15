import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_highlight_text/tag_highlight_text.dart';

import '../../../../2BL_domain/bl.dart';
import '../edit/battr/originalview.dart';

//-----------------------------------------------------------------highl

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
    bl.highligthOnOff = true;
  }

  String text = bl.orm.currentRow.quote.value;

  void tagsH() {
    List<String> tags = bl.orm.currentRow.tags.split('#');
    text = bl.orm.currentRow.quote.value;
    for (String tag in tags) {
      text = text.replaceAll(tag, '<highlight><bold>$tag</bold></highlight>');
    }
    setState(() {});
  }

  void yellowH() {
    List<String> yellowParts = bl.orm.currentRow.yellowParts.split('__|__');
    text = bl.orm.currentRow.quote.value;
    for (String yellowPart in yellowParts) {
      String yp = yellowPart.trim();
      if (yp.isEmpty) continue;
      text = text.replaceAll(yp, '<yp><bold>$yp</bold></yp>');
    }
    setState(() {});
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
                      IconButton(
                          onPressed: () async {
                            text = bl.orm.currentRow.quote.value;
                            setState(() {});
                          },
                          icon: const Icon(Icons.clear)),
                      IconButton(
                          onPressed: () => tagsH(),
                          icon: const Icon(Icons.tag)),
                      IconButton(
                          onPressed: () => yellowH(),
                          icon: const Icon(Icons.circle, color: Colors.yellow)),
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
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1),
                        topRight: Radius.circular(1)),
                    side: BorderSide(width: 1, color: Colors.green)),
                child: TagHighlightText(
                  text: text,
                  highlightBuilder: (tagName) {
                    switch (tagName) {
                      case 'highlight':
                        return HighlightData(
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        );
                      case 'bold':
                        return HighlightData(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      case 'link':
                        return HighlightData(
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          onTap: (text) {
                            debugPrint('Click $text');
                          },
                        );
                      case 'yp':
                        return HighlightData(
                          style: const TextStyle(
                            backgroundColor: Colors.yellow,
                            decoration: TextDecoration.underline,
                          ),
                          onTap: (text) {},
                        );
                    }
                    return null;
                  },
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
