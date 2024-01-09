import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '1AL_pres/pages/_home/_homepage.dart';
import '2BL_domain/bl.dart';

import '3Data/dl.dart';

// flutter run -d windows  --dart-define=devmode=1
// flutter run -d chrome --web-renderer html --dart-define=devmode=1 --web-browser-flag "--disable-web-security"
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bl.init();
  await dl.init();
  await bl.dailyList.getData();
  await bl.bookList.getData();

  bl.updateSlowly();
  //rows2db();
  //rssInDo();

  runApp(const ProviderScope(child: SidebarHome()));

  //mainTagKap();
}
