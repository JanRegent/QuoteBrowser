// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/orm.dart';

import '../../../../BL/bl.dart';
import '../../../../BL/bluti.dart';
import '../../../alib/alib.dart';
import '../2booksbl.dart';
import '../searchshow.dart';

class AuthorBooks extends StatefulWidget {
  final String author;
  const AuthorBooks(this.author, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthorBooksState createState() => _AuthorBooksState();
}

class _AuthorBooksState extends State<AuthorBooks> {
  @override
  void initState() {
    super.initState();
    listTiles = [];
    listTiles.add(buttTile());
    for (var bix = 0; bix < bl.bookList.rows.length; bix++) {
      if (bl.bookList.rows[bix].author != widget.author) continue;
      String sheetName = bl.bookList.rows[bix].sheetName;
      if (bl.bookList.rows[bix].bookName.isEmpty) continue;

      bl.booksCount[sheetName] = '';
      listTiles.add(ListTile(
        leading: Text(bl.bookList.rows[bix].currentIndex.toString()),
        title: Row(
          children: [
            Text(
              bl.bookList.rows[bix].bookName,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
        subtitle: Row(
          children: [Obx(() => Text(bl.filteredSheetName.value))],
        ),
        onTap: () async {
          String sheetId = blUti.url2fileid(bl.bookList.rows[bix].sheetUrl);
          currentSS.currentBooksListRowno = bix + 2;
          currentSS.swiperIndex.value = bl.bookList.rows[bix].currentIndex;
          await getBookContentShow(sheetName, sheetName, sheetId, context);
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
        appBar: AppBar(
          title: Text(widget.author),
        ),
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
