import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/1PL/pages/2bysheetgroups/bysheetgroups.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';

import '../../../2BL_domain/bl.dart';
import '../../../3Data/builddate.dart';
import '../../widgets/alib/alicons.dart';

import '../../zresults/resultbrowser/qresultbrowser.dart';
import '../2books/__authors.dart';
import '../1bydate/1bydate.dart';

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
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                currentSS.currentHomeTabIndex = index;
              },
              tabs: [
                const Tab(icon: Icon(Icons.timeline)),
                const Tab(icon: Icon(Icons.table_rows_outlined)),
                Tab(icon: ALicons.attrIcons.bookIcon),
                const Tab(icon: Icon(Icons.tag)),
                const Tab(child: Text('W')),
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
                    //await bl.supRepo.updateSup();
                  },
                  child: const Icon(Icons.run_circle))
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
              BySheetGroups(),
              BooksAuthors(),
              PrefixSearchPage(),
              Sheetnames5Page(),
              Word5Page(),
              QResultBrowser(),
            ],
          ),
        ),
      ),
    );
  }
}
