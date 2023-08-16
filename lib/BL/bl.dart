import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/params/params.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

// ignore: prefer_typing_uninitialized_variables
late final Isar isar;
Bl bl = Bl();

class Bl {
  Future init() async {
    await openIsar();
    isar = Isar.get(schemas: [SheetSchema, ParamsSchema]);
  }

  Future<void> openIsar() async {
    await Isar.initialize();
    Isar.open(
      engine: kIsWeb ? IsarEngine.sqlite : IsarEngine.isar,
      schemas: [SheetSchema, ParamsSchema],
      directory: '',
      inspector: true,
    );
  }
}
