import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AL/_home/_homepage.dart';

import 'BL/bl.dart';

import 'DL/dl.dart';

// flutter run -d windows  --dart-define=devmode=1
// flutter run -d chrome --web-renderer html --dart-define=devmode=1 --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bl.init();
  await dl.init();
  bl.sheetGroups = await dl.httpService.getSheetGroups();
  //rows2db();
  //rssInDo();

  runApp(const SidebarHome());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            const Text('Hello World!4'),
            IconButton(onPressed: () {}, icon: const Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}
