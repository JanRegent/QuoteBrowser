import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/orm.dart';
import 'gridmenu/groupedgrid.dart';
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

  void setstateHome() {
    setState(() {});
  }

  Widget homeBody(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: loadingTitle.value.isNotEmpty
              ? Row(
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.red,
                    ),
                    const Text('  '),
                    Obx(() => Text(loadingTitle.value)),
                  ],
                )
              : (const Text('Select a sidebar menu item')),
          actions: const [],
        ),
        body: const GridMenuPage(
          crossAxisCount: 3,
          title: 'GroupedGrid',
        ),

        //SidebarPage(setstateHome),
      ),
    );
  }
}
