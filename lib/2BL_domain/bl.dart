// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/repos/supabaserepo.dart';

import '../3Data/providers/gwebapp/tagsparts.dart';
import 'currow.dart';
import 'repos/adminrepo/repoadmin.dart';
import 'repos/authbooksmap.dart';

import 'bluti.dart';

import 'repos/koyebrepo.dart';
import 'repos/neonrepo.dart';

import 'usecases/keys4swiper/_preparekeys.dart';

Bl bl = Bl();

class Bl {
  bool devMode = false;

  //RxString filteredSheetName = ''.obs;
  RxMap lastCount = {}.obs;
  RxMap booksCount = {}.obs;
  RxString homeTitle = ''.obs;

  CurrentSS currentSS = CurrentSS();
  CurRow curRow = CurRow();

  PrepareKeys prepareKeys = PrepareKeys();

  RepoAdmin repoAdmin = const RepoAdmin();
  SupabaseRepo supRepo = SupabaseRepo();
  NeonRepo neonRepo = NeonRepo();
  KoyebRepo koyebRepo = KoyebRepo();

  //FirestoreRepo fireRepo = FirestoreRepo();

  TagsParts tagsParts = TagsParts();

  Future init() async {
    debugPrint('sheetRowsHelper init start');
    //await sheetRowsHelper.initDB(); sqlite
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

