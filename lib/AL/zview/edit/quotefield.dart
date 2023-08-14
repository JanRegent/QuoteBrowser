import 'package:flutter/material.dart';

import '../../../BL/sheet/sheet.dart';

// ignore: must_be_immutable
class QuoteField extends StatelessWidget {
  final Sheet sheet;
  Function setstate;
  QuoteField(this.sheet, this.setstate, {super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.text = sheet.quote;
    return TextField(
      controller: _controller,
      maxLines: 10,
      contextMenuBuilder: (context, editableTextState) {
        final TextEditingValue value = editableTextState.textEditingValue;
        String selected = value.selection.textInside(value.text);
        final List<ContextMenuButtonItem> buttonItems =
            editableTextState.contextMenuButtonItems;
        buttonItems.insert(
            0,
            ContextMenuButtonItem(
              label: '______________',
              onPressed: () {},
            ));

        buttonItems.insert(
            0,
            ContextMenuButtonItem(
              label: 'Author',
              onPressed: () {
                ContextMenuController.removeAny();
                if (selected.isEmpty) return;
                sheet.author = selected;
                sheet.save2cloud += 'Author ';
                setstate();
              },
            ));
        buttonItems.insert(
            0,
            ContextMenuButtonItem(
              label: 'Book',
              onPressed: () {
                ContextMenuController.removeAny();
                if (selected.isEmpty) return;
                sheet.book = selected;
                sheet.save2cloud += 'Book ';
                setstate();
              },
            ));
        buttonItems.insert(
            0,
            ContextMenuButtonItem(
              label: 'Tags',
              onPressed: () {
                ContextMenuController.removeAny();
                if (selected.isEmpty) return;
                //Navigator.of(context).push(_showDialog(context));
                sheet.tagsStr += '|$selected';
                sheet.save2cloud += 'tags ';
                setstate();
              },
            ));
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: editableTextState.contextMenuAnchors,
          buttonItems: buttonItems,
        );
      },
    );
  }
}
