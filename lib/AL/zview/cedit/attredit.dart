import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../../BL/bl.dart';
import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

import 'quoteedit.dart';

// ignore: must_be_immutable
class AttrEdit extends StatefulWidget {
  VoidCallback setstateRowView;
  AttrEdit(this.setstateRowView, {super.key});

  @override
  State<AttrEdit> createState() => _AttrEditState();
}

class _AttrEditState extends State<AttrEdit> {
  @override
  initState() {
    super.initState();
  }

  Card card(BuildContext context) {
    List<ListTile> listTilesGet() {
      List<ListTile> listtiles = [
        ListTile(
          tileColor: Colors.lime,
          leading: ALicons.attrIcons.tagIcon,
          title: Obx(() => Text(bl.orm.currentRow.tags.value)),
        ),
        ListTile(title: QuoteEdit(true, widget.setstateRowView))
      ];

      return listtiles;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(
        children: listTilesGet(),
      ),
    );
  }

  void emptyDialog(String fieldName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Field empty"),
          content: Text("$fieldName is empty"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future setCell(String columnName, String cellContent, String rowNo) async {
    debugPrint('setCell $columnName $rowNo');
    List respData = await dl.httpService.setCell(
        bl.orm.currentRow.sheetName.value,
        bl.orm.currentRow.fileId,
        columnName,
        cellContent,
        rowNo);
    bl.orm.currentRow.rowNo.value = respData[0].toString();
    respStatus = 'row:${respData[0]}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    debugPrint('1post--rowMapRowView[quote]].isEmpty');
    if (bl.orm.currentRow.quote.isEmpty) {
      emptyDialog('Quote /n ${'quote'}');
      return [];
    }

    if (bl.orm.currentRow.sheetName.isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCell('quote', bl.orm.currentRow.quote.value, '');
    bl.orm.currentRow.dateinsert = '${blUti.todayStr()}.';
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return card(context);
  }
}
