import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../zresults/repoadmin/_admintabs.dart';
import '../../../3Data/builddate.dart';
import '../../widgets/alib/alicons.dart';

import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../1bydate/quoteadd.dart';
import '../2books/__authors.dart';
import '../1bydate/1bydate.dart';

import '../../../0app/config/9appsettings.dart';
import '../3tags/tagprefixsearch.dart';

import '../4words/_wor5tabs.dart';

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
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                bl.currentSS.currentHomeTabIndex = index;
              },
              tabs: [
                const Tab(icon: Icon(Icons.timeline)),
                Tab(icon: ALicons.attrIcons.bookIcon),
                const Tab(icon: Icon(Icons.tag)),
                const Tab(
                    icon: Row(
                  children: [Icon(Icons.wordpress), Icon(Icons.view_column)],
                )),
              ],
            ),
            title: titleRowHome(),
            actions: [
              IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuoteAddPage()),
                    );
                  },
                  icon: const Icon(Icons.add)),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminTabs()),
                    );
                  },
                  child: const Icon(Icons.admin_panel_settings)),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QResultBuilder([])),
                    );
                  },
                  child: const Icon(Icons.tv))
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
            ],
          ),
        ),
      ),
    );
  }
}
