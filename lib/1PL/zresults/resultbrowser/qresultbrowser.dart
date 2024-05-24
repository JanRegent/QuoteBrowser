// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../widgets/alib/alib.dart';

import 'plutogrid/resultsgrid.dart';

class QResultBrowser extends StatefulWidget {
  const QResultBrowser({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QResultBrowserState createState() => _QResultBrowserState();
}

class _QResultBrowserState extends State<QResultBrowser> {
  @override
  void initState() {
    super.initState();
    listTiles.add(buttTile());
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
              // await bl.prepareKeys.byWord
              //     .sheetGroupSheetName('${blUti.todayStr()}.', '');
            },
            onLongPress: () async {},
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
    return const Scaffold(body: ResultsGridPage());
  }
}
