import 'package:quotebrowser/BL/bluti.dart';
import 'package:quotebrowser/DL/dl.dart';

class DailyList {
  List<DailyListRow> rows = [];
  Set sheetGroups = {};
  int currentIndex = 1;

  String sheetGroupCurrent = '';

  String sheetId = '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU';
  List<String> cols = [];

  Future getData() async {
    List data = await dl.httpService.getAllrows('dailyList', sheetId);
    cols = blUti.toListString(data[0]);
    int sheetGroupIx = cols.indexOf('sheetGroup');
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String sheetGroup = data[i][sheetGroupIx].toString().trim();
      if (sheetGroup.isEmpty) continue;
      sheetGroups.add(data[i][sheetGroupIx]);
      rows.add(DailyListRow()
        ..sheetGroup = sheetGroup
        ..sheetName = data[i][sheetNameIx]
        ..sheetUrl = data[i][sheetUrlIx]);
    }
  }
}

class DailyListRow {
  String sheetGroup = '';
  String sheetName = '';
  String sheetUrl = '';
}
