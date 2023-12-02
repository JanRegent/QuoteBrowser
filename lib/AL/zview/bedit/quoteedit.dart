import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';

import '../../../BL/orm.dart';

import '../../alib/alicons.dart';

import '../acoloredview/tagsyellowlist.dart';
import 'addquote/addquoterow.dart';
import 'quotepopup.dart';
import 'originalview.dart';

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

  List<PopupMenuItem> buttonRowMenu(BuildContext context) {
    return [
      copyPopupMenuItem(bl.orm.currentRow.quote.value),
      PopupMenuItem(
        value: '/quoteIReplace',
        child: const Text("quote from clipboard Replace"),
        onTap: () async {
          FlutterClipboard.paste().then((value) async {
            await bl.orm.currentRow.setCellBL('quote', value);
          });
        },
      ),
      PopupMenuItem(
        value: '/quoteAppend',
        child: const Text("quote from clipboard Append"),
        onTap: () async {
          FlutterClipboard.paste().then((value) async {
            await bl.orm.currentRow
                .setCellBL('quote', bl.orm.currentRow.quote + '\n\n' + value);
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
            await bl.orm.currentRow.setCellBL(
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
      bl.orm.currentRow.selectedText.value = quoteEditController.text.substring(
          quoteEditController.selection.baseOffset,
          quoteEditController.selection.extentOffset);
      bl.orm.currentRow.attribNameLast.value = '?';
    } catch (_) {
      return;
    }
  }

  void attribSet(String attribName) async {
    if (bl.orm.currentRow.selectedText.value.isEmpty) return;
    bl.orm.currentRow.attribNameLast.value = '';

    setState(() {
      bl.orm.currentRow.setCellDLOn = true;
    });

    switch (attribName) {
      case 'author':
        bl.orm.currentRow.author.value = bl.orm.currentRow.selectedText.value;
        await bl.orm.currentRow
            .setCellBL('author', bl.orm.currentRow.author.value);
        bl.orm.currentRow.attribNameLast.value = attribName;
        break;
      case 'book':
        bl.orm.currentRow.book.value = bl.orm.currentRow.selectedText.value;
        await bl.orm.currentRow.setCellBL('book', bl.orm.currentRow.book.value);
        bl.orm.currentRow.attribNameLast.value = attribName;
        break;
      case 'parPage':
        bl.orm.currentRow.parPage.value;
        bl.orm.currentRow.parPage.value +=
            ' ${bl.orm.currentRow.selectedText.value}';
        await bl.orm.currentRow
            .setCellBL(attribName, bl.orm.currentRow.parPage.value);
        bl.orm.currentRow.attribNameLast.value = attribName;
        break;
      case 'vydal':
        await bl.orm.currentRow
            .setCellBL(attribName, bl.orm.currentRow.selectedText.value);
        break;
      case 'tags':
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        bl.orm.currentRow.tags.value +=
            '#${bl.orm.currentRow.selectedText.value}';
        pureTags();
        await bl.orm.currentRow
            .setCellBL(attribName, bl.orm.currentRow.tags.value);
        bl.orm.currentRow.attribNameLast.value = attribName;
        break;
      case 'yellowParts':
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        bl.orm.currentRow.yellowParts.value +=
            '__|__\n${bl.orm.currentRow.selectedText.value}';
        await bl.orm.currentRow
            .setCellBL(attribName, bl.orm.currentRow.yellowParts.value);
        bl.orm.currentRow.attribNameLast.value = attribName;

        break;
      case 'original':
        await bl.orm.currentRow
            .setCellBL(attribName, bl.orm.currentRow.original.value);
        break;
      case '__othersFields__':
        break;

      default:
        break;
    }
    setState(() {
      bl.orm.currentRow.setCellDLOn = false;
    });
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
        if (bl.orm.currentRow.selectedText.value.isEmpty) return;
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
