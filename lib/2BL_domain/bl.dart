// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/repos/supabaserepo.dart';

import '../1PL/pages/2books/bookslist.dart';
import 'tagsparts.dart';
import 'repos/adminrepo/repoadmin.dart';
import 'repos/authbooksmap.dart';
import 'repos/dailylist.dart';

import 'bluti.dart';

import 'orm.dart';
import 'repos/elephantrepo.dart';
import 'repos/neonrepo.dart';
import 'repos/koyebrepo.dart';
import 'repos/pgedgerepo.dart';
import 'repos/sheetrowshelper.dart';
import 'usecases/keys4swiper/_preparekeys.dart';

Bl bl = Bl();

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
  SheetRowsHelper sheetRowsHelper = SheetRowsHelper();

  PrepareKeys prepareKeys = PrepareKeys();

  RepoAdmin repoAdmin = const RepoAdmin();
  SupabaseRepo supRepo = SupabaseRepo();
  NeonRepo neonRepo = NeonRepo();
  KoyebRepo koyebRepo = KoyebRepo();
  PgedgebRepo pgedgebRepo = PgedgebRepo();
  ElephantRepo elephantRepo = ElephantRepo();

  //FirestoreRepo fireRepo = FirestoreRepo();

  TagsParts tagsParts = TagsParts();

  Future init() async {
    debugPrint('sheetRowsHelper init start');
    await sheetRowsHelper.initDB();
    debugPrint('supRepo init start');
    await supRepo.init();

    if (!kIsWeb) {
      debugPrint('neonRepo init start');
      await neonRepo.init();
      debugPrint('koyebRepo init start');

      try {
        await koyebRepo.init();
      } catch (_) {} //Exception: Null check operator

      // debugPrint('PgedgebRepo init start');
      // debugPrint(pgedgebRepo.conn.isOpen.toString());
      // await pgedgebRepo.init();
    }
    devModeSet();
  }

  List<String> authors = [];
  Set authorsSet = {};
  AuthorBooksMap authorBooksMap = AuthorBooksMap();
  void updateSlowly() async {
    authors = [];
    authors.addAll(blUti.toListString(authorsSet.toList().sorted()));
    authorBooksMap.getData();
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

