import 'package:flutter/material.dart';

import '../../BL/bl.dart';
import 'eaddquote.dart';
import 'cedit/attredit.dart';
import 'browviewattribs.dart';
import 'rowviewmenu.dart';
import 'aquoteview.dart';

// ignore: must_be_immutable
class RowViewPage extends StatefulWidget {
  Map rowMap;
  final String title;
  final VoidCallback swiperSetstate;
  RowViewPage(this.rowMap, this.title, this.swiperSetstate, {super.key});

  @override
  State<RowViewPage> createState() => _RowViewPageState();
}

class _RowViewPageState extends State<RowViewPage> {
  @override
  initState() {
    super.initState();
  }

  setstateRowView() {
    setState(() {});
  }

  Widget tabs() {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [rowViewMenu(widget.rowMap, {}, setstateRowView)],
          bottom: TabBar(
            tabs: [
              Tab(text: currentSheet[bl.orm.fields['author']]),
              const Tab(child: Icon(Icons.view_agenda)),
              const Tab(child: Icon(Icons.edit)),
              const Tab(
                text: '##',
              ),
              const Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuoteView(currentSheet),
            QuoteAttribs(currentSheet),
            AttrEdit(widget.rowMap, setstateRowView),
            const Text('##'),
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