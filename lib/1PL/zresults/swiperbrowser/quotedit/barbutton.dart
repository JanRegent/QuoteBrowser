import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../controllers/selectvalue.dart';
import '../../../widgets/alib/alib.dart';
import '../../../widgets/alib/alicons.dart';
import 'tagsyellowlist.dart';
import 'stars.dart';
import 'barpopup.dart';
import 'setcell.dart';

void selectText(BuildContext context) {
  try {
    bl.orm.currentRow.selectedText.value = quoteEditController.text.substring(
        quoteEditController.selection.baseOffset,
        quoteEditController.selection.extentOffset);

    if (bl.orm.currentRow.selectedText.value.isEmpty) return;
    // print(quoteEditController.selection.baseOffset);
    // print(quoteEditController.selection.extentOffset);
    // print('----');
  } catch (e) {
    return;
  }
  //bl.orm.currentRow.attribNameLast.value = '?';

  try {
    int len = bl.orm.currentRow.selectedText.value.length;
    al.messageInfo(
        context,
        bl.orm.currentRow.selectedText.value.substring(0, 10),
        bl.orm.currentRow.selectedText.value.substring(len - 10, len),
        3);
  } catch (_) {
    al.messageInfo(
        context, 'Selected', bl.orm.currentRow.selectedText.value, 3);
  }
}

PopupMenuButton personPopup(BuildContext context, VoidCallback swiperSetstate) {
  List<PopupMenuItem> items = [];
  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.authorIcon,
        onPressed: () => setCellAL('author', context, swiperSetstate)),
    title: Obx(() => Text(bl.orm.currentRow.author.value)),
    onTap: () async {
      String authorSelected = await authorSelect();
      if (authorSelected.isEmpty) return;
      bl.orm.currentRow.setCellBL('author', authorSelected);
      currentRowSet(bl.orm.currentRow.rowkey.value);
      bl.orm.currentRow.selectedText.value = '';
    },
  )));
  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.bookIcon,
        onPressed: () => setCellAL('book', context, swiperSetstate)),
    title: Obx(() => Text(bl.orm.currentRow.book.value)),
    onTap: () async {
      String bookSelected = await bookSelect(context);
      if (bookSelected.isEmpty) return;
      bl.orm.currentRow.setCellBL('book', bookSelected);
      currentRowSet(bl.orm.currentRow.rowkey.value);
      bl.orm.currentRow.selectedText.value = '';
    },
  )));

  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.parPageIcon,
        onPressed: () => setCellAL('parPage', context, swiperSetstate)),
    title: Text(bl.orm.currentRow.parPage.value),
    onTap: () {},
  )));

  return PopupMenuButton(
    child: ALicons.attrIcons.authorIcon,
    onOpened: () {
      selectText(context);
      if (bl.orm.currentRow.selectedText.value.isEmpty) return;
    },
    itemBuilder: (context) {
      return items;
    },
  );
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

        bl.orm.currentRow.setCellBL('favorite', bl.orm.currentRow.fav.value);
      });
}

PopupMenuButton tagsYellowPopup(BuildContext context,
    VoidCallback quoteSetstate, VoidCallback swiperSetstate) {
  List<PopupMenuItem> items = [];
  items.add(PopupMenuItem(
    child: ListTile(
        leading: ElevatedButton.icon(
            onPressed: () {
              setCellAL('tags', context, swiperSetstate);
              regpatternMatchMapsIndex = 0;
              editControlerInit();
              quoteSetstate();
            },
            onLongPress: () => emptySelected('tags', context),
            icon: ALicons.attrIcons.tagIcon,
            label: const Text('')),
        title: RatingStarsPage(quoteSetstate)),
  ));
  items.add(PopupMenuItem(
      child: ListTile(
    leading: ElevatedButton.icon(
        onPressed: () {
          setCellAL('yellowParts', context, swiperSetstate);
          regpatternMatchMapsIndex = 1;
          editControlerInit();
          quoteSetstate();
        },
        onLongPress: () => emptySelected('yellowParts', context),
        icon: ALicons.attrIcons.yellowPartIcon,
        label: const Text('')),
    title: favButt(),
  )));

  return PopupMenuButton(
    child: ALicons.attrIcons.tagIcon,
    onOpened: () {
      selectText(context);
      if (bl.orm.currentRow.selectedText.value.isEmpty) return;
    },
    itemBuilder: (context) {
      return items;
    },
  );
}

Container buttRow(BuildContext context, VoidCallback swiperSetstate) {
  return Container(
    color: Colors.lightBlue,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(5),
    child: ListTile(
      leading: personPopup(context, swiperSetstate),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return buttonRowMenu(context);
        },
      ),
    ),
  );
}

Future emptySelected(String attribName, BuildContext context) async {
  if (attribName == 'tags') {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TagsYellowPage('tags')),
    );
  }
  if (attribName == 'yellowParts') {
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const TagsYellowPage('yellowparts')),
    );
  }
  editControlerInit();
}
