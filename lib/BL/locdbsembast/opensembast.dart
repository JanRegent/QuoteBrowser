import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

import '../bl.dart';

Future openSembast() async {
  // Declare our store (records are mapd, ids are ints)
  sheetStore = stringMapStoreFactory.store();
  var factory = databaseFactoryWeb;

  // Open the database
  senbastDb = await factory.openDatabase('sheets');
}
