// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:sembast/sembast.dart';

import 'locdbsembast/crudsembast.dart';
import 'locdbsembast/opensembast.dart';
import 'orm.dart';

// ignore: prefer_typing_uninitialized_variables
//late final Isar isar;
late Database senbastDb;
late StoreRef sheetStore;

Bl bl = Bl();

class Bl {
  bool devMode = false;

  Orm orm = Orm();
  CRUDsembast crud = CRUDsembast();

  Future init() async {
    await openSembast();
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
