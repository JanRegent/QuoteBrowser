import 'package:flutter/material.dart';

import 'AL/_home/_homepage.dart';

import 'BL/bl.dart';

import 'DL/dl.dart';

// flutter run -d windows  --dart-define=devmode=1
// flutter run -d chrome --web-renderer html --dart-define=devmode=1 --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bl.init();
  await dl.init();
  await bl.dailyList.getData();

  bl.updateSlowly();
  //rows2db();
  //rssInDo();

  runApp(const SidebarHome());
}
