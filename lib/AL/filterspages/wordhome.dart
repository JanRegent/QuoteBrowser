import 'package:flutter/material.dart';

import '../_home/pages/wordsearchpage.dart';

class WordHomePage extends StatelessWidget {
  const WordHomePage({super.key});

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
      )
    ];
  }

  @override
  void dispose() {
    actions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(children: actions));
  }
}
