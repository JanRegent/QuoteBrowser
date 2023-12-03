import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/AL/alib/alicons.dart';
import 'package:quotebrowser/AL/zview/beditattr/stars.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/bl.dart';
import 'beditattr/quotepopup.dart';

class UserHeadFields extends StatefulWidget {
  const UserHeadFields({super.key});

  @override
  State<UserHeadFields> createState() => _UserHeadFieldsState();
}

class _UserHeadFieldsState extends State<UserHeadFields> {
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
          onPressed: () async {},
        ),
        title: Obx(() => Text(bl.orm.currentRow.author.value)),
        trailing: copyPasteClearPopupMenuButton(
            bl.orm.currentRow.author.value, 'author')));

    headCard.add(ListTile(
        //
        tileColor: Colors.white,
        leading: IconButton(
          icon: ALicons.attrIcons.bookIcon,
          onPressed: () async {},
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
      leading: favButt(),
      title: RatingStarsPage(setstateAattribs),
    ));

    return headCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Head fields'),
        //actions: [rowViewMenu({}, widget.setStateSwiper)],
      ),
      body: Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          color: const Color.fromARGB(255, 122, 203, 243),
          child: ListView.separated(
            itemCount: headCard.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return headCard[index];
            },
          )),
    );
  }
}
