import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase()
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 3;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File('./db.sqlite');

    return NativeDatabase.createInBackground(file);
  });
}
