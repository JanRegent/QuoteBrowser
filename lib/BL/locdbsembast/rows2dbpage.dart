import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';

import '../../AL/zview/_cardsswiper.dart';
import '../../AL/zview/_sheetviewpage.dart';

import '../bl.dart';
import 'rows2db.dart';

class Rows2dbPage extends StatefulWidget {
  const Rows2dbPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Rows2dbPageState createState() {
    return _Rows2dbPageState();
  }
}

class _Rows2dbPageState extends State {
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
                      style: TextStyle(
                          backgroundColor: sheetNamesToday[index] == 0
                              ? Colors.white
                              : Colors.lightBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold))),
                ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SheetViewPage(swiperMaps[0], 'xxx2')));
                },
              ),
              trailing: Obx(() => Text(sheetNamesLength[index].toString())),
            ),
          ),
        );
      },
    );
  }

  IconButton deleteRefresh() {
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () async {
        int sheetsCount = await sheetStore.count(sembastDb);
        loadingStoreCount.value = sheetsCount.toString();

        await sheetStore.delete(sembastDb);

        sheetsCount = await sheetStore.count(sembastDb);
        loadingStoreCount.value = sheetsCount.toString();
        clearLoadingStats();
        await rows2db();
        sheetsCount = await sheetStore.count(sembastDb);
        loadingStoreCount.value = sheetsCount.toString();
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
        actions: [Obx(() => Text(loadingStoreCount.value)), deleteRefresh()],
      ),
      body: fileList(),
    );
  }
}
