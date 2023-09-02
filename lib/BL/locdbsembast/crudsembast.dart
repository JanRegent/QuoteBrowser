import 'package:sembast/sembast.dart';

import '../bl.dart';
import '../bluti.dart';

class CRUDsembast {
  //https://hrishi445.medium.com/persist-data-with-sembast-nosql-database-in-flutter-2b6c5110170f
  Future createRowMap(List<String> cols, List<String> row, String sheetName,
      String rowNo, String fileId) async {
    await sembastDb.transaction((txn) async {
      // You can specify a key
      await sheetStore
          .record('$sheetName,$rowNo')
          .put(txn, bl.orm.row2map(cols, row, sheetName, rowNo, fileId));
    });
  }

  //------------------------------------------------------------------search
  Future<List<String>> searchByFieldSheetRowKeys(
      String fieldName, String searchItem) async {
    // Using a regular expression matching the exact word (no case)
    Filter filterRegex = Filter.matchesRegExp(
        fieldName, RegExp('^$searchItem\$', caseSensitive: false));

    // Using a custom filter exact word (converting everything to lowercase)
    searchItem = searchItem.toLowerCase();

    Finder finder =
        Finder(filter: filterRegex, sortOrders: [SortOrder('dateinsert')]);

    final recordSnapshots = await sheetStore.find(
      sembastDb,
      finder: finder,
    );
    List<String> keys = [];

    for (var snap in recordSnapshots) {
      keys.add('${snap['sheetName']},${snap['rowNo']} ');
    }

    return keys;
  }

  Future<List<String>> searchByFieldKeysInt(
      String fieldName, String searchItem) async {
    // Using a regular expression matching the exact word (no case)
    Filter filterRegex = Filter.matchesRegExp(
        fieldName, RegExp('^$searchItem\$', caseSensitive: false));

    // Using a custom filter exact word (converting everything to lowercase)
    searchItem = searchItem.toLowerCase();

    Finder finder =
        Finder(filter: filterRegex, sortOrders: [SortOrder('dateinsert')]);

    final recordSnapshots = await sheetStore.find(
      sembastDb,
      finder: finder,
    );
    List<String> keysInt = [];

    for (var snap in recordSnapshots) {
      keysInt.add(snap.key.toString());
    }

    return keysInt;
  }

  Future<List<Map>> searchByFieldMaps(
      String fieldName, String searchItem) async {
// Using a regular expression matching the exact word (no case)
    Filter filterRegex = Filter.matchesRegExp(
        fieldName, RegExp('^$searchItem\$', caseSensitive: false));

    // Using a custom filter exact word (converting everything to lowercase)
    searchItem = searchItem.toLowerCase();

    Finder finder =
        Finder(filter: filterRegex, sortOrders: [SortOrder('dateinsert')]);

    final recordSnapshots = await sheetStore.find(
      sembastDb,
      finder: finder,
    );
    List<Map> keys = [];

    for (var snap in recordSnapshots) {
      keys.add(snap.value as Map);
    }

    return keys;
  }

  Future searchByDateinsert(String searchItem) async {
    return searchByFieldSheetRowKeys('dateinsert', searchItem);
  }

  Future searchQuote(String searchItem) async {
    // Using a custom filter exact word (converting everything to lowercase)
    searchItem = searchItem.toLowerCase();

    Filter filter = Filter.custom((snapshot) {
      var value = snapshot['quote'] as String;
      return value.toLowerCase().contains(searchItem);
    });
    Finder finder =
        Finder(filter: filter, sortOrders: [SortOrder('dateinsert')]);

    final recordSnapshots = await sheetStore.find(
      sembastDb,
      finder: finder,
    );
    List<Map> maps = [];

    for (var snap in recordSnapshots) {
      maps.add(snap.value as Map);
    }

    return maps;
  }

  //----------------------------------------------------------------readByKey
  Future<Map> readBySheetRowKey(String sheetRowKey) async {
    final snapshot =
        await sheetStore.record(sheetRowKey).getSnapshot(sembastDb);
    if (snapshot == null) return {};
    return snapshot.value as Map;
  }

  //----------------------------------------------------------------readLen
  Future readLenght() async {
    return await sheetStore.count(sembastDb);
  }

  Future<int> readLenSheet(String sheetName) async {
    var finder = Finder(
      filter: Filter.equals('sheetName', sheetName),
    );
    var records = await sheetStore.find(sembastDb, finder: finder);
    return records.length;
  }

  Future<int> readLenToday(String sheetName) async {
    var finder = Finder(
      filter: Filter.equals('sheetName', sheetName) &
          Filter.equals('dateinsert', '${blUti.todayStr()}.'),
    );
    var records = await sheetStore.find(sembastDb, finder: finder);
    return records.length;
  }

  //----------------------------------------------------------------readCols
  Future<List<Map>> readColRows() async {
    var finder = Finder(
      filter: Filter.equals('rowNo', '1'),
    );
    var records = await sheetStore.find(sembastDb, finder: finder);
    List<Map> colRows = [];

    for (var record in records) {
      colRows.add(record.value as Map);
    }
    return colRows;
  }

  Future<List<String>> readColRowsOfSheetName(String sheetName) async {
    List<Map> colrowsMaps = await readColRows();
    for (var colMap in colrowsMaps) {
      if (colMap['sheetName'] == sheetName) {
        return blUti.toListString(colMap['colRow']);
      }
    }
    return [];
  }

  Future<List<String>> readColRowsOfSheetName2(String sheetName) async {
    var finder = Finder(
      filter:
          Filter.equals('rowNo', '1') & Filter.equals('sheetName', sheetName),
    );
    var records = await sheetStore.find(sembastDb, finder: finder);
    List<String> colRows =
        blUti.toListString(records[0]['colRow'] as List<String>);

    return colRows;
  }
}
