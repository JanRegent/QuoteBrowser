import 'package:sembast/sembast.dart';

import '../../bl.dart';

Future searchByField(String fieldName, String searchItem) async {
// Using a regular expression matching the exact word (no case)
  Filter filterRegex = Filter.matchesRegExp(
      fieldName, RegExp('^$searchItem\$', caseSensitive: false));

  // Using a custom filter exact word (converting everything to lowercase)
  searchItem = searchItem.toLowerCase();

  Finder finder =
      Finder(filter: filterRegex, sortOrders: [SortOrder('dateinsert')]);

  final recordSnapshots = await sheetStore.find(
    senbastDb,
    finder: finder,
  );
  List<Map> maps = [];

  for (var snap in recordSnapshots) {
    maps.add(snap.value as Map);
  }

  return maps;
}

Future searchQuote(String searchItem) async {
  String fieldName = 'citat';

  // Using a custom filter exact word (converting everything to lowercase)
  searchItem = searchItem.toLowerCase();

  Filter filter = Filter.custom((snapshot) {
    var value = snapshot[fieldName] as String;
    return value.toLowerCase().contains(searchItem);
  });
  Finder finder = Finder(filter: filter, sortOrders: [SortOrder('dateinsert')]);

  final recordSnapshots = await sheetStore.find(
    senbastDb,
    finder: finder,
  );
  List<Map> maps = [];

  for (var snap in recordSnapshots) {
    maps.add(snap.value as Map);
  }

  return maps;
}

//https://hrishi445.medium.com/persist-data-with-sembast-nosql-database-in-flutter-2b6c5110170f
Future createRowMap(List<String> cols, List<String> row, String sheetName,
    String rowNo, String fileId) async {
  await senbastDb.transaction((txn) async {
    // You can specify a key
    await sheetStore
        .record('$sheetName,$rowNo')
        .put(txn, bl.orm.row2map(cols, row, sheetName, rowNo, fileId));
  });
}

Future readLenght() async {
  return sheetStore.count(senbastDb);
}

Future<List<Map>> readColRows() async {
  var finder = Finder(
    filter: Filter.equals('rowNo', '1'),
  );
  var records = await sheetStore.find(senbastDb, finder: finder);
  List<Map> colRows = [];

  for (var element in records) {
    colRows.add(element.value as Map);
  }
  return colRows;
}
