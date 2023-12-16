import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/bl.dart';
import 'pages/daily/1daily.dart';
import 'pages/books/2boksmenu.dart';
import 'pages/9appsettings.dart';
import 'pages/wordhome.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.date_range)),
                Tab(icon: Icon(Icons.book_sharp)),
                Tab(icon: Icon(Icons.wordpress)),
                Tab(icon: Icon(Icons.filter_alt)),
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
              BooksMenu(),
              WordHomePage(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
