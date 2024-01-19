import 'package:flutter/material.dart';

class HomeMenuPage extends StatefulWidget {
  const HomeMenuPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeMenuPageState createState() => _HomeMenuPageState();
}

class _HomeMenuPageState extends State<HomeMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        //----------------------------------------------------------Last
        const SliverAppBar(
          backgroundColor: Colors.green,
          title: Text('Last'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(15),
                child: Container(
                  color: Colors.orange[100 * (index % 12 + 1)],
                  height: 60,
                  alignment: Alignment.center,
                  child: ListTile(
                      title: Text(
                    "List Item $index",
                    style: const TextStyle(fontSize: 30),
                  )),
                ),
              );
            },
            childCount: 10,
          ),
        ),
        //----------------------------------------------------------search:word
        const SliverAppBar(
          backgroundColor: Colors.green,
          title: Text('Search word'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(15),
                child: Container(
                  color: Colors.green[100 * (index % 12 + 1)],
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    "List Item $index",
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              );
            },
            childCount: 10,
          ),
        ),
      ],
    ));
  }
}
