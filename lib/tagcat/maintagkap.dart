import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/app_const.dart';
import 'constants/app_routes.dart';
import 'constants/route_names.dart';

void mainTagKap() {
  runApp(const ProviderScope(child: TagKatApp()));
}

class TagKatApp extends StatelessWidget {
  const TagKatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppConst.kThemeApp,
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: RouteNames.homePage,
    );
  }
}
