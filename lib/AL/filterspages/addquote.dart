import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../BL/bl.dart';

import '../../BL/orm.dart';
import '../../DL/dl.dart';

import '../alib/selectiondialogs/selectone.dart';
import '../zview/aedit/quoteedit.dart';

// ignore: must_be_immutable
class AddQuote extends StatefulWidget {
  List<String> sheetNames = [];
  AddQuote(this.sheetNames, {super.key});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  @override
  initState() {
    super.initState();

    currentRowNew();
  }

  void setstate() {
    setState(() {});
  }

  Future sheetNameSet(BuildContext context) async {
    String sheetName = await selectOne(widget.sheetNames, context);
    if (sheetName.isEmpty) return;

    bl.orm.currentRow.sheetName.value = sheetName;
  }

  Card card(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: SingleChildScrollView(
          child: Column(
        children: [
          //----------------------------------------------------------sheetRow
          ListTile(
            tileColor: Colors.white,
            leading: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  setState(() {
                    String sheetNameLast = bl.orm.currentRow.sheetName.value;
                    currentRowNew();
                    bl.orm.currentRow.sheetName.value = sheetNameLast;
                    bl.orm.currentRow.quote.value = '';
                  });
                }),
            title: InkWell(
              child: Obx(() =>
                  Text('sheetName: ${bl.orm.currentRow.sheetName.value}')),
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
          //----------------------------------------------------quoteEdit row
          ListTile(
            title: QuoteEdit(false, setstate),
            leading: Obx(() => Text(bl.orm.currentRow.rowNo.value)),
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

  Future setCellAppendRow() async {
    String sheetRownoKey = await dl.httpService
        .setCellDL(bl.orm.currentRow.sheetName.value, 'quote', '?', '');
    bl.orm.currentRow.rowNo.value = sheetRownoKey.split('__|__')[1];

    respStatus = 'row:${bl.orm.currentRow.rowNo.value}';
    setState(() {});
  }

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });
    // if (bl.orm.currentRow.quote.value.isEmpty) {
    //   emptyDialog('Quote /n ${'quote'}');
    //   return [];
    // }

    if (bl.orm.currentRow.sheetName.value.isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCellAppendRow();
    bl.orm.currentRow.dateinsert = '${blUti.todayStr()}.';

    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add quote"),
        ),
        body: card(context));
  }
}
