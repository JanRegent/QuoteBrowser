import 'package:flutter/material.dart';

import 'acommonrowmap.dart';
import 'eaddquote.dart';
import 'cedit/attredit.dart';
import 'battribs.dart';
import 'rowviewmenu.dart';
import 'aquoteview.dart';

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
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [rowViewMenu(rowMapRowView, {}, setstateRowView)],
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
