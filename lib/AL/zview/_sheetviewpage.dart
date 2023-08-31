import 'package:flutter/material.dart';

import '../../BL/bl.dart';
import 'edit/addquote.dart';
import 'sheetviewfields.dart';
import 'sheetviewmenu.dart';
import 'sheetviewquote.dart';

// ignore: must_be_immutable
class SheetViewPage extends StatefulWidget {
  Map rowMap;
  final String title;
  SheetViewPage(this.rowMap, this.title, {super.key});

  @override
  State<SheetViewPage> createState() => _SheetViewPageState();
}

class _SheetViewPageState extends State<SheetViewPage> {
  @override
  initState() {
    super.initState();
  }

  setstate() {
    setState(() {});
  }

  Widget tabs() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Text(' '),
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(text: currentSheet[bl.orm.fields['author']]),
              const Tab(text: 'Atributes'),
              const Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SheetViewQuote(currentSheet),
            SheetViewFields(currentSheet),
            const AddQuote()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabs();
  }
}
