// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../2BL_domain/repos/sharedprefs.dart';
import '../../widgets/alib/alib.dart';

import '../../controllers/selectvalue.dart';
import '../../zresults/swiperbrowser/_swiper.dart';
import 'quoteadd.dart';

class ByDatePage extends StatefulWidget {
  const ByDatePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ByDatePageState createState() => _ByDatePageState();
}

class _ByDatePageState extends State<ByDatePage> {
  ElevatedButton lastdaySelection() {
    return ElevatedButton(
      child: const Icon(Icons.date_range),
      onPressed: () async {
        String searchDate = await dateSelect(context);
        if (searchDate.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchSheetNamesWord5Swip(
            'dateinsert', searchDate, '', '', '', '');
        filterKeys = SharedPrefs.getKeysAll();
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    filterKeys = SharedPrefs.getKeysAll();
  }

  localQueriesAdd() {
    List<String> keys = SharedPrefs.getKeysAll();
    for (var key in keys) {
      listTiles.add(ListTile(
        title: Text(key.replaceAll('daily', '')),
        onTap: () async {
          String searchDate = key.replaceAll('daily', '').trim();
          await searchSheetNamesWord5Swip('', searchDate, '', '', '', '');
        },
      ));
    }
  }

  List<ListTile> listTiles = [];

  Future searchSheetNamesWord5Swip(String filterColumnName, String word1,
      String word2, String word3, String word4, String word5) async {
    bl.homeTitle.value = '$word1 $word2 $word3 $word4 $word5 ';
    String filterName = '$word1 $word2 $word3 $word4 $word5 ';
    int rowsCount = await bl.prepareKeys.byWord.filterColumnNameWord5(
        filterColumnName, word1, word2, word3, word4, word5);
    bl.homeTitle.value = '';
    if (rowsCount == 0) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing found for $word1', '', 8);
      return;
    }

    currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(filterName, '', const {})),
    );
  }

  List filterKeys = <String>[].obs;

  ListView filtersLv() {
    return ListView.builder(
      itemCount: filterKeys.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(15),
          child: Container(
              color: Colors.orange[100 * (index % 12 + 1)],
              height: 60,
              alignment: Alignment.center,
              child: ListTile(
                title: Text(filterKeys[index].replaceAll('daily', '')),
                onTap: () async {
                  String searchDate =
                      filterKeys[index].replaceAll('daily', '').trim();
                  await searchSheetNamesWord5Swip(
                      'dateinsert', searchDate, '', '', '', '');
                },
              )),
        );
      }, // lists don't need it
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('By date'),
              al.linkIconOpenDoc(
                  '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU', context, ''),
              lastdaySelection()
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuoteAddPage()),
                  );
                },
                icon: const Icon(Icons.man_outlined))
          ],
        ),
        body: filtersLv()

        //Row(children: [todayNews(false), todayNews(true)])

        );
  }
}
