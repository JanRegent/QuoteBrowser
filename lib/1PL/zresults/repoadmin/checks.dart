import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/suprepo.dart';
import '../../controllers/selectvalue.dart';
import '../../widgets/alib/alib.dart';
import 'debugprint/debugprintpage.dart';

class ChecksGrid extends StatefulWidget {
  const ChecksGrid({super.key});

  @override
  State<ChecksGrid> createState() => _ChecksGridState();
}

class _ChecksGridState extends State<ChecksGrid> {
  ListTile rowkeysToday(BuildContext context) {
    return ListTile(
      title: ElevatedButton(
          onPressed: () async {
            al.messageInfo(context, 'watch sheetrowslog', 'supabase.com', 10);
            String report = await bl.supRepo.readSup.rowkeysToday();
            // ignore: use_build_context_synchronously
            await debugPrintShow(context, report);
          },
          child: const Text('supabase rowkeysToday')),
    );
  }

  ListTile sheetnameLast10keys(BuildContext context) {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              String sheetName = await sheetNameSelect(context);
              if (sheetName.isEmpty) return;
              String result = await bl.supRepo.readSup.last10rows(sheetName);
              // ignore: use_build_context_synchronously
              await debugPrintShow(context, result);
            },
            child: const Text('Last 10 supabase.com')),
        trailing: Obx(() => Text(currentSheet2supabase.value)));
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
            child: const Text('countCheck \n neon <> sup')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Checks'),
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
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: rowkeysToday(context),
            ),
            Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: sheetnameLast10keys(context),
            ),
            Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: countCheck(),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
              margin: const EdgeInsets.all(5),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
              margin: const EdgeInsets.all(5),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
              margin: const EdgeInsets.all(5),
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
              margin: const EdgeInsets.all(5),
            ),
          ],
        ));
  }
}
