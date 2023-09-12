import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/bluti.dart';

import '../../../BL/bl.dart';

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

  void setstateAattribs() {
    setState(() {});
  }

  // Widget starsButt() {
  //   if (!bl.orm.currentRow.cols.contains('stars')) {
  //     return const Text('');
  //   }
  //   String stars =
  //       '*************'.substring(0, bl.orm.currentRow.stars.value.length);
  //   if (bl.orm.currentRow.stars.value.isEmpty) {
  //     stars = 'stars';
  //   }
  //   return TextButton(
  //       child: Text(
  //         stars,
  //         style: const TextStyle(fontSize: 25),
  //       ),
  //       onPressed: () {});
  // }

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
    await setCellAttr('quote', bl.orm.currentRow.quote.value, '');
    bl.orm.currentRow.dateinsert = '${blUti.todayStr()}.';
    //update(widget.sheet);
  }

  @override
  Widget build(BuildContext context) {
    return card(context);
  }
}
