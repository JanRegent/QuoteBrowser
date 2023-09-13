import 'package:flutter/material.dart';

import 'package:expandable/expandable.dart';

import 'aheadfields.dart';
import 'btags.dart';
import 'cothers.dart';

// ignore: must_be_immutable
class QuoteAttribs extends StatefulWidget {
  const QuoteAttribs({super.key});

  @override
  State<QuoteAttribs> createState() => _QuoteAttribsState();
}

class _QuoteAttribsState extends State<QuoteAttribs> {
  ExpandableController contr = ExpandableController(initialExpanded: true);

  Widget tabs() {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(206, 230, 239, 1),
          leading: const Text(' '),
          bottom: const TabBar(
            tabs: [
              Tab(child: Icon(Icons.headset_rounded, color: Colors.black)),
              Tab(child: Icon(Icons.tag, color: Colors.black)),
              Tab(child: Icon(Icons.devices_other, color: Colors.black)),
              Tab(child: Icon(Icons.category, color: Colors.black)),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [MainFields(), TagsTab(), OthersFields(), Text('category')],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabs();
  }
}
