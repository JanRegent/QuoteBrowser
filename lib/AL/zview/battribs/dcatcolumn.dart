import 'package:flutter/material.dart';

import 'category/catable.dart';

Widget catTabs() {
  return DefaultTabController(
    length: 1,
    initialIndex: 0,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(206, 230, 239, 1),
        leading: const Text(' '),
        bottom: const TabBar(
          tabs: [
            Tab(child: Icon(Icons.category, color: Colors.black)),
            Tab(child: Icon(Icons.category_outlined, color: Colors.black)),
          ],
        ),
      ),
      body: const TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          CatablePage(),
        ],
      ),
    ),
  );
}
