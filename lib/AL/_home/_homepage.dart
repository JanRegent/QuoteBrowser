import 'package:flutter/material.dart';
import 'menuhome/__hometab.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // appBar: AppBar(
          //   title: Row(
          //     children: [
          //       Obx(() => Text(loadingTitle.value)),
          //     ],
          //   ),
          //   actions: const [],
          // ),
          body: HomeTab()

          //
          //const TreeMenu()
          //const GroupedListMenu()

          //     GridMenuPage(
          //   setstateHome,
          //   crossAxisCount: 3,
          //   title: 'GroupedGrid',
          // ),

          //SidebarPage(setstateHome),
          ),
    );
  }
}
