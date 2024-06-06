// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/2BL_domain/repos/supabase/suprepo.dart';

import '../3Data/providers/gwebapp/tagsparts.dart';
import 'currow.dart';
import 'repos/authbooksmap.dart';

import 'repos/firestorerepo.dart';
import 'repos/supabase/w5filtersrepo.dart';
import 'repos/backuprepos/koyebrepo.dart';
import 'repos/backuprepos/neonrepo.dart';

Bl bl = Bl();

class Bl {
  bool devMode = false;

  //RxString filteredSheetName = ''.obs;
  RxMap lastCount = {}.obs;
  RxMap booksCount = {}.obs;
  RxString homeTitle = ''.obs;

  CurrentSS currentSS = CurrentSS();
  CurRow curRow = CurRow();

  SupabaseRepo supRepo = SupabaseRepo();
  WFiltersRepo wfiltersRepo = WFiltersRepo();
  NeonRepo neonRepo = NeonRepo();
  KoyebRepo koyebRepo = KoyebRepo();
  FirestoreRepo firestoreRepo = FirestoreRepo();

  //FirestoreRepo fireRepo = FirestoreRepo();

  TagsParts tagsParts = TagsParts();

  Future init() async {
    debugPrint('sheetRowsHelper init start');
    //await sheetRowsHelper.initDB(); sqlite
    debugPrint('supRepo init start');
    await supRepo.init();
    wfiltersRepo.supabase = supRepo.supabase;
    debugPrint('firestoreRepo init start');
    await firestoreRepo.init();

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

  AuthorBooksMap authorBooksMap = AuthorBooksMap();
  void updateSlowly() async {
    await authorBooksMap.getData();
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

