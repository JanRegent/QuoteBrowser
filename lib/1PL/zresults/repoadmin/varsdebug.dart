import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/sharedprefs.dart';
import '../../../2BL_domain/repos/suprepo.dart';
import '../../controllers/selectvalue.dart';
import '../../widgets/alib/alib.dart';
import '../../widgets/alib/alicons.dart';
import 'debugprint/debugprintpage.dart';
import 'resultbuilder/qresultbuilder.dart';

class VarsDebugGrid extends StatefulWidget {
  const VarsDebugGrid({super.key});

  @override
  State<VarsDebugGrid> createState() => _VarsDebugGridState();
}

class _VarsDebugGridState extends State<VarsDebugGrid> {
  Future curRowKeysList() async {
    String report = '--------------------------------bl.currentSS.keys';
    for (var i = 0; i < bl.currentSS.keys.length; i++) {
      report += '\n${bl.currentSS.keys[i]}';
    }
    return report;
  }

  Future currKeysShowInGridShow() async {
    List rows = [];
    for (var i = 0; i < bl.currentSS.keys.length; i++) {
      Map row = await bl.supRepo.rowkeySelect(bl.currentSS.keys[i]);
      //print(row);
      rows.add(row);
    }
    bl.currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QResultBuilder(rows)),
    );
  }

  IconButton currKeysShowInGrid() {
    return IconButton(
        onPressed: () async {
          await currKeysShowInGridShow();
        },
        icon: ALicons.viewIcons.gridView);
  }

  ListTile curRowKeysListShow(BuildContext context) {
    return ListTile(
      title: ElevatedButton(
          onPressed: () async {
            String report = await curRowKeysList();
            // ignore: use_build_context_synchronously
            await debugPrintShow(context, report);
          },
          child: const Text('curRowKeysListShow')),
    );
  }

  ListView curRowKeysListView(BuildContext context) {
    List<ListTile> items = [];
    for (var i = 0; i < bl.currentSS.keys.length; i++) {
      items.add(ListTile(
          title: Text(bl.currentSS.keys[i]),
          onTap: () {},
          trailing: IconButton(
            icon: const Icon(Icons.link),
            onPressed: () {
              al.jump2sheetRow(bl.currentSS.keys[i], context, 'Jump to row');
            },
          )));
    }
    return ListView(children: items);
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

  ListTile sheredDelete() {
    return ListTile(
        title: ElevatedButton(
            onPressed: () async {
              SharedPrefs.clear();

              setState(() {});
            },
            child: const Row(
              children: [Icon(Icons.delete), Text('sharedDelete')],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('VarsDebug'),
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
              child: Column(
                children: [curRowKeysListShow(context), currKeysShowInGrid()],
              ),
            ),
            Container(
              width: 200,
              height: 200,
              margin: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: curRowKeysListView(context),
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
              margin: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              child: sheredDelete(),
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
