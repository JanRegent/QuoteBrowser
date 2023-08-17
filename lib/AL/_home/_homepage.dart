import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BL/sheet/sheet2db.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(loadingTitle.value)),
          actions: const [],
        ),
        body: const SidebarPage(),
      ),
    );
  }
}
