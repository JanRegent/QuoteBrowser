// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/1PL/widgets/alib/alicons.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/sharedprefs.dart';
import '../../widgets/alib/alib.dart';

import '../../controllers/selectvalue.dart';
import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../../zresults/swiperbrowser/_swiper.dart';

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
        filterRows = SharedPrefs.getKeysAll();
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //filterKeys = SharedPrefs.getKeysAll();
  }

  Future<String> getData() async {
    filterRows = await bl.wfiltersRepo.getAllDateInsert();
    return 'ok';
  }

  Future searchSheetNamesWord5Swip(String filterColumnName, String word1,
      String word2, String word3, String word4, String word5) async {
    bl.homeTitle.value = '$word1 $word2 $word3 $word4 $word5 ';
    String filterName = '$word1 $word2 $word3 $word4 $word5 ';
    int rowsCount = await bl.prepareKeys.byWord
        .columnWord5(filterColumnName, word1, word2, word3, word4, word5);
    bl.homeTitle.value = '';
    if (rowsCount == 0) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing found for $word1', '', 8);
      return;
    }

    bl.currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(filterName, '', const {})),
    );
  }

  Future showInGrid(String filterKey) async {
    String searchDate = filterKey.replaceAll('daily', '').trim();
    List rows = await bl.supRepo.dateinsertRows(searchDate);
    bl.currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QResultBuilder(rows)),
    );
  }

  List<ListTile> listTiles = [];

  List filterRows = <String>[].obs;
  String filterTitle(Map row) {
    for (var key in row.keys) {
      if (row[key] == null) row[key] = '';
    }
    return '${row['w1']} ${row['w2']} ${row['w3']} ${row['w4']} ${row['w5']}';
  }

  ListView filtersLv() {
    return ListView.builder(
      itemCount: filterRows.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.all(15),
          child: Container(
              color: Colors.orange[100 * (index % 12 + 1)],
              height: 60,
              alignment: Alignment.center,
              child: ListTile(
                leading: IconButton(
                  icon: ALicons.viewIcons.gridView,
                  onPressed: () {
                    String searchDate = filterRows[index]['w1'];
                    showInGrid(searchDate);
                  },
                ),
                title: Text(filterTitle(filterRows[index])),
                onTap: () async {
                  String searchDate = filterRows[index]['w1'];
                  await searchSheetNamesWord5Swip(
                      'dateinsert', searchDate, '', '', '', '');
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    bl.wfiltersRepo.deleteWFilter(filterRows[index]['id']);
                    setState(() {});
                  },
                ),
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
        ),
        body: FutureBuilder<String>(
          future: getData(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              return filtersLv();
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
        )

        //Row(children: [todayNews(false), todayNews(true)])

        );
  }
}
