// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:pluto_grid/pluto_grid.dart';

// import 'cols.dart';
// import 'menugridpage.dart';

// //import 'gtidviewopt.dart';

// class GridPage extends StatefulWidget {
//   final List<PlutoColumn> columns;
//   final List<PlutoRow> rows;
//   final Map configRow;
//   const GridPage(this.columns, this.rows, this.configRow, {Key? key})
//       : super(key: key);

//   @override
//   State<GridPage> createState() => _GridPageState();
// }

// class _GridPageState extends State<GridPage> {
//   //late GridViewOpt gridViewOpt;
//   @override
//   void initState() {
//     super.initState();
//     try {
//       stateManager.setShowColumnFilter(true);
//     } catch (_) {}
//   }

//   PopupMenuButton appbarRightPopup() {
//     return PopupMenuButton(
//         itemBuilder: (context) {
//           return [
//             PopupMenuItem<int>(
//               value: 0,
//               child: ElevatedButton(
//                   child: const Icon(Icons.clear),
//                   onPressed: () {
//                     stateManager.filterRows.clear();
//                     stateManager.setFilterWithFilterRows([]);
//                     //currentSheet.rowsArrFiltered = [];
//                   }),
//             ),
//             PopupMenuItem<int>(
//               value: 0,
//               child: ElevatedButton(
//                   onPressed: () async {
//                     //await gridViewOpt.save();
//                   },
//                   onLongPress: () async {
//                     //await gridViewOpt.filterClear();
//                     setState(() {});
//                   },
//                   child: const Icon(Icons.filter)),
//             ),
//             PopupMenuItem<int>(
//               value: 0,
//               child: ElevatedButton(
//                   onPressed: () async {
//                     //await gridViewOpt.hidedColumnsSave();
//                   },
//                   onLongPress: () async {
//                     //await gridViewOpt.hidedColumnsReset();
//                     setState(() {});
//                   },
//                   child: const Icon(Icons.hide_source)),
//             ),
//           ];
//         },
//         onSelected: (value) {});
//   }

//   Map sheetIDsMap = {};

//   PlutoGrid plutogrid() {
//     return PlutoGrid(
//       columns: widget.columns,
//       rows: widget.rows,
//       //columnGroups: columnGroups,
//       createFooter: (stateManager) {
//         stateManager.setPageSize(50, notify: false); // default 40
//         return PlutoPagination(stateManager);
//       },
//       onLoaded: (PlutoGridOnLoadedEvent event) {
//         try {
//           stateManager = event.stateManager;
//         } catch (_) {}
//         // gridViewOpt = GridViewOpt(
//         //     widget.fileListRow['fileUrl'],
//         //     widget.fileListRow['sheetName'],
//         //     stateManager,
//         //     widget.columns);

//         //gridViewOpt.load();
//         stateManager.setShowColumnFilter(true);
//       },
//       onChanged: (PlutoGridOnChangedEvent event) {
//         if (kDebugMode) {}
//       },
//       onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) async {},
//       //configuration: configuration,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Results browser'),
//           actions: [appbarRightPopup()],
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             //Header Container
//             Container(
//               padding: const EdgeInsets.all(8.0),
//               color: Colors.blue,
//               alignment: Alignment.center,
//               child: MenuGridPage(widget.configRow, 'sheetName'),
//             ),

//             //Body Container  ,
//             Container(
//               padding: const EdgeInsets.all(8.0),
//               color: Colors.blue,
//               alignment: Alignment.center,
//               height: 530.0,
//               child: plutogrid(),
//             ),
//           ],
//         ));
//   }

//   List<int> getFilteredIds(PlutoGridStateManager stateManager) {
//     List<int> ids = [];
//     var idsFilter = stateManager.refRows.map((e) => e.cells['Id']!.value);
//     for (var id in idsFilter) {
//       ids.add(id);
//     }
//     return ids;
//   }
// }
