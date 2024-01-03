import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart' show debugPrint, immutable, kIsWeb;

// ignore: unnecessary_import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

@immutable
class TagIndex {
  final int id;
  final String tag;
  final String sheetName;
  final String rownos;

  const TagIndex({
    required this.id,
    required this.tag,
    required this.sheetName,
    required this.rownos,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tag": tag,
      "sheetname": sheetName,
      "rownos": rownos,
    };
  }
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
    await db.execute(""" CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY,
            tag TEXT,
            sheetname TEXT,
            rownos TEXT
          )
 """);
  }

  Future<TagIndex> insertUSer(TagIndex user) async {
    final db = await database;
    db.insert(
      "users",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<TagIndex>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    final Random random = Random();
    final List<TagIndex> userList = List.generate(
      1000,
      (index) => TagIndex(
        id: index + 1,
        tag: 'User $index',
        sheetName: 'user$index@example.com',
        rownos: random.nextInt(9999).toString(),
      ),
    );
    for (final TagIndex user in userList) {
      batch.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return userList;
  }

  Future<List<TagIndex>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (index) {
      return TagIndex(
        id: maps[index]['id'],
        tag: maps[index]['tag'] ?? '',
        sheetName: maps[index]['sheetName'] ?? '',
        rownos: maps[index]['rownos'] ?? '',
      );
    });
  }

  Future<TagIndex?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return TagIndex(
        id: maps[0]['id'],
        tag: maps[0]['name'],
        sheetName: maps[0]['email'],
        rownos: maps[0]['password'],
      );
    }

    return null;
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('users');

    await batch.commit();
  }
}
