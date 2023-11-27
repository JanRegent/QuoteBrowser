import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';

import '../../../BL/orm.dart';

import '../../../DL/dl.dart';

import '../../alib/alicons.dart';

import '../acoloredview/tagsyellowlist.dart';
import 'addquote/addquoterow.dart';
import 'quotepopup.dart';
import 'originalview.dart';

Future setCellBL(String columnName, String cellContent) async {
  if (columnName.isEmpty) return;
  if (bl.orm.currentRow.sheetName.value.isEmpty) return;
  try {
    String sheetRownokey = await dl.httpService.setCellDL(
        bl.orm.currentRow.sheetName.value,
        columnName,
        cellContent,
        bl.orm.currentRow.rowNo.value);
    if (sheetRownokey.isNotEmpty) {
      await currentRowSet(sheetRownokey);
    }
  } catch (e) {
    debugPrint('setCellBL( \n$e');
  }
}

// ignore: must_be_immutable
class QuoteEdit extends StatefulWidget {
  VoidCallback swiperSetstate;
  VoidCallback attreditSetstate;
  BuildContext context;
  // ignore: use_key_in_widget_constructors
  QuoteEdit(this.swiperSetstate, this.attreditSetstate, this.context,
      {Key? key})
      : super(key: key);

  @override
  State<QuoteEdit> createState() => _QuoteEditState();
}

class _QuoteEditState extends State<QuoteEdit> {
  late BuildContext originalContext = widget.context;
  RxString selected = ''.obs;
  List<PopupMenuItem> buttonRowMenu(BuildContext context) {
    return [
      copyPopupMenuItem(bl.orm.currentRow.quote.value),
      PopupMenuItem(
        value: '/quoteIReplace',
        child: const Text("quote from clipboard Replace"),
        onTap: () async {
          FlutterClipboard.paste().then((value) async {
            await setCellBL('quote', value);
          });
        },
      ),
      PopupMenuItem(
        value: '/quoteAppend',
        child: const Text("quote from clipboard Append"),
        onTap: () async {
          FlutterClipboard.paste().then((value) async {
            await setCellBL('quote', bl.orm.currentRow.quote + '\n\n' + value);
          });
        },
      ),
      PopupMenuItem(
        value: '/OriginalView',
        child: const Text("Original View"),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OriginalView()),
          );
        },
      ),
      PopupMenuItem(
        value: '/__toRead__',
        child: const Text("__toRead__ remove"),
        onTap: () async {
          try {
            await setCellBL(
                'dateinsert',
                bl.orm.currentRow.dateinsert
                    .toString()
                    .replaceAll('__toRead__', ''));
          } catch (_) {}
        },
      )
    ];
  }

  Future emptySelected(String attribName) async {
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
  }

  void selectedSet() {
    try {
      selected.value = quoteEditController.text.substring(
          quoteEditController.selection.baseOffset,
          quoteEditController.selection.extentOffset);
      attribTitleRedo.value = selected.value;
      attribNameRedo.value = '?';
    } catch (_) {
      return;
    }
  }

  void attribSet(String attribName) async {
    if (selected.value.isEmpty) return;
    attribNameRedo.value = '';
    bl.orm.currentRow.setCellDLOn = true;

    switch (attribName) {
      case 'author':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.author.value;
        bl.orm.currentRow.author.value = selected.value;
        await setCellBL('author', bl.orm.currentRow.author.value);
        attribNameRedo.value = attribName;
        break;
      case 'book':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.book.value;
        bl.orm.currentRow.book.value = selected.value;
        await setCellBL('book', bl.orm.currentRow.book.value);
        attribNameRedo.value = attribName;
        break;
      case 'parPage':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.parPage.value;
        bl.orm.currentRow.parPage.value += ' ${selected.value}';
        await setCellBL(attribName, bl.orm.currentRow.parPage.value);
        attribNameRedo.value = attribName;
        break;
      case 'vydal':
        attribTitleRedo.value = selected.value;
        await setCellBL(attribName, selected.value);
        break;
      case 'tags':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.tags.value;
        bl.orm.currentRow.tags.value += '#${selected.value}';
        pureTags();
        await setCellBL(attribName, bl.orm.currentRow.tags.value);
        attribNameRedo.value = attribName;
        break;
      case 'yellowParts':
        attribTitleRedo.value = selected.value;
        attribPrevRedo.value = bl.orm.currentRow.yellowParts.value;
        bl.orm.currentRow.yellowParts.value += '__|__\n${selected.value}';
        await setCellBL(attribName, bl.orm.currentRow.yellowParts.value);
        attribNameRedo.value = attribName;

        break;
      case 'original':
        await setCellBL(attribName, bl.orm.currentRow.original.value);
        break;
      case '__othersFields__':
        break;

      default:
        break;
    }
    bl.orm.currentRow.setCellDLOn = false;

    //error might indicate a memory leak if setState() is being called because another object is retaining a reference to this State object after it has been removed from the tree. To avoid memory leaks, consider breaking the reference to this object during dispose().
    widget.swiperSetstate();
    widget.attreditSetstate(); //quote content refresh
  }

  PopupMenuButton personPopup() {
    List<PopupMenuItem> items = [];
    items.add(PopupMenuItem(
      child: ALicons.attrIcons.authorIcon,
      onTap: () => attribSet('author'),
    ));
    items.add(PopupMenuItem(
      child: ALicons.attrIcons.bookIcon,
      onTap: () => attribSet('book'),
    ));
    items.add(PopupMenuItem(
      child: ALicons.attrIcons.parPageIcon,
      onTap: () => attribSet('parPage'),
    ));
    return PopupMenuButton(
      child: ALicons.attrIcons.authorIcon,
      onOpened: () {
        selectedSet();
        if (selected.value.isEmpty) return;
      },
      itemBuilder: (context) {
        return items;
      },
    );
  }

  PopupMenuButton tagsYellowPopup() {
    List<PopupMenuItem> items = [];
    items.add(PopupMenuItem(
      child: ElevatedButton.icon(
          onPressed: () => attribSet('tags'),
          onLongPress: () => emptySelected('tags'),
          icon: ALicons.attrIcons.tagIcon,
          label: const Text('')),
    ));
    items.add(PopupMenuItem(
        child: ElevatedButton.icon(
            onPressed: () => attribSet('yellowParts'),
            onLongPress: () => emptySelected('yellowParts'),
            icon: ALicons.attrIcons.yellowPartIcon,
            label: const Text(''))));

    return PopupMenuButton(
      child: ALicons.attrIcons.tagIcon,
      onOpened: () {
        selectedSet();
        if (selected.value.isEmpty) return;
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
        child: Row(
          children: [
            personPopup(),
            tagsYellowPopup(),
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return buttonRowMenu(context);
              },
            )
          ],
        ));
  }

  String onEdit = '';

  TextField quoteTextField() {
    return TextField(
      controller: quoteEditController,
      readOnly: true,
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
      maxLines: 20,
      onChanged: (value) async {
        bl.orm.currentRow.quote.value = value;
      },
    );
  }

  @override //printSelectedText()
  Widget build(BuildContext context) {
    List<Widget> colItems = [
      buttRow(context),
      const Text('  '),
      quoteTextField(),
      buttRow(context)
    ];
    if (currentSS.addQuoteMode) {
      colItems.insert(0, addQuoteRow(context, widget.swiperSetstate));
    }

    return Column(children: colItems);
  }
}
