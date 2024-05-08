import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

Future<List<PlutoRow>> gridRowsMap(
    List<String> sheets, List<String> cols) async {
  PlutoRow gridRow(List<dynamic> dynRow, int rowIx) {
    PlutoRow plutoRow = PlutoRow(cells: {});
    Map row = {};
    //sheetDb.rowMap.row2MapSheet(cols, sheets[rowIx]);
    plutoRow.cells['__'] = PlutoCell(value: row['ID']);

    for (var colIx = 0; colIx < cols.length; colIx++) {
      // ignore: unused_local_variable
      String value = '';

      try {
        if (row[cols[colIx]] == null) {
          value = '';
        } else {
          value = row[cols[colIx]];
        }
      } catch (_) {
        value = '';
      }
      try {
        plutoRow.cells[cols[colIx]] = PlutoCell(value: value);
      } catch (e) {
        plutoRow.cells[cols[colIx]] = PlutoCell(value: '');
      }
    }
    return plutoRow;
  }

  List<PlutoRow> gridrows = [];
  for (var rowIx = 1; rowIx < sheets.length; rowIx++) {
    gridrows.add(gridRow([], rowIx)); //sheets[rowIx]
  }
  return gridrows;
}

Icon detailIcon() {
  return const Icon(
    Icons.last_page,
  );
}
