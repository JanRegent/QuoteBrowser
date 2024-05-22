import 'package:flutter/material.dart';

import '../../widgets/alib/alib.dart';
import 'checks.dart';
import 'sheets2db.dart';

class AdminTabs extends StatelessWidget {
  const AdminTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: al.iconBack(context),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.check)),
                Tab(icon: Icon(Icons.import_export)),
              ],
            ),
            title: const Text('Admin tabs'),
          ),
          body: const TabBarView(
            children: [ChecksGrid(), Sheets2dbPage()],
          ),
        ),
      ),
    );
  }
}
