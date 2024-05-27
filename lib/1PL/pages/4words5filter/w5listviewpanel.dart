// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alicons.dart';
import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';

// ignore: must_be_immutable
class W5ListviewPanel extends StatefulWidget {
  List<TextEditingController> txCont;
  VoidCallback setStateW5;
  W5ListviewPanel(this.txCont, this.setStateW5, {super.key});

  @override
  State<W5ListviewPanel> createState() => _W5ListviewPanelState();
}

class _W5ListviewPanelState extends State<W5ListviewPanel> {
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
    return '${row['w1']} ${row['w2']} ${row['w3']} ${row['w4']} ${row['w5']}';
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
                  widget.txCont[1].text = filterRows[index]['w1'];
                  widget.txCont[2].text = filterRows[index]['w2'];
                  widget.txCont[3].text = filterRows[index]['w3'];
                  widget.txCont[4].text = filterRows[index]['w4'];
                  widget.txCont[5].text = filterRows[index]['w5'];
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
