// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/params/params.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

// ignore: prefer_typing_uninitialized_variables
late final Isar isar;
Bl bl = Bl();

class Bl {
  bool devMode = false;

  Future init() async {
    updateStartParams();
    devModeSet();
    await openIsar();
    //isar = Isar.get(schemas: [SheetSchema, ParamsSchema]);
  }

  Future<void> openIsar() async {
    try {
      if (isar.isOpen) return;
    } catch (_) {}
    await Isar.initialize();
    isar = Isar.open(
      engine: kIsWeb ? IsarEngine.sqlite : IsarEngine.isar,
      schemas: [SheetSchema, ParamsSchema],
      directory: kIsWeb ? Isar.sqliteInMemory : '../',
      inspector: true,
    );
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
