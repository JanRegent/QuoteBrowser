import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/supabase/suprepo.dart';
import '../../widgets/alib/alib.dart';

class Sheets2dbPage extends StatefulWidget {
  const Sheets2dbPage({super.key});

  @override
  State<Sheets2dbPage> createState() => _Sheets2dbPageState();
}

class _Sheets2dbPageState extends State<Sheets2dbPage> {
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

  ListTile oneSheet2sup() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              await bl.supRepo.insertSheet2sqldb('EduardT');
            },
            child: const Text('one sheet2sup EduardT')));
  }

  // ListTile koyebRepoDeleteAll() {
  //   return ListTile(
  //       title: ElevatedButton(
  //           onPressed: () async {
  //             await bl.koyebRepo.sheetrowsDelete();
  //             await bl.koyebRepo.count();
  //           },
  //           child: const Text('koyeb deleteAll')));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Sheets-->db'),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          children: [
            Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: ListTile(
                    title: ElevatedButton(
                        onPressed: () async {
                          al.messageInfo(context, 'watch sheetrowslog',
                              'supabase.com', 10);
                          await bl.supRepo.sheets2supabase2();
                        },
                        child: const Text('sheets --> supabase')),
                    trailing: Obx(() => Text(currentSheet2supabase.value)))),
            Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: supabase2neon(context)),
            Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: oneSheet2sup()),
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              margin: const EdgeInsets.all(5),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              margin: const EdgeInsets.all(5),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              margin: const EdgeInsets.all(5),
            ),
          ],
        ));
  }
}
