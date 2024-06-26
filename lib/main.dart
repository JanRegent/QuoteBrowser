import 'package:flutter/material.dart';
import '2BL_domain/bl.dart';

import '2BL_domain/blloading.dart';
import '3Data/dl.dart';

// flutter run -d windows  --dart-define=devmode=1
// flutter run -d chrome --web-renderer html --dart-define=devmode=1 --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bl.init();

  await dl.init();
  // await bl.dailyList.getData();
  // await bl.bookList.getData();

  bl.devMode = true; // false; //sheetview

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoadingPage(),
  ));

  // if (bl.devMode) {
  //   runApp(const MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: SidebarHome(),
  //   ));
  // } else {
  //   await loadCSV(0);
  //   runApp(const MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: Scaffold(body: CardSwiper('Sheets', {})),
  //   ));
  // }
}
