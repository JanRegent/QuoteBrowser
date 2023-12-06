// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../../../BL/bl.dart';
import '../../../BL/bluti.dart';
import '../../alib/searchvalue/searchselectpage.dart';

class WordSearchPage extends StatefulWidget {
  final String tagsYellow;
  const WordSearchPage(this.tagsYellow, {super.key});

  @override
  State<WordSearchPage> createState() => _WordSearchPageState();
}

class _WordSearchPageState extends State<WordSearchPage> {
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
          leading: removeTagOrYellow(index, items), title: Text(items[index])));
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
            child: Column(
              children: [
                IconButton(
                    onPressed: () async {
                      List<String> dateinserts = blUti.lastNdays(10);

                      // ignore: use_build_context_synchronously
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchSelectPage(dateinserts, 'Select date')),
                      );
                    },
                    icon: const Icon(Icons.tag))
              ],
            )));
  }
}
