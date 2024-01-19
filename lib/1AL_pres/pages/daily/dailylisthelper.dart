import 'dart:math';
import 'package:flutter/foundation.dart' show debugPrint, immutable;

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

@immutable
class User {
  final int id;
  final String name;
  final String email;
  final int password;
  final int phoneNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
    };
  }
}

class DailyListHelper {
  Database? _db;

  var factory = databaseFactoryFfiWeb;
  // should print 3.39.3

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await initWinDB();
    onCreate(_db!, 1);
    return _db!;
  }

  Future<Database> initWinDB() async {
    var db = await factory.openDatabase('./tagIndex');
    var sqliteVersion =
        (await db.rawQuery('select sqlite_version()')).first.values.first;
    debugPrint('sqliteVersion $sqliteVersion');

    return db;
  }

  Future<void> onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            password INTEGER,
            phoneNumber INTEGER
          )
 """);
  }

  Future<User> insertUSer(User user) async {
    final db = await database;
    db.insert(
      "users",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<User>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    final Random random = Random();
    final List<User> userList = List.generate(
      1000,
      (index) => User(
        id: index + 1,
        name: 'User $index',
        email: 'user$index@example.com',
        password: random.nextInt(9999),
        phoneNumber: random.nextInt(10000),
      ),
    );
    for (final User user in userList) {
      batch.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return userList;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        name: maps[index]['name'],
        email: maps[index]['email'],
        password: maps[index]['password'],
        phoneNumber: maps[index]['phoneNumber'],
      );
    });
  }

  Future<User?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        name: maps[0]['name'],
        email: maps[0]['email'],
        password: maps[0]['password'],
        phoneNumber: maps[0]['phoneNumber'],
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
