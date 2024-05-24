// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';
import 'quotepopup.dart';

class TagsYellowPage extends StatefulWidget {
  final String tagsYellow;
  const TagsYellowPage(this.tagsYellow, {super.key});

  @override
  State<TagsYellowPage> createState() => _TagsYellowPageState();
}

class _TagsYellowPageState extends State<TagsYellowPage> {
  List<Widget> expandedCardTags = [];

  @override
  initState() {
    super.initState();

    expandedTags();
  }

  IconButton removeTagOrYellow(int index, List<String> items) {
    return IconButton(
        onPressed: () async {
          items.removeAt(index);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          if (widget.tagsYellow == 'tags') {
            bl.curRow.tags.value = items.join('#');
            bl.curRow.setCellBL('tags', bl.curRow.tags.value);
          } else {
            bl.curRow.yellowparts.value = items.join('__|__\n');
            bl.curRow.setCellBL('yellowParts', bl.curRow.yellowparts.value);
          }
        },
        icon: const Icon(Icons.delete));
  }

  List<Widget> expandedTags() {
    expandedCardTags = [];
    List<String> items = [];
    if (widget.tagsYellow == 'tags') {
      items = bl.curRow.tags.value.split('#');
    } else {
      items = bl.curRow.yellowparts.value.split('__|__\n');
    }

    for (int index = 0; index < items.length; index++) {
      if (items[index].trim().isEmpty) continue;
      expandedCardTags.add(ListTile(
          leading: removeTagOrYellow(index, items),
          title: Text(items[index]),
          trailing: copyPopupMenuButton(items[index])));
    }
    return expandedCardTags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.tagsYellow == 'tags'
              ? const Text('#')
              : const Text('Yellow parts'),
        ),
        body: Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListView.separated(
              itemCount: expandedCardTags.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.blue),
              itemBuilder: (BuildContext context, int index) {
                return expandedCardTags[index];
              },
            )));
  }
}
