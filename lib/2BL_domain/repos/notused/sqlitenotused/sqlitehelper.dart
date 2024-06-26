// import 'dart:io';

// import 'package:dartx/dartx.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

// import '../../../bluti.dart';
// import '../../commonrepos.dart';


// SheetRowsHelper sheetrowsHelper = SheetRowsHelper();

// void sheetrowsPrepare() async {
//   await sheetrowsHelper.initDB();
//   await sheetrowsHelper.deleteAllRows();
// }

// class SheetRowsHelper {
//   Database? _db;

//   Future<Database> get database async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDB();
//     onCreate(_db!, 1);
//     return _db!;
//   }

//   Future<Database> initDB() async {
//     // ignore: prefer_typing_uninitialized_variables
//     var db;
//     if (kIsWeb) {
//       var factory = databaseFactoryFfiWeb;
//       // should print 3.39.3

//       db = await factory.openDatabase('./sheetRows');
//     } else {
//       // NOT running on the web! You can check for additional platforms here.
//       db = await initDBWin();
//     }

//     var sqliteVersion =
//         (await db.rawQuery('select sqlite_version()')).first.values.first;
//     debugPrint('sqliteVersion $sqliteVersion');

//     return db;
//   }

//   Future<Database?> initDBWin() async {
//     if (Platform.isWindows || Platform.isLinux) {
//       // Initialize FFI
//       sqfliteFfiInit();
//       databaseFactory = databaseFactoryFfi;
//       var db = await openDatabase('./sheetRows.sqlite',
//           version: 1, onCreate: onCreate);
//       return db;
//     } else if (Platform.isAndroid || Platform.isIOS) {
//       return null;
//     }
//     throw Exception("Unsupported platform");
//   }

//   Future<void> onCreate(Database database, int version) async {
//     final db = database;
//     await db.execute(sheetRowsCreateTable());
//   }

//   //--------------------------------------------------------------create
//   Future<List<String>> insertRowsCollFromSheet(Response response) async {
//     List data = response.data['data'];

//     Map colsSet = response.data['colsSet'];
//     String sheetName = response.data['sheetName'];
//     List<String> rowkeys = [];

//     final db = await database;
//     for (var i = 0; i < data.length; i++) {
//       List rowarr = blUti.toListString(data[i]);
//       List<String> cols = blUti.toListString(colsSet[sheetName]);
//       String rowkey = rowarr[cols.indexOf('rowkey')];
//       rowkeys.add(rowkey);

//       // SheetRows sheetRow = rowdyn2sheetRows(sheetName, cols, rowarr);
//       // //iporttSupUpsert
//       // db.insert(
//       //   "sheetRows",
//       //   sheetRow.toMap(sheetName),
//       //   conflictAlgorithm: ConflictAlgorithm.replace,
//       // );
//     }

//     return rowkeys;
//   }

//   Future<List<String>> insertRowsCollSql(List sqldata) async {
//     List<String> rowkeys = [];
//     final db = await database;
//     for (var i = 0; i < sqldata.length; i++) {
//       String rowkey = sqldata[i]['rowkey'];
//       rowkeys.add(rowkey);
//       // db.insert(
//       //   "sheetRows",
//       //   SheetRows().toMapFromSup(sqldata[i]),
//       //   conflictAlgorithm: ConflictAlgorithm.replace,
//       // );
//     }

//     return rowkeys.sorted();
//   }

//   Future<List<String>> insertResponseAll(String sheetName, List data) async {
//     List<String> cols = blUti.toListString(data[0]);
//     if (!cols.contains('quote')) return [];

//     return await batchInsert(sheetName, cols, data);
//   }

//   void setCellDLUpdate(
//       String columnName, String cellContent, String rowkey) async {
//     final db = await database;
//     db.update("sheetRows", {columnName: cellContent},
//         where: 'rowkey = ?', whereArgs: [rowkey]);
//   }

//   SheetRows rowdyn2sheetRows(String sheetName, List<String> cols, List rowdyn) {
//     List<String> row = blUti.toListString(rowdyn);

//     String fileurlSet(String value) {
//       if (value.isEmpty) return value;
//       if (!value.startsWith('fb')) {
//         if (!value.startsWith('http')) {
//           value = 'https://docs.google.com/document/d/$value/view';
//         }
//       }
//       return value;
//     }

