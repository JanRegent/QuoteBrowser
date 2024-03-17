import 'package:flutter/material.dart';
import 'package:quotebrowser/2BL_domain/repos/koyebrepo.dart';

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
            child: const Text('sheets --> supabase > neon > koyeb')));
  }

  ListTile koyebRepoByRownokey() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.koyebRepo.selectByRownokey();
            },
            child: const Text('koyeb selectByRownokey')));
  }

  ListView bodyLv(BuildContext context) {
    return ListView(
      children: [toSupabase(context), koyebRepoByRownokey()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('repoAdmin')),
      body: bodyLv(context),
    );
  }
}
