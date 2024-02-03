import 'package:quotebrowser/2BL_domain/bluti.dart';
import 'package:quotebrowser/3Data/dl.dart';

import '../../../2BL_domain/bl.dart';

class DailyList {
  List<DailyListRow> rows = [];
  Set sheetGroups = {};
  int swiperIndex = 1;

  List<String> cols = [];

  Future getData() async {
    List data = await dl.httpService.getAllrows('dailyList');
    cols = blUti.toListString(data[0]);
    int sheetGroupIx = cols.indexOf('sheetGroup');
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    int swiperIndexIx = cols.indexOf('swiperIndex');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String sheetGroup = data[i][sheetGroupIx].toString().trim();
      if (sheetGroup.isEmpty) continue;
      sheetGroups.add(data[i][sheetGroupIx]);
      String swiperIndex = data[i][swiperIndexIx].toString();
      if (swiperIndex.isEmpty) swiperIndex = '2';

      String sheetName = data[i][sheetNameIx];
      bl.authorsSet.add(sheetName);

      rows.add(DailyListRow()
        ..rowNo = i + 1
        ..sheetGroup = sheetGroup
        ..sheetName = sheetName
        ..sheetUrl = data[i][sheetUrlIx]
        ..swiperIndex = swiperIndex);

      dl.sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
    }
    dl.sheetUrls['dailyList'] = dl.sheetUrls['rootSheetId'];
  }

  String sheetNamesStr(String groupName) {
    List<String> list = [];
    for (var i = 0; i < bl.dailyList.rows.length; i++) {
      if (bl.dailyList.rows[i].sheetGroup == groupName) {
        list.add(bl.dailyList.rows[i].sheetName);
      }
    }
    return list.join('__|__');
  }
}

class DailyListRow {
  String sheetGroup = '';
  String sheetName = '';
  String sheetUrl = '';
  String swiperIndex = '2';
  int rowNo = 0;
}
