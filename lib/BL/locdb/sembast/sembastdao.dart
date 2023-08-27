import 'package:sembast/sembast.dart';

import '../../bl.dart';
import '../../sheet/sheet.dart';

Future searchFoodByField(String fieldName, String searchItem) async {
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
Future insertSheet(List<String> cols, List<String> row, Sheet sheet) async {
  await senbastDb.transaction((txn) async {
    // You can specify a key
    await sheetStore.record('${sheet.aSheetName},${sheet.aIndex}').put(
        txn,
        bl.orm.row2map(cols, row, sheet.aSheetName, sheet.aIndex.toString(),
            sheet.zfileId));
  });
  //await sheetStore.add(senbastDb, sheet.toJson(cols, row, sheet));
}


// class StudentDao{
//   static const String folderName = "sheets";
//   final _studentFolder = intMapStoreFactory.store(folderName);


//   Future<Database> get  _db  async => senbastDb;

//   Future insertStudent(Sheet sheet) async{

//     await  _studentFolder.add(await _db, sheet.toJson(sheet) );
   
//   }

//   Future updateStudent(Student student) async{
//     final finder = Finder(filter: Filter.byKey(student.rollNo));
//     await _studentFolder.update(await _db, student.toJson(),finder: finder);

//   }


//   Future delete(Student student) async{
//     final finder = Finder(filter: Filter.byKey(student.rollNo));
//     await _studentFolder.delete(await _db, finder: finder);
//   }

//   Future<List<Student>> getAllStudents()async{
//     final recordSnapshot = await _studentFolder.find(await _db);
//     return recordSnapshot.map((snapshot){
//       final student = Student.fromJson(snapshot.value);
//       return student;
//     }).toList();
//   }


// }