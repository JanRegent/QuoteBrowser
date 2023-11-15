import 'package:flutter/material.dart';

import '1 last.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Last'),
                Tab(text: 'Word'),
                Tab(text: 'Filters'),
              ],
            ),
            title: const Text('(qb)Home'),
          ),
          body: const TabBarView(
            children: [
              LastMenu(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
