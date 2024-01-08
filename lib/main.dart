import 'package:flutter/material.dart';

import 'AL/_home/_homepage.dart';
import 'BL/bl.dart';

import 'DL/dl.dart';

import 'DL/tagsindex/qbdb.dart';

// flutter run -d windows  --dart-define=devmode=1
// flutter run -d chrome --web-renderer html --dart-define=devmode=1 --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tagsIndexSqLite();
  await bl.init();
  await dl.init();
  await bl.dailyList.getData();
  await bl.bookList.getData();

  bl.updateSlowly();
  //rows2db();
  //rssInDo();

  runApp(const SidebarHome());

  //mainTagKap();
}
