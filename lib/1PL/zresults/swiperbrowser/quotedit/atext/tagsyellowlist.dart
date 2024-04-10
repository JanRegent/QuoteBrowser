// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../../../../2BL_domain/bl.dart';
import '../battr/quotepopup.dart';

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
            bl.orm.currentRow.tags.value = items.join('#');
            await bl.orm.currentRow
                .setCellBL('tags', bl.orm.currentRow.tags.value);
          } else {
            bl.orm.currentRow.yellowParts.value = items.join('__|__\n');
            await bl.orm.currentRow
                .setCellBL('yellowParts', bl.orm.currentRow.yellowParts.value);
          }
        },
        icon: const Icon(Icons.delete));
  }

  List<Widget> expandedTags() {
    expandedCardTags = [];
    List<String> items = [];
    if (widget.tagsYellow == 'tags') {
      items = bl.orm.currentRow.tags.value.split('#');
    } else {
      items = bl.orm.currentRow.yellowParts.value.split('__|__\n');
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