//     String folderUrlSet(String value) {
//       try {
//         if (value.isEmpty) value = row[cols.indexOf('folderUrl')];
//       } catch (_) {}

//       if (value.isEmpty) return value;
//       if (!value.startsWith('http')) {
//         value = 'https://drive.google.com/drive/u/0/folders/$value';
//       }
//       return value;
//     }

//     String valueGet(String columnName, List<String> row) {
//       int fieldIndex = cols.indexOf(columnName);
//       if (fieldIndex == -1) return '';
//       try {
//         String value = row[fieldIndex];
//         if (columnName == 'fileurl') return fileurlSet(value);
//         if (columnName == 'docUrl') return fileurlSet(value);
//         if (columnName == 'folder') return folderUrlSet(value);
//         return value;
//       } catch (_) {
//         return '';
//       }
//     }

//     SheetRows sheetRow = SheetRows();
//     sheetRow.rowkey = valueGet('rowkey', row);
//     try {
//       sheetRow.sheetName = sheetName;
//     } catch (_) {}
//     sheetRow.quote = valueGet('quote', row);
//     sheetRow.author = valueGet('author', row);
//     sheetRow.book = valueGet('book', row);
//     sheetRow.parPage = valueGet('parPage', row);
//     sheetRow.tags = valueGet('tags', row);
//     sheetRow.yellowParts = valueGet('yellowParts', row);
//     sheetRow.stars = valueGet('stars', row);
//     sheetRow.favorite = valueGet('favorite', row);
//     sheetRow.dateinsert = valueGet('dateinsert', row);
//     sheetRow.sourceUrl = valueGet('sourceUrl', row);

//     if (cols.contains('fileurl')) {
//       sheetRow.fileurl = valueGet('fileurl', row);
//     } else {
//       sheetRow.fileurl = valueGet('docUrl', row);
//     }
//     sheetRow.original = valueGet('original', row);
//     sheetRow.vydal = valueGet('vydal', row);
//     sheetRow.folderUrl = valueGet('folder', row);
//     sheetRow.title = valueGet('title', row);

//     return sheetRow;
//   }

//   Future<List<String>> batchInsert(
//       String sheetName, List<String> cols, List data) async {
//     final db = await database;
//     final batch = db.batch();
//     List<String> rowkeys = [];
//     for (var i = 1; i < data.length; i++) {
//       SheetRows sheetRow = rowdyn2sheetRows(sheetName, cols, data[i]);
//       rowkeys.add(sheetRow.rowkey);
//       batch.insert(
//         'sheetRows',
//         sheetRow.toMap(sheetName),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }

//     await batch.commit();

//     return rowkeys;
//   }

//   Future<List> data2rowmaps(
//       String sheetName, List<String> cols, List data) async {
//     List listmap = [];
//     for (var i = 1; i < data.length; i++) {
//       SheetRows sheetRow = rowdyn2sheetRows(sheetName, cols, data[i]);
//       listmap.add(sheetRow.toMapSup(sheetName));
//     }

//     return listmap;
//   }

//   Future batchCsv(String sheetName, List<String> cols, List data) async {
//     List rows = [];
//     for (var i = 1; i < data.length; i++) {
//       SheetRows sheetRow = rowdyn2sheetRows(sheetName, cols, data[i]);
//       rows.add(sheetRow.toMap(sheetName));
//     }
//   }

//   //----------------------------------------------------------------read

//   Future<List<SheetRows>> getAllRows() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('sheetRows');

//     return List.generate(maps.length, (index) {
//       return SheetRows().fromMap(maps[index]);
//     });
//   }

//   Future<SheetRows> getRowByRowKey(String rowkey) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'sheetRows',
//       where: 'rowkey = ?',
//       whereArgs: [rowkey],
//     );
//     if (maps.isNotEmpty) {
//       return SheetRows().fromMap(maps.first);
//     }

//     return SheetRows();
//   }

//   Future<void> deleteAllRows() async {
//     final db = await database;
//     final Batch batch = db.batch();

//     batch.delete('sheetRows');

//     await batch.commit();
//   }
// }
