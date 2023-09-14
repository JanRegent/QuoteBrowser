// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'categories/catscrud.dart';
import 'orm.dart';

Bl bl = Bl();

class Bl {
  bool devMode = false;

  Orm orm = Orm();
  CatsCRUD catsCRUD = CatsCRUD();
  //CRUDsembast crud = CRUDsembast();

  Future init() async {
    await isarOpen();
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

  isar = Isar.open(
    schemas: [CatSchema],
    directory: docsPath,
    engine: IsarEngine.sqlite,
  );

  await bl.catsCRUD.update();
}
