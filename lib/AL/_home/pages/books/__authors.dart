import 'package:flutter/material.dart';

import '../../../../BL/bl.dart';
import 'authorbooks.dart';

class BooksAuthors extends StatefulWidget {
  const BooksAuthors({super.key});

  @override
  State<BooksAuthors> createState() => _BooksAuthorsState();
}

class _BooksAuthorsState extends State<BooksAuthors> {
  List<Widget> tabTitles = [];
  List<Widget> tabPages = [];
  @override
  initState() {
    super.initState();
    tabTitles = [];
    tabPages = [];
    for (int bix = 0; bix < bl.bookList.authorsUniq.length; bix++) {
      String author = bl.bookList.authorsUniq[bix];
      tabTitles.add(const Divider(
        color: Color.fromARGB(255, 135, 198, 137),
      ));
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


/*

Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            itemCount: bl.bookList.authorsUniq.length,
            // The list items
            itemBuilder: (context, index) {
              String author = bl.bookList.authorsUniq[index];
              return ListTile(
                title: Text(author),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthorBooks(author)),
                  );
                },
              );
            },
            // The separators
            separatorBuilder: (context, index) {
              return Divider(
                color: Theme.of(context).primaryColor,
              );
            }),
      )

*/