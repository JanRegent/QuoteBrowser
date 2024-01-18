import 'package:quotebrowser/2BL_domain/bluti.dart';
import 'package:quotebrowser/3Data/providers/gwebapp/backendurl.dart';
import 'package:quotebrowser/3Data/dl.dart';

class DailyList {
  List<DailyListRow> rows = [];
  Set sheetGroups = {};
  int currentIndex = 1;

  String sheetGroupCurrent = '';

  List<String> cols = [];
  Map<String, String> sheetUrls = {};

  Future getData() async {
    List data = await dl.httpService.getAllrows('dailyList', rootSheetId);
    cols = blUti.toListString(data[0]);
    int sheetGroupIx = cols.indexOf('sheetGroup');
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    int currentIndexIx = cols.indexOf('currentIndex');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String sheetGroup = data[i][sheetGroupIx].toString().trim();
      if (sheetGroup.isEmpty) continue;
      sheetGroups.add(data[i][sheetGroupIx]);
      String currentIndex = data[i][currentIndexIx].toString();
      if (currentIndex.isEmpty) currentIndex = '2';

      rows.add(DailyListRow()
        ..rowNo = i + 1
        ..sheetGroup = sheetGroup
        ..sheetName = data[i][sheetNameIx]
        ..sheetUrl = data[i][sheetUrlIx]
        ..currentIndex = currentIndex);

      sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
      dl.httpService.sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
    }
    dl.httpService.sheetUrls['dailyList'] = rootSheetId;
  }
}

class DailyListRow {
  String sheetGroup = '';
  String sheetName = '';
  String sheetUrl = '';
  String currentIndex = '2';
  int rowNo = 0;
}
