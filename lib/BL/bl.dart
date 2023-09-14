// ignore_for_file: prefer_interpolation_to_compose_strings

import 'orm.dart';

Bl bl = Bl();

class Bl {
  bool devMode = false;

  Orm orm = Orm();
  //CRUDsembast crud = CRUDsembast();

  Future init() async {
    //await openSembast();
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
