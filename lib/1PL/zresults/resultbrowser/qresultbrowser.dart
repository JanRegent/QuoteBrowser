// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';

import '../../zresults/swiperbrowser/_swiper.dart';
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

  Future searchSheetNamesWord5Swip(String filterColumnName, String word1,
      String word2, String word3, String word4, String word5) async {
    bl.homeTitle.value = '$word1 $word2 $word3 $word4 $word5 ';

    int rowsCount = await bl.prepareKeys.byWord
        .columnWord5(filterColumnName, word1, word2, word3, word4, word5);
    bl.homeTitle.value = '';
    if (rowsCount == 0) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing found for $word1', '', 8);
      return;
    }

    bl.currentSS.swiperIndexIncrement = false;
    String filterName = '$word1 $word2 $word3 $word4 $word5 ';
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(filterName, '', const {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ResultsGridPage());
  }
}
