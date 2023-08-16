import 'package:flutter/material.dart';

import '../../BL/sheet/sheet2dbpage.dart';
import 'sidebar.dart';

class SidebarHome extends StatefulWidget {
  const SidebarHome({super.key});

  @override
  State<SidebarHome> createState() => _SidebarHomeState();
}

class _SidebarHomeState extends State<SidebarHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: homeBody(context));
  }

  Widget homeBody(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "News"),
                Tab(text: "Data Update"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [SidebarPage(), Sheets2dbPage()],
          )),
    );
  }
}
