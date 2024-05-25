// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../2BL_domain/bl.dart';

import 'quotepopup.dart';
import '../inportcomments.dart';

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

  List<Widget> expandedOthersBuild() {
    othersFieldsWidgets = [
      ListTile(
          tileColor: Colors.white,
          leading: TextButton(
              onPressed: () {
                importComments(context);
                setState(() {});
              },
              child: const Text('fileUrl')),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.curRow.fileUrl.value))],
              ),
              onPressed: () => onOpen(bl.curRow.fileUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.curRow.fileUrl.value, 'fileUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('sourceUrl'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.curRow.sourceUrl.value))],
              ),
              onPressed: () => onOpen(bl.curRow.sourceUrl.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.curRow.sourceUrl.value, 'sourceUrl')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('vydal'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.curRow.publisher.value))],
              ),
              onPressed: () => onOpen(bl.curRow.publisher.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.curRow.publisher.value, 'vydal')),
      ListTile(
          tileColor: Colors.white,
          leading: const Text('folder'),
          title: TextButton(
              child: Row(
                children: [Obx(() => Text(bl.curRow.folder.value))],
              ),
              onPressed: () => onOpen(bl.curRow.folder.value)),
          trailing: copyPasteClearPopupMenuButton(
              bl.curRow.sourceUrl.value, 'folder')),
    ];

    for (var i = 0; i < bl.curRow.optionalColumNames.length; i++) {
      String columnName = bl.curRow.optionalColumNames[i];
      if (columnName.toString().isEmpty) continue;
      if (columnName == 'fileUrl') continue;
      if (columnName == 'sourceUrl') continue;
      if (columnName == 'original') continue;
      if (columnName == 'vydal') continue;
      if (columnName == 'folder') continue;
      if (columnName == 'yellowParts') continue;

      if (columnName == 'docUrl' || columnName == 'fileUrl') {
        othersFieldsWidgets.add(ListTile(
            tileColor: Colors.white,
            leading: TextButton(
                onPressed: () {
                  importComments(context);
                  setState(() {});
                },
                child: Text(columnName)),
            title: TextButton(
                child: Row(
                  children: [Obx(() => Text(bl.curRow.fileUrl.value))],
                ),
                onPressed: () => onOpen(bl.curRow.fileUrl.value)),
            trailing: copyPasteClearPopupMenuButton(
                bl.curRow.sourceUrl.value, 'docUrl')));
      } else {
        othersFieldsWidgets.add(
          ListTile(
              tileColor: Colors.white,
              leading: Text(columnName),
              title: Row(children: [
                TextButton(
                    child: Obx(() => Text(bl.curRow.optionalvalues[i].value)),
                    onPressed: () => onOpen(bl.curRow.optionalvalues[i].value))
              ]),
              trailing: copyPasteClearPopupMenuButton(
                bl.curRow.optionalvalues[i].value,
                columnName,
              )),
        );
      }
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Other attributes'),
        ),
        body: othersListview());
  }
}
