import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import 'authorbooks.dart';

class BooksAuthors extends StatefulWidget {
  const BooksAuthors({super.key});

  @override
  State<BooksAuthors> createState() => _BooksAuthorsState();
}

class _BooksAuthorsState extends State<BooksAuthors> {
  List<Widget> authorTiles = [];

  @override
  initState() {
    super.initState();
    authorTiles = [];

    for (int bix = 0; bix < bl.bookList.authorsUniq.length; bix++) {
      String author = bl.bookList.authorsUniq[bix];
      authorTiles.add(const Divider(
        color: Color.fromARGB(255, 135, 198, 137),
      ));
      authorTiles.add(ListTile(
        title: Text(author),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AuthorBooks(author)),
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListView(children: authorTiles));
  }
}
