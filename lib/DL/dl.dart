import 'gsheets1.dart';

Dl dl = Dl();

class Dl {
  GsheetsCRUD gsheetsHelper = GsheetsCRUD();

  Future init() async {
    await gsheetsHelper.init();
  }
}
