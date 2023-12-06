// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/authorsbooks/bookscrud.dart';

import '../DL/dl.dart';
import 'authorsbooks/authorscrud.dart';
import 'bluti.dart';
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
  AuthorSchema,
  BooksSchema,
  RssSchema
];

class Bl {
  bool devMode = false;
  bool userViewMode = true;
  bool highligthOnOff = false;

  Map<String, dynamic> sheetGroups = {};
  Map<String, String> sheetUrls = {};

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
  BooksCRUD booksCRUD = BooksCRUD();
  RssCRUD rssCRUD = RssCRUD();

  Future init() async {
    await isarOpen();

    isar = Isar.get(schemas: schemas);

    devModeSet();
  }

  void updateSlowly() {
    bl.catsCRUD.update();
    authorCRUD.updateAuthors();
    booksCRUD.updateBooks();
    sheetUrlsBuild();
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

void sheetUrlsBuild() async {
  List rootRows = await dl.httpService.getRootConfig();
  List<String> cols = blUti.toListString(rootRows[0]);
  int sheetNameIx = cols.indexOf('sheetName');
  int sheetUrlIx = cols.indexOf('sheetUrl');
  for (List row in rootRows) {
    List<String> rowStr = blUti.toListString(row);

    try {
      if (rowStr[sheetNameIx].isEmpty) continue;
      bl.sheetUrls[rowStr[sheetNameIx]] = rowStr[sheetUrlIx];
    } catch (_) {}
  }
  debugPrint('sheetUrlsBuild() ${bl.sheetUrls.length}');
}
