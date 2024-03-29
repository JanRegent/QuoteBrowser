import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

import 'package:quotebrowser/1PL/zresults/swiperbrowser/edit/battr/stars.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../2BL_domain/bl.dart';
import '../../../../widgets/alib/alicons.dart';

import '../../../../controllers/selectvalue.dart';
import '../battr/quotepopup.dart';

class HeadFields extends StatefulWidget {
  const HeadFields({super.key});

  @override
  State<HeadFields> createState() => _HeadFieldsState();
}

class _HeadFieldsState extends State<HeadFields> {
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
    Icon favIcon = const Icon(Icons.favorite_outline);

    if (bl.orm.currentRow.fav.value == 'f') {
      favIcon = const Icon(Icons.favorite);
    } else {
      favIcon = const Icon(Icons.favorite_outline);
    }
    return IconButton(
        icon: favIcon,
        onPressed: () async {
          if (bl.orm.currentRow.fav.value.isEmpty) {
            bl.orm.currentRow.fav.value = 'f';
          } else {
            bl.orm.currentRow.fav.value = '';
          }

          await bl.orm.currentRow
              .setCellBL('favorite', bl.orm.currentRow.fav.value);
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
      headCard.add(
        ListTile(
          tileColor: Colors.white,
          title: TextButton(child: Text(url), onPressed: () => _onOpen(url)),
          leading: const Icon(Icons.link),
          //trailing: fieldPopupMenu(url, '')
        ),
      );
    }
  }

  List<Widget> headFields() {
    headCard = [];

    headCard.add(ListTile(
        tileColor: Colors.white,
        leading: IconButton(
          icon: ALicons.attrIcons.authorIcon,
          onPressed: () async {
            String authorSelected = await authorSelect();
            if (authorSelected.isEmpty) return;
            await bl.orm.currentRow.setCellBL('author', authorSelected);
            currentRowSet(bl.orm.currentRow.rownoKey.value);
          },
        ),
        title: Obx(() => Text(bl.orm.currentRow.author.value)),
        trailing: copyPasteClearPopupMenuButton(
            bl.orm.currentRow.author.value, 'author')));

    headCard.add(ListTile(
        //
        tileColor: Colors.white,
        leading: IconButton(
          icon: ALicons.attrIcons.bookIcon,
          onPressed: () async {
            String bookSelected = await bookSelect(context);
            if (bookSelected.isEmpty) return;
            await bl.orm.currentRow.setCellBL('book', bookSelected);
            currentRowSet(bl.orm.currentRow.rownoKey.value);
          },
        ),
        title: Obx(() => Text(bl.orm.currentRow.book.value)),
        trailing: copyPasteClearPopupMenuButton(
            bl.orm.currentRow.book.value, 'book')));
    headCard.add(ListTile(
        tileColor: Colors.white,
        leading: ALicons.attrIcons.parPageIcon,
        title: Obx(() => Text(bl.orm.currentRow.parPage.value)),
        trailing: copyPasteClearPopupMenuButton(
            bl.orm.currentRow.parPage.value, 'parPage')));
    headCard.add(ListTile(
        tileColor: Colors.white,
        title: Row(
          children: [favButt(), RatingStarsPage(setstateAattribs)],
        )));

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
