// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:quotebrowser/2BL_domain/entities/authorsbooks/bookscrud.dart';

import '../1AL_pres/pages/books/bookslist.dart';

import 'usecases/dailylist/dailylist.dart';
import 'entities/categories/catscrud.dart';

import 'usecases/columntext/columntextfilter.dart';
import 'usecases/filtersbl/simplefilter.dart';
import 'orm.dart';
import 'usecases/rss/rss.dart';
import 'entities/sheetrows/sheetcolscrud.dart';
import 'entities/sheetrows/sheetrowscrud.dart';

Bl bl = Bl();
List<IsarGeneratedSchema> schemas = [
  CatSchema,
  SheetRowSchema,
  SheetColSchema,
  SimpleFilterSchema,
  ColumnTextFilterSchema,
  BooksSchema,
  RssSchema
];

class Bl {
  bool devMode = false;
  bool userViewMode = true;
  bool highligthOnOff = false;

  Color saveHeadColor = Colors.lightBlue;

  DailyList dailyList = DailyList();
  BooksList bookList = BooksList();

  RxString filteredSheetName = ''.obs;
  RxMap lastCount = {}.obs;
  RxMap booksCount = {}.obs;
  RxString homeTitle = '(qb)Home'.obs;

  Orm orm = Orm();
  CatsCRUD catsCRUD = CatsCRUD();
  SheetrowsCRUD sheetrowsCRUD = SheetrowsCRUD();
  SheetcolsCRUD sheetcolsCRUD = SheetcolsCRUD();
  FiltersCRUD filtersCRUD = FiltersCRUD();
  ColumnTextFilterCRUD columnTextFilterCRUD = ColumnTextFilterCRUD();

  BooksCRUD booksCRUD = BooksCRUD();
  RssCRUD rssCRUD = RssCRUD();

  Future init() async {
    await isarOpen();

    isar = Isar.get(schemas: schemas);

    devModeSet();
  }

  final deviceInfoPlugin = DeviceInfoPlugin();

  // ignore: prefer_typing_uninitialized_variables
  late final deviceInfoAll;

  void updateSlowly() async {
    bl.catsCRUD.update();
    booksCRUD.updateBooks();
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
      //Isar.open if kIsWeb
      schemas: schemas,
      directory: docsPath,
      engine: kIsWeb ? IsarEngine.sqlite : IsarEngine.isar,
      inspector: true);

  debugPrint('Isar open ${isar.isOpen}');
}