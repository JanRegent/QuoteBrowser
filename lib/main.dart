import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/DL/dl.dart';
import './BL/email/email.dart';
import 'BL/bl.dart';

import 'BL/sheet/sheet2dvui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bl.init();
  await dl.init();
  //await sheets2db();

  runApp(const Sheets2dbPage());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Isar _isar;

  @override
  void initState() {
    // Open Isar instance
    _isar = Isar.open(
      schemas: [EmailSchema],
      directory: Isar.sqliteInMemory,
      engine: IsarEngine.sqlite,
    );
    super.initState();
  }

  void emailAdd() {
    // Persist counter value to database
    _isar.write((isar) async {
      isar.emails.put(Email(id: 1, title: 't1'));
    });

    setState(() {});
  }

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
