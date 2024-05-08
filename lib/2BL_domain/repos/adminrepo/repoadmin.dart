import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/repos/sharedprefs.dart';
import 'package:quotebrowser/2BL_domain/repos/supabaserepo.dart';

import '../../../1PL/widgets/alib/alib.dart';
import '../../bl.dart';
import '../sheetrowshelper.dart';

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

  ListTile koyebRepoByRowkey() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.koyebRepo.selectByRowkey();
            },
            child: const Text('koyeb selectByRowkey')));
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

  ListTile sheet2sup() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.supRepo.insertSheet2sqldb('ramtalk');
            },
            child: const Text('sheet2sup ramtalk')));
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

  ListTile sqliteClear() {
    return ListTile(
        leading: const Text('sqlite del'),
        title: IconButton(
            onPressed: () async {
              await sheetrowsHelper.deleteAllRows();
              SharedPrefs.clear();
            },
            icon: const Icon(Icons.delete)));
  }

  ListView bodyLv(BuildContext context) {
    return ListView(
      children: [
        toSupabase(context),
        koyebRepoByRowkey(),
        koyebRepoDeleteAll(),
        countCheck(),
        sheet2sup(),
        sqliteClear()
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
