import 'package:flutter/material.dart';
import '1AL_pres/pages/_home/_homepage.dart';

import '1AL_pres/zswipbrowser/_swiper.dart';
import '2BL_domain/bl.dart';

import '2BL_domain/repos/sharedprefs.dart';
import '3Data/dl.dart';
import '3Data/providers/csv/loadassetsfile.dart';

// flutter run -d windows  --dart-define=devmode=1
// flutter run -d chrome --web-renderer html --dart-define=devmode=1 --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await bl.init();

  await dl.init();
  await bl.dailyList.getData();
  await bl.bookList.getData();

  bl.updateSlowly();
  bl.devMode = true; // false; //sheetview
  if (bl.devMode) {
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SidebarHome(),
    ));
  } else {
    await loadCSV(0);
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: CardSwiper('Sheets', {})),
    ));
  }
}
