import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

part 'tags.g.dart';

class TagsItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tag => text().named('tag')();
  TextColumn get rownos => text().named('rownos')();
}

@DriftDatabase(tables: [TagsItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  @override
  int get schemaVersion => 3;
}
