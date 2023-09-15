// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'categories/catscrud.dart';
import 'orm.dart';
import 'sheetrows/sheetcolscrud.dart';
import 'sheetrows/sheetrowscrud.dart';

Bl bl = Bl();

class Bl {
  bool devMode = false;

  Orm orm = Orm();
  CatsCRUD catsCRUD = CatsCRUD();
  SheetrowsCRUD sheetrowsCRUD = SheetrowsCRUD();
  SheetcolsCRUD sheetcolsCRUD = SheetcolsCRUD();
  //CRUDsembast crud = CRUDsembast();

  Future init() async {
    await isarOpen();

    isar = Isar.get(schemas: [CatSchema, SheetRowSchema, SheetColSchema]);
    await bl.catsCRUD.update();

    devModeSet();
  }

  void devModeSet() {
    //flutter run -d chrome --web-renderer html --dart-define=devmode=1
    try {
      String devModeStr =
          const String.fromEnvironment('devmode', defaultValue: '');
      if (devModeStr == '1') devMode = true;
    } catch (_) {}
  }
}

//----------------------------------------------------------isar
late Isar isar;
Future isarOpen() async {
  try {
    if (isar.isOpen) return;
  } catch (_) {}
  await Isar.initialize();

  const docsPath = kIsWeb ? Isar.sqliteInMemory : '../';

  isar = await Isar.openAsync(
      schemas: [CatSchema, SheetRowSchema, SheetColSchema],
      directory: docsPath,
      engine: kIsWeb ? IsarEngine.sqlite : IsarEngine.isar,
      inspector: true);

  debugPrint('Isar open ${isar.isOpen}');
}
