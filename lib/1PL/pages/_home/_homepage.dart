import 'package:flutter/material.dart';

import '../../widgets/alib/alib.dart';

import '__hometab.dart';

class SidebarHome extends StatefulWidget {
  const SidebarHome({super.key});

  @override
  State<SidebarHome> createState() => _SidebarHomeState();
}

class _SidebarHomeState extends State<SidebarHome> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    al.homeContext = context;
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
