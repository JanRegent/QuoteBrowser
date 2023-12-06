import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';
import '1last.dart';
import '9appsettings.dart';
import 'wordhome.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  final int _selectedIndex = 0;
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
          body: const TabBarView(
            children: [
              LastMenu(),
              WordHomePage(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
