import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:expandable/expandable.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../BL/bl.dart';
import '../alib/alicons.dart';
import 'aacommon.dart';

// ignore: must_be_immutable
class QuoteAttribs extends StatefulWidget {
  const QuoteAttribs({super.key});

  @override
  State<QuoteAttribs> createState() => _QuoteAttribsState();
}

class _QuoteAttribsState extends State<QuoteAttribs> {
  @override
  initState() {
    super.initState();

    expandedCard = expandedWidgets1();
    expandedWidgets2urls(rowMapRowView['quote']);
  }

  //------------------------------------------------------------------expand
  List<Widget> expandedCard = [];
  List<Widget> expandedWidgets1() {
    expandedCard = [];

    expandedCard.add(ListTile(
      tileColor: Colors.white,
      leading: ALicons.attrIcons.authorIcon,
      title: Text(rowMapRowView['author']),
    ));

    expandedCard.add(ListTile(
      tileColor: Colors.white,
      leading: ALicons.attrIcons.bookIcon,
      title: Text(rowMapRowView['book']),
    ));

    expandedCard.add(ListTile(
      tileColor: Colors.lime,
      leading: ALicons.attrIcons.tagIcon,
      title: Text(rowMapRowView['tags'].toString().replaceAll(',', ',\n')),
    ));

    for (String columnName in bl.orm.optionalFields) {
      if (rowMapRowView[columnName] == null) continue;
      if (rowMapRowView[columnName].toString().isEmpty) continue;

      expandedCard.add(ListTile(
        tileColor: Colors.white,
        leading: Text(columnName),
        title: rowMapRowView[columnName].toString().startsWith('https:')
            ? TextButton(
                child: Text(rowMapRowView[columnName]),
                onPressed: () => _onOpen(rowMapRowView[columnName]))
            : Text(rowMapRowView[columnName]),
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
      if (!url.startsWith('http')) continue;
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
        color: const Color.fromARGB(255, 122, 203, 243),
        child: ListView.separated(
          itemCount: expandedCard.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return expandedCard[index];
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return card(rowMapRowView);
  }
}
