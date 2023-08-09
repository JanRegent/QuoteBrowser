import 'gsheets1.dart';

Dl dl = Dl();

class Dl {
  GsheetsHelper gsheetsHelper = GsheetsHelper();

  Future init() async {
    await gsheetsHelper.init();
  }
}
