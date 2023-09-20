import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/AL/zview/aedit/stars.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/bl.dart';
import '../../alib/alicons.dart';
import '../aedit/quoteedit.dart';
import 'cfieldpopup.dart';

class MainFields extends StatefulWidget {
  const MainFields({super.key});

  @override
  State<MainFields> createState() => _MainFieldsState();
}

class _MainFieldsState extends State<MainFields> {
  List<Widget> headCard = [];
  @override
  initState() {
    super.initState();

    headCard = headFields();
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

  Widget categories() {
    if (!bl.orm.currentRow.cols.contains('categories')) {
      return const Text('');
    }
    Icon catIcon = const Icon(Icons.category);

    return ListTile(
        leading: catIcon,
        title: Text(bl.orm.currentRow.categories.value),
        trailing: fieldPopupMenu(bl.orm.currentRow.categories.value));
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
      headCard.add(
        ListTile(
            tileColor: Colors.white,
            title: TextButton(child: Text(url), onPressed: () => _onOpen(url)),
            leading: const Icon(Icons.link),
            trailing: fieldPopupMenu(url)),
      );
    }
  }

  List<Widget> headFields() {
    headCard = [];

    headCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.authorIcon,
        title: Obx(() => Text(bl.orm.currentRow.author.value)),
        trailing: fieldPopupMenu(bl.orm.currentRow.author.value)));

    headCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.bookIcon,
        title: Obx(() => Text(bl.orm.currentRow.book.value)),
        trailing: fieldPopupMenu(bl.orm.currentRow.book.value)));
    headCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.parPageIcon,
        title: Obx(() => Text(bl.orm.currentRow.parPage.value)),
        trailing: fieldPopupMenu(bl.orm.currentRow.parPage.value)));
    headCard.add(ListTile(
      tileColor: Colors.white,
      leading: favButt(),
      title: RatingStarsPage(setstateAattribs),
    ));
    headCard.add(categories());

    return headCard;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: const Color.fromARGB(255, 122, 203, 243),
        child: ListView.separated(
          itemCount: headCard.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return headCard[index];
          },
        ));
  }
}
