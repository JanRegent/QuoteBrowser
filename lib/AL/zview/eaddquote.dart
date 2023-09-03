import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/bluti.dart';

import 'package:quotebrowser/BL/locdbsembast/rows2db.dart';
import 'package:quotebrowser/BL/params/params.dart';

import '../../BL/bl.dart';

import '../../DL/dl.dart';

import '../alib/selectiondialogs/selectone.dart';

import '_cardsswiper.dart';

import 'aarowmaprowview.dart';
import 'cedit/quoteedit.dart';

// ignore: must_be_immutable
class AddQuote extends StatefulWidget {
  const AddQuote({super.key});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  @override
  initState() {
    super.initState();
    rowMapRowView = bl.orm.newRowMap();
  }

  void setstate() {
    setState(() {});
  }

  Future sheetNameSet(BuildContext context) async {
    String sheetName = await selectOne(sheetNames, context);
    if (sheetName.isEmpty) return;

    rowMapRowView['sheetName'] = sheetName;
    rowMapRowView['fileId'] = dataSheetId;
  }

  Card card(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            tileColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  setState(() {
                    rowMapRowView = bl.orm.newRowMap();
                    rowMapRowView['quote'] = '';
                  });
                }),
            title: InkWell(
              child: Text('sheetName: ${rowMapRowView['sheetName']}'),
              onTap: () async {
                await sheetNameSet(context);

                setState(() {});
              },
            ),
            trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await saveQuote();
                }),
          ),

          ListTile(
            title: QuoteEdit(false, setstate),
            leading: Text(rowMapRowView['rowNo']),
          ),

          //----------------------------------------------------last buttons row
        ],
      )),
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
    swiperRowMaps.add(rowMapRowView);
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return card(context);
  }
}
