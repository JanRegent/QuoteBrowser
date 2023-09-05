import 'package:flutter/material.dart';

import 'addquote.dart';
import 'bedit/attredit.dart';
import 'aattribs.dart';

import 'zquoteview.dart';
import 'rowviewmenu.dart';

// ignore: must_be_immutable
class RowViewPage extends StatefulWidget {
  final String title;
  final VoidCallback setstateSviper;
  const RowViewPage(this.title, this.setstateSviper, {super.key});

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
      initialIndex: 1, //refresh 1st page
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [rowViewMenu({}, widget.setstateSviper)],
          bottom: const TabBar(
            tabs: [
              Tab(child: Icon(Icons.format_quote)),
              Tab(child: Icon(Icons.view_agenda)),
              Tab(child: Icon(Icons.edit)),
              Tab(
                text: '##',
              ),
              Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const QuoteView(),
            const QuoteAttribs(),
            AttrEdit(setstateRowView),
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
