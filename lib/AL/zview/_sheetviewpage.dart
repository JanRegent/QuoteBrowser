import 'package:flutter/material.dart';

import '../../BL/bl.dart';
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const Text(' '),
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(text: currentSheet[bl.orm.fields['author']]),
              const Tab(
                text: 'Atributes',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SheetViewQuote(currentSheet),
            SheetViewFields(currentSheet),
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
