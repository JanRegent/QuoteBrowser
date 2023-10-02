// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/bl.dart';
import '../aedit/fieldpopup.dart';

class OthersFields extends StatefulWidget {
  const OthersFields({super.key});

  @override
  State<OthersFields> createState() => _OthersFieldsState();
}

class _OthersFieldsState extends State<OthersFields> {
  List<Widget> othersFieldsWidgets = [];

  @override
  initState() {
    super.initState();

    expandedOthers();
  }

  Future<void> _onOpen(String url) async {
    LinkableElement link = LinkableElement('Link in text', url);
    if (!await launchUrl(Uri.parse(link.url))) {
      //ebugPrint('_onOpen--Could not launch ${link.url}');
    }
  }

  List<Widget> expandedOthers() {
    othersFieldsWidgets = [
      ListTile(
          tileColor: Colors.white,
          leading: const Text('fileUrl'),
          title: TextButton(
              child: Obx(() => Text(bl.orm.currentRow.fileUrl.value)),
              onPressed: () => _onOpen(bl.orm.currentRow.fileUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.fileUrl.value, 'fileUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('sourceUrl'),
          title: TextButton(
              child: Obx(() => Text(bl.orm.currentRow.sourceUrl.value)),
              onPressed: () => _onOpen(bl.orm.currentRow.sourceUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.sourceUrl.value, 'sourceUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('original'),
          title: TextButton(
              child: Obx(() => Text(bl.orm.currentRow.original.value)),
              onPressed: () {}),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.original.value, 'original'))
    ];

    for (String columnName in bl.orm.currentRow.optionalFields.keys) {
      if (columnName.toString().isEmpty) continue;
      if (columnName == 'fileUrl') continue;
      if (columnName == 'sourceUrl') continue;
      if (columnName == 'original') continue;

      othersFieldsWidgets.add(
        ListTile(
            tileColor: Colors.white,
            leading: Text(columnName),
            title: bl.orm.currentRow.optionalFields[columnName]
                    .toString()
                    .startsWith('https:')
                ? TextButton(
                    child: Text(bl.orm.currentRow.optionalFields[columnName]),
                    onPressed: () =>
                        _onOpen(bl.orm.currentRow.optionalFields[columnName]))
                : Text(bl.orm.currentRow.optionalFields[columnName]),
            trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.optionalFields[columnName],
              columnName,
            )),
      );
    }

    return othersFieldsWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: const Color.fromARGB(255, 122, 203, 243),
        child: ListView.separated(
          itemCount: othersFieldsWidgets.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return othersFieldsWidgets[index];
          },
        ));
  }
}
