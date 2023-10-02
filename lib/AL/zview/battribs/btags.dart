// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../../BL/bl.dart';
import '../aedit/fieldpopup.dart';

class TagsTab extends StatefulWidget {
  const TagsTab({super.key});

  @override
  State<TagsTab> createState() => _TagsTabState();
}

class _TagsTabState extends State<TagsTab> {
  List<Widget> expandedCardTags = [];

  @override
  initState() {
    super.initState();

    expandedTags();
  }

  List<Widget> expandedTags() {
    expandedCardTags = [];

    List<String> tags = bl.orm.currentRow.tags.value.split('#');

    for (int i = 0; i < tags.length; i++) {
      expandedCardTags.add(ListTile(
          title: Text(tags[i]), trailing: copyPopupMenuButton(tags[i])));
    }
    return expandedCardTags;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ListView.separated(
          itemCount: expandedCardTags.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return expandedCardTags[index];
          },
        ));
  }
}
