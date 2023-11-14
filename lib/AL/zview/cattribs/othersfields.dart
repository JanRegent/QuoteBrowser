// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../BL/bl.dart';
import '../bedit/quotepopup.dart';

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

    expandedOthersBuild();
  }

  Future<void> _onOpen(String url) async {
    LinkableElement link = LinkableElement('Link in text', url);
    if (!await launchUrl(Uri.parse(link.url))) {
      //ebugPrint('_onOpen--Could not launch ${link.url}');
    }
  }

  List<Widget> expandedOthersBuild() {
    othersFieldsWidgets = [
      ListTile(
          tileColor: Colors.white,
          leading: const Text('fileUrl'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.orm.currentRow.fileUrl.value))],
              ),
              onPressed: () => _onOpen(bl.orm.currentRow.fileUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.fileUrl.value, 'fileUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('sourceUrl'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.orm.currentRow.sourceUrl.value))],
              ),
              onPressed: () => _onOpen(bl.orm.currentRow.sourceUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.sourceUrl.value, 'sourceUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('vydal'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.orm.currentRow.publisher.value))],
              ),
              onPressed: () => _onOpen(bl.orm.currentRow.publisher.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.publisher.value, 'vydal')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('folder'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.orm.currentRow.folder.value))],
              ),
              onPressed: () => _onOpen(bl.orm.currentRow.folder.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.sourceUrl.value, 'folder')),
    ];
    for (var i = 0; i < bl.orm.currentRow.optionalColumNames.length; i++) {
      String columnName = bl.orm.currentRow.optionalColumNames[i];
      if (columnName.toString().isEmpty) continue;
      if (columnName == 'fileUrl') continue;
      if (columnName == 'sourceUrl') continue;
      if (columnName == 'original') continue;
      if (columnName == 'vydal') continue;
      if (columnName == 'folder') continue;

      othersFieldsWidgets.add(
        ListTile(
            tileColor: Colors.white,
            leading: Text(columnName),
            title: Row(children: [
              TextButton(
                  child: Obx(
                      () => Text(bl.orm.currentRow.optionalvalues[i].value)),
                  onPressed: () =>
                      _onOpen(bl.orm.currentRow.optionalvalues[i].value))
            ]),
            trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.optionalvalues[i].value,
              columnName,
            )),
      );
    }

    return othersFieldsWidgets;
  }

  Card othersListview() {
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

  @override
  Widget build(BuildContext context) {
    return othersListview();
  }
}