// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:quotebrowser/BL/authorsbooks/bookscrud.dart';

import '../AL/_home/pages/books/bookslist.dart';
import '../AL/_home/pages/daily/dailylist.dart';

import 'categories/catscrud.dart';

import 'columntext/columntextfilter.dart';
import 'filtersbl/simplefilter.dart';
import 'orm.dart';
import 'rss/rss.dart';
import 'sheetrows/sheetcolscrud.dart';
import 'sheetrows/sheetrowscrud.dart';

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
    await deviceInfoInit();

    await isarOpen();

    isar = Isar.get(schemas: schemas);

    devModeSet();
  }

  final deviceInfoPlugin = DeviceInfoPlugin();

  // ignore: prefer_typing_uninitialized_variables
  late final deviceInfoAll;

  Future deviceInfoInit() async {
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //print(json.decode(androidInfo.display)); // e.g. "Moto G (4)"

    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"

    // WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    // print('Running on ${webBrowserInfo.userAgent}');
  }

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
