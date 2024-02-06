import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';

import '../../../2BL_domain/bl.dart';
import '../../../3Data/builddate.dart';
import '../../widgets/alib/alicons.dart';

import '../../zresults/resultbrowser/qresultbrowser.dart';
import '../2books/__authors.dart';
import '../1daily/1daily.dart';

import '../../../0app/config/9appsettings.dart';
import '../3tags/prefixsearch.dart';

import '../4words/sheetnames5page.dart';
import '../5word5/fulltext5page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final int _selectedIndex = 0;

  Row titleRowHome() {
    List<Widget> items = [
      Obx(() => bl.homeTitle.value.isEmpty
          ? const Text('(qb)Home')
          : const CircularProgressIndicator()),
      Obx(() => Text(bl.homeTitle.value))
    ];

    return Row(children: items);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                onTap: (index) {
                  currentSS.currentHomeTabIndex = index;
                },
                tabs: [
                  const Tab(icon: Icon(Icons.tv)),
                  const Tab(icon: Icon(Icons.query_builder)),
                  Tab(icon: ALicons.attrIcons.bookIcon),
                  const Tab(icon: Icon(Icons.tag)),
                  const Tab(icon: Icon(Icons.wordpress)),
                  const Tab(
                      icon: Row(
                    children: [Icon(Icons.wordpress), Icon(Icons.view_column)],
                  )),
                ],
              ),
              title: titleRowHome()),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        const Text('(qb)settings'),
                        const Text(' '),
                        const Text(' '),
                        Text(buildDate)
                      ],
                    )),
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
          body: const TabBarView(
            children: [
              QResultBrowser(),
              LastMenu(),
              BooksAuthors(),
              PrefixSearchPage(),
              Sheetnames5Page(),
              Word5Page(),
            ],
          ),
        ),
      ),
    );
  }
}