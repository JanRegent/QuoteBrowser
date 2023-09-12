import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../BL/bl.dart';
import '../alib/alicons.dart';
import 'bedit/quoteedit.dart';
import 'bedit/stars.dart';

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

    expandedCardMain = expandedMainFields();
    expandedWidgets2urls(bl.orm.currentRow.quote.value);
    expandedTags();
    expandedOthers();
  }

  void setstateAattribs() {
    setState(() {});
  }

  Widget favButt() {
    if (!bl.orm.currentRow.cols.contains('favorite')) {
      return const Text('');
    }
    Icon favIcon = const Icon(Icons.favorite_outline);

    if (bl.orm.currentRow.fav.value.isEmpty) {
      favIcon = const Icon(Icons.favorite_outline);
    } else {
      favIcon = const Icon(Icons.favorite);
    }
    return IconButton(
        icon: favIcon,
        onPressed: () async {
          if (bl.orm.currentRow.fav.value.isEmpty) {
            bl.orm.currentRow.fav.value = 'f';
          } else {
            bl.orm.currentRow.fav.value = '';
          }

          await setCellAttr('favorite', bl.orm.currentRow.fav.value,
              bl.orm.currentRow.rowNo.value);
        });
  }

  //------------------------------------------------------------------expand
  List<Widget> expandedCardMain = [];
  List<Widget> expandedCardTags = [];
  List<Widget> expandedCardOthers = [];

  List<Widget> expandedMainFields() {
    expandedCardMain = [];

    expandedCardMain.add(ListTile(
      tileColor: Colors.white,
      leading: ALicons.attrIcons.authorIcon,
      title: Obx(() => Text(bl.orm.currentRow.author.value)),
    ));

    expandedCardMain.add(ListTile(
      tileColor: Colors.white,
      leading: ALicons.attrIcons.bookIcon,
      title: Obx(() => Text(bl.orm.currentRow.book.value)),
    ));
    expandedCardMain.add(ListTile(
      tileColor: Colors.white,
      leading: ALicons.attrIcons.parPageIcon,
      title: Obx(() => Text(bl.orm.currentRow.parPage.value)),
    ));
    expandedCardMain.add(ListTile(
      tileColor: Colors.white,
      leading: favButt(),
      title: RatingStarsPage(setstateAattribs),
    ));

    return expandedCardMain;
  }

  List<Widget> expandedTags() {
    expandedCardTags = [];

    List<String> tags = bl.orm.currentRow.tags.value.split('#');

    for (int i = 0; i < tags.length; i++) {
      expandedCardTags.add(ListTile(title: Text(tags[i])));
    }
    return expandedCardTags;
  }

  List<Widget> expandedOthers() {
    expandedCardOthers = [];

    for (String columnName in bl.orm.currentRow.optionalFields.keys) {
      if (columnName.toString().isEmpty) {
        continue;
      }

      expandedCardOthers.add(ListTile(
        tileColor: Colors.white,
        leading: Text(columnName),
        title: bl.orm.currentRow.optionalFields[columnName]
                .toString()
                .startsWith('https:')
            ? TextButton(
                child: Text(bl.orm.currentRow.optionalFields[columnName]),
                onPressed: () =>
                    _onOpen(bl.orm.currentRow.optionalFields[columnName]))
            : Text(bl.orm.currentRow.optionalFields[columnName]),
      ));
    }

    return expandedCardOthers;
  }

  Future<void> _onOpen(String url) async {
    LinkableElement link = LinkableElement('Link in text', url);
    if (!await launchUrl(Uri.parse(link.url))) {
      //ebugPrint('_onOpen--Could not launch ${link.url}');
    }
  }

  void expandedWidgets2urls(String text) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    for (var match in matches) {
      String url = text.substring(match.start, match.end);
      if (!url.startsWith('http')) continue;
      expandedCardMain.add(
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

  Widget tabs() {
    return DefaultTabController(
      length: 3,
      initialIndex: 1, //refresh 1st page
      child: Scaffold(
        appBar: AppBar(
          leading: const Text(' '),
          bottom: const TabBar(
            tabs: [
              Tab(child: Icon(Icons.headset_rounded)),
              Tab(child: Icon(Icons.tag)),
              Tab(child: Icon(Icons.devices_other)),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MainFields(expandedCardMain),
            TagsTab(expandedCardTags),
            OthersFields(expandedCardOthers)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabs();
  }
}

// ignore: must_be_immutable
class MainFields extends StatelessWidget {
  List<Widget> expandedCardMain;
  MainFields(this.expandedCardMain, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: const Color.fromARGB(255, 122, 203, 243),
        child: ListView.separated(
          itemCount: expandedCardMain.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return expandedCardMain[index];
          },
        ));
  }
}

// ignore: must_be_immutable
class TagsTab extends StatelessWidget {
  List<Widget> expandedCardTags;
  TagsTab(this.expandedCardTags, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ListView.separated(
          itemCount: expandedCardTags.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return expandedCardTags[index];
          },
        ));
  }
}

// ignore: must_be_immutable
class OthersFields extends StatelessWidget {
  List<Widget> expandedCardOthers;
  OthersFields(this.expandedCardOthers, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: const Color.fromARGB(255, 122, 203, 243),
        child: ListView.separated(
          itemCount: expandedCardOthers.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return expandedCardOthers[index];
          },
        ));
  }
}
