import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/orm.dart';
import 'gridmenu/_groupedgrid.dart';

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
          title: Row(
            children: [
              Obx(() => Text(loadingTitle.value)),
            ],
          ),
          actions: const [],
        ),
        body: GridMenuPage(
          setstateHome,
          crossAxisCount: 3,
          title: 'GroupedGrid',
        ),

        //SidebarPage(setstateHome),
      ),
    );
  }
}
