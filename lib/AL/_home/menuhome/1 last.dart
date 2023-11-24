// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';
import '../../../BL/bluti.dart';
import '../../alib/alib.dart';
import '../../filterspages/_selectview.dart';
import 'common.dart';

class LastMenu extends StatefulWidget {
  const LastMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LastMenuState createState() => _LastMenuState();
}

class _LastMenuState extends State<LastMenu> {
  ElevatedButton lastdays() {
    return ElevatedButton(
      child: const Icon(Icons.last_page),
      onPressed: () async {
        String searchDate = '';
        try {
          // ignore: use_build_context_synchronously
          searchDate = await dateSelect(context);
        } catch (_) {
          return;
        }

        if (searchDate.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchText(searchDate, context);
      },
    );
  }

  PopupMenuButton popupGen(String sheetGroup) {
    List<PopupMenuItem> items = [];
    for (String sheetName in bl.sheetGroups[sheetGroup].keys) {
      items.add(PopupMenuItem(
        child: Text(sheetName),
        onTap: () {
          debugPrint(sheetName);
        },
      ));
    }
    return PopupMenuButton(
      child: const Icon(Icons.arrow_forward_ios_rounded),
      itemBuilder: (context) {
        return items;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    listTiles.add(buttTile());
    for (var sheetGroup in bl.sheetGroups.keys) {
      bl.lastCount[sheetGroup] = '';
      listTiles.add(ListTile(
          leading: Obx(() => bl.lastCount[sheetGroup] != 'loading'
              ? Text(bl.lastCount[sheetGroup])
              : const CircularProgressIndicator()),
          title: Row(
            children: [
              Text(
                sheetGroup,
                style: const TextStyle(fontSize: 30),
              ),
              popupGen(sheetGroup)
            ],
          ),
          onTap: () async {
            await searchSheetGroup(sheetGroup, '${blUti.todayStr()}.', context);
          },
          trailing: lastdays()));
    }
  }

  List<ListTile> listTiles = [];

  ListTile buttTile() {
    return ListTile(
      title: Row(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('All'),
            onPressed: () async {
              await searchSheetGroups('${blUti.todayStr()}.');
            },
            onLongPress: () async {
              await bl.sheetrowsCRUD.deleteAllDb();
              await searchSheetGroups('${blUti.todayStr()}.');
            },
          ),
          const Text(''),
          al.linkIconOpenDoc(
              '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU', context, ''),
        ],
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        //----------------------------------------------------------Last

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == 0) {
                return listTiles[index];
              } else {
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: Container(
                    color: Colors.orange[100 * (index % 12 + 1)],
                    height: 60,
                    alignment: Alignment.center,
                    child: listTiles[index],
                  ),
                );
              }
            },
            childCount: listTiles.length,
          ),
        ),
      ],
    ));
  }
}
