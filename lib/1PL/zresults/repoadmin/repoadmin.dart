import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/repos/suprepo.dart';

import '../../controllers/selectvalue.dart';
import '../../widgets/alib/alib.dart';
import '../../../2BL_domain/bl.dart';
import 'debugprint/debugprintpage.dart';

// ignore: must_be_immutable
class RepoAdmin extends StatelessWidget {
  const RepoAdmin({super.key});

  ListTile sheets2Supabase(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              al.messageInfo(context, 'watch sheetrowslog', 'supabase.com', 10);
              await bl.supRepo.sheets2supabase2();
            },
            child: const Text('sheets --> supabase')),
        trailing: Obx(() => Text(currentSheet2supabase.value)));
  }

  ListTile rowkeysToday(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              al.messageInfo(context, 'watch sheetrowslog', 'supabase.com', 10);
              bl.supRepo.readSup.rowkeysToday();
            },
            child: const Text('supabase rowkeysToday')),
        trailing: Obx(() => Text(currentSheet2supabase.value)));
  }

  ListTile sheetnameLast10keys(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              String sheetName = await sheetNameSelect(context);
              if (sheetName.isEmpty) return;
              String result = await bl.supRepo.readSup.last10rows(sheetName);
              // ignore: use_build_context_synchronously
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DebugPrintPage(result)),
              );
            },
            child: const Text('Last 10 supabase.com')),
        trailing: Obx(() => Text(currentSheet2supabase.value)));
  }

  ListTile supabase2neon(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              al.messageInfo(context, 'watch console', '', 10);
              await bl.supRepo.sheets2neon2('neon');
            },
            child: const Text('sheets >> neon')),
        trailing: Obx(() => Text(currentSup2neon.value)));
  }
  // ListTile koyebRepoByRowkey() {
  //   return ListTile(
  //       title: ElevatedButton(
  //           onPressed: () async {
  //             await bl.koyebRepo.selectByRowkey();
  //           },
  //           child: const Text('koyeb selectByRowkey')));
  // }

  // ListTile koyebRepoDeleteAll() {
  //   return ListTile(
  //       title: ElevatedButton(
  //           onPressed: () async {
  //             await bl.koyebRepo.sheetrowsDelete();
  //             await bl.koyebRepo.count();
  //           },
  //           child: const Text('koyeb deleteAll')));
  // }

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
              // try {
              //   int ckoyeb = await bl.koyebRepo.count();

              //   if (c1 == ckoyeb) debugPrint('koueb ok $ckoyeb');
              // } catch (_) {}
            },
            child: const Text('countCheck')));
  }

  ListView bodyLv(BuildContext context) {
    return ListView(
      children: [
        sheets2Supabase(context),
        rowkeysToday(context),
        supabase2neon(context),
        sheetnameLast10keys(context),
        // koyebRepoByRowkey(),
        // koyebRepoDeleteAll(),
        countCheck(),
        sheet2sup(),
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
