import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/orm.dart';

import '../../BL/bl.dart';
import '../../DL/drift/maind.dart';
import '../alib/alicons.dart';
import 'pages/books/__authtabs.dart';
import 'pages/daily/1daily.dart';

import 'pages/9appsettings.dart';
import 'pages/wordhome.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                currentSS.currentHomeTabIndex = index;
              },
              tabs: [
                const Tab(icon: Icon(Icons.newspaper)),
                Tab(icon: ALicons.attrIcons.bookIcon),
                const Tab(icon: Icon(Icons.wordpress)),
                const Tab(icon: Icon(Icons.filter_alt)),
              ],
            ),
            title: Obx(() => Text(bl.homeTitle.value)),
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('(qb)settings'),
                ),
                ListTile(
                  title: const Text('Home'),
                  selected: _selectedIndex == 0,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Business'),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: appSettingPopup(context),
                  selected: _selectedIndex == 2,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const LastMenu(),
              const BooksAuthorsTab(),
              const WordHomePage(),
              IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriftApp()),
                    );
                  },
                  icon: const Icon(Icons.drive_eta)),
            ],
          ),
        ),
      ),
    );
  }
}
