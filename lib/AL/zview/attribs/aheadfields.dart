import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/AL/zview/bedit/stars.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/bl.dart';
import '../../alib/alicons.dart';
import '../bedit/quoteedit.dart';

class MainFields extends StatefulWidget {
  const MainFields({super.key});

  @override
  State<MainFields> createState() => _MainFieldsState();
}

class _MainFieldsState extends State<MainFields> {
  List<Widget> expandedCardMain = [];
  @override
  initState() {
    super.initState();

    expandedCardMain = expandedMainFields();
    expandedWidgets2urls(bl.orm.currentRow.quote.value);
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
