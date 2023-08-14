import 'package:flutter/material.dart';
import 'sheetviewfields.dart';

import '../../BL/sheet/sheetcrud.dart';

import 'sheetviewmenu.dart';
import 'sheetviewquote.dart';

// ignore: must_be_immutable
class SheetViewPage extends StatefulWidget {
  int locId;
  final String title;
  SheetViewPage(this.locId, this.title, {super.key});

  @override
  State<SheetViewPage> createState() => _SheetViewPageState();
}

class _SheetViewPageState extends State<SheetViewPage> {
  @override
  initState() {
    super.initState();
  }

  Future<String> getData() async {
    readByRowIndex2(widget.locId);

    return 'ok';
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
              Tab(text: currentSheet.author),
              const Tab(icon: Icon(Icons.text_fields_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SheetViewQuote(currentSheet),
            //Text(currentSheet.toStrings()),
            SheetViewFields(currentSheet),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getData(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            tabs();
          } else if (snapshot.hasError) {
            return tabs();
          } else {
            const Text('Awaiting result...');
          }
          return tabs();
        });
  }
}
