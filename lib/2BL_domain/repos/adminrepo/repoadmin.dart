import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/repos/supabaserepo.dart';

import '../../../1PL/widgets/alib/alib.dart';
import '../../bl.dart';

// ignore: must_be_immutable
class RepoAdmin extends StatelessWidget {
  const RepoAdmin({super.key});

  ListTile toSupabase(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              al.messageInfo(context, 'watch sheetrowslog', 'supabase.com', 10);
              await bl.supRepo.sheets2supabase2neon2koyeb();
            },
            child: const Text('sheets --> supabase > neon > koyeb')),
        trailing: Obx(() => Text(currentSheet2supabase.value)));
  }

  ListTile koyebRepoByRownokey() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.koyebRepo.selectByRownokey();
            },
            child: const Text('koyeb selectByRownokey')));
  }

  ListTile koyebRepoDeleteAll() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.koyebRepo.sheetrowsDelete();
              await bl.koyebRepo.count();
            },
            child: const Text('koyeb deleteAll')));
  }

  ListTile countCheck() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              int c1 = await bl.supRepo.count();
              int cNeon = await bl.neonRepo.count();
              if (c1 == cNeon) debugPrint('ok neon $c1');
              try {
                int ckoyeb = await bl.koyebRepo.count();

                if (c1 == ckoyeb) debugPrint('koueb ok $ckoyeb');
              } catch (_) {}
            },
            child: const Text('countCheck')));
  }

  ListView bodyLv(BuildContext context) {
    return ListView(
      children: [
        toSupabase(context),
        koyebRepoByRownokey(),
        koyebRepoDeleteAll(),
        countCheck()
      ],
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
