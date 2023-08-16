import 'package:flutter/material.dart';

import 'AL/_home/_homepage.dart';
import 'BL/bl.dart';

import 'BL/sheet/sheet2db.dart';
import 'BL/sheet/sheet2dbpage.dart';
import 'DL/credentialspage.dart';
import 'DL/dl.dart';
import 'DL/gsheets1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bl.init();

  await gsheetsCredentialsLoad();
  if (gsheetsCredentials.isEmpty) {
    runApp(CredentialsPage());
  } else {
    await dl.init();
    sheetNamesInit();
    runApp(const SidebarHome());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const Text('Hello World!4'),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Sheets2dbPage()),
                  );
                },
                icon: const Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}
