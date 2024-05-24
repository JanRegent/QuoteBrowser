// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../widgets/alib/alib.dart';

import 'plutogrid/resultsgrid.dart';

class QResultBuilder extends StatefulWidget {
  final List rows;
  const QResultBuilder(this.rows, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QResultBuilderState createState() => _QResultBuilderState();
}

class _QResultBuilderState extends State<QResultBuilder> {
  @override
  void initState() {
    super.initState();
    listTiles.add(buttTile());
  }

  List<String> columns = [];

  Future<String> getData() async {
    columns = await bl.supRepo.readSup.columnsGet();

    return 'ok';
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
    return Scaffold(
        body: FutureBuilder<String>(
      future: getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return ResultsGridPage(columns, widget.rows);
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    ));
  }
}
