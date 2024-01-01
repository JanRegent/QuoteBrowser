import 'package:drift/drift.dart';

class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get post => text().nullable()();
  IntColumn get salary => integer().nullable()();
}
