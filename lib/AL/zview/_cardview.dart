import 'package:flutter/material.dart';

import 'addquote.dart';
import 'bedit/attredit.dart';
import 'attribs/_attribs.dart';

import 'zquoteview.dart';

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
