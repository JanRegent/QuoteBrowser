// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'package:quotebrowser/2BL_domain/entities/authorsbooks/bookscrud.dart';

import '../1PL/pages/2books/bookslist.dart';
import '../1PL/pages/1bydate/dailylist.dart';

import 'bluti.dart';
import 'entities/categories/catscrud.dart';

import 'entities/sheetrows/sheetrowshelper.dart';
import 'orm.dart';
import 'usecases/keys4swiper/_preparekeys.dart';

import 'entities/sheetrows/sheetcolscrud.dart';
import 'entities/sheetrows/sheetrowscrud.dart';

Bl bl = Bl();
List<IsarGeneratedSchema> schemas = [
  CatSchema,
  SheetRowSchema,
  SheetColSchema,
  BooksSchema,
];

class Bl {
  bool devMode = false;
  bool userViewMode = true;
  bool highligthOnOff = false;

  Color saveHeadColor = Colors.lightBlue;

  DailyList dailyList = DailyList();
  BooksList bookList = BooksList();

  //RxString filteredSheetName = ''.obs;
  RxMap lastCount = {}.obs;
  RxMap booksCount = {}.obs;
  RxString homeTitle = ''.obs;

  Orm orm = Orm();
  CatsCRUD catsCRUD = CatsCRUD();
  SheetrowsCRUD sheetrowsCRUD = SheetrowsCRUD();
  SheetRowsHelper sheetRowsHelper = SheetRowsHelper();
  SheetcolsCRUD sheetcolsCRUD = SheetcolsCRUD();

  BooksCRUD booksCRUD = BooksCRUD();

  PrepareKeys prepareKeys = PrepareKeys();

  Future init() async {
    await sheetRowsHelper.initDB();
    await isarOpen();

    isar = Isar.get(schemas: schemas);

    devModeSet();
  }

  List<String> authors = [];
  Set authorsSet = {};

  void updateSlowly() async {
    authors = [];
    authors.addAll(blUti.toListString(authorsSet.toList().sorted()));
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
