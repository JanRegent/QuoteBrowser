import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';
import 'quotepopup.dart';

// ignore: must_be_immutable
class OriginalView extends StatefulWidget {
  const OriginalView({super.key});

  @override
  State<OriginalView> createState() => _OriginalViewState();
}

class _OriginalViewState extends State<OriginalView> {
  @override
  initState() {
    super.initState();
  }

  //------------------------------------------------------------------highlight

  TextStyle textStyle = const TextStyle(
    // You can set the general style, like a Text()
    fontSize: 20.0,
    color: Colors.red,
  );

  //------------------------------------------------------------------card

  Card card() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 213, 209, 192),
      child: ListView(children: [
        ListTile(
          tileColor: const Color.fromARGB(255, 232, 216, 142),
          leading: Text(bl.orm.currentRow.dateinsert),
          title: Obx(() => Text('${bl.orm.currentRow.rownoKey}')),
          trailing: copyPasteClearPopupMenuButton(
              bl.orm.currentRow.original.value, 'original'),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Original quote'),
        ),
        body: card());
  }
}
