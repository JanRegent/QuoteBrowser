import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/BL/sheet/sheetcrud.dart';

import '../../AL/zview/_sheetviewpage.dart';

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
      icon: const Icon(Icons.refresh),
      onPressed: () async {
        clearSheets();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sheets2dbPage()),
        );
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
          child: Text('Data loading'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(loadingTitle.value)),
        actions: [runLoading()],
      ),
      body: fileList(),
    );
  }
}
