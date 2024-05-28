// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../widgets/alib/alicons.dart';
import '../../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';

// ignore: must_be_immutable
class RpanelWfilterLv extends StatefulWidget {
  List<TextEditingController> txCont;
  VoidCallback setStateW5;
  RpanelWfilterLv(this.txCont, this.setStateW5, {super.key});

  @override
  State<RpanelWfilterLv> createState() => _RpanelWfilterLvState();
}

class _RpanelWfilterLvState extends State<RpanelWfilterLv> {
  List filterRows = <String>[].obs;
  Future<String> getData() async {
    filterRows = await bl.wfiltersRepo.getAllW5Insert();
    return 'ok';
  }

  List<ListTile> listTiles = [];

  String filterTitle(Map row) {
    for (var key in row.keys) {
      if (row[key] == null) row[key] = '';
    }
    String titlerow =
        '${row['w1']} ${row['w2']} ${row['w3']} ${row['w4']} ${row['w5']}';
    titlerow += '\n${row['author']} ${row['book']} ';
    titlerow +=
        '\n${'*****'.substring(0, row['stars'])} ${row['starsany']} ${row['favorite']}';

    return titlerow;
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

  ListView filtersLv() {
    return ListView.builder(
        itemCount: filterRows.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: const EdgeInsets.all(15),
              child: ListTile(
                leading: IconButton(
                  icon: ALicons.viewIcons.gridView,
                  onPressed: () {
                    String searchDate = filterRows[index]['w1'];
                    showInGrid(searchDate);
                  },
                ),
                title: Text(
                  filterTitle(filterRows[index]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () async {
                  bl.wfiltersRepo.wfilterDbrow2wfilterMap(filterRows[index]);
                  widget.setStateW5();
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    bl.wfiltersRepo.deleteWFilter(filterRows[index]['id']);
                    widget.setStateW5();
                  },
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[200],
        child: FutureBuilder<String>(
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
        ));
  }
}
