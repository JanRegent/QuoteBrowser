import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

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

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'rownoKey': PlutoCell(value: 'user1'),
        'quote': PlutoCell(value: 'Mike'),
        'author': PlutoCell(value: 20),
        'book': PlutoCell(value: 'Programmer'),
        'stars': PlutoCell(value: '2021-01-01'),
        'favorite': PlutoCell(value: '09:00'),
        'dateinsert': PlutoCell(value: 300),
      },
    ),
    PlutoRow(
      cells: {
        'rownoKey': PlutoCell(value: 'user2'),
        'quote': PlutoCell(value: 'Jack'),
        'author': PlutoCell(value: 25),
        'book': PlutoCell(value: 'Designer'),
        'stars': PlutoCell(value: '2021-02-01'),
        'favorite': PlutoCell(value: '10:00'),
        'dateinsert': PlutoCell(value: 400),
      },
    ),
    PlutoRow(
      cells: {
        'rownoKey': PlutoCell(value: 'user3'),
        'quote': PlutoCell(value: 'Suzi'),
        'author': PlutoCell(value: 40),
        'book': PlutoCell(value: 'Owner'),
        'stars': PlutoCell(value: '2021-03-01'),
        'favorite': PlutoCell(value: '11:00'),
        'dateinsert': PlutoCell(value: 700),
      },
    ),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          configuration: const PlutoGridConfiguration(),
        ),
      ),
    );
  }
}
