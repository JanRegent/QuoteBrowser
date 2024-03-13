import 'package:flutter/material.dart';

import '../../bl.dart';

class RepoAdmin extends StatelessWidget {
  const RepoAdmin({super.key});

  ListTile toSupabase() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.supRepo.sheets2supabase();
            },
            child: const Text('sheets --> supabase')));
  }

  ListView bodyLv() {
    return ListView(
      children: [toSupabase()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyLv(),
    );
  }
}
