//------------------------------------------------------------- filterRows

import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'cols.dart';

class PlutoFilterTypeExt extends PlutoFilterType {}

PlutoColumnFrozen setFreeze(
    String columnName, List<String> startList, List<String> endList) {
  try {
    if (startList.contains(columnName)) return PlutoColumnFrozen.start;
    if (endList.contains(columnName)) return PlutoColumnFrozen.end;
  } catch (e) {
    return PlutoColumnFrozen.none;
  }
  return PlutoColumnFrozen.none;
}

List<Map> currentGridFilterGet(String sheetName) {
  List<Map> filtersList = [];
  for (var index = 0; index < gridCols.length; index++) {
    String value = filteredColumnGetValue(stateManager, gridCols[index].title);
    if (value.isEmpty) continue;
    Map filter = {};
    filter['columnName'] = gridCols[index].title;
    filter['operator'] = 'contains';
    filter['value'] = value;
    filter['title'] =
        '${filter["columnName"]} ${filter["operator"]} ${filter["value"]}';
    filter['sheetName'] = sheetName;

    filtersList.add(filter);
  }
  return filtersList;
}

void currentGridFilterSave(List<Map> filters, String sheetName) {
  String gridFilter = '$sheetName __|__gridfilter';
  //String filterName = '$sheetName __|__gridfilter';
  for (var element in filters) {
    if (gridFilter.isEmpty) {
      gridFilter = jsonEncode(element);
    } else {
      gridFilter = '__|__${jsonEncode(element)}';
    }
    //filterName += '__|__${element['title']}';
  }
  // appData.setString('$sheetName __|__gridfilter__last', gridFilter);
  // appData.setString(filterName, gridFilter);
}

List<String> gridFiltersLoadNames(String sheetName) {
  List<String> filterNames = [];
  // for (String key in appData.getKeys()) {
  //   if (!key.contains('__|__gridfilter')) continue;
  //   filterNames.add(key
  //       .replaceAll('__|__gridfilter', '')
  //       .replaceAll(sheetName, '')
  //       .replaceAll('__|__', '')
  //       .trim());
  // }
  return filterNames.sorted();
}

//---------------------------------------------------------------------old
void filtersInit(List<String> colsFilter) {
  if (colsFilter.isEmpty) return;

  // for (var element in colsFilter) {
  //  PlutoRow filter = PlutoRow(cells: {
  //     FilterHelper.filterFieldColumn: PlutoCell(
  //       value: expr['columnName'],
  //     ),
  //     FilterHelper.filterFieldType: PlutoCell(
  //       value: const PlutoFilterTypeContains(),
  //     ),
  //     FilterHelper.filterFieldValue: PlutoCell(
  //       value: expr['value'],
  //     ),
  //   });
  //   //viewHelper.filterRows.add(filter); // Map expr = jsonDecode(element);

  // }
}

List<PlutoColumn> getFilteredColumns(PlutoGridStateManager gridAStateManager) {
  return gridAStateManager.refColumns.where((e) {
    return gridAStateManager.isFilteredColumn(e);
  }).toList();
}

List<String> getFilteredColsTitles(PlutoGridStateManager gridAStateManager) {
  List<PlutoColumn> filteredCols = gridAStateManager.refColumns.where((e) {
    return gridAStateManager.isFilteredColumn(e);
  }).toList();
  List<String> filteredColsTitles = [];
  for (var i = 0; i < filteredCols.length; i++) {
    filteredColsTitles.add(filteredCols[i].title.toLowerCase());
  }
  return filteredColsTitles;
}

// void handleSaveFilter(PlutoGridStateManager gridAStateManager) {
//   filterRows.clear();

//   final List<PlutoRow> filters = gridAStateManager.filterRows
//       .map(
//         (e) => PlutoRow(cells: {
//           FilterHelper.filterFieldColumn: PlutoCell(
//             value: e.cells[FilterHelper.filterFieldColumn]!.value,
//           ),
//           FilterHelper.filterFieldType: PlutoCell(
//             value: e.cells[FilterHelper.filterFieldType]!.value,
//           ),
//           FilterHelper.filterFieldValue: PlutoCell(
//             value: e.cells[FilterHelper.filterFieldValue]!.value,
//           ),
//         }),
//       )
//       .toList();
//   if (filters.isEmpty) return;
//   // rint(filters[0].cells.keys);
//   // rint(filters[0].cells['column']!.value);
//   // rint(filters[0].cells['type']!.value);
//   // rint(filters[0].cells['value']!.value);

//   filterRows.addAll(filters);
// }

String filteredColumnGetValue(
    PlutoGridStateManager gridAStateManager, String columnName) {
  try {
    final List<PlutoRow> filters = gridAStateManager.filterRows
        .map(
          (e) => PlutoRow(cells: {
            FilterHelper.filterFieldColumn: PlutoCell(
              value: e.cells[FilterHelper.filterFieldColumn]!.value,
            ),
            FilterHelper.filterFieldType: PlutoCell(
              value: e.cells[FilterHelper.filterFieldType]!.value,
            ),
            FilterHelper.filterFieldValue: PlutoCell(
              value: e.cells[FilterHelper.filterFieldValue]!.value,
            ),
          }),
        )
        .toList();
    if (filters.isEmpty) return '';
    // rint(filters[0].cells.keys);
    // rint(filters[0].cells['column']!.value);
    // rint(filters[0].cells['type']!.value);
    // rint(filters[0].cells['value']!.value);
    for (var fIx = 0; fIx < filters.length; fIx++) {
      if (filters[fIx].cells['column']!.value == columnName) {
        return filters[fIx].cells['value']!.value.toString();
      }
    }
    return '';
  } catch (e) {
    return '';
  }
}

void handleLoadFilter(PlutoGridStateManager gridAStateManager) {
  gridAStateManager.gridFocusNode.unfocus();
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   gridAStateManager.setFilterWithFilterRows(viewHelper.filterRows);
  // });
}
