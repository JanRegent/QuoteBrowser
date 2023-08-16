import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AL/zview/_sheetviewpage.dart';

import '../../DL/dl.dart';

import 'sheet2db.dart';

class Sheets2dbPage extends StatefulWidget {
  const Sheets2dbPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Sheets2dbPageState createState() {
    return _Sheets2dbPageState();
  }
}

class _Sheets2dbPageState extends State {
  Future<String> getData() async {
    sheetNames = await dl.gsheetsHelper.getSheetNames(fileId);

    for (var i = 0; i < sheetNames.length; i++) {
      sheetNamesToday.add(0);
      sheetNamesLength.add(0);
    }
    await sheets2db();
    return 'ok';
  }

  ListView bodyLv() {
    return ListView.builder(
      itemCount: sheetNames.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                sheetNames[index],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              leading: InkWell(
                child: CircleAvatar(
                  child: Obx(() => Text(sheetNamesToday[index].toString(),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SheetViewPage(12, 'xxx2')));
                },
              ),
              trailing: Obx(() => Text(sheetNamesLength[index].toString())),
            ),
          ),
        );
      },
    );
  }

  IconButton runLoading() {
    return IconButton(
      icon: const Icon(Icons.run_circle),
      onPressed: () async {
        await sheets2db();
      },
    );
  }

  Widget fileList() {
    return FutureBuilder<String>(
      future: getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return bodyLv();
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(loadingTitle.value)),
          actions: [runLoading()],
        ),
        body: fileList(),
      ),
    );
  }
}
