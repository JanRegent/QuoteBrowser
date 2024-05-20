import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'words5page.dart';

class Word5Tabs extends StatefulWidget {
  const Word5Tabs({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Word5TabsState createState() => _Word5TabsState();
}

class _Word5TabsState extends State<Word5Tabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: Colors.blue[600],
                unselectedBackgroundColor: Colors.white,
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                ),
                borderWidth: 1,
                unselectedBorderColor: Colors.blue,
                radius: 100,
                tabs: const [
                  Tab(text: "W5"),
                  Tab(icon: Icon(Icons.person), text: "w5"),
                  Tab(icon: Icon(Icons.book), text: "w5"),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Words5Page(),
                    Center(child: Icon(Icons.person)),
                    Center(child: Icon(Icons.book)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
