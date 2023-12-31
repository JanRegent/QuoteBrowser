import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/orm.dart';

import '../../../../BL/bl.dart';
import 'authorbooks.dart';

class BooksAuthorsTab extends StatefulWidget {
  const BooksAuthorsTab({super.key});

  @override
  State<BooksAuthorsTab> createState() => _BooksAuthorsTabState();
}

class _BooksAuthorsTabState extends State<BooksAuthorsTab> {
  List<Widget> tabTitles = [];
  List<Widget> tabPages = [];
  @override
  initState() {
    super.initState();
    tabTitles = [];
    tabPages = [];
    for (int bix = 0; bix < bl.bookList.authorsUniq.length; bix++) {
      String author = bl.bookList.authorsUniq[bix];
      tabTitles.add(ListTile(
        title: Text(author),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AuthorBooks(author)),
          );
        },
      ));
      tabPages.add(AuthorBooks(author));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: ListView(children: tabTitles));
  }
}
