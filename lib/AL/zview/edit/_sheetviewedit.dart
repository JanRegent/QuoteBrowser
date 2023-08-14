import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:highlight_text/highlight_text.dart';
import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/sheet/sheet.dart';
import '../../alib/alicons.dart';
import 'attredit.dart';

// ignore: must_be_immutable
class SheetViewPage extends StatefulWidget {
  int locId;
  SheetViewPage(this.locId, {super.key});

  @override
  State<SheetViewPage> createState() => _SheetViewPageState();
}

class _SheetViewPageState extends State<SheetViewPage> {
  @override
  initState() {
    super.initState();
  }

  Sheet currentSheet = Sheet()..quote = '[init]';
  Future<String> getData() async {
    // currentSheet =
    //     await bl.sheetsBL.sheetCRUD.readSheet.readByLocid(widget.locId);
    // currentSheet.tags.addAll(currentSheet.tagsStr.split(','));
    expandedCard = expandedWidgets1();
    expandedWidgets2urls(currentSheet.quote);
    highlightedWordFill();
    return 'ok';
  }

  //------------------------------------------------------------------highlight
  Map<String, HighlightedWord> highlightedWord = {};
  void highlightedWordFill() {
    List<String> tagsStr = currentSheet.tagsStr.split('|');

    highlightedWord = {};
    for (var word in tagsStr) {
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
    highlightedWordFill();
    return TextHighlight(
        text: sheet.quote,
        words: highlightedWord,
        matchCase: false,
        textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ));
  }

  //------------------------------------------------------------------expand
  List<Widget> expandedCard = [];
  List<Widget> expandedWidgets1() {
    expandedCard = [
      ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.author,
        title: Text(currentSheet.author),
      )
    ];
    if (currentSheet.book.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.book,
        title: Text(currentSheet.book),
      ));
    }
    if (currentSheet.tagsStr.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.lime,
        leading: ALicons.attrIcons.tag,
        title: Text(currentSheet.tagsStr),
      ));
    }
    if (currentSheet.category.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.category,
        title: InkWell(
          child: Text(currentSheet.category),
          onTap: () async {},
        ),
      ));
    }
    if (currentSheet.categoryChapterPB.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.lime,
        leading: const Text('PB'),
        title: InkWell(
          child: Text(currentSheet.categoryChapterPB),
          onTap: () async {},
        ),
      ));
    }
    if (currentSheet.folder.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        title: Text(currentSheet.folder),
        leading: const Icon(Icons.folder),
        trailing:
            IconButton(onPressed: () async {}, icon: const Icon(Icons.link)),
      ));
    }

    return expandedCard;
  }

  Future<void> _onOpen(String url) async {
    LinkableElement link = LinkableElement('Link in text', url);
    if (!await launchUrl(Uri.parse(link.url))) {
      debugPrint('_onOpen--Could not launch ${link.url}');
    }
  }

  void expandedWidgets2urls(String text) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    for (var match in matches) {
      String url = text.substring(match.start, match.end);
      expandedCard.add(
        ListTile(
          tileColor: Colors.white,
          title: TextButton(child: Text(url), onPressed: () => _onOpen(url)),
          leading: const Icon(Icons.link),
        ),
      );
    }
  }

  //------------------------------------------------------------------card
  ExpandableController contr = ExpandableController(initialExpanded: true);
  Card card(Sheet sheet) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: Column(children: [
        ListTile(
          title: quoteField(sheet),
          leading: Text(sheet.id.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AttrEdit(sheet)));
              setState(() {});
            },
          ),
        ),
        ExpandablePanel(
          controller: contr,
          header: const Text(' '),
          collapsed: const Text(' '
              // currentSheet.tags.join(','),
              // softWrap: true,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              ),
          expanded: Column(
            children: expandedCard,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getData(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            card(currentSheet);
          } else if (snapshot.hasError) {
            return card(currentSheet);
          } else {
            const Text('Awaiting result...');
          }
          return card(currentSheet);
        });
  }
}
