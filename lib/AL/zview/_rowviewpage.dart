import 'package:flutter/material.dart';

import '../../BL/bl.dart';
import 'edit/addquote.dart';
import 'edit/attredit.dart';
import 'rowviewatribs.dart';
import 'sheetviewmenu.dart';
import 'rowviewquote.dart';

// ignore: must_be_immutable
class RowViewPage extends StatefulWidget {
  Map rowMap;
  final String title;
  RowViewPage(this.rowMap, this.title, {super.key});

  @override
  State<RowViewPage> createState() => _RowViewPageState();
}

class _RowViewPageState extends State<RowViewPage> {
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
              Tab(
                child: Row(children: [
                  const Icon(Icons.edit_attributes),
                  const Text('          '),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttrEdit(widget.rowMap)));

                      setState(() {});
                    },
                  )
                ]),
              ),
              const Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RowViewQuote(currentSheet),
            RowViewAtribs(currentSheet),
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
