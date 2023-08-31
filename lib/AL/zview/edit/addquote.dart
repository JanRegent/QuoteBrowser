import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/bluti.dart';

import 'package:quotebrowser/BL/locdbsembast/rows2db.dart';
import 'package:quotebrowser/BL/params/params.dart';

import '../../../BL/bl.dart';

import '../../../DL/dl.dart';

import '../../alib/selectiondialogs/selectone.dart';

import '../_cardsswiper.dart';
import 'attredit.dart';
import 'quotefield.dart';

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
            title: QuoteField(rowMap, false, setstate),
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
                    rowMap[bl.orm.fields['quote']] = '';
                  });
                }),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                if (rowMap['rowNo'].isEmpty) {
                  emptyDialog(
                      'Save new quote before to get rowNo from cloud sheet');
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttrEdit(rowMap)),
                );
              },
            ),
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
    List respData = await dl.httpService.setCell(rowMap['sheetName'],
        rowMap['fileId'], bl.orm.fields[columnName], cellContent, rowNo);
    rowMap['rowNo'] = respData[0].toString();
    respStatus = 'row:${respData[0]}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    if (rowMap[bl.orm.fields['quote']].isEmpty) {
      emptyDialog('Quote /n ${bl.orm.fields['quote']}');
      return [];
    }

    if (rowMap['sheetName'].isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCell('quote', rowMap[bl.orm.fields['quote']], '');
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
