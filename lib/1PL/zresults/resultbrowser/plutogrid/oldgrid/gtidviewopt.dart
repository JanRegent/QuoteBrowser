// //------------------------------------------------------------- filterRows
// //https://github.com/bosskmk/pluto_grid/issues/138
// ///https://github.com/bosskmk/pluto_grid/issues/381
// ///https://pub.dev/documentation/pluto_grid/latest/pluto_grid/PlutoGridStateChangeNotifier/setFilterWithFilterRows.html
// ///https://pluto.weblaze.dev/configuration //User-Defined Column Filters

// //import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'package:pluto_grid/pluto_grid.dart';

// import '../../../BL/bl.dart';
// //import 'package:sheetviewer/AL/views/plutogrid/drawergrid.dart';

// class GridViewOpt {
//   Map expr = {};
//   final String fileUrl;
//   String fileId = '';
//   final String sheetName;
//   PlutoGridStateManager stateManager;
//   List<PlutoColumn> plutoCols;
//   GridViewOpt(this.fileUrl, this.sheetName, this.stateManager, this.plutoCols) {
//     fileId = bl.blUti.url2fileid(fileUrl);
//   }

//   Future save() async {
//     await _filterSave();
//     await _freezeColumnsSave();
//   }

//   Future load() async {
//     await _setFilter();
//     await _freezeColumnsLoad();
//   }

//   List<Map> filtersList = [];
//   List<PlutoRow> filterRows = [];

//   Future _filtersInit() async {
//     filterRows.clear();

//     String? exprStr =
//         await viewSetting.valueGet(sheetName + '__|__currentFilter');
//     if (exprStr!.isEmpty) return;
//     Map exprMap = jsonDecode(exprStr);
//     //for (var element in filtersList) {
//     PlutoRow filter = PlutoRow(cells: {
//       FilterHelper.filterFieldColumn: PlutoCell(
//         value: exprMap['columnName'],
//       ),
//       FilterHelper.filterFieldType: PlutoCell(
//         value: const PlutoFilterTypeContains(),
//       ),
//       FilterHelper.filterFieldValue: PlutoCell(
//         value: exprMap['value'],
//       ),
//     });
//     filterRows.add(filter); // Map expr = jsonDecode(element);

//     //}
//   }

//   ///set the filters of the current configuration
//   Future _setFilter() async {
//     await _filtersInit();
//     stateManager.setFilterWithFilterRows(filterRows);
//   }

//   Future _filterSave() async {
//     filterRows.clear();

//     final List<PlutoRow> filters = stateManager.filterRows
//         .map(
//           (e) => PlutoRow(cells: {
//             FilterHelper.filterFieldColumn: PlutoCell(
//               value: e.cells[FilterHelper.filterFieldColumn]!.value,
//             ),
//             FilterHelper.filterFieldType: PlutoCell(
//               value: e.cells[FilterHelper.filterFieldType]!.value,
//             ),
//             FilterHelper.filterFieldValue: PlutoCell(
//               value: e.cells[FilterHelper.filterFieldValue]!.value,
//             ),
//           }),
//         )
//         .toList();
//     if (filters.isEmpty) return;
//     Map expr = {};
//     expr['columnName'] = (filters[0].cells['column']!.value);
//     //filters[0].cells['type']!.value.toString();
//     expr['operator'] = 'contains';
//     expr['value'] = filters[0].cells['value']!.value;
//     await viewSetting.valueSet(
//         sheetName + '__|__' + 'currentFilter', jsonEncode(expr));
//     filterRows.addAll(filters);
//   }

//   Future filterClear() async {
//     stateManager.filterRows.clear();
//     stateManager.setFilterWithFilterRows([]);

//     await viewSetting.valueSetEmpty(sheetName + '__|__' + 'currentFilter');
//   }

// //-----------------------------------------------------------------------hideCols
//   Future hidedColumnsSave() async {
//     List<String> list = [];
//     for (var index = 0; index < plutoCols.length; index++) {
//       if (!plutoCols[index].hide) continue;
//       list.add(plutoCols[index].title);
//     }
//     if (list.isEmpty) return;

//     await viewSetting.valueSet(
//         sheetName + '__|__' + 'hidedColumns', jsonEncode(list.join(',')));
//     return list;
//   }

//   Future hidedColumnsReset() async {
//     for (var index = 0; index < plutoCols.length; index++) {
//       plutoCols[index].hide = false;
//     }

//     await viewSetting.valueSetEmpty(sheetName + '__|__' + 'hidedColumns');
//   }

//   //-----------------------------------------------------------------freeze
//   Future _freezeColumnsSave() async {
//     List<String> freezeStart = [];
//     List<String> freezeEnd = [];
//     for (var index = 0; index < plutoCols.length; index++) {
//       if (!plutoCols[index].frozen.isFrozen) continue;
//       if (plutoCols[index].frozen.isStart) {
//         freezeStart.add(plutoCols[index].title);
//       }
//       if (plutoCols[index].frozen.isEnd) freezeEnd.add(plutoCols[index].title);
//     }
//     if (freezeStart.isNotEmpty) {
//       await viewSetting.valueSet(sheetName + '__|__' + 'freezeStart',
//           jsonEncode(freezeStart.join(',')));
//     }
//     if (freezeEnd.isNotEmpty) {
//       await viewSetting.valueSet(
//           sheetName + '__|__' + 'freezeEnd', jsonEncode(freezeEnd.join(',')));
//     }
//   }

//   Future _freezeColumnsLoad() async {
//     String? freezeStart =
//         await viewSetting.valueGet(sheetName + '__|__freezeStart');

//     if (freezeStart!.isEmpty) return;
//     if (freezeStart.startsWith('"')) {
//       freezeStart = freezeStart.substring(1, freezeStart.length - 1);
//     }
//     for (var index = 0; index < plutoCols.length; index++) {
//       if (plutoCols[index].title != freezeStart) {
//         plutoCols[index].frozen = PlutoColumnFrozen.none;
//         continue;
//       }
//       plutoCols[index].frozen = PlutoColumnFrozen.start;

//       return;
//     }
//   }
// }
