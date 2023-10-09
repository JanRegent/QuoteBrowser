// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../../BL/bl.dart';
import '../aedit/fieldpopup.dart';

class TagsYelowPage extends StatefulWidget {
  final String tagsYellow;
  const TagsYelowPage(this.tagsYellow, {super.key});

  @override
  State<TagsYelowPage> createState() => _TagsYelowPageState();
}

class _TagsYelowPageState extends State<TagsYelowPage> {
  List<Widget> expandedCardTags = [];

  @override
  initState() {
    super.initState();

    expandedTags();
  }

  List<Widget> expandedTags() {
    expandedCardTags = [];
    List<String> items = [];
    if (widget.tagsYellow == 'tags') {
      items = bl.orm.currentRow.tags.value.split('#');
    } else {
      items = bl.orm.currentRow.yellowParts.value.split('__|__\n');
    }

    for (int i = 0; i < items.length; i++) {
      if (items[i].trim().isEmpty) continue;
      expandedCardTags.add(ListTile(
          title: Text(items[i]), trailing: copyPopupMenuButton(items[i])));
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
