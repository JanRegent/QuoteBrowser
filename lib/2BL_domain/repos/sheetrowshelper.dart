import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;

// ignore: unnecessary_import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../bl.dart';
import '../bluti.dart';

class SheetRows {
  String rownoKey = '';
  String sheetName = '';
  String rowNo = '';
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
      "rowNo": rownoKey.split('__|__')[1],
      "quote": quote,
      "author": author,
      "book": book,
      "parPage": parPage,
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

  Map<String, dynamic> toMapSup() {
    return {
      "rownokey": rownoKey,
      "sheetname": rownoKey.split('__|__')[0],
      "rowno": rownoKey.split('__|__')[1],
      "quote": quote,
      "author": author,
      "book": book,
      "parpage": parPage,
      "tags": tags,
      "yellowparts": yellowParts,
      "stars": stars,
      "favorite": favorite,
      "dateinsert": dateinsert,
      "sourceurl": sourceUrl,
      "fileurl": fileUrl,
      "original": original,
      "vydal": vydal,
      "folderurl": folderUrl,
      "title": title,
    };
  }

  SheetRows fromMap(var maprow) {
    SheetRows row = SheetRows();
    row.rownoKey = maprow['rownoKey'] ?? '';
    row.sheetName = maprow['sheetName'] ?? '';
    row.rowNo = maprow['rowNo'] ?? '';
    row.quote = maprow['quote'] ?? '';
    row.author = maprow['author'] ?? '';
    row.book = maprow['book'] ?? '';
    row.parPage = maprow['parPage'] ?? '';
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

  void toString_() {
    debugPrint(
        '''
      "rownoKey":     $rownoKey
      "sheetname":  $sheetName
      "rowNo":      $rowNo
      "author":     $author
      "book":       $book
      "parPage":    $parPage
      "tags":       $tags
      "yellowParts":$yellowParts
      "stars":      $stars
      "favorite":   $favorite
      "dateinsert": $dateinsert
      "sourceUrl":  $sourceUrl
      "fileUrl":    $fileUrl
      "original":   $original
      "vydal":      $vydal
      "folderUrl":  $folderUrl
      "title":      $title
            "quote":      $quote

    };
  }

    ''');
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
    await db.execute(
        """ CREATE TABLE IF NOT EXISTS sheetRows(
            rownoKey TEXT PRIMARY KEY,
            sheetName TEXT,
            rowNo TEXT,
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
  Future<List<String>> insertRowsCollection(Response response) async {
    List data = response.data['data'];
    Map colsSet = response.data['colsSet'];
    List<String> rownoKeys = [];
    final db = await database;
    for (var i = 0; i < data.length; i++) {
      List rowarr = blUti.toListString(data[i]);
      String rownoKey = rowarr[0];
      rownoKeys.add(rownoKey);
      String sheetName = rownoKey.split('__|__')[0];
      List<String> cols = blUti.toListString(colsSet[sheetName]);
      SheetRows sheetRow = rowdyn2sheetRows(cols, rowarr);
      db.insert(
        "sheetRows",
        sheetRow.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return rownoKeys;
  }

  Future<List<String>> insertResponseAll(List data) async {
    List<String> cols = blUti.toListString(data[0]);
    if (!cols.contains('quote')) return [];

    return await batchInsert(cols, data);
  }

  Future<List> insertResponseAllSup(List data, String sheetName) async {
    try {
      List<String> cols = blUti.toListString(data[0]);
      if (!cols.contains('quote')) return [];
      return await batchInsertSup(cols, data);
    } catch (e) {
      String mess = '''
      sheetName: $sheetName
      err: \n$e
      ''';
      bl.supRepo.log2sheetrows(mess);
      return [];
    }
  }

  Future<List> insertResponseTagindexSup(List data, String sheetName) async {
    List maprows = [];
    try {
      for (int rIx = 1; rIx < data.length; rIx++) {
        maprows.add({
          "tag": data[rIx][1],
          "sheetname": data[rIx][2],
          "rownos": data[rIx][3]
        });
      }

      return maprows;
    } catch (e) {
      String mess = '''
      sheetName: $sheetName
      err: \n$e
      ''';
      bl.supRepo.log2sheetrows(mess);
      return [];
    }
  }

  SheetRows rowdyn2sheetRows(List<String> cols, List rowdyn) {
    List<String> row = blUti.toListString(rowdyn);

    String fileUrlSet(String value) {
      if (value.isEmpty) return value;
      if (!value.startsWith('fb')) {
        if (!value.startsWith('http')) {
          value = 'https://docs.google.com/document/d/$value/view';
        }
      }
      return value;
    }

    String folderUrlSet(String value) {
      try {
        if (value.isEmpty) value = row[cols.indexOf('folderUrl')];
      } catch (_) {}

      if (value.isEmpty) return value;
      if (!value.startsWith('http')) {
        value = 'https://drive.google.com/drive/u/0/folders/$value';
      }
      return value;
    }

    String valueGet(String columnName, List<String> row) {
      int fieldIndex = cols.indexOf(columnName);
      if (fieldIndex == -1) return '';
      try {
        String value = row[fieldIndex];
        if (columnName == 'fileUrl') return fileUrlSet(value);
        if (columnName == 'docUrl') return fileUrlSet(value);
        if (columnName == 'folder') return folderUrlSet(value);
        return value;
      } catch (_) {
        return '';
      }
    }

    SheetRows sheetRow = SheetRows();
    sheetRow.rownoKey = valueGet('rownoKey', row);
    try {
      sheetRow.sheetName = sheetRow.rownoKey.split('__|__')[0];
      sheetRow.rowNo = sheetRow.rownoKey.split('__|__')[1];
    } catch (_) {}
    sheetRow.quote = valueGet('quote', row);
    sheetRow.author = valueGet('author', row);
    sheetRow.book = valueGet('book', row);
    sheetRow.parPage = valueGet('parPage', row);
    sheetRow.tags = valueGet('tags', row);
    sheetRow.yellowParts = valueGet('yellowParts', row);
    sheetRow.stars = valueGet('stars', row);
    sheetRow.favorite = valueGet('favorite', row);
    sheetRow.dateinsert = valueGet('dateinsert', row);
    sheetRow.sourceUrl = valueGet('sourceUrl', row);

    if (cols.contains('fileUrl')) {
      sheetRow.fileUrl = valueGet('fileUrl', row);
    } else {
      sheetRow.fileUrl = valueGet('docUrl', row);
    }
    sheetRow.original = valueGet('original', row);
    sheetRow.vydal = valueGet('vydal', row);
    sheetRow.folderUrl = valueGet('folder', row);
    sheetRow.title = valueGet('title', row);

    return sheetRow;
  }

  Future<List<String>> batchInsert(List<String> cols, List data) async {
    final db = await database;
    final batch = db.batch();
    List<String> rownoKeys = [];
    for (var i = 1; i < data.length; i++) {
      SheetRows sheetRow = rowdyn2sheetRows(cols, data[i]);
      rownoKeys.add(sheetRow.rownoKey);
      batch.insert(
        'sheetRows',
        sheetRow.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();

    return rownoKeys;
  }

  Future<List> batchInsertSup(List<String> cols, List data) async {
    List listmap = [];
    for (var i = 1; i < data.length; i++) {
      SheetRows sheetRow = rowdyn2sheetRows(cols, data[i]);
      listmap.add(sheetRow.toMapSup());
    }

    return listmap;
  }

  Future batchCsv(List<String> cols, List data) async {
    List rows = [];
    for (var i = 1; i < data.length; i++) {
      SheetRows sheetRow = rowdyn2sheetRows(cols, data[i]);
      rows.add(sheetRow.toMap());
    }
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

  Future<List<String>> searchWord(String word) async {
    try {
      final db = await database;
      var res = await db
          .query("tagindex", where: "tag LIKE ?", whereArgs: ['$word%']);
      List<String> keys = [];
      for (var i = 0; i < res.length; i++) {
        SheetRows sheetRow = SheetRows().fromMap(res[i]);

        keys.add(sheetRow.rownoKey);
      }
      return keys;
    } catch (e) {
      debugPrint('searchWord().readAll()\n$e');
      return [];
    }
  }

  Future<List<SheetRows>> getAllRows() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sheetRows');

    return List.generate(maps.length, (index) {
      return SheetRows().fromMap(maps[index]);
    });
  }

  Future<SheetRows> getRowByRownoKey(String rownoKey) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sheetRows',
      where: 'rownoKey = ?',
      whereArgs: [rownoKey],
    );
    if (maps.isNotEmpty) {
      return SheetRows().fromMap(maps.first);
    }

    return SheetRows();
  }

  Future<void> deleteAllRows() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('sheetRows');

    await batch.commit();
  }
}
