// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bl.dart';
import '../../../BL/bluti.dart';
import '../../alib/alib.dart';
import '2booksbl.dart';
import 'searchshow.dart';

class BooksMenu extends StatefulWidget {
  const BooksMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BooksMenuState createState() => _BooksMenuState();
}

class _BooksMenuState extends State<BooksMenu> {
  @override
  void initState() {
    super.initState();

    listTiles.add(buttTile());
    for (var bookSheet in bl.booksMap.keys) {
      bl.booksCount[bookSheet] = '';
      listTiles.add(ListTile(
        leading: Obx(() => bl.booksCount[bookSheet] != 'loading'
            ? Text(bl.booksCount[bookSheet])
            : const CircularProgressIndicator()),
        title: Row(
          children: [
            Text(
              bookSheet,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
        subtitle: Row(
          children: [Obx(() => Text(bl.filteredSheetName.value))],
        ),
        onTap: () async {
          await getBookContentShow(bookSheet, bookSheet, context);
        },
      ));
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
              await searchSheetGroups('${blUti.todayStr()}.', '');
            },
            onLongPress: () async {
              await bl.sheetrowsCRUD.deleteAllDb();
              await searchSheetGroups('${blUti.todayStr()}.', '');
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
