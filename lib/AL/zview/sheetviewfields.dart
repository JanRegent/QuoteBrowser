import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../alib/alicons.dart';
import 'edit/attredit.dart';

// ignore: must_be_immutable
class SheetViewFields extends StatefulWidget {
  Map rowMap;
  SheetViewFields(this.rowMap, {super.key});

  @override
  State<SheetViewFields> createState() => _SheetViewFieldsState();
}

class _SheetViewFieldsState extends State<SheetViewFields> {
  @override
  initState() {
    super.initState();

    expandedCard = expandedWidgets1();
    expandedWidgets2urls(widget.rowMap['citat']);
  }

  //------------------------------------------------------------------expand
  List<Widget> expandedCard = [];
  List<Widget> expandedWidgets1() {
    expandedCard = [
      ListTile(
          tileColor: Colors.white,
          leading: ALicons.attrIcons.authorIcon,
          title: Text(widget.rowMap['autor']),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttrEdit(widget.rowMap)));

              setState(() {});
            },
          ))
    ];
    if (widget.rowMap['kniha'].isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.bookIcon,
        title: Text(widget.rowMap['kniha']),
      ));
    }
    if (widget.rowMap['tags'].isNotEmpty) {
      expandedCard.add(ListTile(
        tileColor: Colors.lime,
        leading: ALicons.attrIcons.tagIcon,
        title: Text(widget.rowMap['tags']),
      ));
    }
    try {
      if (widget.rowMap['category'].isNotEmpty) {
        expandedCard.add(ListTile(
          tileColor: Colors.white,
          leading: ALicons.attrIcons.categoryIcon,
          title: InkWell(
            child: Text(widget.rowMap['category']),
            onTap: () async {},
          ),
        ));
      }
    } catch (_) {}
    try {
      if (widget.rowMap['categoryChapterPB'].isNotEmpty) {
        expandedCard.add(ListTile(
          tileColor: Colors.lime,
          leading: const Text('PB'),
          title: InkWell(
            child: Text(widget.rowMap['categoryChapterPB']),
            onTap: () async {},
          ),
        ));
      }
    } catch (_) {}
    try {
      if (widget.rowMap['folder'].isNotEmpty) {
        expandedCard.add(ListTile(
          tileColor: Colors.white,
          title: Text(widget.rowMap['folder']),
          leading: const Icon(Icons.folder),
          trailing:
              IconButton(onPressed: () async {}, icon: const Icon(Icons.link)),
        ));
      }
    } catch (_) {}

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
  Card card(Map rowMap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(children: expandedCard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return card(widget.rowMap);
  }
}
