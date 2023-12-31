import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: unused_import
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../../BL/bluti.dart';

import '../backendurl.dart';
import '../dl.dart';

void tagsIndexSqLite() async {
//   return;
// // Use the ffi web factory in web apps (flutter or dart)
//   var factory = databaseFactoryFfiWeb;
//   var db = await factory.openDatabase('./qbdb');
//   var sqliteVersion =
//       (await db.rawQuery('select sqlite_version()')).first.values.first;
//   debugPrint('sqliteVersion $sqliteVersion'); // should print 3.39.3

//   // await db.rawQuery(tadIndexTableCreate);
//   try {
//     const tagsIndexTable =
//         "CREATE TABLE TagsIndex (id INTEGER PRIMARY KEY, tag TEXT, sheetname TEXT, rownos Text)";

//     await db.rawQuery(tagsIndexTable);
//   } catch (_) {}

//   //await tagsIndexSQL(db);
//   List<Map<String, Object?>> rows = await db.rawQuery(
//       "select * from TagsIndex where tag like 'laska%' AND sheetname like '%amana%'");
//   for (var row in rows) {
//     debugPrint(row.toString());
//   }

//   rows = await db.rawQuery(
//       "select * from TagsIndex where tag = '*****'  AND sheetname like '%EMT%' ");
//   for (var row in rows) {
//     debugPrint(row.toString());
//   }
}

void tagsIndexSP() async {
  List tagIndex = await dl.httpService.getAllrows('__tagSheets__', rootSheetId);

// Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> cols = blUti.toListString(tagIndex[0]);

  int tagIx = cols.indexOf('tag');
  int sheetNameIx = cols.indexOf('sheetName');
  int rownosIx = cols.indexOf('rownos');
  for (var i = 1; i < tagIndex.length; i++) {
    List<String> row = blUti.toListString(tagIndex[i]);
    String tag = row[tagIx];
    String sheetName = row[sheetNameIx];
    String rownos = row[rownosIx];
    await prefs.setString('${tag}__|__$sheetName', rownos);
  }

  Iterable<String> keys =
      prefs.getKeys().where((key) => key.startsWith('*****'));
  for (String key in keys) {
    String? value = prefs.getString(
        key); // Throws an error if you store something other than a String
    debugPrint('$key  $value');
  }
}
