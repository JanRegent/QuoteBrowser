import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../BL/sheet/sheet.dart';
import '../alib/alicons.dart';
import 'edit/attredit.dart';

// ignore: must_be_immutable
class SheetViewFields extends StatefulWidget {
  Sheet sheet;
  SheetViewFields(this.sheet, {super.key});

  @override
  State<SheetViewFields> createState() => _SheetViewFieldsState();
}

class _SheetViewFieldsState extends State<SheetViewFields> {
  @override
  initState() {
    super.initState();

    expandedCard = expandedWidgets1();
    expandedWidgets2urls(widget.sheet.quote);
  }

  //------------------------------------------------------------------expand
  List<Widget> expandedCard = [];
  List<Widget> expandedWidgets1() {
    expandedCard = [
      ListTile(
          tileColor: Colors.white,
          leading: ALicons.attrIcons.author,
          title: Text(widget.sheet.author),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttrEdit(widget.sheet)));

              setState(() {});
            },
          ))
    ];
    if (widget.sheet.book.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.book,
        title: Text(widget.sheet.book),
      ));
    }
    if (widget.sheet.tagsStr.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.lime,
        leading: ALicons.attrIcons.tag,
        title: Text(widget.sheet.tagsStr),
      ));
    }
    if (widget.sheet.category.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.category,
        title: InkWell(
          child: Text(widget.sheet.category),
          onTap: () async {},
        ),
      ));
    }
    if (widget.sheet.categoryChapterPB.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.lime,
        leading: const Text('PB'),
        title: InkWell(
          child: Text(widget.sheet.categoryChapterPB),
          onTap: () async {},
        ),
      ));
    }
    if (widget.sheet.folder.isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        title: Text(widget.sheet.folder),
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
      child: ListView(children: expandedCard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return card(widget.sheet);
  }
}
