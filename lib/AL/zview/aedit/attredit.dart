import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../../BL/bl.dart';

import 'fieldpopup.dart';
import 'quoteedit.dart';

// ignore: must_be_immutable
class AttrEdit extends StatefulWidget {
  VoidCallback swiperSetstate;
  AttrEdit(this.swiperSetstate, {super.key});

  @override
  State<AttrEdit> createState() => _AttrEditState();
}

class _AttrEditState extends State<AttrEdit> {
  @override
  initState() {
    super.initState();
  }

  void attreditSetstate() {
    setState(() {});
  }

  ListTile redorowAL() {
    return ListTile(
        tileColor: Colors.lime,
        leading: Obx(() => Text(attribNameRedo.value)),
        title: Obx(() => Text(attribTitleRedo.value)),
        trailing: attribNameRedo.value.isNotEmpty
            ? redoButton(attreditSetstate)
            : const Text(' '));
  }

  Card card(BuildContext context) {
    List<ListTile> listTilesGet() {
      List<ListTile> listtiles = [
        redorowAL(),
        ListTile(title: QuoteEdit(true, widget.swiperSetstate, context)),
        redorowAL()
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

  String? respStatus = 'status:new';
  Future saveQuote() async {
    setState(() {
      respStatus = 'status:?';
    });

    if (bl.orm.currentRow.quote.isEmpty) {
      emptyDialog('Quote /n ${'quote'}');
      return [];
    }

    if (bl.orm.currentRow.sheetName.isEmpty) {
      emptyDialog('Sheetname');
      return [];
    }
    await setCellBL('quote', bl.orm.currentRow.quote.value);
    bl.orm.currentRow.dateinsert = '${blUti.todayStr()}.';
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return card(context);
  }
}
