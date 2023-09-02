import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/bluti.dart';

import 'package:quotebrowser/BL/locdbsembast/rows2db.dart';
import 'package:quotebrowser/BL/params/params.dart';

import '../../BL/bl.dart';

import '../../DL/dl.dart';

import '../alib/selectiondialogs/selectone.dart';

import '_cardsswiper.dart';

import 'cedit/quoteedit.dart';

// ignore: must_be_immutable
class AddQuote extends StatefulWidget {
  const AddQuote({super.key});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  Map rowMap = {};
  @override
  initState() {
    super.initState();
    rowMap = bl.orm.newRowMap();
  }

  void setstate() {
    setState(() {});
  }

  Future sheetNameSet(BuildContext context) async {
    String sheetName = await selectOne(sheetNames, context);
    if (sheetName.isEmpty) return;

    rowMap['sheetName'] = sheetName;
    rowMap['fileId'] = dataSheetId;
  }

  Card card(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(
        children: [
          ListTile(
            title: QuoteEdit(rowMap, false, setstate),
            leading: Text(rowMap['rowNo']),
          ),
          ListTile(
            tileColor: Colors.white,
            trailing: InkWell(
              child: Text('sheetName: ${rowMap['sheetName']}'),
              onTap: () async {
                await sheetNameSet(context);

                setState(() {});
              },
            ),
          ),
          //----------------------------------------------------last buttons row
          ListTile(
            tileColor: Colors.lightBlue,
            leading: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await saveQuote();
                }),
            title: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  setState(() {
                    rowMap = bl.orm.newRowMap();
                    rowMap['quote'] = '';
                  });
                }),
          ),
        ],
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
    List respData = await dl.httpService.setCell(
        rowMap['sheetName'], rowMap['fileId'], columnName, cellContent, rowNo);
    rowMap['rowNo'] = respData[0].toString();
    respStatus = 'row:${respData[0]}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    if (rowMap['quote'].isEmpty) {
      emptyDialog('Quote /n ${'quote'}');
      return [];
    }

    if (rowMap['sheetName'].isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCell('quote', rowMap['quote'], '');
    rowMap['dateinsert'] = '${blUti.todayStr()}.';
    swiperRowMaps.add(rowMap);
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New quote'),
        ),
        body: card(context));
  }
}
