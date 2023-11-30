// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import 'categories/catscrud.dart';

import 'columntext/authorscrud.dart';
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
  AuthorSchema,
  RssSchema
];

class Bl {
  bool devMode = false;

  Map<String, dynamic> sheetGroups = {};
  String sheetGroupCurrent = '';
  RxString filteredSheetName = ''.obs;
  RxMap lastCount = {}.obs;
  RxString homeTitle = '(qb)Home'.obs;

  Orm orm = Orm();
  CatsCRUD catsCRUD = CatsCRUD();
  SheetrowsCRUD sheetrowsCRUD = SheetrowsCRUD();
  SheetcolsCRUD sheetcolsCRUD = SheetcolsCRUD();
  FiltersCRUD filtersCRUD = FiltersCRUD();
  ColumnTextFilterCRUD columnTextFilterCRUD = ColumnTextFilterCRUD();
  AuthorCRUD authorCRUD = AuthorCRUD();
  RssCRUD rssCRUD = RssCRUD();

  Future init() async {
    await isarOpen();

    isar = Isar.get(schemas: schemas);
    await bl.catsCRUD.update();

    devModeSet();

    authorCRUD.updateAuthors();

    // dl.httpService
    //     .getDataSheets(dataSheetId)
    //     .then((values) => currentSS.sheetNames = values);
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
