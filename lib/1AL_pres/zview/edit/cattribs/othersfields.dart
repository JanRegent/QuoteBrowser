// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/1AL_pres/controllers/alib/alib.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';
import 'package:quotebrowser/3Data/dl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../2BL_domain/bl.dart';
import '../battr/quotepopup.dart';

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
          leading: TextButton(
              onPressed: () => importComments(), child: const Text('fileUrl')),
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
      if (columnName == 'yellowParts') continue;
      if (columnName == 'rownoKey') continue;

      if (columnName == 'docUrl' || columnName == 'fileUrl') {
        othersFieldsWidgets.add(ListTile(
            tileColor: Colors.white,
            leading: TextButton(
                onPressed: () => importComments(), child: Text(columnName)),
            title: TextButton(
                child: Row(
                  children: [Obx(() => Text(bl.orm.currentRow.fileUrl.value))],
                ),
                onPressed: () => _onOpen(bl.orm.currentRow.fileUrl.value)),
            trailing: copyPasteClearPopupMenuButton(
                bl.orm.currentRow.sourceUrl.value, 'docUrl')));
      } else {
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
    }

    return othersFieldsWidgets;
  }

  Future importComments() async {
    String rownoKey =
        '${bl.orm.currentRow.sheetName.value}__|__${bl.orm.currentRow.rowNo}';
    al.showTopSnackBar(context, 'Importing comments at \n\n$rownoKey', 15);

    await dl.httpService.comments2tagsYellowparts(rownoKey);

    await currentRowSet(rownoKey);
    // ignore: use_build_context_synchronously
    al.showTopSnackBar(context, 'Import done at \n\n$rownoKey', 3);
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
