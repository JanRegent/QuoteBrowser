import 'package:flutter/foundation.dart';

List assetsFiles = ['Robert', 'karmel', 'Eckhart'];
String assetFile = assetsFiles[0];
Future loadCSV(String sheetName, int index) async {
  assetFile = assetsFiles[index];
  debugPrint('$assetFile.csv load');
  //final rawData = await rootBundle.loadString("assets/data/$assetFile.csv");
  //List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

  //listData.removeAt(0);

  // await bl.sheetRowsHelper.deleteAllRows();

  // currentSS.keys =
  //     await bl.sheetRowsHelper.insertResponseAll(sheetName, listData);
}
