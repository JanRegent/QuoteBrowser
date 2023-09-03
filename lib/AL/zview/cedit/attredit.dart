import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../../DL/dl.dart';
import '../../alib/alicons.dart';

import '../aarowMapRowView.dart';
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
          title: Text(rowMapRowView['tags']),
        ),
        ListTile(
          title: QuoteEdit(true, widget.setstateRowView),
          leading: Text(rowMapRowView['rowNo']),
        )
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
    debugPrint('5 pred post');
    List respData = await dl.httpService.setCell(rowMapRowView['sheetName'],
        rowMapRowView['fileId'], columnName, cellContent, rowNo);
    rowMapRowView['rowNo'] = respData[0].toString();
    respStatus = 'row:${respData[0]}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    debugPrint('1post--rowMapRowView[quote]].isEmpty');
    if (rowMapRowView['quote'].isEmpty) {
      emptyDialog('Quote /n ${'quote'}');
      return [];
    }

    if (rowMapRowView['sheetName'].isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCell('quote', rowMapRowView['quote'], '');
    rowMapRowView['dateinsert'] = '${blUti.todayStr()}.';
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return card(context);
  }
}
