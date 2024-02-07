import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;

// ignore: unnecessary_import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../bluti.dart';

class SheetRows {
  String rownoKey = '';
  String sheetName = '';
  String quote = '';
  String author = '';
  String book = '';
  String parPage = '';
  String tags = '';
  String yellowParts = '';
  String stars = '';
  String favorite = '';
  String dateinsert = '';
  String sourceUrl = '';
  String fileUrl = '';
  String original = '';
  String vydal = '';
  String folderUrl = '';
  String title = '';

  SheetRows();

  Map<String, dynamic> toMap() {
    return {
      "rownoKey": rownoKey,
      "sheetname": rownoKey.split('__|__')[0],
      "quote": quote,
      "author": author,
      "book": book,
      "parPage": rownoKey,
      "tags": tags,
      "yellowParts": yellowParts,
      "stars": stars,
      "favorite": favorite,
      "dateinsert": dateinsert,
      "sourceUrl": sourceUrl,
      "fileUrl": fileUrl,
      "original": original,
      "vydal": vydal,
      "folderUrl": folderUrl,
      "title": title,
    };
  }

  SheetRows fromMap(var maprow) {
    SheetRows row = SheetRows();

    row.rownoKey = maprow['rownoKey'] ?? '';
    row.sheetName = maprow['sheetName'] ?? '';
    row.quote = maprow['quote'] ?? '';
    row.author = maprow['author'] ?? '';
    row.book = maprow['book'] ?? '';
    row.parPage = maprow['rownoKey'] ?? '';
    row.tags = maprow['tags'] ?? '';
    row.yellowParts = maprow['yellowParts'] ?? '';
    row.stars = maprow['stars'] ?? '';
    row.favorite = maprow['favorite'] ?? '';
    row.dateinsert = maprow['dateinsert'] ?? '';
    row.sourceUrl = maprow['sourceUrl'] ?? '';
    row.fileUrl = maprow['fileUrl'] ?? '';
    row.original = maprow['original'] ?? '';
    row.vydal = maprow['vydal'] ?? '';
    row.folderUrl = maprow['folderUrl'] ?? '';
    row.title = maprow['title'] ?? '';
    return row;
  }
}

SheetRowsHelper sheetrowsHelper = SheetRowsHelper();

void sheetrowsPrepare() async {
  await sheetrowsHelper.initDB();
  await sheetrowsHelper.deleteAllRows();
  //await tagIndexHelper.batchInsert();
}

class SheetRowsHelper {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    onCreate(_db!, 1);
    return _db!;
  }

  Future<Database> initDB() async {
    // ignore: prefer_typing_uninitialized_variables
    var db;
    if (kIsWeb) {
      var factory = databaseFactoryFfiWeb;
      // should print 3.39.3

      db = await factory.openDatabase('./sheetRows');
    } else {
      // NOT running on the web! You can check for additional platforms here.
      db = await initDBWin();
    }

    var sqliteVersion =
        (await db.rawQuery('select sqlite_version()')).first.values.first;
    debugPrint('sqliteVersion $sqliteVersion');

    return db;
  }

  Future<Database?> initDBWin() async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      var db = await openDatabase('./sheetRows.sqlite',
          version: 1, onCreate: onCreate);
      return db;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return null;
    }
    throw Exception("Unsupported platform");
  }

  Future<void> onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS sheetRows(
            rownoKey TEXT PRIMARY KEY,
            sheetName TEXT,
            quote TEXT,
            author TEXT,
            book TEXT,
            parPage TEXT,
            tags TEXT,
            yellowParts TEXT,
            stars TEXT,
            favorite TEXT,
            dateinsert TEXT,
            sourceUrl TEXT,
            fileUrl TEXT,
            original TEXT,
            vydal TEXT,
            folderUrl TEXT,
            title
          )
 """);
  }

  //--------------------------------------------------------------create
  Future<SheetRows> insertRow(SheetRows sheetrow) async {
    final db = await database;
    db.insert(
      "sheetRows",
      sheetrow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return sheetrow;
  }

  Future insertResponse(Response response) async {
    List data = response.data['data'];
    List<String> cols = blUti.toListString(data[0]);
    if (!cols.contains('quote')) return;
    await sheetrowsHelper.deleteAllRows();
    print(cols);
    await batchInsert(cols, data);
  }

  Future<List<SheetRows>> batchInsert(List<String> cols, List data) async {
    String valueGet(String columnName, List<String> row) {
      int fieldIndex = cols.indexOf(columnName);
      if (fieldIndex == -1) return '';
      try {
        String value = row[fieldIndex];
        return value;
      } catch (_) {
        return '';
      }
    }

    final db = await database;
    final batch = db.batch();
    List<SheetRows> rowList = [];

    for (var i = 1; i < data.length; i++) {
      List<String> row = blUti.toListString(data[i]);

      SheetRows sheetRow = SheetRows();
      sheetRow.rownoKey = valueGet('rownoKey', row);
      sheetRow.sheetName = sheetRow.rownoKey.split('__|__')[0];
      sheetRow.quote = valueGet('quote', row);
      sheetRow.author = valueGet('author', row);
      sheetRow.book = valueGet('book', row);
      sheetRow.parPage = valueGet('rownoKey', row);
      sheetRow.tags = valueGet('tags', row);
      sheetRow.yellowParts = valueGet('yellowParts', row);
      sheetRow.stars = valueGet('stars', row);
      sheetRow.favorite = valueGet('favorite', row);
      sheetRow.dateinsert = valueGet('dateinsert', row);
      sheetRow.sourceUrl = valueGet('sourceUrl', row);
      sheetRow.fileUrl = valueGet('fileUrl', row);
      sheetRow.original = valueGet('original', row);
      sheetRow.vydal = valueGet('vydal', row);
      sheetRow.folderUrl = valueGet('folderUrl', row);
      sheetRow.title = valueGet('title', row);

      rowList.add(sheetRow);
      batch.insert(
        'sheetRows',
        sheetRow.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();

    return rowList;
  }

  //----------------------------------------------------------------read
  Future<List<String>> getTagsStarts(String tagPrefix) async {
    if (tagPrefix.trim().length < 2) return [];
    final db = await database;
    var res = await db
        .query("tagindex", where: "tag LIKE ?", whereArgs: ['$tagPrefix%']);

    List<String> tagList = [];
    for (var element in res) {
      tagList.add(element['tag'].toString());
    }

    return tagList;
  }

  Future<List<SheetRows>> getAllRows() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sheetRows');

    return List.generate(maps.length, (index) {
      return SheetRows().fromMap(maps[index]);
    });
  }

  Future<SheetRows?> getRowByRownoKey(String rownoKey) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sheetRows',
      where: 'rownoKey = ?',
      whereArgs: [rownoKey],
    );

    if (maps.isNotEmpty) {
      return SheetRows().fromMap(maps);
    }

    return null;
  }

  Future<void> deleteAllRows() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('sheetRows');

    await batch.commit();
  }
}
