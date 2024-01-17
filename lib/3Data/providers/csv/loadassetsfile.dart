import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/bluti.dart';
import '../../../2BL_domain/orm.dart';
import '../../../2BL_domain/usecases/filtersbl/searchss.dart';

List assetsFiles = ['Robert', 'karmel', 'Eckhart'];
String assetFile = assetsFiles[0];
Future loadCSV(int index) async {
  assetFile = assetsFiles[index];
  debugPrint('$assetFile.csv load');
  final rawData = await rootBundle.loadString("assets/data/$assetFile.csv");
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

  List<String> cols = blUti.toListString(listData[0]);
  cols.insert(0, 'rownoKey');
  await bl.sheetcolsCRUD.updateCols('Robert', cols);
  listData.removeAt(0);

  for (var i = 0; i < listData.length; i++) {
    listData[i].insert(0, 'Robert__|__$i');
  }
  await bl.sheetrowsCRUD.deleteAllDb();
  currentSS.keys = await sheetRowsSaveGetKeys(listData);
}
