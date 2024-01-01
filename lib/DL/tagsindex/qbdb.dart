import 'package:shared_preferences/shared_preferences.dart';

import '../../BL/bluti.dart';
import '../backendurl.dart';
import '../dl.dart';

void openDb() async {
  List tagIndex = await dl.httpService.getAllrows('__tagSheets__', rootSheetId);

// Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> cols = blUti.toListString(tagIndex[0]);

  int tagIx = cols.indexOf('tag');
  int sheetNameIx = cols.indexOf('sheetName');
  int rownosIx = cols.indexOf('rownos');
  for (var i = 1; i < tagIndex.length; i++) {
    List<String> row = blUti.toListString(tagIndex[i]);
    String tag = row[tagIx];
    String sheetName = row[sheetNameIx];
    String rownos = row[rownosIx];
    await prefs.setString('${tag}__|__$sheetName', rownos);
  }

  Iterable<String> keys =
      prefs.getKeys().where((key) => key.startsWith('*****'));
  for (String key in keys) {
    String? value = prefs.getString(
        key); // Throws an error if you store something other than a String
    print('$key  $value');
  }

// // Save an integer value to 'counter' key.
//   await prefs.setInt('counter', 10);
// // Save an boolean value to 'repeat' key.
//   await prefs.setBool('repeat', true);
// // Save an double value to 'decimal' key.
//   await prefs.setDouble('decimal', 1.5);
// // Save an String value to 'action' key.
//   await prefs.setString('action', 'Start');
// // Save an list of strings to 'items' key.
//   await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
}
