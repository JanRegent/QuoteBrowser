import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/home.dart';
import 'screens/search.dart';

class DriftApp extends StatelessWidget {
  DriftApp({Key? key}) : super(key: key);

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            path: 'search',
            builder: (_, __) => const SearchPage(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Drift Todos',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          typography: Typography.material2018(),
        ),
        routerConfig: _router,
      ),
    );
  }
}
