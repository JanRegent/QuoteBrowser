import 'package:flutter/material.dart';

import '__hometab.dart';

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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeTab()),
    );
  }
}
