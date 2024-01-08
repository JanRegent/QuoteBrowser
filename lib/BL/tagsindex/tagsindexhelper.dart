import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint, immutable, kIsWeb;

// ignore: unnecessary_import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../DL/backendurl.dart';
import '../../DL/dl.dart';
import '../bluti.dart';

@immutable
class TagIndex {
  final String tag;
  final String sheetName;
  final String rownos;

  const TagIndex({
    required this.tag,
    required this.sheetName,
    required this.rownos,
  });
  Map<String, dynamic> toMap() {
    return {
      "tag": tag,
      "sheetname": sheetName,
      "rownos": rownos,
    };
  }
}

void tagIndexPrepare() async {
  TagIndexHelper tagIndexHelper = TagIndexHelper();

  await tagIndexHelper.initDB();
  await tagIndexHelper.deleteAllTags();
  await tagIndexHelper.batchInsert();
  List<TagIndex> users = await tagIndexHelper.getAllTags();
  debugPrint(users[10].toMap().toString());
}

class TagIndexHelper {
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

      db = await factory.openDatabase('./tagIndex');
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
      var db = await openDatabase('./tagIndex.sqlite',
          version: 1, onCreate: onCreate);
      return db;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return null;
    }
    throw Exception("Unsupported platform");
  }

  Future<void> onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS tagindex(
            tag TEXT PRIMARY KEY,
            sheetname TEXT,
            rownos TEXT
          )
 """);
  }

  Future<TagIndex> insertTag(TagIndex user) async {
    final db = await database;
    db.insert(
      "tagindex",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<TagIndex>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    List<TagIndex> userList = [];
    List tagIndex =
        await dl.httpService.getAllrows('__tagSheets__', rootSheetId);

    List<String> cols = blUti.toListString(tagIndex[0]);

    int tagIx = cols.indexOf('tag');
    int sheetNameIx = cols.indexOf('sheetName');
    int rownosIx = cols.indexOf('rownos');

    for (var i = 1; i < tagIndex.length; i++) {
      List<String> row = blUti.toListString(tagIndex[i]);

      TagIndex user = TagIndex(
        tag: row[tagIx],
        sheetName: row[sheetNameIx],
        rownos: row[rownosIx],
      );
      userList.add(user);
      batch.insert(
        'tagindex',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
    return userList;
  }

  Future<List<TagIndex>> getAllTags() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tagindex');

    return List.generate(maps.length, (index) {
      return TagIndex(
        tag: maps[index]['tag'] ?? '',
        sheetName: maps[index]['sheetName'] ?? '',
        rownos: maps[index]['rownos'] ?? '',
      );
    });
  }

  Future<TagIndex?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tagindex',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return TagIndex(
        tag: maps[0]['tag'],
        sheetName: maps[0]['sheetname'],
        rownos: maps[0]['rownos'],
      );
    }

    return null;
  }

  Future<void> deleteAllTags() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('tagindex');

    await batch.commit();
  }
}
