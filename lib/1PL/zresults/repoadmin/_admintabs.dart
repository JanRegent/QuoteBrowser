import 'package:flutter/material.dart';

import '../../widgets/alib/alib.dart';
import 'checks.dart';
import 'sheets2db.dart';
import 'varsdebug.dart';

class AdminTabs extends StatelessWidget {
  const AdminTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: al.iconBack(context),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.view_array)),
                Tab(icon: Icon(Icons.check)),
                Tab(icon: Icon(Icons.import_export)),
              ],
            ),
            title: const Text('Admin tabs'),
          ),
          body: const TabBarView(
            children: [VarsDebugGrid(), ChecksGrid(), Sheets2dbPage()],
          ),
        ),
      ),
    );
  }
}
