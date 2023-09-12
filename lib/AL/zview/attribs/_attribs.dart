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
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 195, 240, 209),
          leading: const Text(' '),
          bottom: const TabBar(
            tabs: [
              Tab(child: Icon(Icons.headset_rounded)),
              Tab(child: Icon(Icons.tag)),
              Tab(child: Icon(Icons.devices_other)),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [MainFields(), TagsTab(), OthersFields()],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabs();
  }
}
