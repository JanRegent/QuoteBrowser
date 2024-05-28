import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../2BL_domain/bl.dart';
import '../../../../../2BL_domain/currow.dart';
import '../../../../controllers/selectvalue.dart';
import '../../../../widgets/alib/alib.dart';
import '../../../../widgets/alib/alicons.dart';
import '../tagsyellowlist.dart';
import 'stars.dart';
import 'barpopup.dart';
import '../setcell.dart';

void selectText(BuildContext context) {
  try {
    bl.curRow.selectedText.value = quoteEditController.text.substring(
        quoteEditController.selection.baseOffset,
        quoteEditController.selection.extentOffset);

    if (bl.curRow.selectedText.value.isEmpty) return;
    // print(quoteEditController.selection.baseOffset);
    // print(quoteEditController.selection.extentOffset);
    // print('----');
  } catch (e) {
    return;
  }
  //bl.curRow.attribNameLast.value = '?';

  try {
    int len = bl.curRow.selectedText.value.length;
    al.messageInfo(context, bl.curRow.selectedText.value.substring(0, 10),
        bl.curRow.selectedText.value.substring(len - 10, len), 3);
  } catch (_) {
    al.messageInfo(context, 'Selected', bl.curRow.selectedText.value, 3);
  }
}

PopupMenuButton personPopup(BuildContext context, VoidCallback swiperSetstate) {
  List<PopupMenuItem> items = [];
  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.authorIcon,
        onPressed: () => setCellAL('author', context, swiperSetstate)),
    title: Obx(() => Text(bl.curRow.author.value)),
    onTap: () async {
      String authorSelected = await authorSelect();
      if (authorSelected.isEmpty) return;
      bl.curRow.setCellBL('author', authorSelected);
      bl.curRow.getRow(bl.curRow.rowkey.value);
      bl.curRow.selectedText.value = '';
    },
  )));
  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.bookIcon,
        onPressed: () => setCellAL('book', context, swiperSetstate)),
    title: Obx(() => Text(bl.curRow.book.value)),
    onTap: () async {
      String bookSelected = await bookSelect(context, bl.curRow.author.value);
      if (bookSelected.isEmpty) return;
      bl.curRow.setCellBL('book', bookSelected);
      bl.curRow.getRow(bl.curRow.rowkey.value);
      bl.curRow.selectedText.value = '';
    },
  )));

  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.parpageIcon,
        onPressed: () => setCellAL('parPage', context, swiperSetstate)),
    title: Obx(() => Text(bl.curRow.parpage.value)),
    onTap: () {},
  )));

  return PopupMenuButton(
    child: ALicons.attrIcons.authorIcon,
    onOpened: () {
      selectText(context);
      if (bl.curRow.selectedText.value.isEmpty) return;
    },
    itemBuilder: (context) {
      return items;
    },
  );
}

Widget favButt() {
  Icon favIcon = const Icon(Icons.favorite_outline);

  if (bl.curRow.fav.value == 'f') {
    favIcon = const Icon(Icons.favorite);
  } else {
    favIcon = const Icon(Icons.favorite_outline);
  }
  return IconButton(
      icon: favIcon,
      onPressed: () async {
        if (bl.curRow.fav.value.isEmpty) {
          bl.curRow.fav.value = 'f';
        } else {
          bl.curRow.fav.value = '';
        }

        bl.curRow.setCellBL('favorite', bl.curRow.fav.value);
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
      if (bl.curRow.selectedText.value.isEmpty) return;
    },
    itemBuilder: (context) {
      return items;
    },
  );
}

Container editorspopup(BuildContext context, VoidCallback swiperSetstate) {
  return Container(
    margin: const EdgeInsets.all(15.0),
    padding: const EdgeInsets.all(3.0),
    decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 143, 203, 246))),
    child: ListTile(
      leading: personPopup(context, swiperSetstate),
      title: Obx(() => Text(bl.curRow.stars.value)),
      subtitle: Obx(() => Text(bl.curRow.fav.value)),
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
