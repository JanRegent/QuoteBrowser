import 'package:quotebrowser/2BL_domain/bluti.dart';
import 'package:quotebrowser/3Data/dl.dart';

import '../bl.dart';

class DailyList {
  List<DailyListRow> rows = [];

  int swiperIndex = 1;

  List<String> sheetNames = [];
  List<String> cols = [];

  DailyListRow? getBySheetName(String sheetName) {
    for (DailyListRow row in rows) {
      if (row.sheetName == sheetName) return row;
    }
    return null;
  }

  String getRowkeyPrefix(String sheetName) {
    for (DailyListRow row in rows) {
      if (row.sheetName == sheetName) return row.rowkey;
    }
    return '';
  }

  Future getData() async {
    List data = await dl.gservice23.getPureSheet('dailyList');

    cols = blUti.toListString(data[0]);
    int sheetNameIx = cols.indexOf('sheetName');
    int sheetUrlIx = cols.indexOf('sheetUrl');
    int swiperIndexIx = cols.indexOf('swiperIndex');
    int parPageParseIx = cols.indexOf('parPageParse');
    int remove1Ix = cols.indexOf('remove1');
    int remove2Ix = cols.indexOf('remove2');
    int authorIx = cols.indexOf('author');
    int rowkeyIx = cols.indexOf('rowkey');
    rows.clear();
    for (var i = 1; i < data.length; i++) {
      String sheetName = data[i][sheetNameIx];
      if (sheetName.isEmpty) continue;
      sheetNames.add(sheetName);

      String swiperIndex = data[i][swiperIndexIx].toString();
      if (swiperIndex.isEmpty) swiperIndex = '2';

      bl.authorsSet.add(sheetName);

      rows.add(DailyListRow()
        ..rowkey = data[i][rowkeyIx]
        ..sheetName = sheetName
        ..sheetUrl = data[i][sheetUrlIx]
        ..swiperIndex = swiperIndex
        ..author = data[i][authorIx].toString().trim()
        ..parPageParse = data[i][parPageParseIx].toString().trim()
        ..remove1 = data[i][remove1Ix].toString().trim()
        ..remove2 = data[i][remove2Ix].toString().trim());

      dl.sheetUrls[rows.last.sheetName] = rows.last.sheetUrl;
      dl.rowkeySheetNameMap[rows.last.rowkey] = rows.last.sheetName;
    }
    dl.sheetUrls['dailyList'] = dl.sheetUrls['rootSheetId'];
  }
}

class DailyListRow {
  String sheetName = '';
  String sheetUrl = '';
  String swiperIndex = '2';
  String author = '';
  String parPageParse = '';
  String remove1 = '';
  String remove2 = '';
  String rowkey = '';
}
