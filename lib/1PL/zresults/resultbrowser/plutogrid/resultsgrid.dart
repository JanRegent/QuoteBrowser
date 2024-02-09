import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:quotebrowser/2BL_domain/entities/sheetrows/sheetrowshelper.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/orm.dart';
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
      title: 'rownoKey',
      field: 'rownoKey',
      type: PlutoColumnType.text(),
      width: 200,
    ),
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
        stateManager.refRows.map((e) => e.cells['rownoKey']!.value.toString());
    rownos.value = [];
    for (String rownoKey in rownosDyn) {
      rownos.add(rownoKey);
    }
    if (rownos.isEmpty) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing filtered', '', 8);
      return;
    }
    currentSS.keys = [];
    currentSS.swiperIndex.value = swiperIndex;
    for (String rownoKey in rownos) {
      currentSS.keys.add(rownoKey);
    }

    currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CardSwiper('Grid filter', {})),
    );
  }

  Future<String> getData() async {
    rows = [];
    List<SheetRows> sheetRows = await bl.sheetRowsHelper.getAllRows();
    for (SheetRows row in sheetRows) {
      rows.add(PlutoRow(
        cells: {
          'rownoKey': PlutoCell(value: row.rownoKey),
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
        actions: [
          IconButton(
              onPressed: () async {
                await sheetrowsHelper.deleteAllRows();
                await getData();
                setState(() {});
              },
              icon: const Icon(Icons.delete))
        ],
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
