import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/bluti.dart';
import '../../../2BL_domain/orm.dart';
import '../../../2BL_domain/usecases/filtersbl/searchss.dart';

// This function is triggered when the floating button is pressed
Future loadCSV() async {
  final rawData = await rootBundle.loadString("assets/data/RobertAdams.csv");
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
