import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../widgets/alib/alib.dart';
import '../../swiperbrowser/_swiper.dart';

class ResultsGridPage extends StatefulWidget {
  const ResultsGridPage({Key? key}) : super(key: key);

  @override
  State<ResultsGridPage> createState() => _ResultsGridPageState();
}

class _ResultsGridPageState extends State<ResultsGridPage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'quote',
      field: 'quote',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'author',
      field: 'author',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'book',
      field: 'book',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'stars',
      field: 'stars',
      width: 100,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'favorite',
      field: 'favorite',
      width: 100,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'dateinsert',
      field: 'dateinsert',
      width: 150,
      type: PlutoColumnType.text(),
    ),
  ];

  List<PlutoRow> rows = [];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  void getRownos(int swiperIndex) {
    var rownosDyn =
        stateManager.refRows.map((e) => e.cells['rowkey']!.value.toString());
    rownos.value = [];
    for (String rowkey in rownosDyn) {
      rownos.add(rowkey);
    }
    if (rownos.isEmpty) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing filtered', '', 8);
      return;
    }
    bl.currentSS.keys = [];
    bl.currentSS.swiperIndex.value = swiperIndex;
    for (String rowkey in rownos) {
      bl.currentSS.keys.add(rowkey);
    }
    bl.currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CardSwiper('Grid filter', '', {})),
    );
  }

  Future<String> getData() async {
    rows = [];
    List sheetRows = [];
    // await bl.sheetRowsHelper.getAllRows();
    for (var row in sheetRows) {
      rows.add(PlutoRow(
        cells: {
          'rowkey': PlutoCell(value: row.rowkey),
          'quote': PlutoCell(value: row.quote),
          'author': PlutoCell(value: row.author),
          'book': PlutoCell(value: row.book),
          'stars': PlutoCell(value: row.stars),
          'favorite': PlutoCell(value: row.favorite),
          'dateinsert': PlutoCell(value: row.dateinsert),
        },
      ));
    }
    return 'ok';
  }

  RxList rownos = [].obs;

  Widget scaffoldPage() {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                onPressed: () => getRownos(1),
                icon: const Icon(Icons.view_agenda))
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;
            stateManager.setShowColumnFilter(true);
          },
          onChanged: (PlutoGridOnChangedEvent event) {},
          mode: PlutoGridMode.select,
          onSelected: (PlutoGridOnSelectedEvent event) {
            if (event.row != null) {
              getRownos(stateManager.currentRowIdx!);
            }
          },
          configuration: const PlutoGridConfiguration(),
          createFooter: (stateManager) {
            stateManager.setPageSize(50, notify: false); // default 40
            return PlutoPagination(stateManager);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: getData(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return scaffoldPage();
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
      ),
    );
  }
}
