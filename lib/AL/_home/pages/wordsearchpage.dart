// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../BL/bluti.dart';
import '../../../DL/dl.dart';
import '../../alib/searchvalue/searchselectpage.dart';

class WordSearchPage extends StatefulWidget {
  final String tagsYellow;
  const WordSearchPage(this.tagsYellow, {super.key});

  @override
  State<WordSearchPage> createState() => _WordSearchPageState();
}

class _WordSearchPageState extends State<WordSearchPage> {
  @override
  initState() {
    super.initState();
    tagsUsed.add('??'.obs);
  }

  List<String> tags = [];
  Future<String> getData() async {
    List data = await dl.httpService.getSheetNamesTags();
    int tagIx = blUti.toListString(data[0]).indexOf('tags');
    for (var six = 1; six < data.length; six++) {
      tags.addAll(data[six][tagIx].toString().split('#'));
    }
    return 'Ok';
  }

  RxList<RxString> tagsUsed = RxList<RxString>();

  Card tagsCard() {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () async {
                    // ignore: use_build_context_synchronously
                    tagsUsed[0].value = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchSelectPage(tags, 'Select tag')),
                    );
                  },
                  icon: const Icon(Icons.tag)),
              title: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Obx(() => Text(tagsUsed[0].value)))
                ],
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<String>(
      future: getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // ignore: unused_local_variable
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Result: ${snapshot.data}'),
            ),
          ];
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
              child: Text('Awaiting tags...'),
            ),
          ];
        }
        return tagsCard();
      },
    ));
  }
}
//----------------------------------
