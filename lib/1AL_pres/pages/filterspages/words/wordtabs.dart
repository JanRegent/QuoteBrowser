import 'package:flutter/material.dart';

import '../../wordsearchpage.dart';

class WordTabsPage extends StatelessWidget {
  const WordTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WordSelect(),
    );
  }
}

class WordSelect extends StatefulWidget {
  const WordSelect({super.key});

  @override
  WordSelectState createState() => WordSelectState();
}

class WordSelectState extends State<WordSelect> {
  bool isSelectionMode = false;
  final int listLength = 3;
  late List<Widget> actions = [];

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    actions = [
      ListTile(
        leading: IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WordSearchPage('tags')),
              );
            },
            icon: const Icon(Icons.tag)),
      ),
      TextButton(
          onPressed: () {
//             jsonResponse = jsonDecode('''
// {"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"Jan Regent@reqres.in","first_name":"Michael","last_name":"Lawson","avatar":"https://reqres.in/img/faces/7-image.jpg"},{"id":8,"email":"lindsay.ferguson@reqres.in","first_name":"Lindsay","last_name":"Ferguson","avatar":"https://reqres.in/img/faces/8-image.jpg"},{"id":9,"email":"tobias.funke@reqres.in","first_name":"Tobias","last_name":"Funke","avatar":"https://reqres.in/img/faces/9-image.jpg"},{"id":10,"email":"byron.fields@reqres.in","first_name":"Byron","last_name":"Fields","avatar":"https://reqres.in/img/faces/10-image.jpg"},{"id":11,"email":"george.edwards@reqres.in","first_name":"George","last_name":"Edwards","avatar":"https://reqres.in/img/faces/11-image.jpg"},{"id":12,"email":"rachel.howell@reqres.in","first_name":"Rachel","last_name":"Howell","avatar":"https://reqres.in/img/faces/12-image.jpg"}],"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}

// ''');
          },
          child: const Text('ch'))
    ];
  }

  @override
  void dispose() {
    actions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.tag)),
              Tab(icon: Icon(Icons.wordpress)),
            ],
          ),
          title: const Text('By words Demo'),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.cabin),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    ));
    //SearchUserRiverpod());

    //ListView(children: actions));
  }
}
