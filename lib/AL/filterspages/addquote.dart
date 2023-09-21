import 'package:clipboard/clipboard.dart';
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
            title: InkWell(
              child: Row(
                children: [
                  Obx(() =>
                      Text('sheetName: ${bl.orm.currentRow.sheetName.value}')),
                  // IconButton(
                  //     icon: const Icon(Icons.save),
                  //     onPressed: () async {
                  //       await savenewQuote();
                  //     })
                ],
              ),
              onTap: () async {
                try {
                  await sheetNameSet(context);
                } catch (_) {}

                setState(() {});
              },
            ),
            trailing: bl.orm.currentRow.sheetName.value.toString().isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      await savenewOriginalFromClipboard();
                      setState(() {});
                      // setState(() {
                      //   String sheetNameLast = bl.orm.currentRow.sheetName.value;
                      //   currentRowNew();
                      //   bl.orm.currentRow.sheetName.value = sheetNameLast;
                      //   bl.orm.currentRow.quote.value = '';
                      // });
                    })
                : const Text(' '),
          ),
          //----------------------------------------------------quoteEdit row
          bl.orm.currentRow.quote.value.toString().isNotEmpty
              ? ListTile(
                  title: QuoteEdit(false, setstate),
                  leading: Obx(() => Text(bl.orm.currentRow.rowNo.value)),
                )
              : const Text(' '),

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
  Future savenewOriginalFromClipboard() async {
    setState(() {
      respStatus = 'status:?';
    });

    if (bl.orm.currentRow.sheetName.value.isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCellAppendRow();
    bl.orm.currentRow.quote.value = '';
    bl.orm.currentRow.dateinsert = '${blUti.todayStr()}.';

    await FlutterClipboard.paste().then((value) async {
      String sheetRownoKey = await dl.httpService.setCellDL(
          bl.orm.currentRow.sheetName.value,
          'original',
          value,
          bl.orm.currentRow.rowNo.value);
      await currentRowSet(sheetRownoKey);
    });
    setState(() {});
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
