import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../controllers/selectvalue.dart';
import '../../../widgets/alib/alib.dart';
import '../../../widgets/alib/alicons.dart';
import 'atext/editpage.dart';
import 'atext/tagsyellowlist.dart';
import 'qbarpopup.dart';
import 'setcell.dart';

void selectText(BuildContext context) {
  try {
    bl.orm.currentRow.selectedText.value = quoteEditController.text.substring(
        quoteEditController.selection.baseOffset,
        quoteEditController.selection.extentOffset);
    bl.orm.currentRow.attribNameLast.value = '?';

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
  } catch (_) {
    return;
  }
}

PopupMenuButton personPopup(BuildContext context) {
  List<PopupMenuItem> items = [];
  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.authorIcon,
        onPressed: () => setCellAL('author', context)),
    title: Obx(() => Text(bl.orm.currentRow.author.value)),
    onTap: () async {
      String authorSelected = await authorSelect();
      if (authorSelected.isEmpty) return;
      await bl.orm.currentRow.setCellBL('author', authorSelected);
      currentRowSet(bl.orm.currentRow.rownoKey.value);
    },
  )));
  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.bookIcon,
        onPressed: () => setCellAL('book', context)),
    title: Text(bl.orm.currentRow.book.value),
    onTap: () {},
  )));

  items.add(PopupMenuItem(
      child: ListTile(
    leading: IconButton(
        icon: ALicons.attrIcons.parPageIcon,
        onPressed: () => setCellAL('parPage', context)),
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

PopupMenuButton tagsYellowPopup(
    BuildContext context, VoidCallback quoteSetstate) {
  List<PopupMenuItem> items = [];
  items.add(PopupMenuItem(
    child: ElevatedButton.icon(
        onPressed: () {
          setCellAL('tags', context);
          regpatternMatchMapsIndex = 0;
          editControlerInit();
          quoteSetstate();
        },
        onLongPress: () => emptySelected('tags', context),
        icon: ALicons.attrIcons.tagIcon,
        label: const Text('')),
  ));
  items.add(PopupMenuItem(
      child: ElevatedButton.icon(
          onPressed: () {
            setCellAL('yellowParts', context);
            regpatternMatchMapsIndex = 1;
            editControlerInit();
            quoteSetstate();
          },
          onLongPress: () => emptySelected('yellowParts', context),
          icon: ALicons.attrIcons.yellowPartIcon,
          label: const Text(''))));

  items.add(PopupMenuItem(
      child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            regpatternMatchMapsIndex = 0;
            editControlerInit();
            quoteSetstate();
          },
          child: const Text('hihglight #'))));
  items.add(PopupMenuItem(
      child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            regpatternMatchMapsIndex = 1;
            editControlerInit();
            quoteSetstate();
          },
          child: const Text('hihglight yellow'))));

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

Container buttRow(BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.yellow[100],
          border: Border.all(
            color: bl.orm.currentRow.setCellDLOn ? Colors.red : Colors.white,
            width: 5,
          )),
      child: ListTile(
        leading: personPopup(context),
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPage()),
                );
              },
            ),
            const Spacer(),
            al.infoButton(
                context, 'Selected', bl.orm.currentRow.selectedText.value),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return buttonRowMenu(context);
          },
        ),
      ));
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
