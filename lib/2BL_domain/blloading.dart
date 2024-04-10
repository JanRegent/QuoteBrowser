import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../1PL/pages/_home/_homepage.dart';
import '../3Data/builddate.dart';
import 'bl.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _fetchFromAPI();
  }

  Future<void> _fetchFromAPI() async {
    loadingLog.value += '\n dailyList';
    await bl.dailyList.getData();
    loadingLog.value += '\n bookList';
    await bl.bookList.getData();

    loadingLog.value += '\n others';
    bl.updateSlowly();

    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SidebarHome(),
    ));
  }

  RxString loadingLog = '\nloading:\n $buildDate \n\n'.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CircularProgressIndicator(),
          Obx(() => Text(loadingLog.value)),
        ],
      ),
    );
  }
}
