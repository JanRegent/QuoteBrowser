import 'package:flutter/material.dart';

import '../../../1PL/widgets/alib/alib.dart';
import '../../bl.dart';

class RepoAdmin extends StatelessWidget {
  const RepoAdmin({super.key});

  ListTile toSupabase(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              al.messageInfo(context, 'watch sheetrowslog', 'supabase.com', 10);
              await bl.supRepo.sheets2supabase2neon2koyeb();
            },
            child: const Text('sheets --> supabase')));
  }

  ListView bodyLv(BuildContext context) {
    return ListView(
      children: [toSupabase(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyLv(context),
    );
  }
}
