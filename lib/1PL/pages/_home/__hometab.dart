import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';
import 'package:quotebrowser/2BL_domain/repos/adminrepo/repoadmin.dart';

import '../../../2BL_domain/bl.dart';
import '../../../3Data/builddate.dart';
import '../../widgets/alib/alicons.dart';

import '../../zresults/resultbrowser/qresultbrowser.dart';
import '../2books/__authors.dart';
import '../1bydate/1bydate.dart';

import '../../../0app/config/9appsettings.dart';
import '../3tags/tagprefixsearch.dart';

import '../word5/_wor5tabs.dart';

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
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                currentSS.currentHomeTabIndex = index;
              },
              tabs: [
                const Tab(icon: Icon(Icons.timeline)),
                Tab(icon: ALicons.attrIcons.bookIcon),
                const Tab(icon: Icon(Icons.tag)),
                const Tab(
                    icon: Row(
                  children: [Text('W'), Icon(Icons.view_column)],
                )),
                const Tab(icon: Icon(Icons.tv)),
              ],
            ),
            title: titleRowHome(),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RepoAdmin()),
                    );
                  },
                  child: const Icon(Icons.admin_panel_settings))
            ],
          ),
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
              ByDatePage(),
              BooksAuthors(),
              TagPrefixSearch(),
              Word5Tabs(),
              //ColumnWord5Page(),
              QResultBrowser(),
            ],
          ),
        ),
      ),
    );
  }
}
